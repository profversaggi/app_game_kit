rem **********************************
rem Battleship collisiondetection.agc
rem **********************************


Function CheckMunitionsCollisions()
    CheckProjectileCollisions()
    CheckTorpedoCollisions()
    CheckBulletCollisions()
    CheckGunsCollisions()
EndFunction



` ***************** Ship Collision Detection ***********************


Function CheckGunsCollisions()

    ` **** Turrets *****
    if (GetSpriteExists(turretFront.sprID) = EXISTS)
        if (GetSpriteFirstContact(turretFront.sprID))
            baseType$ = spriteLookup[GetSpriteContactSpriteID2()].typeDefinition
            index = spriteLookup[GetSpriteContactSpriteID2()].localIndex
            select baseType$
                case    SINGLE_ENEMY_BOAT           `["enemy"]
                    AddDamageToShip(TURRET_FRONT, enemy.inflictedDamage)
                endcase
                case    ENEMY_BOAT                  `["myenemy"]
                    AddDamageToShip(TURRET_FRONT, myenemy[index].inflictedDamage)
                endcase
                case    ATTACK_BOAT                  `["attackBoat"]
                    AddDamageToShip(TURRET_FRONT, attackBoats[index].inflictedDamage)
                endcase
            endselect
        endif
    endif
    if (GetSpriteExists(turretTop.sprID) = EXISTS)
        if (GetSpriteFirstContact(turretTop.sprID))
            baseType$ = spriteLookup[GetSpriteContactSpriteID2()].typeDefinition
            index = spriteLookup[GetSpriteContactSpriteID2()].localIndex
            select baseType$
                case    SINGLE_ENEMY_BOAT           `["enemy"]
                    AddDamageToShip(TURRET_TOP, enemy.inflictedDamage)
                endcase
                case    ENEMY_BOAT                  `["myenemy"]
                    AddDamageToShip(TURRET_TOP, myenemy[index].inflictedDamage)
                endcase
                case    ATTACK_BOAT                  `["attackBoat"]
                    AddDamageToShip(TURRET_TOP, attackBoats[index].inflictedDamage)
                endcase
            endselect
        endif
    endif
    if (GetSpriteExists(turretRear.sprID) = EXISTS)
        if (GetSpriteFirstContact(turretRear.sprID))
            baseType$ = spriteLookup[GetSpriteContactSpriteID2()].typeDefinition
            index = spriteLookup[GetSpriteContactSpriteID2()].localIndex
            select baseType$
                case    SINGLE_ENEMY_BOAT           `["enemy"]
                    AddDamageToShip(TURRET_REAR, enemy.inflictedDamage)
                endcase
                case    ENEMY_BOAT                  `["myenemy"]
                    AddDamageToShip(TURRET_REAR, myenemy[index].inflictedDamage)
                endcase
                case    ATTACK_BOAT                  `["attackBoat"]
                    AddDamageToShip(TURRET_REAR, attackBoats[index].inflictedDamage)
                endcase
            endselect
        endif
    endif

    ` **** Gunners *****
    if (GetSpriteExists(leftGunner.sprID) = EXISTS)
        if (GetSpriteFirstContact(leftGunner.sprID))
            baseType$ = spriteLookup[GetSpriteContactSpriteID2()].typeDefinition
            index = spriteLookup[GetSpriteContactSpriteID2()].localIndex
            select baseType$
                case    SINGLE_ENEMY_BOAT           `["enemy"]
                    AddDamageToShip(GUNNER_LEFT, enemy.inflictedDamage)
                endcase
                case    ENEMY_BOAT                  `["myenemy"]
                    AddDamageToShip(GUNNER_LEFT, myenemy[index].inflictedDamage)
                endcase
                case    ATTACK_BOAT                  `["attackBoat"]
                    AddDamageToShip(GUNNER_LEFT, attackBoats[index].inflictedDamage)
                endcase
            endselect
        endif
    endif
    if (GetSpriteExists(rightGunner.sprID) = EXISTS)
        if (GetSpriteFirstContact(rightGunner.sprID))
            baseType$ = spriteLookup[GetSpriteContactSpriteID2()].typeDefinition
            index = spriteLookup[GetSpriteContactSpriteID2()].localIndex
            select baseType$
                case    SINGLE_ENEMY_BOAT           `["enemy"]
                    AddDamageToShip(GUNNER_RIGHT, enemy.inflictedDamage)
                endcase
                case    ENEMY_BOAT                  `["myenemy"]
                    AddDamageToShip(GUNNER_RIGHT, myenemy[index].inflictedDamage)
                endcase
                case    ATTACK_BOAT                  `["attackBoat"]
                    AddDamageToShip(GUNNER_RIGHT, attackBoats[index].inflictedDamage)
                endcase
            endselect
        endif
    endif
EndFunction





// *********** Munitions Collision Detection ***********************

Function CheckProjectileCollisions()

        ` *** Front Turret Projectiles
    for i = 0 to projectileLimit
        if (GetSpriteFirstContact(frontTurretLProjectile[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, frontTurretLProjectile[i].damage)
            ChangeFrontTurretLProjectileState(i, PROJECTILE_STATE_IMPACT)
        endif
        if (GetSpriteFirstContact(frontTurretRProjectile[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, frontTurretRProjectile[i].damage)
            ChangeFrontTurretRProjectileState(i, PROJECTILE_STATE_IMPACT)
        endif
        if (GetSpriteFirstContact(frontTurretMProjectile[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, frontTurretMProjectile[i].damage)
            ChangeFrontTurretMProjectileState(i, PROJECTILE_STATE_IMPACT)
        endif
    next i

        ` *** TOP Turret Projectiles
    for i = 0 to projectileLimit
        if (GetSpriteFirstContact(topTurretLProjectile[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, topTurretLProjectile[i].damage)
            ChangeTopTurretLProjectileState(i, PROJECTILE_STATE_IMPACT)
        endif
        if (GetSpriteFirstContact(topTurretRProjectile[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, topTurretLProjectile[i].damage)
            ChangeTopTurretRProjectileState(i, PROJECTILE_STATE_IMPACT)
        endif
        if (GetSpriteFirstContact(topTurretMProjectile[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, topTurretLProjectile[i].damage)
            ChangeTopTurretMProjectileState(i, PROJECTILE_STATE_IMPACT)
        endif
    next i

        ` *** Rear Turret Projectiles
    for i = 0 to projectileLimit

        if (GetSpriteFirstContact(rearTurretLProjectile[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, rearTurretLProjectile[i].damage)
            ChangeRearTurretLProjectileState(i, PROJECTILE_STATE_IMPACT)
        endif
        if (GetSpriteFirstContact(rearTurretRProjectile[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, rearTurretLProjectile[i].damage)
            ChangeRearTurretRProjectileState(i, PROJECTILE_STATE_IMPACT)
        endif
        if (GetSpriteFirstContact(rearTurretMProjectile[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, rearTurretLProjectile[i].damage)
            ChangeRearTurretMProjectileState(i, PROJECTILE_STATE_IMPACT)
        endif
    next i
EndFunction


Function CheckTorpedoCollisions()
    for i = 0 to torpedoLimit
        ` **** Left Torpedo
        if (GetSpriteFirstContact(leftTorpedo[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, leftTorpedo[i].damage)
            ChangeLeftTorpedoState(i, TORPEDO_STATE_IMPACT)
        endif
        ` **** Right Torpedo
        if (GetSpriteFirstContact(rightTorpedo[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, rightTorpedo[i].damage)
            ChangeRightTorpedoState(i, TORPEDO_STATE_IMPACT)
        endif
    next i
EndFunction



Function CheckBulletCollisions()
    ` **** Left Gunner
    for i = 0 to gunnerBulletLimit
        if (GetSpriteFirstContact(gunnerLGLBBullets[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, gunnerLGLBBullets[i].damage)
            ChangeLeftGunnerLBulletState(i, BULLET_STATE_IMPACT)
        endif
        if (GetSpriteFirstContact(gunnerLGRBBullets[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, gunnerLGRBBullets[i].damage)
            ChangeLeftGunnerRBulletState(i, BULLET_STATE_IMPACT)
        endif
    next i
    ` **** Right Gunner

    for i = 0 to gunnerBulletLimit
        if (GetSpriteFirstContact(gunnerRGLBBullets[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, gunnerRGLBBullets[i].damage)
            ChangeRightGunnerLBulletState(i, BULLET_STATE_IMPACT)
        endif
        if (GetSpriteFirstContact(gunnerRGRBBullets[i].sprID))
            AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, gunnerRGRBBullets[i].damage)
            ChangeRightGunnerRBulletState(i, BULLET_STATE_IMPACT)
        endif
    next i
EndFunction


// **** Establishes the 4 *Absolute* World Border(s) ******

` **** X ****
Function WorldBorderRight()
    border# = worldWidth
EndFunction border#

Function WorldBorderLeft()
    border# = 0
EndFunction border#

` **** Y ****
Function WorldBorderUp()
    border# = 0
EndFunction border#

Function WorldBorderDown()
    border# = worldHeight
EndFunction border#


// *********** World Borders Collision Detection ***********************

Function CheckWorldBorderCollisions()
                                                            ` *** X Coordinates ***
    ` Note: If the ship had been destroyed, exit the function.
     if (ship.state = SHIP_STATE_DESTROYED) then ExitFunction

     ` **** [TR/BR] RIGHT Border
     if ( ShipSensorTopRightX() >= WorldBorderRight()-borderWarningDistance OR ShipSensorBottomRightX() >= WorldBorderRight()-borderWarningDistance )
        Print("*** ALERT: Leaving Combat Zone ***")
        if ( ShipSensorTopRightX() >= WorldBorderRight()-borderBuffer OR ShipSensorBottomRightX() >= WorldBorderRight()-borderBuffer ) then ChangeShipState(SHIP_STATE_DESTROYED)

     ` **** [TR/BR] LEFT Border
     elseif ( ShipSensorTopRightX() <= WorldBorderLeft()+borderWarningDistance OR  ShipSensorBottomRightX() <= WorldBorderLeft()+borderWarningDistance )
        Print("*** ALERT: Leaving Combat Zone ***")
        if ( ShipSensorTopRightX() <= WorldBorderLeft()+borderBuffer OR  ShipSensorBottomRightX() <= WorldBorderLeft()+borderBuffer ) then ChangeShipState(SHIP_STATE_DESTROYED)

                                                            ` *** Y Coordinates ***
     ` ****[TR/BR] TOP Border
     elseif ( ShipSensorTopRightY() <= WorldBorderUp()+borderWarningDistance OR ShipSensorBottomRightY() <= WorldBorderUp()+borderWarningDistance )
        Print("*** ALERT: Leaving Combat Zone ***")
        if ( ShipSensorTopRightY() <= WorldBorderUp()+borderBuffer OR ShipSensorBottomRightY() <= WorldBorderUp()+borderBuffer ) then ChangeShipState(SHIP_STATE_DESTROYED)

     ` **** [TR/BR] BOTTOM Border
     elseif ( ShipSensorTopRightY() >= WorldBorderDown()-borderWarningDistance OR ShipSensorBottomRightY() >= WorldBorderDown()-borderWarningDistance )
        Print("*** ALERT: Leaving Combat Zone ***")
        if ( ShipSensorTopRightY() >= WorldBorderDown()-borderBuffer OR ShipSensorBottomRightY() >= WorldBorderDown()-borderBuffer ) then ChangeShipState(SHIP_STATE_DESTROYED)
    endif
EndFunction


// *********** Enemy Ship Collision Detection ***********************

Function CheckEnemySensorCollissions()
    if (GetSpriteExists(enemy.sprID) = EXISTS)
        tempGoal = GetStackTop(GOAL_STACK)                              ` Interrogate the currently executing Goal....
        ` **** FrontTop *****
        if (GetSpriteFirstContact(enemy.obstacleSensor.frontTopID))     ` If the FrontTop Sensor detects a collision,
            AddGoalToGoalStack(G_AVOID_OBSTACLE_ENEMY_FT_SENSOR)        ` ... add the proper (predefined) obstacle avoidance goal to the Goal Stack (if duplicate will not be added).
        elseif (tempGoal.goalName = G_AVOID_OBSTACLE_ENEMY_FT_SENSOR)   ` If there is *no* collission, check to see if the currently executing goal is this one,
            SetCurrentGoalSatisifiedFlag(TRUE)                          ` ... if so set it's 'Satisfied' flag to true so the InterrogateGoalStack() FN will remove it.
        endif
        ` **** MidTop *****
        if (GetSpriteFirstContact(enemy.obstacleSensor.midTopID))       ` If the MidTop Sensor detects a collision.....
            AddGoalToGoalStack(G_AVOID_OBSTACLE_ENEMY_MT_SENSOR)
        elseif (tempGoal.goalName = G_AVOID_OBSTACLE_ENEMY_MT_SENSOR)
            SetCurrentGoalSatisifiedFlag(TRUE)
        endif
        ` **** BackTop *****
        if (GetSpriteFirstContact(enemy.obstacleSensor.backTopID))      ` If the BackTop Sensor detects a collision...
            AddGoalToGoalStack(G_AVOID_OBSTACLE_ENEMY_BT_SENSOR)
        elseif (tempGoal.goalName = G_AVOID_OBSTACLE_ENEMY_BT_SENSOR)
            SetCurrentGoalSatisifiedFlag(TRUE)
        endif
        ` **** FrontBottom *****
        if (GetSpriteFirstContact(enemy.obstacleSensor.frontBottomID))   ` If the FrontBottom Sensor detects a collision...
            AddGoalToGoalStack(G_AVOID_OBSTACLE_ENEMY_FB_SENSOR)
        elseif (tempGoal.goalName = G_AVOID_OBSTACLE_ENEMY_FB_SENSOR)
            SetCurrentGoalSatisifiedFlag(TRUE)
        endif
        ` **** MidBottom *****
        if (GetSpriteFirstContact(enemy.obstacleSensor.midBottomID))     ` If the MidBottom Sensor detects a collision.....
            AddGoalToGoalStack(G_AVOID_OBSTACLE_ENEMY_MB_SENSOR)
        elseif (tempGoal.goalName = G_AVOID_OBSTACLE_ENEMY_MB_SENSOR)
            SetCurrentGoalSatisifiedFlag(TRUE)
        endif
        ` **** BackBottom *****
        if (GetSpriteFirstContact(enemy.obstacleSensor.backBottomID))    ` If the BackBottom Sensor detects a collision...
            AddGoalToGoalStack(G_AVOID_OBSTACLE_ENEMY_BB_SENSOR)
        elseif (tempGoal.goalName = G_AVOID_OBSTACLE_ENEMY_BB_SENSOR)
            SetCurrentGoalSatisifiedFlag(TRUE)
        endif
    endif
EndFunction







rem **************************************
rem EOF Battleship collisiondetection.agc
rem **************************************


