rem ********************************
rem Battleship enemy_behaviors.agc
rem *******************************




` **** CheckCurrentShipState()
Function CheckAIBehaviorStates()


    acircle.angle#     = GetSpriteAngle(acircle.sprID)                       ` Circle
    acircle.x#         = GetSpriteX(acircle.sprID)
    acircle.y#         = GetSpriteY(acircle.sprID)
    acircle.absCtrX#   = acircle.x#+acircle.width#/2.0
    acircle.absCtrY#   = acircle.y#+acircle.height#/2.0
    acircle.angle#     = GetSpriteAngle(acircle.sprID)

    if (GetSpriteExists(attackBoatSpriteID) = EXISTS)
        enemy.x#         = GetSpriteX(attackBoatSpriteID)                         ` Enemy object
        enemy.y#         = GetSpriteY(attackBoatSpriteID)
        enemy.absCtrX#   = enemy.x#+enemy.width#/2.0
        enemy.absCtrY#   = enemy.y#+enemy.height#/2.0
        enemy.angle#     = GetSpriteAngle(attackBoatSpriteID)
    endif

    for i = 1 to enemy_limit
        if (GetSpriteExists(attackBoats[i].sprID) = EXISTS)
            attackBoats[i].x#         = GetSpriteX(attackBoats[i].sprID)           ` AttackBoat objects
            attackBoats[i].y#         = GetSpriteY(attackBoats[i].sprID)
            attackBoats[i].absCtrX#   = attackBoats[i].x#+attackBoats[i].width#/2.0
            attackBoats[i].absCtrY#   = attackBoats[i].y#+attackBoats[i].height#/2.0
            attackBoats[i].angle#     = GetSpriteAngle(attackBoats[i].sprID)
        endif
    next i

    enemywanderDirection = UNCHANGED
EndFunction




` ******************************* Meta Steering Behaviors ***********************************



Function SeekTarget(object, target)
    PointAtTarget(object, target)
    PropelVehicle(object, enemy_vehicle_speed)
EndFunction


Function FleeTarget(object, target)
    panicDistance# = 500
    if (distanceFromAtoB(object, target) <= panicDistance#)
        PointAwayFromTarget(object, target)
        PropelVehicle(object, enemy_vehicle_speed)
    else
        StopVehicle(object)
    endif
EndFunction


Function PursueTarget(object, target)
    SetPredictedPositionOfTarget(object, target)    ` Sets targetingSpriteID to the predicted future position of target
    PointAtTarget(object, targetingSpriteID)        ` targetingSpriteID gets set as the 'Seek' target so we pass it in here.
    PropelVehicle(object, enemy_vehicle_speed)
EndFunction



Function EvadeTarget(object, target)
    SetPredictedPositionOfTarget(object, target)    ` Sets targetingSpriteID to the predicted future position of target
    PointAwayFromTarget(object, targetingSpriteID)  ` targetingSpriteID gets set as the 'Flee' target so we pass it in here.
    panicDistance# = 500
    if (distanceFromAtoB(object, target) <= panicDistance#)
        PointAwayFromTarget(object, target)
        PropelVehicle(object, enemy_vehicle_speed)
    else
        StopVehicle(object)
    endif
EndFunction



Function AttackTarget(object, target, deceleration)  ` Seek: but arrive at the target with a zero velocity
    EnemySensorCollissionsChecking = ON
    ChangeEnemyBehaviorState(ATTACK, SINGLETON)     ` < *** enemy.behavior_state = ENGAGED

    distance# = distanceFromAtoB(object, target)
    targetThreshold = 900
    if (distance# > targetThreshold)
        decelerationTweeker# = .03
        speed# = distance# / (deceleration * decelerationTweeker#)
        speed# = min(speed#, enemy_vehicle_speed)
    else
        speed# = 0  ` Immediately stops vehicle, sets velocity to zero, then later set arrivedAtTarget flag to TRUE.
        `SetCurrentGoalSatisifiedFlag(TRUE)      ` If we've arrived at a target, that must be the current goal, so flag it as satisified.
        Print("*** BOOM, BOOM, BOOM ****")

        index = spriteLookup[object].localIndex                 ` Use Global spriteLookup Table to get UDT info
        designation$ = spriteLookup[object].typeDefinition
        select designation$
            case    SINGLE_ENEMY_BOAT   `["enemy"]
                    enemy.arrivedAtTarget = TRUE
            endcase
            case    ATTACK_BOAT          `["attackboat"]
                    attackBoats[index].arrivedAtTarget = TRUE
            endcase
        endselect
    endif

    PointAtTarget(object, target) ` *** Below is effectively Seek w/the new speed as a passed in variable.
    PropelVehicle(object, speed#)
EndFunction


Function ArriveAtTarget(object, target, deceleration)  ` Seek: but arrive at the target with a zero velocity
    distance# = distanceFromAtoB(object, target)
    targetThreshold = 300
    if (distance# > targetThreshold)
        decelerationTweeker# = .03
        speed# = distance# / (deceleration * decelerationTweeker#)
        speed# = min(speed#, enemy_vehicle_speed)
    else
        speed# = 0  ` Immediately stops vehicle, sets velocity to zero, then later set arrivedAtTarget flag to TRUE.
        `SetCurrentGoalSatisifiedFlag(TRUE)      ` If we've arrived at a target, that must be the current goal, so flag it as satisified.

        index = spriteLookup[object].localIndex                 ` Use Global spriteLookup Table to get UDT info
        designation$ = spriteLookup[object].typeDefinition
        select designation$
            case    SINGLE_ENEMY_BOAT   `["enemy"]
                    enemy.arrivedAtTarget = TRUE

                    if  (enemy.node.lastVisited_1 = FALSE)      ` For use w/the PATROL state ... this whole select/case will change...
                        enemy.node.lastVisited_5 = FALSE
                         enemy.node.lastVisited_1 = target
                    elseif (enemy.node.lastVisited_2 = FALSE)
                         enemy.node.lastVisited_2 = target
                    elseif (enemy.node.lastVisited_3 = FALSE)
                         enemy.node.lastVisited_3 = target
                    elseif (enemy.node.lastVisited_4 = FALSE)
                         enemy.node.lastVisited_4 = target
                    elseif (enemy.node.lastVisited_5 = FALSE)
                         enemy.node.lastVisited_5 = target
                         enemy.node.lastVisited_1 = FALSE          ` Set the rest of the previous to false
                         enemy.node.lastVisited_2 = FALSE
                         enemy.node.lastVisited_3 = FALSE
                         enemy.node.lastVisited_4 = FALSE
                    endif

            endcase
            case    ATTACK_BOAT          `["attackboat"]
                    attackBoats[index].arrivedAtTarget = TRUE
            endcase
        endselect
    endif

    PointAtTarget(object, target) ` *** Below is effectively Seek w/the new speed as a passed in variable.
    PropelVehicle(object, speed#)
EndFunction



Function WanderAround(object)
    if (GetSpriteExists(object) = EXISTS)
        diameter# = 250                 ` taken from the physical width of the sprite, but it could be distance
        area# = PI * (radius#*radius#)
        circumference# = PI*diameter#
        radius# = diameter#/2

        ovx# = GetSpritePhysicsVelocityX(object) ` The velocities of the physics enabled sprites.
        ovy# = GetSpritePhysicsVelocityY(object)

        index = spriteLookup[object].localIndex                 ` Use Global spriteLookup Table to get UDT info
        designation$ = spriteLookup[object].typeDefinition
        select designation$
            case    SINGLE_ENEMY_BOAT   `["enemy"]
               x# = (enemy.width#+ovx#+1)*(Cos(enemy.angle#))+enemy.absCtrX#   ` *** Tweek the "+1" for more control
               y# = (enemy.width#+ovy#+1)*(Sin(enemy.angle#))+enemy.absCtrY#
               SetSpriteVisible(enemy.steering.sprID, VISIBLE)
                    steeringSprID = enemy.steering.sprID
            endcase
            case    ATTACK_BOAT          `["attackboat"]
               x# = (attackBoats[index].width#+ovx#+1)*(Cos(attackBoats[index].angle#))+attackBoats[index].absCtrX#
               y# = (attackBoats[index].width#+ovy#+1)*(Sin(attackBoats[index].angle#))+attackBoats[index].absCtrY#
               SetSpriteVisible(attackBoats[index].steering.sprID, VISIBLE)
               steeringSprID = attackBoats[index].steering.sprID
            endcase
        endselect

        currentAngle# = GetSpriteAngle(object)
        quadrant = random(1,4)
        select quadrant
            case    1
                angle# = random(0, 90)
            endcase
            case    2
                angle# = random(91, 165)
            endcase
            case    3
                angle# = random(190, 270)
            endcase
            case    4
                angle# = random(271, 360)
            endcase
        endselect
        SetSpritePositionByOffset(steeringSprID, radius#*Cos(angle#)+x#, radius#*Sin(angle#)+y#)

        PointAtTarget(object, steeringSprID)    ` *** Below is effectively Seek w/new Target and Speed.
        PropelVehicle(object, enemy_vehicle_speed)
    endif
EndFunction



Function Hide(object, target, shield, safePlaceMarker)
    SetHideTarget(shield, target, safePlaceMarker)  ` Set the safe place sprite target to move toward.
    GoHide(object, safePlaceMarker, FAST, target)
EndFunction


Function GoHide(object, safePlaceMarker, deceleration, target)
    distance# = distanceFromAtoB(object, safePlaceMarker)
    targetThreshold = 50

    if (distance# > targetThreshold)
        decelerationTweeker# = .03
        speed# = distance# / (deceleration * decelerationTweeker#)
        speed# = min(speed#, enemy_vehicle_speed)
    else
        speed# = 0                                  ` Stops vehicle by sets velocity to zero
        ChangeEnemyBehaviorState(SAFE, SINGLETON)   ` Note: enemy.behavior_state = SAFE
    endif

    if (speed# = 0)
        PointAtTarget(object, target)               ` Once arrived at safety, idle & point at target
        EnemySensorCollissionsChecking = OFF        ` Turn off EnemySensorCollissionsChecking so the ship doesn't bounce around ....
    elseif (distance# > 10)                         ` The safety marker will move, if it moves past a point, move also
        if (enemy.behavior_state = SAFE)            ` If safe (enemy.behavior_state = SAFE), just subtly reposition w/marker & point at target
            x# = GetSpriteX(safePlaceMarker)
            y# = GetSpriteY(safePlaceMarker)
            SetSpritePositionByOffset(object, x#, y#)
            PointAtTarget(object, target)
            EnemySensorCollissionsChecking = OFF
        elseif NOT (enemy.behavior_state = SAFE)    ` If not (yet) safe, point to the safety marker and move toward it.
            PointAtTarget(object, safePlaceMarker)
            PropelVehicle(object, speed#)
            EnemySensorCollissionsChecking = ON
        endif
    endif
EndFunction




` *********************** Primitive Steering Behvaiors ******************************


Function SetHideTarget(shield, target, safePlaceMarker)
    distance# = 450   ` The distance from the enemy to his shield
    if (GetSpriteExists(shield) = EXISTS)
        ` **** You *must* use the ByOffset or it won't work ....
        hit = PhysicsRayCast(GetSpriteXByOffset(shield), GetSpriteYByOffset(shield),GetSpriteXByOffset(target), GetSpriteYByOffset(target))
        if hit = TRUE
            id = GetRayCastSpriteID()       ` Just in case we need it later ...
            x#=GetRayCastX()
            y#=GetRayCastY()
            ` **** Offset = RayCast [Target] minux SpriteByOffset [shield]
            ox# = GetSpriteXByOffset(shield)
            oy# = GetSpriteYByOffset(shield)
            xoffset#=x#-ox#
            yoffset#=y#-oy#
            ` **** Adjustment for angles outside -90 to +90 range: "bias"
            if xoffset# < 0
                bias = 180
            else
                bias = 0
            endif
            angle# = ATan(yoffset#/xoffset#)+bias
            SetSpriteAngle(safePlaceMarker, angle#-180)  ` <**** Subtract 180 degrees to point in opposite direction
            SetSpritePositionByOffset(safePlaceMarker, distance#*Cos(angle#-180)+ox#, distance#*Sin(angle#-180)+oy#)  ` Place the safe place marker there
        endif
    endif
EndFunction



Function SetPredictedPositionOfTarget(object, target)
    CheckCurrentShipState()

    SetSpriteVisible(targetingSpriteID, VISIBLE) `<== Visual Target for new Seek position. change to invisible later

        ` The "*Inversely* Proportional to distance bewteen the object and target" factor
        tvx# = GetSpritePhysicsVelocityX(target) ` The velocities of the physics enabled sprites.
        tvy# = GetSpritePhysicsVelocityY(target)
        ovx# = GetSpritePhysicsVelocityX(object)
        ovy# = GetSpritePhysicsVelocityY(object)

        vx# = tvx# + ovx#                       ` Subtract the target velocities from the object velocities
        vy# = tvy# + ovy#

    x_offset# = ship.absCtrX#   ` Moving the rotation point (x,y) from the Default TLC to somewhere else.
    y_offset# = ship.absCtrY#   ` Is this case the absolute center of the sprite (our ultimate target for the Seek Operation)

    distance# = distanceFromAtoB(object, target)    ` The distance between the object and target
    lookAheadTime# = distance# / 5                  ` Technically lookAheadTime is a factor = distance / (obj velocity + target velocity),
                                                    ` but since we get velocities in (x,y) format and this formula requires a factor, I fudge it a bit w/(5).

    `angle# = ship.angle#
    angle = GetSpriteAngle(ship.sprID)  ` This is the angle of our target

    ` |-Target distance position -|
    ` |- is calculated here -|
    ` \/                    \/
    x# = (lookAheadTime#+vx#)*(Cos(ship.angle#))+ship.absCtrX#
    y# = (lookAheadTime#+vy#)*(Sin(ship.angle#))+ship.absCtrY#

    SetSpritePositionByOffset(targetingSpriteID, x#, y#)  ` This sets the position of the target sprite that the 'Seek' Function uses next
EndFunction


Function PointAtTarget(object, target)
    if (GetSpriteExists(object) = EXISTS)

        ` **** You *must* use the ByOffset or it won't work ....
        hit = PhysicsRayCast(GetSpriteXByOffset(object), GetSpriteYByOffset(object), GetSpriteXByOffset(target), GetSpriteYByOffset(target))
        if hit = TRUE
            id = GetRayCastSpriteID()       ` Just in case we need it later ...

            x#=GetRayCastX()
            y#=GetRayCastY()

            ` **** Offset = RayCast [Target] minux SpriteByOffset [object]
            xoffset#=x#-GetSpriteXByOffset(object)
            yoffset#=y#-GetSpriteYByOffset(object)

            ` **** Adjustment for angles outside -90 to +90 range: "bias"
            if xoffset# < 0
                bias = 180
            else
                bias = 0
            endif

            angle# = ATan(yoffset#/xoffset#)+bias
            SetSpriteAngle(object, angle#)
        endif
    endif
EndFunction


Function PointAwayFromTarget(object, target)
    if (GetSpriteExists(object) = EXISTS)
        ` **** You *must* use the ByOffset or it won't work ....
        hit = PhysicsRayCast(GetSpriteXByOffset(object), GetSpriteYByOffset(object),GetSpriteXByOffset(target), GetSpriteYByOffset(target))
        if hit = TRUE
            id = GetRayCastSpriteID()       ` Just in case we need it later ...

            x#=GetRayCastX()
            y#=GetRayCastY()

            ` **** Offset = RayCast [Target] minux SpriteByOffset [object]
            xoffset#=x#-GetSpriteXByOffset(object)
            yoffset#=y#-GetSpriteYByOffset(object)

            ` **** Adjustment for angles outside -90 to +90 range: "bias"
            if xoffset# < 0
                bias = 180
            else
                bias = 0
            endif

            angle# = ATan(yoffset#/xoffset#)+bias
            SetSpriteAngle(object, angle#-180)    ` <**** Subtract 180 degrees to point in opposite direction
        endif
    endif
EndFunction


Function StopVehicle(object)
    if (GetSpriteExists(object) = EXISTS)
        SetSpritePhysicsDamping(object, HALF_STOP)      ` Implements the stopping procedure for an object
        `PropelVehicle(object, ZERO)
    endif
EndFunction



Function PropelVehicle(object, speed)
    if (GetSpriteExists(object) = EXISTS)
        SetSpritePhysicsDamping(object, NONE)           ` Since we use MAX 'Damping' to stop a object, we must turn it off here.
        if (GetSpriteExists(object) = EXISTS)
            angle# = GetSpriteAngle(object)             ` Angle
            vx# = speed*Cos(angle#)                     ` The vector is in the direction of the angle of the enemy vehicle
            vy# = speed*Sin(angle#)
            SetSpritePhysicsVelocity(object, vx#, vy#)  ` Moves the vehicle forward...
        endif
    endif
EndFunction





` ******************** Steering Behavior Support Functions ***********************

Function distanceFromAtoB(object, target)
    if (GetSpriteExists(object) = EXISTS) AND (GetSpriteExists(target)  = EXISTS)
        ox# = GetSpriteX(object)
        oy# = GetSpriteY(object)
        tx# = GetSpriteX(target)
        ty# = GetSpriteY(target)

        ` **** Distance = Target - Object
        distanceX# =  tx# - ox#
        distanceY# =  ty# - oy#

        ` Pythagorean Theorem-ish
        distance# = sqrt((distanceX#*distanceX#)+(distanceY#*distanceY#))
    endif
EndFunction distance#



Function min(a, b)
    minimun# as integer
    if (a <= b )
        minimun# = a
    else
        minimun# = b
    endif

EndFunction minimun#






// *********************** DEBUG STUFF ****************


rem **********************************
rem EOF Battleship enemy_behaviors.agc
rem **********************************



