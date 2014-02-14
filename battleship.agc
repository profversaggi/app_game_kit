rem **************************
rem Battleship battleship.agc
rem **************************


` **** ControlShip()
Function ControlShip()

    ` Note: If the ship had been destroyed, exit the function.
    if (ship.state = SHIP_STATE_DESTROYED) then ExitFunction

    if GetPointerState() = 1    ` If Button is Pressed ...
        ` **** Handle *ALL* Individual Button Presses
        select GetSpriteHit(ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY()))  ` Use when using World Coordinated [executing SetViewOffset()]

            case 101: ` **** Rotate Ship Left [leftButtonSpriteID]
                CheckCurrentShipState()
                ship.angle# = ship.angle#-ship.rotateSpeed# ` (NOTE: Subtraction)
                SetSpriteAngle(ship.sprID, ship.angle#)
            endcase
            case 102: ` **** Roatate Ship Right [rightButtonSpriteID]
                CheckCurrentShipState()
                ship.angle# = ship.angle#+ship.rotateSpeed#  ` (NOTE: Addition)
                SetSpriteAngle(ship.sprID, ship.angle#)
            endcase
            case 103: ` **** Propulsion of Ship [propulsionButtonSpriteID]
                CheckCurrentShipState()
                butonUP = FALSE
                ship.throttle_engine = TRUE
                SetParticlesVisible(shipEngineWakeParticleID, VISIBLE)  ` Turn *on* the engine wake
                `SetParticlesVisible(shipSternWakeParticleID, VISIBLE)  ` Turn *on* the engine wake
                EngageShipPropulsion(ship.angle#)
            endcase
            case 112: ` **** Reverse Engines [reverseButtonSpriteID]
                CheckCurrentShipState()
                if (ship.reverseEngines = FALSE)
                    ship.reverseEngines = TRUE
                elseif (ship.reverseEngines = TRUE)
                    ship.reverseEngines = FALSE
                endif
            endcase
            case 113: ` **** Throttle UP [throttleUpSpriteID]
                ship.throttle# = ship.throttle# + 1.0
            endcase
            case 114: ` **** Throttle Down [throttleDownSpriteID]
                ship.throttle# = ship.throttle# - 1.0
            endcase
        endselect
    else
        buttonUp = TRUE     ` If no buttons are being pressed, record that, do cleanup tasks
        ship.throttle_engine = FALSE
        SetParticlesVisible(shipEngineWakeParticleID, INVISIBLE)  ` Turn *off* the engine wake
        `SetParticlesVisible(shipSternWakeParticleID, INVISIBLE)  ` Turn *off* the engine wake
    endif
EndFunction



` **** ControlGuns()
Function ControlGuns()

    ` Note: If the ship had been destroyed, exit the function.
    if (ship.state = SHIP_STATE_DESTROYED) then ExitFunction

    if GetPointerState() = 1    ` If Button is Pressed
        ` **** Handle *ALL* Individual Button Presses - Rotation Hard Stops enforced via/IF Clause in each Case Select statement
        select GetSpriteHit(ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY())) // Use when executing SetViewOffset()

            case 118: ` **** Rotate Front Turret Left [turretFrontLButtonSPriteID]
                if (turretFront.state = TURRETFRONT_STATE_DEPLOYED)
                    CheckCurrentShipState()
                    turretFront.angle# = turretFront.angle#+turretFront.rotateSpeed# ` (NOTE: Addition)
                    `if (turretFront.angle# >= turretFront.leftStop) then turretFront.angle#=turretFront.leftStop
                    SetSpriteAngle(turretFront.sprID, turretFront.angle#)
                endif
            endcase
            case 119: ` **** Rotate Front Turret Right [turretFrontRButtonSPriteID]
                if (turretFront.state = TURRETFRONT_STATE_DEPLOYED)
                    CheckCurrentShipState()
                    turretFront.angle# = turretFront.angle#-turretFront.rotateSpeed# ` (NOTE: Subtraction)
                    `if (turretFront.angle# <= turretFront.rightStop) then turretFront.angle#=turretFront.rightStop
                    SetSpriteAngle(turretFront.sprID, turretFront.angle#)
                endif
            endcase
            case 120: ` **** Rotate Rear Turret Left [turretRearLButtonSPriteID]
                if (turretRear.state = TURRETREAR_STATE_DEPLOYED)
                    CheckCurrentShipState()
                    turretRear.angle# = turretRear.angle#+turretRear.rotateSpeed# ` (NOTE: Addition)
                    if (turretRear.angle# >= turretRear.leftStop) then turretRear.angle#=turretRear.leftStop
                    SetSpriteAngle(turretRear.sprID, turretRear.angle#)
                endif
            endcase
            case 121: ` **** Rotate Rear Turret Right [turretRearRButtonSPriteID]
                if (turretRear.state = TURRETREAR_STATE_DEPLOYED)
                    CheckCurrentShipState()
                    turretRear.angle# = turretRear.angle#-turretRear.rotateSpeed# ` (NOTE: Subtraction)
                    if (turretRear.angle# <= turretRear.rightStop) then turretRear.angle#=turretRear.rightStop
                    SetSpriteAngle(turretRear.sprID, turretRear.angle#)
                endif
            endcase
            case 122: ` **** Rotate Top Turret Left [turretTopLButtonSPriteID]
                if (turretTop.state = TURRETTOP_STATE_DEPLOYED)
                    CheckCurrentShipState()
                    turretTop.angle# = turretTop.angle#+turretTop.rotateSpeed# ` (NOTE: Addition)
                    if (turretTop.angle# >= turretTop.leftStop) then turretTop.angle#=turretTop.leftStop
                    SetSpriteAngle(turretTop.sprID, turretTop.angle#)
                endif
            endcase
            case 123: ` **** Rotate Top Turret Right [turretTopRButtonSPriteID]
                if (turretTop.state = TURRETTOP_STATE_DEPLOYED)
                    CheckCurrentShipState()
                    turretTop.angle# = turretTop.angle#-turretTop.rotateSpeed# ` (NOTE: Subtraction)
                    if (turretTop.angle# <= turretTop.rightStop) then turretTop.angle#=turretTop.rightStop
                    SetSpriteAngle(turretTop.sprID, turretTop.angle#)
                endif
            endcase
            case 126: ` **** Rotate Left Gunner Left [leftGunnerLButtonSPriteID]
                if (leftGunner.state = LEFTGUNNER_STATE_DEPLOYED)
                    CheckCurrentShipState()
                    leftGunner.angle# = leftGunner.angle#+leftGunner.rotateSpeed# ` (NOTE: Addition)
                    if (leftGunner.angle# >= leftGunner.leftStop) then leftGunner.angle#=leftGunner.leftStop
                    SetSpriteAngle(leftGunner.sprID, leftGunner.angle#)
                endif
            endcase
            case 127: ` **** Rotate Left Gunner Right [leftGunnerRButtonSPriteID]
                if (leftGunner.state = LEFTGUNNER_STATE_DEPLOYED)
                    CheckCurrentShipState()
                    leftGunner.angle# = leftGunner.angle#-leftGunner.rotateSpeed# ` (NOTE: Subtraction)
                    if (leftGunner.angle# <= leftGunner.rightStop) then leftGunner.angle#=leftGunner.rightStop
                    SetSpriteAngle(leftGunner.sprID, leftGunner.angle#)
                endif
            endcase
            case 128: ` **** Rotate Right Gunner Left [rightGunnerLButtonSPriteID]
                if (rightGunner.state = RIGHTGUNNER_STATE_DEPLOYED)
                    CheckCurrentShipState()
                    rightGunner.angle# = rightGunner.angle#+rightGunner.rotateSpeed# ` (NOTE: Addition)
                    if (rightGunner.angle# >= rightGunner.leftStop) then rightGunner.angle#=rightGunner.leftStop
                    SetSpriteAngle(rightGunner.sprID, rightGunner.angle#)
                endif
            endcase
            case 129: ` **** Rotate Right Gunner Right [rightGunnerRButtonSPriteID]
                if (rightGunner.state = RIGHTGUNNER_STATE_DEPLOYED)
                    CheckCurrentShipState()
                    rightGunner.angle# = rightGunner.angle#-rightGunner.rotateSpeed# ` (NOTE: Subtraction)
                    if (rightGunner.angle# <= rightGunner.rightStop) then rightGunner.angle#=rightGunner.rightStop
                    SetSpriteAngle(rightGunner.sprID, rightGunner.angle#)
                endif
            endcase
            case 130: ` **** Fire Front Turret [fireTurretFrontButtonID]
                if (turretFront.state = TURRETFRONT_STATE_DEPLOYED)
                    turretFront.fired = TRUE
                    CheckCurrentShipState()
                    angle# = GetSpriteAngle(turretFront.sprID)
                    if (buttonUp = TRUE) AND (GetSeconds() > frontTurretFireTime + 2)` If this is the FIRST time *this* button is pressed buttonUp will equal TRUE
                        if (frontTurretProjectileCount = projectileLimit) then frontTurretProjectileCount = 0
                        frontTurretProjectileCount = frontTurretProjectileCount + 1
                        LoadFTProjectiles(frontTurretRProjectile[frontTurretProjectileCount].sprID, "right",  angle#)
                        LoadFTProjectiles(frontTurretLProjectile[frontTurretProjectileCount].sprID, "left",   angle#)
                        LoadFTProjectiles(frontTurretMProjectile[frontTurretProjectileCount].sprID, "center", angle#)
                        pa# = ship.angle#-turretFront.angle#
                        SetSpriteAngle(frontTurretRProjectile[frontTurretProjectileCount].sprID, pa#)
                        SetSpriteAngle(frontTurretLProjectile[frontTurretProjectileCount].sprID, pa#)
                        SetSpriteAngle(frontTurretMProjectile[frontTurretProjectileCount].sprID, pa#)
                        vx# = ordinance_speed*Cos(ship.angle#-turretFront.angle#)
                        vy# = ordinance_speed*Sin(ship.angle#-turretFront.angle#)
                        SetSpritePhysicsVelocity(frontTurretRProjectile[frontTurretProjectileCount].sprID, vx#, vy#)  ` *** Launch 3 Projectiles
                        SetSpritePhysicsVelocity(frontTurretLProjectile[frontTurretProjectileCount].sprID, vx#, vy#)
                        SetSpritePhysicsVelocity(frontTurretMProjectile[frontTurretProjectileCount].sprID, vx#, vy#)
                        frontTurretFireTime = GetSeconds()
                        SetAnimationToHeadOfFrontTurret(ftCannonFireAnimSpriteID, angle#)
                        PlaySprite(ftCannonFireAnimSpriteID,FRAME_RATE_6,NO_LOOP,1,25)
                        ChangeLights(ftReloadLightSpriteID, ftLaunchLightSpriteID)    ` Change Fire/ReLoad Indicators
                        ChangeFrontTurretLProjectileState(frontTurretProjectileCount, PROJECTILE_STATE_FIRED)
                        ChangeFrontTurretRProjectileState(frontTurretProjectileCount, PROJECTILE_STATE_FIRED)
                        ChangeFrontTurretMProjectileState(frontTurretProjectileCount, PROJECTILE_STATE_FIRED)
                        SetParticlesToTailOfSprite(frontTurretRParticles[frontTurretProjectileCount].particleID, frontTurretRProjectile[frontTurretProjectileCount].sprID, pa#)
                        SetParticlesToTailOfSprite(frontTurretLParticles[frontTurretProjectileCount].particleID, frontTurretLProjectile[frontTurretProjectileCount].sprID, pa#)
                        SetParticlesToTailOfSprite(frontTurretMParticles[frontTurretProjectileCount].particleID, frontTurretMProjectile[frontTurretProjectileCount].sprID, pa#)
                        frontTurretRParticles[frontTurretProjectileCount].active = TRUE
                        frontTurretLParticles[frontTurretProjectileCount].active = TRUE
                        frontTurretMParticles[frontTurretProjectileCount].active = TRUE
                        buttonUp = FALSE ` Set buttonUp to FALSE to signal that *this* key is being held down (and we don't want a rapid fire turret)
                    endif
                endif
            endcase
            case 131: ` **** Fire Rear Turret [fireTurretRearButtonID]
                if (turretRear.state = TURRETREAR_STATE_DEPLOYED)
                    turretRear.fired = TRUE
                    CheckCurrentShipState()
                    angle# = GetSpriteAngle(turretRear.sprID)
                    if (buttonUp = TRUE) AND (GetSeconds() > rearTurretFireTime + 2)` If this is the FIRST time *this* button is pressed buttonUp will equal TRUE
                        if (rearTurretProjectileCount = projectileLimit) then rearTurretProjectileCount = 0
                        rearTurretProjectileCount = rearTurretProjectileCount + 1
                        LoadRTProjectiles(rearTurretRProjectile[rearTurretProjectileCount].sprID, "right",  angle#)
                        LoadRTProjectiles(rearTurretLProjectile[rearTurretProjectileCount].sprID, "left",   angle#)
                        LoadRTProjectiles(rearTurretMProjectile[rearTurretProjectileCount].sprID, "center", angle#)
                        pa# = ship.angle#-turretRear.angle#
                        SetSpriteAngle(rearTurretRProjectile[rearTurretProjectileCount].sprID, pa#)
                        SetSpriteAngle(rearTurretLProjectile[rearTurretProjectileCount].sprID, pa#)
                        SetSpriteAngle(rearTurretMProjectile[rearTurretProjectileCount].sprID, pa#)
                        vx# = ordinance_speed*Cos(ship.angle#-turretRear.angle#)
                        vy# = ordinance_speed*Sin(ship.angle#-turretRear.angle#)
                        SetSpritePhysicsVelocity(rearTurretRProjectile[rearTurretProjectileCount].sprID, vx#, vy#)  ` *** Launch 3 Projectiles
                        SetSpritePhysicsVelocity(rearTurretLProjectile[rearTurretProjectileCount].sprID, vx#, vy#)
                        SetSpritePhysicsVelocity(rearTurretMProjectile[rearTurretProjectileCount].sprID, vx#, vy#)
                        rearTurretFireTime = GetSeconds()
                        SetAnimationToHeadOfRearTurret(rtCannonFireAnimSpriteID, angle#)
                        PlaySprite(rtCannonFireAnimSpriteID,FRAME_RATE_6,NO_LOOP,1,25)
                        ChangeLights(rtReloadLightSpriteID, rtLaunchLightSpriteID)    ` Change Fire/ReLoad Indicators
                        ChangeRearTurretLProjectileState(rearTurretProjectileCount, PROJECTILE_STATE_FIRED)
                        ChangeRearTurretRProjectileState(rearTurretProjectileCount, PROJECTILE_STATE_FIRED)
                        ChangeRearTurretMProjectileState(rearTurretProjectileCount, PROJECTILE_STATE_FIRED)
                        SetParticlesToTailOfSprite(rearTurretRParticles[rearTurretProjectileCount].particleID, rearTurretRProjectile[rearTurretProjectileCount].sprID, pa#)
                        SetParticlesToTailOfSprite(rearTurretLParticles[rearTurretProjectileCount].particleID, rearTurretLProjectile[rearTurretProjectileCount].sprID, pa#)
                        SetParticlesToTailOfSprite(rearTurretMParticles[rearTurretProjectileCount].particleID, rearTurretMProjectile[rearTurretProjectileCount].sprID, pa#)
                        rearTurretRParticles[rearTurretProjectileCount].active = TRUE
                        rearTurretLParticles[rearTurretProjectileCount].active = TRUE
                        rearTurretMParticles[rearTurretProjectileCount].active = TRUE
                        buttonUp = FALSE ` Set buttonUp to FALSE to signal that *this* key is being held down (and we don't want a rapid fire turret)
                    endif
                endif
            endcase
            case 132: ` **** Fire Top Turret [fireTurretTopButtonID]
                if (turretTop.state = TURRETTOP_STATE_DEPLOYED)
                    turretTop.fired = TRUE
                    CheckCurrentShipState()
                    angle# = GetSpriteAngle(turretTop.sprID)
                    if (buttonUp = TRUE) AND (GetSeconds() > topTurretFireTime + 2)` If this is the FIRST time *this* button is pressed buttonUp will equal TRUE
                        if (topTurretProjectileCount = projectileLimit) then topTurretProjectileCount = 0
                        topTurretProjectileCount = topTurretProjectileCount + 1
                        LoadTTProjectiles(topTurretRProjectile[topTurretProjectileCount].sprID, "right",  angle#)
                        LoadTTProjectiles(topTurretLProjectile[topTurretProjectileCount].sprID, "left",   angle#)
                        LoadTTProjectiles(topTurretMProjectile[topTurretProjectileCount].sprID, "center", angle#)
                        pa# = ship.angle#-turretTop.angle#
                        SetSpriteAngle(topTurretRProjectile[topTurretProjectileCount].sprID, pa#)
                        SetSpriteAngle(topTurretLProjectile[topTurretProjectileCount].sprID, pa#)
                        SetSpriteAngle(topTurretMProjectile[topTurretProjectileCount].sprID, pa#)
                        vx# = ordinance_speed*Cos(ship.angle#-turretTop.angle#)
                        vy# = ordinance_speed*Sin(ship.angle#-turretTop.angle#)
                        SetSpritePhysicsVelocity(topTurretRProjectile[topTurretProjectileCount].sprID, vx#, vy#)    ` *** Launch 3 Projectiles
                        SetSpritePhysicsVelocity(topTurretLProjectile[topTurretProjectileCount].sprID, vx#, vy#)
                        SetSpritePhysicsVelocity(topTurretMProjectile[topTurretProjectileCount].sprID, vx#, vy#)
                        topTurretFireTime = GetSeconds()
                        SetAnimationToHeadOfTopTurret(ttCannonFireAnimSpriteID, angle#)
                        PlaySprite(ttCannonFireAnimSpriteID,FRAME_RATE_6,NO_LOOP,1,25)
                        ChangeLights(ttReloadLightSpriteID, ttLaunchLightSpriteID)    ` Change Fire/ReLoad Indicators
                        ChangeTopTurretLProjectileState(topTurretProjectileCount, PROJECTILE_STATE_FIRED)
                        ChangeTopTurretRProjectileState(topTurretProjectileCount, PROJECTILE_STATE_FIRED)
                        ChangeTopTurretMProjectileState(topTurretProjectileCount, PROJECTILE_STATE_FIRED)
                        SetParticlesToTailOfSprite(topTurretRParticles[topTurretProjectileCount].particleID, topTurretRProjectile[topTurretProjectileCount].sprID, pa#)
                        SetParticlesToTailOfSprite(topTurretLParticles[topTurretProjectileCount].particleID, topTurretLProjectile[topTurretProjectileCount].sprID, pa#)
                        SetParticlesToTailOfSprite(topTurretMParticles[topTurretProjectileCount].particleID, topTurretMProjectile[topTurretProjectileCount].sprID, pa#)
                        topTurretRParticles[topTurretProjectileCount].active = TRUE
                        topTurretLParticles[topTurretProjectileCount].active = TRUE
                        topTurretMParticles[topTurretProjectileCount].active = TRUE
                        buttonUp = FALSE ` Set buttonUp to FALSE to signal that *this* key is being held down (and we don't want a rapid fire turret)
                    endif
                endif
            endcase
            case 133: ` **** Fire Left Gunner [fireLeftGunnerButtonID]
                if (leftGunner.state = LEFTGUNNER_STATE_DEPLOYED)
                    CheckCurrentShipState()
                    angle# = GetSpriteAngle(leftGunner.sprID)
                    SetAnimationToHeadOfLeftGunner(leftGunnerFireAnimSpriteID, angle#)
                    PlaySprite(leftGunnerFireAnimSpriteID,FRAME_RATE_6,0,1,3)
                    Sync()
                    if (gunnerLBulletCount = gunnerBulletLimit) then gunnerLBulletCount = 0
                    gunnerLBulletCount = gunnerLBulletCount + 1
                    LoadLeftGunnerBullets(gunnerLGLBBullets[gunnerLBulletCount].sprID, "left", angle#)
                    LoadLeftGunnerBullets(gunnerLGRBBullets[gunnerLBulletCount].sprID, "right", angle#)
                    vx# = ordinance_speed*Cos(ship.angle#-leftGunner.angle#)
                    vy# = ordinance_speed*Sin(ship.angle#-leftGunner.angle#)
                    SetSpritePhysicsVelocity(gunnerLGLBBullets[gunnerLBulletCount].sprID, vx#, vy#)
                    SetSpritePhysicsVelocity(gunnerLGRBBullets[gunnerLBulletCount].sprID, vx#, vy#)
                    ChangeLeftGunnerLBulletState(gunnerLBulletCount, BULLET_STATE_FIRED)
                    ChangeLeftGunnerRBulletState(gunnerLBulletCount, BULLET_STATE_FIRED)
                endif
            endcase
            case 134: ` **** Fire Right Gunner [fireRightGunnerButtonID]
                if (rightGunner.state = RIGHTGUNNER_STATE_DEPLOYED)
                    CheckCurrentShipState()
                    angle# = GetSpriteAngle(rightGunner.sprID)
                    SetAnimationToHeadOfrightGunner(rightGunnerFireAnimSpriteID, angle#)
                    PlaySprite(rightGunnerFireAnimSpriteID,FRAME_RATE_6,0,1,3)
                    Sync()
                    if (gunnerRBulletCount = gunnerBulletLimit) then gunnerRBulletCount = 0
                    gunnerRBulletCount = gunnerRBulletCount + 1
                    LoadRightGunnerBullets(gunnerRGLBBullets[gunnerRBulletCount].sprID, "left", angle#)
                    LoadRightGunnerBullets(gunnerRGRBBullets[gunnerRBulletCount].sprID, "right", angle#)
                    vx# = ordinance_speed*Cos(ship.angle#-rightGunner.angle#)
                    vy# = ordinance_speed*Sin(ship.angle#-rightGunner.angle#)
                    SetSpritePhysicsVelocity(gunnerRGLBBullets[gunnerRBulletCount].sprID, vx#, vy#)
                    SetSpritePhysicsVelocity(gunnerRGRBBullets[gunnerRBulletCount].sprID, vx#, vy#)
                    ChangeRightGunnerLBulletState(gunnerRBulletCount, BULLET_STATE_FIRED)
                    ChangeRightGunnerRBulletState(gunnerRBulletCount, BULLET_STATE_FIRED)
                endif
            endcase
            case 135: ` **** Fire Left Torpedos [fireLeftTorpedoButtonID]
                torpedo_left_fired = TRUE
                CheckCurrentShipState()
                if (buttonUp = TRUE)  AND (GetSeconds() > leftTorpedoFireTime + 1) ` If this is the FIRST time *this* button is pressed buttonUp will equal TRUE
                    if (leftTorpedoCount = torpedoLimit) then leftTorpedoCount = 0
                    leftTorpedoCount = leftTorpedoCount + 1
                    SetAnimationsForTorpedos(leftTorpedoFireAnimSpriteID, "port")
                    PlaySprite(leftTorpedoFireAnimSpriteID,FRAME_RATE_5,NO_LOOP,1,9)
                    LoadTorpedo(leftTorpedo[leftTorpedoCount].sprID, "left", ship.angle#)
                    vx# = torpedo_speed*Cos(ship.angle#)
                    vy# = torpedo_speed*Sin(ship.angle#)
                    SetSpritePhysicsVelocity(leftTorpedo[leftTorpedoCount].sprID, vx#, vy#)
                    leftTorpedoFireTime = GetSeconds()  ` Record Firing time in order to force a 1/2 sec delay between rapid launchings
                    ChangeLights(ltpdoReloadLightSpriteID, ltpdoLaunchLightSpriteID)    ` Change Fire/ReLoad Indicators
                    ChangeLeftTorpedoState(leftTorpedoCount, TORPEDO_STATE_FIRED)
                    SetParticlesToTailOfSprite(leftTorpedoParticles[leftTorpedoCount].particleID, leftTorpedo[leftTorpedoCount].sprID, ship.angle#)
                    leftTorpedoParticles[leftTorpedoCount].active = TRUE
                    buttonUp = FALSE ` Set buttonUp to FALSE to signal that *this* key is being held down (and we don't want a rapid fire turret)
                endif
            endcase
            case 136: ` **** Fire Right Torpedos [fireRightTorpedoButtonID]
                torpedo_right_fired = TRUE
                CheckCurrentShipState()
                if (buttonUp = TRUE) AND (GetSeconds() > rightTorpedoFireTime + 1) ` If this is the FIRST time *this* button is pressed buttonUp will equal TRUE
                    SetAnimationsForTorpedos(rightTorpedoFireAnimSpriteID, "starboard")
                    PlaySprite(rightTorpedoFireAnimSpriteID,FRAME_RATE_5,NO_LOOP,1,9)
                    if (rightTorpedoCount = torpedoLimit) then rightTorpedoCount = 0
                    rightTorpedoCount = rightTorpedoCount + 1
                    LoadTorpedo(rightTorpedo[rightTorpedoCount].sprID, "right", ship.angle#)
                    vx# = torpedo_speed*Cos(ship.angle#)
                    vy# = torpedo_speed*Sin(ship.angle#)
                    SetSpritePhysicsVelocity(rightTorpedo[rightTorpedoCount].sprID, vx#, vy#)
                    rightTorpedoFireTime = GetSeconds()  ` Record Firing time in order to force a 1/2 sec delay between rapid launchings
                    ChangeLights(rtpdoReloadLightSpriteID, rtpdoLaunchLightSpriteID)    ` Change Fire/ReLoad Indicators
                    ChangeRightTorpedoState(rightTorpedoCount, TORPEDO_STATE_FIRED)
                    SetParticlesToTailOfSprite(rightTorpedoParticles[rightTorpedoCount].particleID, rightTorpedo[rightTorpedoCount].sprID, ship.angle#)
                    rightTorpedoParticles[rightTorpedoCount].active = TRUE
                    buttonUp = FALSE ` Set buttonUp to FALSE to signal that *this* key is being held down (and we don't want a rapid fire turret)


                    SetCurrentGoalSatisifiedFlag(TRUE)              ` < ***** DEBUG TEST *****<<<<<

                endif

            endcase
            case 145: ` **** DeployMine [deployMineButtonID]
                mine_deployed = TRUE
                CheckCurrentShipState()
                if (buttonUp = TRUE) AND (GetSeconds() > mineDeploymentTime + 1) ` If this is the FIRST time *this* button is pressed buttonUp will equal TRUE
                    SetParticlesVisible(shipEngineWakeParticleID, VISIBLE)  ` Turn *on* the engine wake to launch mine .....
                    if (mineCount = mineLimit) then mineCount = 0
                    mineCount = mineCount + 1
                    DeployMines(mine[mineCount].sprID, ship.angle#)
                    mineDeploymentTime = GetSeconds()  ` Record deploying time in order to force a 1/2 sec delay between rapid launchings
                    ChangeLights(mineReloadLightSpriteID, mineLaunchLightSpriteID)    ` Change Fire/ReLoad Indicators
                    ChangeMineState(mineCount, MINE_STATE_DEPLOYED)
                    buttonUp = FALSE ` Set buttonUp to FALSE to signal that *this* key is being held down (and we don't want a rapid fire turret)


                    ` **** TESTING: State Change Damage Add Cases & Enemy Movements *****

                    AddGoalToGoalStack(G_ENEMY_ATTACK_SHIP)

                endif
            endcase
        endselect
    else
        buttonUp = TRUE     ` If no buttons are being pressed, record that, do cleanup tasks
    endif
EndFunction



// LOAD TURRET PROJECTILES FUNCTIONS GROUP ********************************

` **** LoadFTProjectiles()
Function LoadFTProjectiles(projectileID, turret$, angle#)
    if (turret$ = "left")
        x# = ((turretFront.width#/2.0)+turretFront.sensorDistance#)*(Cos(angle#+turretFront.sensorAngle#))+turretFront.absCtrX#-turretFront.offset
        y# = ((turretFront.width#/2.0)+turretFront.sensorDistance#)*(Sin(angle#+turretFront.sensorAngle#))+turretFront.absCtrY#
    elseif (turret$ = "right")
        x# = ( (turretFront.width#/2.0)+turretFront.sensorDistance#)*(Cos(angle#-turretFront.sensorAngle#))+turretFront.absCtrX#-turretFront.offset
        y# = ((turretFront.width#/2.0)+turretFront.sensorDistance#)*(Sin(angle#-turretFront.sensorAngle#))+turretFront.absCtrY#
    elseif (turret$ = "center")
        x# = (30*Cos(angle#)+(turretFront.absCtrX#-turretFront.offset))
        y# = (30*Sin(angle#)+(turretFront.absCtrY#))
    endif
    SetSpritePositionByOffset(projectileID, x#, y#)
    SetSpriteVisible(projectileID, VISIBLE)
EndFunction



` **** LoadTTProjectiles()
Function LoadTTProjectiles(projectileID, turret$, angle#)
    if (turret$ = "left")
        x# = ((turretTop.width#/2.0)+turretTop.sensorDistance#)*(Cos(angle#+turretTop.sensorAngle#))+turretTop.absCtrX#-turretTop.offset
        y# = ((turretTop.width#/2.0)+turretTop.sensorDistance#)*(Sin(angle#+turretTop.sensorAngle#))+turretTop.absCtrY#
    elseif (turret$ = "right")
        x# = ( (turretTop.width#/2.0)+turretTop.sensorDistance#)*(Cos(angle#-turretTop.sensorAngle#))+turretTop.absCtrX#-turretTop.offset
        y# = ((turretTop.width#/2.0)+turretTop.sensorDistance#)*(Sin(angle#-turretTop.sensorAngle#))+turretTop.absCtrY#
    elseif (turret$ = "center")
        x# = 30*Cos(angle#)+(turretTop.absCtrX#-turretTop.offset)
        y# = 30*Sin(angle#)+(turretTop.absCtrY#)
    endif
    SetSpritePositionByOffset(projectileID, x#, y#)
    SetSpriteVisible(projectileID, VISIBLE)
EndFunction

` **** LoadRTProjectiles()
Function LoadRTProjectiles(projectileID, turret$, angle#)
    if (turret$ = "left")
        x# = ((turretRear.width#/2.0)+turretRear.sensorDistance#)*(Cos(angle#+turretRear.sensorAngle#))+turretRear.absCtrX#-turretRear.offset
        y# = ((turretRear.width#/2.0)+turretRear.sensorDistance#)*(Sin(angle#+turretRear.sensorAngle#))+turretRear.absCtrY#
    elseif (turret$ = "right")
        x# = ( (turretRear.width#/2.0)+turretRear.sensorDistance#)*(Cos(angle#-turretRear.sensorAngle#))+turretRear.absCtrX#-turretRear.offset
        y# = ((turretRear.width#/2.0)+turretRear.sensorDistance#)*(Sin(angle#-turretRear.sensorAngle#))+turretRear.absCtrY#
    elseif (turret$ = "center")
        x# = 30*Cos(angle#)+turretRear.absCtrX#-turretRear.offset
        y# = 30*Sin(angle#)+turretRear.absCtrY#
    endif
    SetSpritePositionByOffset(projectileID, x#, y#)
    SetSpriteVisible(projectileID, VISIBLE)
EndFunction


// LOAD GUNNER BULLETS FUNCTIONS GROUP ********************************

` **** LoadLeftGunnerProjectiles()
Function LoadLeftGunnerBullets(projectileID, barrel$, angle#)
    if (barrel$ = "right")
        x# = ((leftGunner.width#/2.0)+leftGunner.sensorDistance#)*(Cos(angle#+leftGunner.sensorAngle#))+leftGunner.absCtrX#-leftGunner.offset
        y# = ((leftGunner.width#/2.0)+leftGunner.sensorDistance#)*(Sin(angle#+leftGunner.sensorAngle#))+leftGunner.absCtrY#
    elseif (barrel$ = "left")
        x# = ((leftGunner.width#/2.0)+leftGunner.sensorDistance#)*(Cos(angle#-leftGunner.sensorAngle#))+leftGunner.absCtrX#-leftGunner.offset
        y# = ((leftGunner.width#/2.0)+leftGunner.sensorDistance#)*(Sin(angle#-leftGunner.sensorAngle#))+leftGunner.absCtrY#
    endif
    SetSpritePositionByOffset(projectileID, x#, y#)
    SetSpriteVisible(projectileID, VISIBLE)
EndFunction


` **** LoadRightGunnerProjectiles()
Function LoadRightGunnerBullets(projectileID, barrel$, angle#)
    if (barrel$ = "left")
        x# = ((rightGunner.width#/2.0)+rightGunner.sensorDistance#)*(Cos(angle#+rightGunner.sensorAngle#))+rightGunner.absCtrX#-rightGunner.offset
        y# = ((rightGunner.width#/2.0)+rightGunner.sensorDistance#)*(Sin(angle#+rightGunner.sensorAngle#))+rightGunner.absCtrY#
    elseif (barrel$ = "right")
        x# = ((rightGunner.width#/2.0)+rightGunner.sensorDistance#)*(Cos(angle#-rightGunner.sensorAngle#))+rightGunner.absCtrX#-rightGunner.offset
        y# = ((rightGunner.width#/2.0)+rightGunner.sensorDistance#)*(Sin(angle#-rightGunner.sensorAngle#))+rightGunner.absCtrY#
    endif
    SetSpritePositionByOffset(projectileID, x#, y#)
    SetSpriteVisible(projectileID, VISIBLE)
EndFunction


// LOAD TORPEDO'S  ********************************

` **** LoadTorpedo()
Function LoadTorpedo(torpedoID, tube$, angle#)
    if (tube$ = "left")
        x# = ((ship.width#/4.5)+ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#+5))+ship.absCtrX#
        y# = ((ship.width#/4.5)+ship.sensorDistance#)*(Sin(angle#-ship.sensorAngle#+5))+ship.absCtrY#
    elseif (tube$ = "right")
        x# = ((ship.width#/4.5)+ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#-5))+ship.absCtrX#
        y# = ((ship.width#/4.5)+ship.sensorDistance#)*(Sin(angle#+ship.sensorAngle#-5))+ship.absCtrY#
    endif
    SetSpritePositionByOffset(torpedoID, x#, y#)
    SetSpriteAngle(torpedoID, angle#)
    SetSpriteVisible(torpedoID, VISIBLE)
EndFunction


// Deploy MINES  ********************************

` **** DeployMines()
Function DeployMines(mineID, angle#)
    CheckCurrentShipState()
    x# = -(ship.width#/1.9)*(Cos(angle#))+ship.absCtrX#     ` Start from the absolute center of the ship,
    y# = -(ship.width#/1.9)*(Sin(angle#))+ship.absCtrY#     ` go straight back 1/2 width & 1/2 height to place mine
    SetSpritePositionByOffset(mineID, x#, y#)
    SetSpriteVisible(mineID, VISIBLE)
    SetSpritePhysicsAngularVelocity(mineID, 5)
EndFunction



` **** CheckCurrentShipState()
Function CheckCurrentShipState()

    ` Note: If the ship had been destroyed, exit the function.
    if (ship.state = SHIP_STATE_DESTROYED) then ExitFunction

    ship.angle#     = GetSpriteAngle(ship.sprID)                        ` Ship
    ship.x#         = GetSpriteX(ship.sprID)
    ship.y#         = GetSpriteY(ship.sprID)
    ship.absCtrX#   = ship.x#+ship.width#/2.0
    ship.absCtrY#   = ship.y#+ship.height#/2.0

    turretFront.x#         = GetSpriteX(turretFront.sprID)              ` Front Turret
    turretFront.y#         = GetSpriteY(turretFront.sprID)
    turretFront.absCtrX#   = turretFront.x#+turretFront.width#/2.0
    turretFront.absCtrY#   = turretFront.y#+turretFront.height#/2.0

    turretTop.x#           = GetSpriteX(turretTop.sprID)                 ` Top Turret
    turretTop.y#           = GetSpriteY(turretTop.sprID)
    turretTop.absCtrX#     = turretTop.x#+turretTop.width#/2.0
    turretTop.absCtrY#     = turretTop.y#+turretTop.height#/2.0

    turretRear.x#          = GetSpriteX(turretRear.sprID)                 ` Rear Turret
    turretRear.y#          = GetSpriteY(turretRear.sprID)
    turretRear.absCtrX#    = turretRear.x#+turretRear.width#/2.0
    turretRear.absCtrY#    = turretRear.y#+turretRear.height#/2.0

    leftGunner.x#          = GetSpriteX(leftGunner.sprID)                 ` Left Gunner
    leftGunner.y#          = GetSpriteY(leftGunner.sprID)
    leftGunner.absCtrX#    = leftGunner.x#+leftGunner.width#/2.0
    leftGunner.absCtrY#    = leftGunner.y#+leftGunner.height#/2.0

    rightGunner.x#         = GetSpriteX(rightGunner.sprID)                 ` Right Gunner
    rightGunner.y#         = GetSpriteY(rightGunner.sprID)
    rightGunner.absCtrX#   = rightGunner.x#+rightGunner.width#/2.0
    rightGunner.absCtrY#   = rightGunner.y#+rightGunner.height#/2.0
EndFunction


` **** UpdateShipParameters()
Function UpdateShipParameters()

    ` Note: If the ship had been destroyed, exit the function.
    if (ship.state = SHIP_STATE_DESTROYED) then ExitFunction

    SetSpriteAngle(ship.sprID, ship.angle#)     ` Set the angle of the ship to prevent drifting away

    ` Update Turret Guns Positions on Ship as it moves - these never change position.
    SetTurretOnShip(turretFront.sprID, turretFront.offsetFromShipCtr)
    SetTurretOnShip(turretRear.sprID,  turretRear.offsetFromShipCtr)
    SetTurretOnShip(turretTop.sprID,   turretTop.offsetFromShipCtr)

    if (turretFront.isDestroyed = TRUE) then SetTurretOnShip(turretFront.d_sprID, turretFront.offsetFromShipCtr)
    if (turretRear.isDestroyed  = TRUE) then SetTurretOnShip(turretRear.d_sprID,  turretRear.offsetFromShipCtr)
    if (turretTop.isDestroyed   = TRUE) then SetTurretOnShip(turretTop.d_sprID,   turretTop.offsetFromShipCtr)

    ` Set/Maintain the Turret(s) angles in relation to the angle of the ship
    SetSpriteAngle(turretFront.sprID, ship.angle#-turretFront.angle#)
    SetSpriteAngle(turretRear.sprID,  ship.angle#-turretRear.angle#)
    SetSpriteAngle(turretTop.sprID,   ship.angle#-turretTop.angle#)

    if (turretFront.isDestroyed = TRUE) then SetSpriteAngle(turretFront.d_sprID, ship.angle#-turretFront.angle#)
    if (turretRear.isDestroyed  = TRUE) then SetSpriteAngle(turretRear.d_sprID,  ship.angle#-turretRear.angle#)
    if (turretTop.isDestroyed   = TRUE) then SetSpriteAngle(turretTop.d_sprID,   ship.angle#-turretTop.angle#)

    ` Position Gunners on the ship - Port is left and starboard is right
    SetGunnerOnShip(leftGunner.sprID, "port")
    SetGunnerOnShip(rightGunner.sprID, "starboard")

    ` Set/Maintain the Gunners angles in relation to the angle of the ship
    SetSpriteAngle(leftGunner.sprID,  ship.angle#-leftGunner.angle#)
    SetSpriteAngle(rightGunner.sprID, ship.angle#-rightGunner.angle#)

    ` Upate he engine stern wake (the particles) regardless of their visible state                 ` Engine Stern Wake
    x# = -(ship.width#/2.0)*(Cos(ship.angle#))+ship.absCtrX#
    y# = -(ship.width#/2.0)*(Sin(ship.angle#))+ship.absCtrY#
    SetParticlesPosition(shipEngineWakeParticleID, x#, y#)

    RemStart
        ` Upate he Bow wake (the particles) regardless of their visible state                 ` Ship Bow Wake
        x# = (ship.width#/2.8)*(Cos(ship.angle#))+ship.absCtrX#
        y# = (ship.width#/2.8)*(Sin(ship.angle#))+ship.absCtrY#
        SetParticlesPosition(shipSternWakeParticleID, x#, y#)
    RemEnd

    ` **** Launch / Reload Lights *****
    now = GetSeconds()
    if (now > frontTurretFireTime + TWO_SECONDS)
        ChangeLights(ftLaunchLightSpriteID, ftReloadLightSpriteID)
    endif
    if (now > rearTurretFireTime + TWO_SECONDS)
        ChangeLights(rtLaunchLightSpriteID, rtReloadLightSpriteID)
    endif
    if (now > topTurretFireTime + TWO_SECONDS)
        ChangeLights(ttLaunchLightSpriteID, ttReloadLightSpriteID)
    endif

    if (now > leftTorpedoFireTime + ONE_SECOND)
        ChangeLights(ltpdoLaunchLightSpriteID, ltpdoReloadLightSpriteID)
    endif
    if (now > rightTorpedoFireTime + ONE_SECOND)
        ChangeLights(rtpdoLaunchLightSpriteID, rtpdoReloadLightSpriteID)
    endif

    if (now > mineDeploymentTime + ONE_SECOND)
        ChangeLights(mineLaunchLightSpriteID, mineReloadLightSpriteID)
    endif

    ` *** Set the Turret Fire and Smoke animations properly on the ship as it moves
    if (turretFront.isDestroyed = TRUE)
        if ((GetSpritePlaying(fTurretExplodeAnimSpriteID) = 0) AND (GetSpritePlaying(ftFireSmokeAnimSpriteID) = 0))
            SetAnimationToCenterOfFrontTurret(ftFireSmokeAnimSpriteID, angle#)
            SetSpriteVisible(ftFireSmokeAnimSpriteID, VISIBLE)
            PlaySprite(ftFireSmokeAnimSpriteID,FRAME_RATE_3,1,1,26) ` *** Note: Vary the START Frame slightly to prevent animations from playing in sync.
        endif
        SetTurretOnShip(ftFireSmokeAnimSpriteID, turretFront.offsetFromShipCtr)
        SetSpriteAngle(ftFireSmokeAnimSpriteID, ship.angle#-90)
    endif
    if (turretTop.isDestroyed = TRUE)
        if ((GetSpritePlaying(tTurretExplodeAnimSpriteID) = 0) AND (GetSpritePlaying(ttFireSmokeAnimSpriteID) = 0))
            SetAnimationToCenterOfTopTurret(ttFireSmokeAnimSpriteID, angle#)
            SetSpriteVisible(ttFireSmokeAnimSpriteID, VISIBLE)
            PlaySprite(ttFireSmokeAnimSpriteID,FRAME_RATE_3,LOOPING,3,26) ` *** Note: Vary the START Frame slightly
        endif
        SetTurretOnShip(ttFireSmokeAnimSpriteID, turretTop.offsetFromShipCtr)
        SetSpriteAngle(ttFireSmokeAnimSpriteID, ship.angle#-90)
    endif
    if (turretRear.isDestroyed = TRUE)
        if ((GetSpritePlaying(rTurretExplodeAnimSpriteID) = 0) AND (GetSpritePlaying(rtFireSmokeAnimSpriteID) = 0))
            SetAnimationToCenterOfRearTurret(rtFireSmokeAnimSpriteID, angle#)
            SetSpriteVisible(rtFireSmokeAnimSpriteID, VISIBLE)
            PlaySprite(rtFireSmokeAnimSpriteID,FRAME_RATE_3,LOOPING,5,26) ` *** Note: Vary the START Frame slightly
        endif
        SetTurretOnShip(rtFireSmokeAnimSpriteID, turretRear.offsetFromShipCtr)
        SetSpriteAngle(rtFireSmokeAnimSpriteID, ship.angle#-90)
    endif
    if (leftGunner.isDestroyed = TRUE)
        SetGunnerOnShip(lDamagedGunnerSpriteID, "port")
        SetSpriteAngle(lDamagedGunnerSpriteID,  ship.angle#-leftGunner.angle#)
    endif
    if (rightGunner.isDestroyed = TRUE)
        SetGunnerOnShip(rDamagedGunnerSpriteID, "starboard")
        SetSpriteAngle(rDamagedGunnerSpriteID, ship.angle#-rightGunner.angle#+5)
    endif
EndFunction



` **** ChangeLights()
Function ChangeLights(inSprID, outSprID)
    SetSpriteVisible(outSprID, INVISIBLE)
    SetSpriteVisible(inSprID, VISIBLE)
EndFunction


` **** UpdateMunitionsParameters()
Function UpdateMunitionsParameters()

    ` Note: If the ship had been destroyed, exit the function.
    if (ship.state = SHIP_STATE_DESTROYED) then ExitFunction

    if (turretFront.fired = TRUE)
        angle# = ship.angle#-turretFront.angle#                                             ` Front Turret
        for x = 0 to projectileLimit
            if (frontTurretRParticles[x].active = TRUE)
                SetParticlesToTailOfSprite(frontTurretRParticles[x].particleID, frontTurretRProjectile[x].sprID, angle#)
                SetParticlesToTailOfSprite(frontTurretLParticles[x].particleID, frontTurretLProjectile[x].sprID, angle#)
                SetParticlesToTailOfSprite(frontTurretMParticles[x].particleID, frontTurretMProjectile[x].sprID, angle#)
                frontTurretLProjectile[x].nose_x# = GetSpriteX(frontTurretLProjectile[x].sprID)+frontTurretLProjectile[x].width#
                frontTurretLProjectile[x].nose_y# = GetSpriteY(frontTurretLProjectile[x].sprID)
                frontTurretRProjectile[x].nose_x# = GetSpriteX(frontTurretRProjectile[x].sprID)+frontTurretRProjectile[x].width#
                frontTurretRProjectile[x].nose_y# = GetSpriteY(frontTurretRProjectile[x].sprID)
                frontTurretMProjectile[x].nose_x# = GetSpriteX(frontTurretMProjectile[x].sprID)+frontTurretMProjectile[x].width#
                frontTurretMProjectile[x].nose_y# = GetSpriteY(frontTurretMProjectile[x].sprID)
            endif
        next x
    endif
    if (turretTop.fired = TRUE)
        angle# = ship.angle#-turretTop.angle#                                               ` Top Turret
        for x = 0 to projectileLimit
            if (topTurretRParticles[x].active = TRUE)
                SetParticlesToTailOfSprite(topTurretRParticles[x].particleID, topTurretRProjectile[x].sprID, angle#)
                SetParticlesToTailOfSprite(topTurretLParticles[x].particleID, topTurretLProjectile[x].sprID, angle#)
                SetParticlesToTailOfSprite(topTurretMParticles[x].particleID, topTurretMProjectile[x].sprID, angle#)
                topTurretLProjectile[x].nose_x# = GetSpriteX(topTurretLProjectile[x].sprID)+topTurretLProjectile[x].width#
                topTurretLProjectile[x].nose_y# = GetSpriteY(topTurretLProjectile[x].sprID)
                topTurretRProjectile[x].nose_x# = GetSpriteX(topTurretRProjectile[x].sprID)+topTurretRProjectile[x].width#
                topTurretRProjectile[x].nose_y# = GetSpriteY(topTurretRProjectile[x].sprID)
                topTurretMProjectile[x].nose_x# = GetSpriteX(topTurretMProjectile[x].sprID)+topTurretMProjectile[x].width#
                topTurretMProjectile[x].nose_y# = GetSpriteY(topTurretMProjectile[x].sprID)
            endif
        next x
    endif
    if (turretRear.fired = TRUE)
        angle# = ship.angle#-turretRear.angle#                                               ` Rear Turret
        for x = 0 to projectileLimit
            if (rearTurretRParticles[x].active = TRUE)
                SetParticlesToTailOfSprite(rearTurretRParticles[x].particleID, rearTurretRProjectile[x].sprID, angle#)
                SetParticlesToTailOfSprite(rearTurretLParticles[x].particleID, rearTurretLProjectile[x].sprID, angle#)
                SetParticlesToTailOfSprite(rearTurretMParticles[x].particleID, rearTurretMProjectile[x].sprID, angle#)
                rearTurretLProjectile[x].nose_x# = GetSpriteX(rearTurretLProjectile[x].sprID)+rearTurretLProjectile[x].width#
                rearTurretLProjectile[x].nose_y# = GetSpriteY(rearTurretLProjectile[x].sprID)
                rearTurretRProjectile[x].nose_x# = GetSpriteX(rearTurretRProjectile[x].sprID)+rearTurretRProjectile[x].width#
                rearTurretRProjectile[x].nose_y# = GetSpriteY(rearTurretRProjectile[x].sprID)
                rearTurretMProjectile[x].nose_x# = GetSpriteX(rearTurretMProjectile[x].sprID)+rearTurretMProjectile[x].width#
                rearTurretMProjectile[x].nose_y# = GetSpriteY(rearTurretMProjectile[x].sprID)
            endif
        next x
    endif
    if (torpedo_left_fired = TRUE)                                                          ` Left Torpedo
        for x = 0 to torpedoLimit
            if (leftTorpedoParticles[x].active = TRUE)
                SetParticlesToTailOfSprite(leftTorpedoParticles[x].particleID, leftTorpedo[x].sprID, ship.angle#)
                leftTorpedo[x].nose_x# = GetSpriteX(leftTorpedo[x].sprID)+leftTorpedo[x].width#
                leftTorpedo[x].nose_y# = GetSpriteY(leftTorpedo[x].sprID)
            endif
        next x
    endif
    if (torpedo_right_fired = TRUE)                                                         ` Right Torpedo
        for x = 0 to torpedoLimit
            if (rightTorpedoParticles[x].active = TRUE)
                SetParticlesToTailOfSprite(rightTorpedoParticles[x].particleID, rightTorpedo[x].sprID, ship.angle#)
                rightTorpedo[x].nose_x# = GetSpriteX(rightTorpedo[x].sprID)+rightTorpedo[x].width#
                rightTorpedo[x].nose_y# = GetSpriteY(rightTorpedo[x].sprID)
            endif
        next x
    endif
                        ` **** Gunner Bullets ****
    for x = 0 to gunnerBulletLimit
            if (gunnerLGLBBullets[x].State = BULLET_STATE_FIRED)
                gunnerLGLBBullets[x].x# = GetSpriteX(gunnerLGLBBullets[x].sprID)
                gunnerLGLBBullets[x].y# = GetSpriteY(gunnerLGLBBullets[x].sprID)
            endif
            if (gunnerLGRBBullets[x].State = BULLET_STATE_FIRED)
                gunnerLGRBBullets[x].x# = GetSpriteX(gunnerLGRBBullets[x].sprID)
                gunnerLGRBBullets[x].y# = GetSpriteY(gunnerLGRBBullets[x].sprID)
            endif
            if (gunnerRGLBBullets[x].State = BULLET_STATE_FIRED)
                gunnerRGLBBullets[x].x# = GetSpriteX(gunnerRGLBBullets[x].sprID)
                gunnerRGLBBullets[x].y# = GetSpriteY(gunnerRGLBBullets[x].sprID)
            endif
            if (gunnerRGRBBullets[x].State = BULLET_STATE_FIRED)
                gunnerRGRBBullets[x].x# = GetSpriteX(gunnerRGRBBullets[x].sprID)
                gunnerRGRBBullets[x].y# = GetSpriteY(gunnerRGRBBullets[x].sprID)
            endif
    next x
                    ` **** Cannon Blast Animations  ****
        ftAngle#=GetSpriteAngle(turretFront.sprID)
        SetAnimationToHeadOfFrontTurret(ftCannonFireAnimSpriteID, ftAngle#)  ` Front Turret

        ttAngle#=GetSpriteAngle(turretTop.sprID)
        SetAnimationToHeadOfTopTurret(ttCannonFireAnimSpriteID, ttAngle#)    ` Top Turret

        rtAngle#=GetSpriteAngle(turretRear.sprID)
        SetAnimationToHeadOfRearTurret(rtCannonFireAnimSpriteID, rtAngle#)   ` Rear Turret

                ` **** Torpedo Launch Animations  ****                       ` Torpedos
        SetAnimationsForTorpedos(leftTorpedoFireAnimSpriteID, "port")
        SetAnimationsForTorpedos(rightTorpedoFireAnimSpriteID, "starboard")
EndFunction



` **** SetParticlesToTailOfSprite()                                         ` **** PARTICLES *****
Function SetParticlesToTailOfSprite(particlesID, spriteID, angle#)
    x# = GetSpriteX(spriteID)
    y# = GetSpriteY(spriteID)
    width#  = GetSpriteWidth(spriteID)
    height# = GetSpriteHeight(spriteID)
    SetParticlesPosition(particlesID, Cos(angle#)+x#+(width#/2), Sin(angle#)+y#+(height#/2))
    SetParticlesVisible(particlesID, VISIBLE)
EndFunction



` **** SetAnimationToHeadOfFrontTurret()                                    ` **** ANIMATIONS ****
Function SetAnimationToHeadOfFrontTurret(animationID, angle#)
    x# = (30*Cos(angle#)+(turretFront.absCtrX#-turretFront.offset))
    y# = (30*Sin(angle#)+(turretFront.absCtrY#))
    SetSpritePositionByOffset(animationID, x#, y#)
    SetSpriteAngle(animationID, angle#+90)
EndFunction


` **** SetAnimationToCenterOfFrontTurret()
Function SetAnimationToCenterOfFrontTurret(animationID, angle#)
    x# = (15*Cos(angle#)+(turretFront.absCtrX#-turretFront.offset))
    y# = (15*Sin(angle#)+(turretFront.absCtrY#))
    SetSpritePositionByOffset(animationID, x#, y#)
    SetSpriteAngle(animationID, angle#+90)
EndFunction



` **** SetAnimationToHeadOfRearTurret()
Function SetAnimationToHeadOfRearTurret(animationID, angle#)
    x# = (30*Cos(angle#)+(turretRear.absCtrX#-turretRear.offset))
    y# = (30*Sin(angle#)+(turretRear.absCtrY#))
    SetSpritePositionByOffset(animationID, x#, y#)
    SetSpriteAngle(animationID, angle#+90)
EndFunction


` **** SetAnimationToCenterOfRearTurret()                                         ` **** PARTICLES *****
Function SetAnimationToCenterOfRearTurret(animationID, angle#)
    x# = (10*Cos(angle#)+(turretRear.absCtrX#-turretRear.offset))
    y# = (10*Sin(angle#)+(turretRear.absCtrY#))
    SetSpritePositionByOffset(animationID, x#, y#)
    SetSpriteAngle(animationID, angle#+90)
EndFunction


` **** SetAnimationToHeadOfTopTurret()
Function SetAnimationToHeadOfTopTurret(animationID, angle#)
    x# = (30*Cos(angle#)+(turretTop.absCtrX#-turretTop.offset))
    y# = (30*Sin(angle#)+(turretTop.absCtrY#))
    SetSpritePositionByOffset(animationID, x#, y#)
    SetSpriteAngle(animationID, angle#+90)
EndFunction


` **** SetAnimationToCenterOfTopTurret()
Function SetAnimationToCenterOfTopTurret(animationID, angle#)
    x# = (15*Cos(angle#)+(turretTop.absCtrX#-turretTop.offset))
    y# = (15*Sin(angle#)+(turretTop.absCtrY#))
    SetSpritePositionByOffset(animationID, x#, y#)
    SetSpriteAngle(animationID, angle#+90)
EndFunction



` **** SetAnimationToHeadOfLeftGunner()
Function SetAnimationToHeadOfLeftGunner(animationID, angle#)
    x# = (25*Cos(angle#)+(leftGunner.absCtrX#-leftGunner.offset))
    y# = (25*Sin(angle#)+(leftGunner.absCtrY#))
    SetSpritePositionByOffset(animationID, x#, y#)
    SetSpriteAngle(animationID, angle#+90)
EndFunction


` **** SetAnimationToCenterOfLeftGunner()
Function SetAnimationToCenterOfLeftGunner(animationID, angle#)
    x# = (10*Cos(angle#)+(leftGunner.absCtrX#-leftGunner.offset))
    y# = (10*Sin(angle#)+(leftGunner.absCtrY#))
    SetSpritePositionByOffset(animationID, x#, y#)
    SetSpriteAngle(animationID, angle#+90)
EndFunction



` **** SetAnimationToHeadOfrightGunner()
Function SetAnimationToHeadOfRightGunner(animationID, angle#)
    x# = (25*Cos(angle#)+(rightGunner.absCtrX#-rightGunner.offset))
    y# = (25*Sin(angle#)+(rightGunner.absCtrY#))
    SetSpritePositionByOffset(animationID, x#, y#)
    SetSpriteAngle(animationID, angle#+90)
EndFunction


` **** SetAnimationToCenterOfrightGunner()
Function SetAnimationToCenterOfRightGunner(animationID, angle#)
    x# = (10*Cos(angle#)+(rightGunner.absCtrX#-rightGunner.offset))
    y# = (10*Sin(angle#)+(rightGunner.absCtrY#))
    SetSpritePositionByOffset(animationID, x#, y#)
    SetSpriteAngle(animationID, angle#+90)
EndFunction



` *** SetAnimationsForTorpedos()
Function SetAnimationsForTorpedos(animationID, shipSide$)
    if (shipSide$ = "port")              ` Left
        x# = ((ship.width#/34.0)+ship.sensorDistance#+70)*(Cos(ship.angle#+ship.sensorAngle#-16))+ship.absCtrX#
        y# = ((ship.width#/34.0)+ship.sensorDistance#+70)*(Sin(ship.angle#+ship.sensorAngle#-16))+ship.absCtrY#
    elseif (shipSide$ = "starboard")     ` Right
        x# = ((ship.width#/34.0)+ship.sensorDistance#+70)*(Cos(ship.angle#+ship.sensorAngle#-4))+ship.absCtrX#
        y# = ((ship.width#/34.0)+ship.sensorDistance#+70)*(Sin(ship.angle#+ship.sensorAngle#-4))+ship.absCtrY#
    endif
    SetSpriteAngle(animationID, ship.angle#+90)
    SetSpritePositionByOffset(animationID, x#, y#)
EndFunction



Function SetAnimationToCenterOfBullet(bulletSprID, animSprID)
    x# = GetSpriteX(animSprID)
    y# = GetSpriteY(animSprID)
    w# = GetSpriteWidth(animSprID)
    h# = GetSpriteHeight(animSprID)
    SetSpritePosition(animSprID, GetSpriteX(bulletSprID), GetSpriteY(bulletSprID))
EndFunction



Function SetAnimationToHeadOMunition(spriteID, animSprID)
    x# = GetSpriteX(spriteID)
    y# = GetSpriteY(spriteID)
    width#  = GetSpriteWidth(spriteID)
    height# = GetSpriteHeight(spriteID)
    SetSpritePositionByOffset(animSprID, x#+(width#), y#+(height#/2)) ` Places the animation to the middle front of the Munition.
EndFunction




// **** SHIP SENSORS ***
//
` X-COORINATES
Function ShipSensorTopRightX()
    angle# = GetSpriteAngle(ship.sprID)
    x_coordinate# = ((ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#))+ship.absCtrX#
EndFunction x_coordinate#

Function ShipSensorBottomRightX()
    angle# = GetSpriteAngle(ship.sprID)
    x_coordinate# = ((ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#
EndFunction x_coordinate#


` Y_COORDINATES
Function ShipSensorTopRightY()
    angle# = GetSpriteAngle(ship.sprID)
    y_coordinate# = ((ship.width#/2.0)+ship.sensorDistance#)*(Sin(angle#-ship.sensorAngle#))+ship.absCtrY#
EndFunction y_coordinate#

Function ShipSensorBottomRightY()
    angle# = GetSpriteAngle(ship.sprID)
    y_coordinate# = ((ship.width#/2.0)+ship.sensorDistance#)*(Sin(angle#+ship.sensorAngle#))+ship.absCtrY#
EndFunction y_coordinate#



` **** DestroyShip()
Function DestroyShip()
    ship.isDestroyed = TRUE
    CheckCurrentShipState()

    ` **** Position, rotate, set visible and play ship explosion animation
    SetSpritePositionbyoffset(shipBlowUpAnimSpriteID, ship.absCtrX#, ship.absCtrY#)
    SetSpriteAngle(shipBlowUpAnimSpriteID, GetSpriteAngle(ship.sprID))
    SetSpriteVisible(shipBlowUpAnimSpriteID, VISIBLE)
    PlaySprite(shipBlowUpAnimSpriteID,FRAME_RATE_2,NO_LOOP,1,69)
    Sync()

    ` **** Destroy *ALL* Particle EMitters
    DeleteParticles(shipEngineWakeParticleID)

    ` **** Destroy *ALL* sprites of the Battleship and it's Guns
    SetSpritePhysicsOff(ship.sprID)
    DeleteSprite(ship.sprID)

    ` *** Destroy *ALL* Gun Sprites if they aren't already
    if (turretFront.state = TURRETFRONT_STATE_DEPLOYED) then DeleteSprite(turretFront.sprID)
    if (turretRear.state  = TURRETREAR_STATE_DEPLOYED)  then DeleteSprite(turretRear.sprID)
    if (turretTop.state   = TURRETTOP_STATE_DEPLOYED)   then DeleteSprite(turretTop.sprID)
    if (leftGunner.state  = LEFTGUNNER_STATE_DEPLOYED)  then DeleteSprite(leftGunner.sprID)
    if (rightGunner.state = RIGHTGUNNER_STATE_DEPLOYED) then DeleteSprite(rightGunner.sprID)

    ` *** Destroy *ALL* Gun Fire and Smoke Sprites if they exist
    if (turretFront.state = TURRETFRONT_STATE_DESTROYED)
        DeleteSprite(ftFireSmokeAnimSpriteID)
        DeleteSprite(turretFront.d_sprID)
    endif
    if (turretRear.state  = TURRETREAR_STATE_DESTROYED)
        DeleteSprite(rtFireSmokeAnimSpriteID)
        DeleteSprite(turretRear.d_sprID)
    endif
    if (turretTop.state   = TURRETTOP_STATE_DESTROYED)
        DeleteSprite(ttFireSmokeAnimSpriteID)
        DeleteSprite(turretTop.d_sprID)
    endif
    if (leftGunner.state = LEFTGUNNER_STATE_DESTROYED)then DeleteSprite(lDamagedGunnerSpriteID)
    if (rightGunner.state = RIGHTGUNNER_STATE_DESTROYED) then DeleteSprite(rDamagedGunnerSpriteID)

    for m = 1 to mineLimit                         ` *** Clean up any mines still floating around
        SetSpriteVisible(mine[m].SprID, INVISIBLE)
        ChangeMineState(m, MINE_STATE_INACTIVE)
    next m
EndFunction


Function DestroyFrontTurret()
    CheckCurrentShipState()
    angle# = GetSpriteAngle(turretFront.sprID)
    if (turretFront.isDestroyed = FALSE)
        SetSpriteVisible(turretFront.sprID, INVISIBLE)
        SetTurretOnShip(turretFront.d_sprID, turretFront.offsetFromShipCtr)
        SetSpriteVisible(turretFront.d_sprID, VISIBLE)
        SetAnimationToCenterOfFrontTurret(fTurretExplodeAnimSpriteID, angle#)
        SetSpriteVisible(fTurretExplodeAnimSpriteID, VISIBLE)
        PlaySprite(fTurretExplodeAnimSpriteID,FRAME_RATE_2,NO_LOOP,1,135)
        turretFront.isDestroyed = TRUE
        ` *** Note: The updating of the Smoke & Flames Animation is done in UpdateShipParameters()
    endif
EndFunction


Function DestroyRearTurret()
    CheckCurrentShipState()
    angle# = GetSpriteAngle(turretRear.sprID)
    if (turretRear.isDestroyed = FALSE)
        SetSpriteVisible(turretRear.sprID, INVISIBLE)
        SetTurretOnShip(turretRear.d_sprID, turretRear.offsetFromShipCtr)
        SetSpriteVisible(turretRear.d_sprID, VISIBLE)
        SetAnimationToCenterOfRearTurret(rTurretExplodeAnimSpriteID, angle#)
        SetSpriteVisible(rTurretExplodeAnimSpriteID, VISIBLE)
        PlaySprite(rTurretExplodeAnimSpriteID,FRAME_RATE_2,NO_LOOP,1,135)
        turretRear.isDestroyed = TRUE
        ` *** Note: The updating of the Smoke & Flames Animation is done in UpdateShipParameters()
    endif
EndFunction


Function DestroyTopTurret()
    CheckCurrentShipState()
    angle# = GetSpriteAngle(turretTop.sprID)
    if (turretTop.isDestroyed = FALSE)
        SetSpriteVisible(turretTop.sprID, INVISIBLE)
        SetTurretOnShip(turretTop.d_sprID, turretTop.offsetFromShipCtr)
        SetSpriteVisible(turretTop.d_sprID, VISIBLE)
        SetAnimationToCenterOfTopTurret(tTurretExplodeAnimSpriteID, angle#)
        SetSpriteVisible(tTurretExplodeAnimSpriteID, VISIBLE)
        PlaySprite(tTurretExplodeAnimSpriteID,FRAME_RATE_2,NO_LOOP,1,135)
        turretTop.isDestroyed = TRUE
        ` *** Note: The updating of the Smoke & Flames Animation is done in UpdateShipParameters()
    endif
EndFunction



Function DestroyLeftGunner()
    CheckCurrentShipState()
    angle# = GetSpriteAngle(leftGunner.sprID)
    if (leftGunner.isDestroyed = FALSE)
        SetAnimationToCenterOfLeftGunner(lGunnerExplosionAminSpriteID, angle#)
        SetSpriteVisible(lGunnerExplosionAminSpriteID, VISIBLE)
        PlaySprite(lGunnerExplosionAminSpriteID,FRAME_RATE_2,NO_LOOP,1,135)
        SetSpriteVisible(leftGunner.sprID, INVISIBLE)
        leftGunner.isDestroyed = TRUE
        SetGunnerOnShip(lDamagedGunnerSpriteID, "port")
        SetSpriteVisible(lDamagedGunnerSpriteID, VISIBLE)
    endif
EndFunction


Function DestroyRightGunner()
    CheckCurrentShipState()
    angle# = GetSpriteAngle(rightGunner.sprID)
    if (rightGunner.isDestroyed = FALSE)
        SetAnimationToCenterOfRightGunner(rGunnerExplosionAminSpriteID, angle#)
        SetSpriteVisible(rGunnerExplosionAminSpriteID, VISIBLE)
        PlaySprite(rGunnerExplosionAminSpriteID,FRAME_RATE_2,NO_LOOP,1,135)
        SetSpriteVisible(rightGunner.sprID, INVISIBLE)
        rightGunner.isDestroyed = TRUE
        SetGunnerOnShip(rDamagedGunnerSpriteID, "starboard")
        SetSpriteVisible(rDamagedGunnerSpriteID, VISIBLE)
    endif
EndFunction



` **** EngageShipPropulsion()
Function EngageShipPropulsion(angle#)

                // Establish Ship heading angle ranges, corresponding propulsion force directions (Forward and reverse)

                if (angle# < -70) AND (angle# > -135)           ` Up
                     ship.vx = ZERO
                     ship.vy = -ship.throttle#
                     ship.rvx = ZERO
                     ship.rvy = ship.throttle#
                     screen.viewOffsetIncrementX# = 0
                     screen.viewOffsetIncrementY# = -0.5
                     ship.heading$ = d_UP

                elseif (angle# > 70) AND (angle# < 130)        ` Down
                     ship.vx = ZERO
                     ship.vy = ship.throttle#
                     ship.rvx = ZERO
                     ship.rvy = -ship.throttle#
                     screen.viewOffsetIncrementX# = 0
                     screen.viewOffsetIncrementY# = 0.5
                     ship.heading$ = d_DOWN

                elseif (angle# > 150) AND (angle# > -150)       ` Left
                     ship.vx = -ship.throttle#
                     ship.vy = ZERO
                     ship.rvx = ship.throttle#
                     ship.rvy = ZERO
                     screen.viewOffsetIncrementX# = -0.5
                     screen.viewOffsetIncrementY# = 0
                     ship.heading$ = d_LEFT

                elseif (angle# > -45) AND (angle# < 45)         ` Right
                     ship.vx = ship.throttle#
                     ship.vy = ZERO
                     ship.rvx = -ship.throttle#
                     ship.rvy = ZERO
                     screen.viewOffsetIncrementX# = 0.5
                     screen.viewOffsetIncrementY# = 0
                     ship.heading$ = d_RIGHT

                elseif (angle# <= -45) AND (angle# >= -70)      ` Top-Right
                     ship.vx =  ship.throttle#
                     ship.vy = -ship.throttle#
                     ship.rvx = -ship.throttle#
                     ship.rvy = ship.throttle#
                     screen.viewOffsetIncrementX# = 0.5
                     screen.viewOffsetIncrementY# = -0.5
                     ship.heading$ = d_TOP_RIGHT

                elseif (angle# <= -130) AND (angle# >= -180)    ` Top-Left
                     ship.vx = -ship.throttle#
                     ship.vy = -ship.throttle#
                     ship.rvx = ship.throttle#
                     ship.rvy = ship.throttle#
                     screen.viewOffsetIncrementX# = -0.5
                     screen.viewOffsetIncrementY# = -0.5
                     ship.heading$ = d_TOP_LEFT

                elseif (angle# <= 90) AND (angle# >= 45)        ` Bottom-Right
                     ship.vx =  ship.throttle#
                     ship.vy =  ship.throttle#
                     ship.rvx = -ship.throttle#
                     ship.rvy = -ship.throttle#
                     screen.viewOffsetIncrementX# = 0.5
                     screen.viewOffsetIncrementY# = 0.5
                     ship.heading$ = d_BOTTOM_RIGHT

                elseif (angle# <= 180) AND (angle# >= 90)       ` Botom-Left
                     ship.vx =  -ship.throttle#
                     ship.vy =  ship.throttle#
                     ship.rvx = ship.throttle#
                     ship.rvy = -ship.throttle#
                     screen.viewOffsetIncrementX# = -0.5
                     screen.viewOffsetIncrementY# = 0.5
                     ship.heading$ = d_BOTTOM_LEFT

                endif
                ` **** Create the Physics Force to move the ship - place force directly behind back of the ship ******************************************
                CheckCurrentShipState()
                x# = -(ship.width#/2.0)*(Cos(angle#))+ship.absCtrX#                       ` Start from the absolute center of the ship,
                y# = -(ship.width#/2.0)*(Sin(angle#))+ship.absCtrY#                       ` go straight back 1/2 width & 1/2 height to place force pt.
                if (ship.reverseEngines = FALSE)                                          ` Engines Forward
                    SetSpritePhysicsImpulse(ship.sprID, x#, y#, ship.vx, ship.vy)
                elseif (ship.reverseEngines = TRUE)                                       ` Engines Reverse
                    SetSpritePhysicsImpulse(ship.sprID, x#, y#, ship.rvx, ship.rvy)
                endif
EndFunction


rem ******************************
rem EOF Battleship battleship.agc
rem ******************************




