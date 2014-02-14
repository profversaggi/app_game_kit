rem **************************
rem Battleship enemies.agc
rem **************************


` **** LoadEnemyResources()
Function LoadEnemyResources()
    `LoadBallMarker()
    LoadAISteeringShapes()
    LoadEnemies()
    LoadAIPOVGraph()
EndFunction


Function LoadAIPOVGraph()
    dim nodes$[5] as string = ["A", "B", "C", "D", "E"]
    dim booleanData[25] as integer = [0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0]
    index = 0
    for i = 0 to mapNodesSize -1                             ` Establish Adjacency Matrix Node
        myNodes[i].nodeName$ = nodes$[i]
        myNodes[i].matrixIndex = i
        myNodes[i].visited = FALSE
        myNodes[i].sprID = CloneSprite(acircle.sprID)
        SetSpriteSize(myNodes[i].sprID, 50, -1)
        SetSpriteShape(myNodes[i].sprID, CIRCLE)
        SetSpriteDepth(myNodes[i].sprID, AISteeringDepth)
        SetSpriteGroup(myNodes[i].sprID, NAVGRAPH_GROUP)
        SetSpriteVisible(myNodes[i].sprID, VISIBLE)
        SetSpriteActive(myNodes[i].sprID, ACTIVE)
        myNodes[i].x# = GetSpriteX(myNodes[i].sprID)                 ` Top
        myNodes[i].y# = GetSpriteY(myNodes[i].sprID)                 ` Left
        myNodes[i].width# = GetSpriteWidth(myNodes[i].sprID)         ` Width Offset
        myNodes[i].height# = GetSpriteHeight(myNodes[i].sprID)       ` Height Offset
        myNodes[i].absCtrX# = myNodes[i].x#+myNodes[i].width#/2.0    ` Absolute Center X
        myNodes[i].absCtrY# = myNodes[i].y#+myNodes[i].height#/2.0   ` Absolute Center Y
        SetSpriteOffset(myNodes[i].sprID, myNodes[i].absCtrX#, myNodes[i].absCtrY#)
        SetSpritePhysicsOn(myNodes[i].sprID, DYNAMIC)
        SetSpritePhysicsIsSensor(myNodes[i].sprID, SENSOR)
        spriteLookup[myNodes[i].sprID].sprID = myNodes[i].sprID
        spriteLookup[myNodes[i].sprID].typeDefinition = POV_NAV_GRAPH
        spriteLookup[myNodes[i].sprID].localIndex = i
        for j = 0 to mapNodesSize -1
                myMatrix[i, j] = booleanData[index]         ` Fill Adjacency Matrix w/Graph Data
                inc index
        next j
    next i


    `SetSpriteVisible(myNodes[0].sprID, INVISIBLE)
    SetSpritePositionByOffset(myNodes[0].sprID, 3450, 3000) `A      ` **** Place Nodes on Screen
    `SetSpritePositionByOffset(myNodes[0].sprID, 3300, 1000) `A      ` **** Place Nodes on Screen
    `SetSpritePositionByOffset(myNodes[0].sprID, 5000, 1000) `A      ` **** Place Nodes on Screen
    SetSpritePositionByOffset(myNodes[1].sprID, 6000, 1000) `B
    SetSpritePositionByOffset(myNodes[2].sprID, 6000, 2000) `C
    SetSpritePositionByOffset(myNodes[3].sprID, 5500, 3500) `D
    SetSpritePositionByOffset(myNodes[4].sprID, 5000, 2000) `E

EndFunction



Function LoadAISteeringShapes()

    LoadImage(acircle.imgID, acircle.imgFile$)                ` **** CIRCLE
    CreateSprite(acircle.sprID, acircle.imgID)
    SetSpriteSize(acircle.sprID, 200, -1)
    SetSpriteShape(acircle.sprID, CIRCLE)
    SetSpriteDepth(acircle.sprID, AISteeringDepth)
    SetSpriteGroup(acircle.sprID, STEERING_GROUP)
    SetSpriteVisible(acircle.sprID, INVISIBLE)
    acircle.x# = GetSpriteX(acircle.sprID)                   ` Top
    acircle.y# = GetSpriteY(acircle.sprID)                   ` Left
    acircle.width# = GetSpriteWidth(acircle.sprID)           ` Width Offset
    acircle.height# = GetSpriteHeight(acircle.sprID)         ` Height Offset
    acircle.absCtrX# = acircle.x#+acircle.width#/2.0         ` Absolute Center X
    acircle.absCtrY# = acircle.y#+acircle.height#/2.0        ` Absolute Center Y
    acircle.angle# = GetSpriteAngle(acircle.sprID)           ` Angle
    SetSpriteOffset(acircle.sprID, acircle.absCtrX#, acircle.absCtrY#)
    SetSpritePhysicsOn(acircle.sprID, DYNAMIC)
    SetSpritePhysicsIsSensor(acircle.sprID, SENSOR)

    LoadImage(aship.imgID, aship.imgFile$)          ` **** SHIP IMAGE
    CreateSprite(aship.sprID, aship.imgID)
    SetSpriteSize(aship.sprID, 200, 40)
    SetSpriteShape(aship.sprID, POLYGON)
    SetSpriteDepth(aship.sprID, AISteeringDepth)
    SetSpriteGroup(aship.sprID, STEERING_GROUP)
    SetSpriteVisible(aship.sprID, INVISIBLE)
    aship.x# = GetSpriteX(aship.sprID)              ` Top
    aship.y# = GetSpriteY(aship.sprID)              ` Left
    aship.width# = GetSpriteWidth(aship.sprID)      ` Width Offset
    aship.height# = GetSpriteHeight(aship.sprID)    ` Height Offset
    aship.absCtrX# = aship.x#+aship.width#/2.0 ` Absolute Center X
    aship.absCtrY# = aship.y#+aship.height#/2.0 ` Absolute Center Y
    aship.angle# = GetSpriteAngle(aship.sprID)       ` Angle
    SetSpriteOffset(aship.sprID, aship.absCtrX#, aship.absCtrY#)
    SetSpritePhysicsOn(aship.sprID, DYNAMIC)
    `SetSpritePhysicsIsSensor(aship.sprID, SENSOR)

RemStart
    LoadImage(asquare.imgID, asquare.imgFile$)              ` **** SQUARE
    CreateSprite(asquare.sprID, asquare.imgID)
    SetSpriteSize(asquare.sprID, 100, -1)

    SetSpriteShape(asquare.sprID, BOX)
    SetSpriteDepth(asquare.sprID, AISteeringDepth)
    SetSpriteGroup(asquare.sprID, STEERING_GROUP)
    SetSpriteVisible(asquare.sprID, VISIBLE)
    asquare.x# = GetSpriteX(asquare.sprID)              ` Top
    asquare.y# = GetSpriteY(asquare.sprID)              ` Left
    asquare.width# = GetSpriteWidth(asquare.sprID)      ` Width Offset
    asquare.height# = GetSpriteHeight(asquare.sprID)    ` Height Offset
    asquare.absCtrX# = asquare.x#+asquare.width#/2.0    ` Absolute Center X
    asquare.absCtrY# = asquare.y#+asquare.height#/2.0    ` Absolute Center Y
    asquare.angle# = GetSpriteAngle(asquare.sprID)       ` Angle
    SetSpriteOffset(asquare.sprID, asquare.absCtrX#, asquare.absCtrY#)

    SetSpritePosition(asquare.sprID, 1900, 500)
    `SetSpritePhysicsOn(asquare.sprID, STATIC)
RemEnd

    LoadImage(asquare.imgID, asquare.imgFile$)

    for i = 1 to 9
        `obstacle[i].sprID = CloneSprite(asquare.sprID)
        obstacle[i].sprID = CreateSprite(asquare.imgID)
        SetSpriteSize(obstacle[i].sprID, 100, -1)
        SetSpriteShape(obstacle[i].sprID, BOX)
        SetSpriteDepth(obstacle[i].sprID, AISteeringDepth)
        SetSpriteGroup(obstacle[i].sprID, OBSTACLES_GROUP)
        SetSpriteVisible(obstacle[i].sprID, VISIBLE)
        obstacle[i].x# = GetSpriteX(obstacle[i].sprID)                ` Top
        obstacle[i].y# = GetSpriteY(obstacle[i].sprID)                ` Left
        obstacle[i].width# = GetSpriteWidth(obstacle[i].sprID)        ` Width Offset
        obstacle[i].height# = GetSpriteHeight(obstacle[i].sprID)      ` Height Offset
        obstacle[i].absCtrX# = obstacle[i].x#+obstacle[i].width#/2.0  ` Absolute Center X
        obstacle[i].absCtrY# = obstacle[i].y#+obstacle[i].height#/2.0 ` Absolute Center Y
        obstacle[i].angle# = GetSpriteAngle(obstacle[i].sprID)        ` Angle
        SetSpriteOffset(obstacle[i].sprID, obstacle[i].absCtrX#, obstacle[i].absCtrY#)
   next i

    RemStart
    SetSpritePositionByOffset(obstacle[1].sprID, 3100, 1500)
    SetSpritePhysicsOn(obstacle[1].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[2].sprID, 3350, 1500)
    SetSpritePhysicsOn(obstacle[2].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[3].sprID, 3200, 1300)
    SetSpritePhysicsOn(obstacle[3].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[4].sprID, 3200, 1800)
    SetSpritePhysicsOn(obstacle[4].sprID, STATIC)

    SetSpritePositionByOffset(obstacle[5].sprID, 3450, 1800)
    SetSpritePhysicsOn(obstacle[5].sprID, STATIC)

    SetSpritePositionByOffset(obstacle[6].sprID, 3650, 1800)
    SetSpritePhysicsOn(obstacle[6].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[7].sprID, 3100, 2100)
    SetSpritePhysicsOn(obstacle[7].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[8].sprID, 3400, 2100)
    SetSpritePhysicsOn(obstacle[8].sprID, STATIC)
    RemEnd

    SetSpritePositionByOffset(obstacle[9].sprID, 3650, 2100)
    SetSpritePhysicsOn(obstacle[9].sprID, STATIC)

    LoadImage(ballImageID, "Ball.png")
    CreateSprite(ballSpriteID, ballImageID)
    SetSpriteSize(ballSpriteID, 10, 10)
    SetSpriteDepth(ballSpriteID,9)
    x# = GetSpriteX(ballSpriteID)
    y# = GetSpriteY(ballSpriteID)
    w# = GetSpriteWidth(ballSpriteID)/2
    h# = GetSpriteHeight(ballSpriteID)/2
    ball_abs_ctr_x# = x# + w#
    ball_abs_ctr_y# = y# + h#
    SetSpriteOffset(ballSpriteID, ball_abs_ctr_x#, ball_abs_ctr_y#)
    SetSpriteVisible(ballSpriteID, VISIBLE)

EndFunction


Function LoadEnemies()

    LoadImage(attackBoatImageID, "attack-boat.png")
    CreateSprite(attackBoatSpriteID, attackBoatImageID)
    SetSpriteSize(attackBoatSpriteID, 150, -1)
    SetSpritePosition(attackBoatSpriteID, 3350, 500)                 ` Top-LHS default placement
    SetSpriteDepth(attackBoatSpriteID, turretDepth)
    SetSpriteGroup(attackBoatSpriteID, ENEMIES_GROUP)
    SetSpriteShape(attackBoatSpriteID, POLYGON)
    SetSpritePhysicsOn(attackBoatSpriteID, 2)
    SetSpritePhysicsDamping(attackBoatSpriteID, .15)

    enemy.sprID = attackBoatSpriteID
    enemy.inflictedDamage = SINGLE_ENEMY_BOAT_DAMAGE
    enemy.designation     = SINGLE_ENEMY_BOAT
    enemy.damage.limit    = enemy_damage_limit
    enemy.vehicleSpeed    = enemy_vehicle_speed
    enemy.arrivedAtTarget = FALSE
    enemy.node.currentTargetIndex = NONE
    enemy.node.currentTargetSprID = NONE
    enemy.node.lastVisited_1 = NONE
    enemy.node.lastVisited_2 = NONE
    enemy.node.lastVisited_3 = NONE
    enemy.node.lastVisited_4 = NONE
    enemy.node.lastVisited_5 = NONE

    enemy.width#     = GetSpriteWidth(attackBoatSpriteID)
    enemy.height#    = GetSpriteHeight(attackBoatSpriteID)
    enemy.angle#     = GetSpriteAngle(attackBoatSpriteID)
    enemy.x#         = GetSpriteX(attackBoatSpriteID)
    enemy.y#         = GetSpriteY(attackBoatSpriteID)
    enemy.absCtrX#   = enemy.x#+enemy.width#/2.0
    enemy.absCtrY#   = enemy.y#+enemy.height#/2.0


    enemy.obstacleSensor.frontTopID     = CloneSprite(ballSpriteID)     ` Red Sensor Balls
    SetSpriteGroup(enemy.obstacleSensor.frontTopID, ENEMIES_GROUP)
    SetSpritePhysicsOn(enemy.obstacleSensor.frontTopID, DYNAMIC)
    SetSpritePhysicsIsSensor(enemy.obstacleSensor.frontTopID, SENSOR)

    enemy.obstacleSensor.midTopID       = CloneSprite(ballSpriteID)
    SetSpriteGroup(enemy.obstacleSensor.midTopID, ENEMIES_GROUP)
    SetSpritePhysicsOn(enemy.obstacleSensor.midTopID, DYNAMIC)
    SetSpritePhysicsIsSensor(enemy.obstacleSensor.midTopID, SENSOR)

    enemy.obstacleSensor.backTopID      = CloneSprite(ballSpriteID)
    SetSpriteGroup(enemy.obstacleSensor.backTopID, ENEMIES_GROUP)
    SetSpritePhysicsOn(enemy.obstacleSensor.backTopID, DYNAMIC)
    SetSpritePhysicsIsSensor(enemy.obstacleSensor.backTopID, SENSOR)


    enemy.obstacleSensor.frontBottomID  = CloneSprite(ballSpriteID)
    SetSpriteGroup(enemy.obstacleSensor.frontBottomID, ENEMIES_GROUP)
    SetSpritePhysicsOn(enemy.obstacleSensor.frontBottomID, DYNAMIC)
    SetSpritePhysicsIsSensor(enemy.obstacleSensor.frontBottomID, SENSOR)


    enemy.obstacleSensor.midBottomID    = CloneSprite(ballSpriteID)
    SetSpriteGroup(enemy.obstacleSensor.midBottomID, ENEMIES_GROUP)
    SetSpritePhysicsOn(enemy.obstacleSensor.midBottomID, DYNAMIC)
    SetSpritePhysicsIsSensor(enemy.obstacleSensor.midBottomID, SENSOR)


    enemy.obstacleSensor.backBottomID   = CloneSprite(ballSpriteID)
    SetSpriteGroup(enemy.obstacleSensor.backBottomID, ENEMIES_GROUP)
    SetSpritePhysicsOn(enemy.obstacleSensor.backBottomID, DYNAMIC)
    SetSpritePhysicsIsSensor(enemy.obstacleSensor.backBottomID, SENSOR)


    spriteLookup[attackBoatSpriteID].sprID = attackBoatSpriteID
    spriteLookup[attackBoatSpriteID].typeDefinition = SINGLE_ENEMY_BOAT
    spriteLookup[attackBoatSpriteID].localIndex = SINGLETON

    ChangeEnemyState(ENEMY_STATE_DEPLOYED)
    ChangeEnemyBehaviorState(IDLE, SINGLETON)

RemStart
    for i = 1 to enemy_limit
        myenemy[i].sprID = CloneSprite(attackBoatSpriteID)
        SetSpriteSize(myenemy[i].sprID, 100, -1)
        SetSpritePosition(myenemy[i].sprID, Random(100, 1000), Random(100, 1000))
        SetSpriteDepth(myenemy[i].sprID, shipDepth)
        SetSpriteGroup(myenemy[i].sprID, ENEMIES_GROUP)
        SetSpritePhysicsOn(myenemy[i].sprID, DYNAMIC)
        SetSpritePhysicsDamping(myenemy[i].sprID, .75)
        myenemy[i].damage.limit      = enemy_damage_limit
        myenemy[i].inflictedDamage   = ATTACK_BOAT_DAMAGE
        myenemy[i].designation       = ENEMY_BOAT
        spriteLookup[myenemy[i].sprID].sprID = myenemy[i].sprID
        spriteLookup[myenemy[i].sprID].typeDefinition = ENEMY_BOAT
        spriteLookup[myenemy[i].sprID].localIndex = i
        myenemy[i].isDestroyed = FALSE
        ChangeMyEnemyState(i, ENEMY_STATE_DEPLOYED)
    next i
RemEnd


    for i = 1 to enemy_limit  `<= This *must* begin at 1 or else you get ghost sprite
        attackBoats[i].sprID = CloneSprite(attackBoatSpriteID)
        SetSpriteSize(attackBoats[i].sprID, 100, -1)
        SetSpritePosition(attackBoats[i].sprID, Random(100, 2000), Random(100, 1000))
        SetSpriteDepth(attackBoats[i].sprID, shipDepth)
        SetSpriteGroup(attackBoats[i].sprID, ENEMIES_GROUP)
        SetSpritePhysicsOn(attackBoats[i].sprID, DYNAMIC)
        SetSpritePhysicsDamping(attackBoats[i].sprID, .75)
        attackBoats[i].damage.limit     = enemy_damage_limit
        attackBoats[i].vehicleSpeed     = enemy_vehicle_speed
        attackBoats[i].inflictedDamage  = ATTACK_BOAT_DAMAGE
        attackBoats[i].designation      = ATTACK_BOAT

        attackBoats[i].width#     = GetSpriteWidth(attackBoats[i].sprID)    ` Needed for AI behavior
        attackBoats[i].height#    = GetSpriteHeight(attackBoats[i].sprID)
        attackBoats[i].angle#     = GetSpriteAngle(attackBoats[i].sprID)
        attackBoats[i].x#         = GetSpriteX(attackBoats[i].sprID)
        attackBoats[i].y#         = GetSpriteY(attackBoats[i].sprID)
        attackBoats[i].absCtrX#   = attackBoats[i].x#+attackBoats[i].width#/2.0
        attackBoats[i].absCtrY#   = attackBoats[i].y#+attackBoats[i].height#/2.0


        attackBoats[i].steering.sprID = CloneSprite(gunnerBulletSpriteID)
        SetSpriteGroup(attackBoats[i].steering.sprID, ENEMIES_GROUP)
        SetSpriteDepth(attackBoats[i].steering.sprID, targetDepth)
        SetSpriteSize(attackBoats[i].steering.sprID, 15, 15)
        attackBoats[i].steering.x# = GetSpriteX(attackBoats[i].steering.sprID)                   ` Top
        attackBoats[i].steering.y# = GetSpriteY(attackBoats[i].steering.sprID)                   ` Left
        attackBoats[i].steering.width# = GetSpriteWidth(attackBoats[i].steering.sprID)           ` Width Offset
        attackBoats[i].steering.height# = GetSpriteHeight(attackBoats[i].steering.sprID)         ` Height Offset
        attackBoats[i].steering.absCtrX# = attackBoats[i].steering.x#+attackBoats[i].steering.width#/2.0  ` Absolute Center X
        attackBoats[i].steering.absCtrY# = attackBoats[i].steering.y#+attackBoats[i].steering.height#/2.0 ` Absolute Center Y
        attackBoats[i].steering.angle# = GetSpriteAngle(attackBoats[i].steering.sprID)           ` Angle
        SetSpriteOffset(attackBoats[i].steering.sprID, attackBoats[i].steering.absCtrX#, attackBoats[i].steering.absCtrY#)
        SetSpritePositionByOffset(attackBoats[i].steering.sprID, 1500, 2000)
        SetSpritePhysicsOn(attackBoats[i].steering.sprID, DYNAMIC)
        SetSpritePhysicsIsSensor(attackBoats[i].steering.sprID, SENSOR)
        SetSpriteVisible(attackBoats[i].steering.sprID, INVISIBLE)


        spriteLookup[attackBoats[i].sprID].sprID = attackBoats[i].sprID
        spriteLookup[attackBoats[i].sprID].typeDefinition = ATTACK_BOAT
        spriteLookup[attackBoats[i].sprID].localIndex = i

        attackBoats[i].isDestroyed = FALSE
        ChangeAttackBoatsState(i, ENEMY_STATE_DEPLOYED)
        ChangeAttackBoatsBehaviorState(i, IDLE)
    next i

EndFunction


Function DestroyEnemy()
    if (enemy.isDestroyed = FALSE)
        SetAnimationToCenterOfObject(enemy.sprID, tTurretExplodeAnimSpriteID)
        SetSpriteVisible(tTurretExplodeAnimSpriteID, VISIBLE)
        PlaySprite(tTurretExplodeAnimSpriteID,FRAME_RATE_2,NO_LOOP,1,135)
        enemy.isDestroyed = TRUE
        SetSpriteVisible(enemy.sprID, INVISIBLE)
        SetSpritePhysicsOff(enemy.sprID)
        DeleteSprite(enemy.sprID)
    endif
EndFunction


Function DestroyMyEnemy(index)
    if (myenemy[index].isDestroyed = FALSE)
        SetAnimationToCenterOfObject(myenemy[index].sprID ,tTurretExplodeAnimSpriteID)
        SetSpriteVisible(tTurretExplodeAnimSpriteID, VISIBLE)
        PlaySprite(tTurretExplodeAnimSpriteID,FRAME_RATE_2,NO_LOOP,1,135)
        myenemy[index].isDestroyed = TRUE
        SetSpriteVisible(myenemy[index].sprID, INVISIBLE)
        SetSpritePhysicsOff(myenemy[index].sprID)
        DeleteSprite(myenemy[index].sprID)
    endif
EndFunction


Function DestroyAttackBoats(index)
    if (attackBoats[index].isDestroyed = FALSE)
        SetAnimationToCenterOfObject(attackBoats[index].sprID ,tTurretExplodeAnimSpriteID)
        SetSpriteVisible(tTurretExplodeAnimSpriteID, VISIBLE)
        PlaySprite(tTurretExplodeAnimSpriteID,FRAME_RATE_2,NO_LOOP,1,135)
        attackBoats[index].isDestroyed = TRUE
        SetSpriteVisible(attackBoats[index].sprID, INVISIBLE)
        SetSpritePhysicsOff(attackBoats[index].sprID)
        DeleteSprite(attackBoats[index].sprID)
    endif
EndFunction


Function SetAnimationToCenterOfObject(objectSprID, animSprID)
    if (GetSpriteExists(objectSprID) = EXISTS)
        x# = GetSpriteX(animSprID)
        y# = GetSpriteY(animSprID)
        w# = GetSpriteWidth(animSprID)
        h# = GetSpriteHeight(animSprID)
        SetSpritePosition(animSprID, GetSpriteX(objectSprID), GetSpriteY(objectSprID))
    endif
EndFunction



Function CheckCurrentEnemiesStates()
    if (GetSpriteExists(enemy.sprID) = EXISTS)

        enemy.angle#     = GetSpriteAngle(enemy.sprID)
        enemy.x#         = GetSpriteX(enemy.sprID)
        enemy.y#         = GetSpriteY(enemy.sprID)
        enemy.absCtrX#   = enemy.x#+enemy.width#/2.0
        enemy.absCtrY#   = enemy.y#+enemy.height#/2.0

        ` *** Enemy Ship Sensor Data ****
        enemy.obstacleSensor.frontTop_x = ((enemy.width#/2.0)+130)*(Cos(enemy.angle#-8))+enemy.absCtrX#      ` Front
        enemy.obstacleSensor.frontTop_y = ((enemy.width#/2.0)+130)*(Sin(enemy.angle#-8))+enemy.absCtrY#
        SetSpritePositionByOffset(enemy.obstacleSensor.frontTopID, enemy.obstacleSensor.frontTop_x, enemy.obstacleSensor.frontTop_y)

        enemy.obstacleSensor.midTop_x = ((enemy.width#/2.0)+50)*(Cos(enemy.angle#-13))+enemy.absCtrX#      ` Middle
        enemy.obstacleSensor.midTop_y = ((enemy.width#/2.0)+50)*(Sin(enemy.angle#-13))+enemy.absCtrY#
        SetSpritePositionByOffset(enemy.obstacleSensor.midTopID, enemy.obstacleSensor.midTop_x, enemy.obstacleSensor.midTop_y)

        enemy.obstacleSensor.backTop_x = ((enemy.width#/4.0)-100)*(Cos(enemy.angle#+90))+enemy.absCtrX#      ` Back
        enemy.obstacleSensor.backTop_y = ((enemy.width#/4.0)-100)*(Sin(enemy.angle#+90))+enemy.absCtrY#
        SetSpritePositionByOffset(enemy.obstacleSensor.backTopID, enemy.obstacleSensor.backTop_x, enemy.obstacleSensor.backTop_y)

        enemy.obstacleSensor.frontBottom_x = ((enemy.width#/2.0)+130)*(Cos(enemy.angle#+8))+enemy.absCtrX#
        enemy.obstacleSensor.frontBottom_y = ((enemy.width#/2.0)+130)*(Sin(enemy.angle#+8))+enemy.absCtrY#
        SetSpritePositionByOffset(enemy.obstacleSensor.frontBottomID, enemy.obstacleSensor.frontBottom_x, enemy.obstacleSensor.frontBottom_y)

        enemy.obstacleSensor.midBottom_x = ((enemy.width#/2.0)+50)*(Cos(enemy.angle#+13))+enemy.absCtrX#
        enemy.obstacleSensor.midBottom_y = ((enemy.width#/2.0)+50)*(Sin(enemy.angle#+13))+enemy.absCtrY#
        SetSpritePositionByOffset(enemy.obstacleSensor.midBottomID, enemy.obstacleSensor.midBottom_x, enemy.obstacleSensor.midBottom_y)

        enemy.obstacleSensor.backBottom_x  = ((enemy.width#/4.0)-100)*(Cos(enemy.angle#-90))+enemy.absCtrX#
        enemy.obstacleSensor.backBottom_y = ((enemy.width#/4.0)-100)*(Sin(enemy.angle#-90))+enemy.absCtrY#
        SetSpritePositionByOffset(enemy.obstacleSensor.backBottomID, enemy.obstacleSensor.backBottom_x, enemy.obstacleSensor.backBottom_y)

    endif
EndFunction



Function SetForceVectors(objectID, sensorLocation$)
    if (GetSpriteExists(objectID) = EXISTS)
         angle# = GetSpriteAngle(objectID)
         object$ = spriteLookup[objectID].typeDefinition
         vx# = GetSpritePhysicsVelocityX(objectID)
         vy# = GetSpritePhysicsVelocityY(objectID)
        force# = 500                                ` Force strength of Impulse

        if (angle# < -70) AND (angle# > -110)           ` *** Object moving UP ***
                select  sensorLocation$
                                                    ` *** Push Object RIGHT
                    case "frontTop"
                        vector_x# = force#
                        vector_y# = ZERO
                    endcase
                    case "midTop"
                        vector_x# = force#
                        vector_y# = ZERO
                    endcase
                    case "backTop"
                        vector_x# = force#
                        vector_y# = ZERO
                    endcase
                                                    ` *** Push Object LEFT
                    case "frontBottom"
                        vector_x# = -force#
                        vector_y# = ZERO
                    endcase
                    case "midBottom"
                        vector_x# = -force#
                        vector_y# = ZERO
                    endcase
                    case "backBottom"
                        vector_x# = -force#
                        vector_y# = ZERO
                    endcase
                endselect

        elseif (angle# > 70) OR (angle# < 110)        ` *** Object moving DOWN ***
                select  sensorLocation$
                                                    ` *** Push Object LEFT
                    case "frontTop"
                        vector_x# = -force#
                        vector_y# = ZERO
                    endcase
                    case "midTop"
                        vector_x# = -force#
                        vector_y# = ZERO
                    endcase
                    case "backTop"
                        vector_x# = -force#
                        vector_y# = ZERO
                    endcase
                                                    ` *** Push Object RIGHT
                    case "frontBottom"
                        vector_x# = force#
                        vector_y# = ZERO
                    endcase
                    case "midBottom"
                        vector_x# = force#
                        vector_y# = ZERO
                    endcase
                    case "backBottom"
                        vector_x# = force#
                        vector_y# = ZERO
                    endcase
                endselect

        elseif  (angle# > 150) OR (angle# < -150)   ` *** Object moving Left ***
                select  sensorLocation$
                                                    ` *** Push Object UP
                    case "frontTop"
                        vector_x# = ZERO
                        vector_y# = -force#
                    endcase
                    case "midTop"
                        vector_x# = ZERO
                        vector_y# = -force#
                    endcase
                    case "backTop"
                        vector_x# = ZERO
                        vector_y# = -force#
                    endcase
                                                    ` *** Push Object DOWN
                    case "frontBottom"
                        vector_x# = ZERO
                        vector_y# = force#
                    endcase
                    case "midBottom"
                        vector_x# = ZERO
                        vector_y# = force#
                    endcase
                    case "backBottom"
                        vector_x# = ZERO
                        vector_y# = force#
                    endcase
                endselect

        elseif (angle# > -30) AND (angle# < 30)         ` *** Object moving Right ***
                select  sensorLocation$
                                                    ` *** Push Object DOWN
                    case "frontTop"
                        vector_x# = ZERO
                        vector_y# = force#
                    endcase
                    case "midTop"
                        vector_x# = ZERO
                        vector_y# = force#
                    endcase
                    case "backTop"
                        vector_x# = ZERO
                        vector_y# = force#
                    endcase

                                                    ` *** Push Object UP
                    case "frontBottom"
                        vector_x# = ZERO
                        vector_y# = -force#
                    endcase
                    case "midBottom"
                        vector_x# = ZERO
                        vector_y# = -force#
                    endcase
                    case "backBottom"
                        vector_x# = ZERO
                        vector_y# = -force#
                    endcase
                endselect
        endif

         select object$
            case    SINGLE_ENEMY_BOAT   `["enemy"]
                enemy.forceVector.x = vector_x#
                enemy.forceVector.y = vector_y#
            endcase
            case    ATTACK_BOAT          `["attackboat"]
                ` Do Nothing
            endcase
        endselect

    endif
EndFunction




rem *******************************
rem  EOF Battleship enemies.agc
rem *******************************










