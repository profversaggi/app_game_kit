rem *************************
rem Battleship states.agc
rem *************************



` *** CheckStates()
Function CheckStates()
    CheckLeftTorpedoState()
    CheckRightTorpedoState()
    CheckFrontTurretProjectilesState()
    CheckTopTurretProjectilesState()
    CheckRearTurretProjectilesState()
    CheckGunnersBulletsState()
    `debugTorpedoes()
    `debugFTProjectiles()
    `debugTTProjectiles()
    `debugRTProjectiles()
    `debugGunners()
EndFunction




` ******** Enemy FINITE STATE MACHINE **********************
Function ChangeEnemyState(newState)
    select newState
        case ENEMY_STATE_DEPLOYED:    `[1059]
            enemy.state = ENEMY_STATE_DEPLOYED
        endcase
        case ENEMY_STATE_DESTROYED:    `[1060]
            enemy.state = ENEMY_STATE_DESTROYED
            if (enemy.isDestroyed = FALSE) then DestroyEnemy()
            enemy.isDestroyed = TRUE
        endcase
    endselect
EndFunction




Function ChangeMyEnemyState(index, newState)
    select newState
        case ENEMY_STATE_DEPLOYED:    `[1059]
            myenemy[index].state = ENEMY_STATE_DEPLOYED ` <== Working OK
        endcase
        case ENEMY_STATE_DESTROYED:    `[1060]
            myenemy[index].state = ENEMY_STATE_DESTROYED
            if (myenemy[index].isDestroyed = FALSE) then DestroyMyEnemy(index)
        endcase
    endselect
EndFunction


Function ChangeAttackBoatsState(index, newState)
    select newState
        case ENEMY_STATE_DEPLOYED:    `[1059]
            attackBoats[index].state = ENEMY_STATE_DEPLOYED ` <== Working OK
        endcase
        case ENEMY_STATE_DESTROYED:    `[1060]
            attackBoats[index].state = ENEMY_STATE_DESTROYED    ` <== Working OK
            if (attackBoats[index].isDestroyed = FALSE) then DestroyAttackBoats(index)
        endcase
    endselect
EndFunction



` ******** Ship FINITE STATE MACHINE **********************
Function ChangeShipState(newState)
    select newState
        case SHIP_STATE_DEPLOYED:    `[1041]
            ship.state = SHIP_STATE_DEPLOYED
        endcase
        case SHIP_STATE_DESTROYED:    `[1042]
            ship.state = SHIP_STATE_DESTROYED
            if (ship.isDestroyed = FALSE) then DestroyShip()
        endcase
        case SHIP_STATE_DAMAGED:     `[1043]
            ship.state = SHIP_STATE_DAMAGED
        endcase
    endselect
EndFunction


` ******** Turret's FINITE STATE MACHINES **********************

Function ChangeFrontTurretState(newState)
    select newState
        case TURRETFRONT_STATE_DEPLOYED:    `[1044]
            turretFront.state = TURRETFRONT_STATE_DEPLOYED
        endcase
        case TURRETFRONT_STATE_DESTROYED:    `[1045]
            turretFront.state = TURRETFRONT_STATE_DESTROYED
            DestroyFrontTurret()
        endcase
        case TURRETFRONT_STATE_DAMAGED:     `[1046]
            turretFront.state = TURRETFRONT_STATE_DAMAGED
        endcase
    endselect
EndFunction


Function ChangeRearTurretState(newState)
    select newState
        case TURRETREAR_STATE_DEPLOYED:    `[1047]
            turretRear.state = TURRETREAR_STATE_DEPLOYED
        endcase
        case TURRETREAR_STATE_DESTROYED:    `[1048]
            turretRear.state = TURRETREAR_STATE_DESTROYED
            DestroyRearTurret()
        endcase
        case TURRETREAR_STATE_DAMAGED:     `[1049]
            turretRear.state = TURRETREAR_STATE_DAMAGED
        endcase
    endselect
EndFunction


Function ChangeTopTurretState(newState)
    select newState
        case TURRETTOP_STATE_DEPLOYED:    `[1050]
            turretTop.state = TURRETTOP_STATE_DEPLOYED
        endcase
        case TURRETTOP_STATE_DESTROYED:    `[1051]
            turretTop.state = TURRETTOP_STATE_DESTROYED
            DestroyTopTurret()
        endcase
        case TURRETTOP_STATE_DAMAGED:     `[1052]
            turretTop.state = TURRETTOP_STATE_DAMAGED
        endcase
    endselect
EndFunction


` ******** Gunner's FINITE STATE MACHINES **********************

Function ChangeLeftGunnerState(newState)
    select newState
        case LEFTGUNNER_STATE_DEPLOYED:    `[1053]
            leftGunner.state = LEFTGUNNER_STATE_DEPLOYED
        endcase
        case LEFTGUNNER_STATE_DESTROYED:    `[1054]
            leftGunner.state = LEFTGUNNER_STATE_DESTROYED
            DestroyLeftGunner()
        endcase
        case LEFTGUNNER_STATE_DAMAGED:     `[1055]
            leftGunner.state = LEFTGUNNER_STATE_DAMAGED
        endcase
    endselect
EndFunction


Function ChangeRightGunnerState(newState)
    select newState
        case RIGHTGUNNER_STATE_DEPLOYED:    `[1056]
            rightGunner.state = RIGHTGUNNER_STATE_DEPLOYED
        endcase
        case RIGHTGUNNER_STATE_DESTROYED:    `[1057]
            rightGunner.state = RIGHTGUNNER_STATE_DESTROYED
            DestroyRightGunner()
        endcase
        case RIGHTGUNNER_STATE_DAMAGED:     `[1058]
            rightGunner.state = RIGHTGUNNER_STATE_DAMAGED
        endcase
    endselect
EndFunction



` ****** Gunner Bullets FINITE STATE MACHINES **************

Function ChangeLeftGunnerLBulletState(index, newState)
    select newState
        case BULLET_STATE_FIRED:    `[1021]
            gunnerLGLBBullets[index].state = BULLET_STATE_FIRED
        endcase
        case BULLET_STATE_LOST:     `[1022]
            gunnerLGLBBullets[index].state = BULLET_STATE_LOST
            DeleteSprite(gunnerLGLBBullets[index].sprID)
            gunnerLGLBBullets[index].sprID  = CloneSprite(gunnerBulletSpriteID)
            SetSpriteGroup(gunnerLGLBBullets[index].sprID, -1)
            SetSpritePhysicsOn(gunnerLGLBBullets[index].sprID, DYNAMIC)
            gunnerLGLBBullets[index].state = BULLET_STATE_INACTIVE
        endcase
        case BULLET_STATE_IMPACT:   `[1023]
            gunnerLGLBBullets[index].state = BULLET_STATE_IMPACT
            SetAnimationToCenterOfBullet(gunnerLGLBBullets[index].sprID, gunnerLGLBBullets[index].impactSprID)
            SetSpriteVisible(gunnerLGLBBullets[index].impactSprID, VISIBLE)
            Sync()
            SetSpriteVisible(gunnerLGLBBullets[index].impactSprID, INVISIBLE)
            ChangeLeftGunnerLBulletState(index, BULLET_STATE_LOST)
        endcase
        case BULLET_STATE_INACTIVE: `[1024]
            gunnerLGLBBullets[index].state = BULLET_STATE_INACTIVE
        endcase
    endselect
EndFunction

Function ChangeLeftGunnerRBulletState(index, newState)
    select newState
        case BULLET_STATE_FIRED:    `[1021]
            gunnerLGRBBullets[index].state = BULLET_STATE_FIRED
        endcase
        case BULLET_STATE_LOST:     `[1022]
            gunnerLGRBBullets[index].state = BULLET_STATE_LOST
            DeleteSprite(gunnerLGRBBullets[index].sprID)
            gunnerLGRBBullets[index].sprID  = CloneSprite(gunnerBulletSpriteID)
            SetSpriteGroup(gunnerLGRBBullets[index].sprID, -1)
            SetSpritePhysicsOn(gunnerLGRBBullets[index].sprID, DYNAMIC)
            gunnerLGRBBullets[index].state = BULLET_STATE_INACTIVE
        endcase
        case BULLET_STATE_IMPACT:   `[1023]
            gunnerLGRBBullets[index].state = BULLET_STATE_IMPACT
            SetAnimationToCenterOfBullet(gunnerLGRBBullets[index].sprID, gunnerLGRBBullets[index].impactSprID)
            SetSpriteVisible(gunnerLGRBBullets[index].impactSprID, VISIBLE)
            Sync()
            SetSpriteVisible(gunnerLGRBBullets[index].impactSprID, INVISIBLE)
            ChangeLeftGunnerRBulletState(index, BULLET_STATE_LOST)
        endcase
        case BULLET_STATE_INACTIVE: `[1024]
            gunnerLGRBBullets[index].state = BULLET_STATE_INACTIVE
        endcase
    endselect
EndFunction

Function ChangeRightGunnerLBulletState(index, newState)
    select newState
        case BULLET_STATE_FIRED:    `[1021]
            gunnerRGLBBullets[index].state = BULLET_STATE_FIRED
        endcase
        case BULLET_STATE_LOST:     `[1022]
            gunnerRGLBBullets[index].state = BULLET_STATE_LOST
            DeleteSprite(gunnerRGLBBullets[index].sprID)
            gunnerRGLBBullets[index].sprID  = CloneSprite(gunnerBulletSpriteID)
            SetSpriteGroup(gunnerRGLBBullets[index].sprID, -1)
            SetSpritePhysicsOn(gunnerRGLBBullets[index].sprID, DYNAMIC)
            gunnerRGLBBullets[index].state = BULLET_STATE_INACTIVE
        endcase
        case BULLET_STATE_IMPACT:   `[1023]
            gunnerRGLBBullets[index].state = BULLET_STATE_IMPACT
            SetAnimationToCenterOfBullet(gunnerRGLBBullets[index].sprID, gunnerRGLBBullets[index].impactSprID)
            SetSpriteVisible(gunnerRGLBBullets[index].impactSprID, VISIBLE)
            Sync()
            SetSpriteVisible(gunnerRGLBBullets[index].impactSprID, INVISIBLE)
            ChangeRightGunnerLBulletState(index, BULLET_STATE_LOST)
        endcase
        case BULLET_STATE_INACTIVE: `[1024]
            gunnerRGLBBullets[index].state = BULLET_STATE_INACTIVE
        endcase
    endselect
EndFunction

Function ChangeRightGunnerRBulletState(index, newState)
    select newState
        case BULLET_STATE_FIRED:    `[1021]
            gunnerRGRBBullets[index].state = BULLET_STATE_FIRED
        endcase
        case BULLET_STATE_LOST:     `[1022]
            gunnerRGRBBullets[index].state = BULLET_STATE_LOST
            DeleteSprite(gunnerRGRBBullets[index].sprID)
            gunnerRGRBBullets[index].sprID  = CloneSprite(gunnerBulletSpriteID)
            SetSpriteGroup(gunnerRGRBBullets[index].sprID, -1)
            SetSpritePhysicsOn(gunnerRGRBBullets[index].sprID, DYNAMIC)
            gunnerRGRBBullets[index].state = BULLET_STATE_INACTIVE
        endcase
        case BULLET_STATE_IMPACT:   `[1023]
            gunnerRGRBBullets[index].state = BULLET_STATE_IMPACT
            SetAnimationToCenterOfBullet(gunnerRGRBBullets[index].sprID, gunnerRGRBBullets[index].impactSprID)
            SetSpriteVisible(gunnerRGRBBullets[index].impactSprID, VISIBLE)
            Sync()
            SetSpriteVisible(gunnerRGRBBullets[index].impactSprID, INVISIBLE)
            ChangeRightGunnerRBulletState(index, BULLET_STATE_LOST)
        endcase
        case BULLET_STATE_INACTIVE: `[1024]
            gunnerRGRBBullets[index].state = BULLET_STATE_INACTIVE
        endcase
    endselect
EndFunction

Function CheckGunnersBulletsState()
    for x = 0 to gunnerBulletLimit
            if (gunnerLGLBBullets[x].State = BULLET_STATE_FIRED)
                if (gunnerLGLBBullets[x].x# <= WorldBorderLeft())  then ChangeLeftGunnerLBulletState(x, BULLET_STATE_LOST)
                if (gunnerLGLBBullets[x].y# <= WorldBorderUp())    then ChangeLeftGunnerLBulletState(x, BULLET_STATE_LOST)
                if (gunnerLGLBBullets[x].y# >= WorldBorderDown())  then ChangeLeftGunnerLBulletState(x, BULLET_STATE_LOST)
                if (gunnerLGLBBullets[x].x# >= WorldBorderRight()) then ChangeLeftGunnerLBulletState(x, BULLET_STATE_LOST)
            endif
            if (gunnerLGRBBullets[x].State = BULLET_STATE_FIRED)
                if (gunnerLGRBBullets[x].x# <= WorldBorderLeft())  then ChangeLeftGunnerRBulletState(x, BULLET_STATE_LOST)
                if (gunnerLGRBBullets[x].y# <= WorldBorderUp())    then ChangeLeftGunnerRBulletState(x, BULLET_STATE_LOST)
                if (gunnerLGRBBullets[x].y# >= WorldBorderDown())  then ChangeLeftGunnerRBulletState(x, BULLET_STATE_LOST)
                if (gunnerLGRBBullets[x].x# >= WorldBorderRight()) then ChangeLeftGunnerRBulletState(x, BULLET_STATE_LOST)
            endif
            if (gunnerRGLBBullets[x].State = BULLET_STATE_FIRED)
                if (gunnerRGLBBullets[x].x# <= WorldBorderLeft())  then ChangeRightGunnerLBulletState(x, BULLET_STATE_LOST)
                if (gunnerRGLBBullets[x].y# <= WorldBorderUp())    then ChangeRightGunnerLBulletState(x, BULLET_STATE_LOST)
                if (gunnerRGLBBullets[x].y# >= WorldBorderDown())  then ChangeRightGunnerLBulletState(x, BULLET_STATE_LOST)
                if (gunnerRGLBBullets[x].x# >= WorldBorderRight()) then ChangeRightGunnerLBulletState(x, BULLET_STATE_LOST)
            endif
            if (gunnerRGRBBullets[x].State = BULLET_STATE_FIRED)
                if (gunnerRGRBBullets[x].x# <= WorldBorderLeft())  then ChangeRightGunnerRBulletState(x, BULLET_STATE_LOST)
                if (gunnerRGRBBullets[x].y# <= WorldBorderUp())    then ChangeRightGunnerRBulletState(x, BULLET_STATE_LOST)
                if (gunnerRGRBBullets[x].y# >= WorldBorderDown())  then ChangeRightGunnerRBulletState(x, BULLET_STATE_LOST)
                if (gunnerRGRBBullets[x].x# >= WorldBorderRight()) then ChangeRightGunnerRBulletState(x, BULLET_STATE_LOST)
            endif
    next x
EndFunction



` ****** Rear Turret Projectiles FINITE STATE MACHINES **************

Function ChangeRearTurretLProjectileState(index, newState)
    select newState
        case PROJECTILE_STATE_FIRED:    `[1011]
            rearTurretLProjectile[index].state = PROJECTILE_STATE_FIRED
        endcase
        case PROJECTILE_STATE_LOST:     `[1012]
            rearTurretLProjectile[index].state = PROJECTILE_STATE_LOST
            DeleteSprite(rearTurretLProjectile[index].sprID)
            rearTurretLProjectile[index].sprID  = CloneSprite(projectileSpriteID)
            SetSpriteGroup(rearTurretLProjectile[index].sprID, -1)
            SetSpritePhysicsOn(rearTurretLProjectile[index].sprID, DYNAMIC)
            rearTurretLProjectile[index].width#   = GetSpriteWidth(rearTurretLProjectile[index].sprID)
            rearTurretLProjectile[index].height#  = GetSpriteHeight(rearTurretLProjectile[index].sprID)
            rearTurretLProjectile[index].state = PROJECTILE_STATE_INACTIVE
            SetParticlesVisible(rearTurretLParticles[index].particleID, INVISIBLE) ` *** Recycle Particle Emitter
            rearTurretLParticles[index].active = FALSE
        endcase
        case PROJECTILE_STATE_IMPACT:   `[1013]
            rearTurretLProjectile[index].state = PROJECTILE_STATE_IMPACT
            SetAnimationToHeadOMunition(rearTurretLProjectile[index].SprID, rearTurretLProjectile[index].impactSprID)
            PlaySprite(rearTurretLProjectile[index].impactSprID,FRAME_RATE_4,NO_LOOP,1,7)
            ChangeRearTurretLProjectileState(index, PROJECTILE_STATE_LOST)
        endcase
        case PROJECTILE_STATE_INACTIVE: `[1014]
            rearTurretLProjectile[index].state = PROJECTILE_STATE_INACTIVE
        endcase
    endselect
EndFunction


Function ChangeRearTurretRProjectileState(index, newState)
    select newState
        case PROJECTILE_STATE_FIRED:    `[1011]
            rearTurretRProjectile[index].state = PROJECTILE_STATE_FIRED
        endcase
        case PROJECTILE_STATE_LOST:     `[1012]
            rearTurretRProjectile[index].state = PROJECTILE_STATE_LOST
            DeleteSprite(rearTurretRProjectile[index].sprID)
            rearTurretRProjectile[index].sprID  = CloneSprite(projectileSpriteID)
            SetSpriteGroup(rearTurretRProjectile[index].sprID, -1)
            SetSpritePhysicsOn(rearTurretRProjectile[index].sprID, DYNAMIC)
            rearTurretRProjectile[index].width#   = GetSpriteWidth(rearTurretRProjectile[index].sprID)
            rearTurretRProjectile[index].height#  = GetSpriteHeight(rearTurretRProjectile[index].sprID)
            rearTurretRProjectile[index].state = PROJECTILE_STATE_INACTIVE
            SetParticlesVisible(rearTurretRParticles[index].particleID, INVISIBLE) ` *** Recycle Particle Emitter
            rearTurretRParticles[index].active = FALSE
        endcase
        case PROJECTILE_STATE_IMPACT:   `[1013]
            rearTurretRProjectile[index].state = PROJECTILE_STATE_IMPACT
            SetAnimationToHeadOMunition(rearTurretRProjectile[index].SprID, rearTurretRProjectile[index].impactSprID)
            PlaySprite(rearTurretRProjectile[index].impactSprID,FRAME_RATE_4,0,1,7)
            ChangeRearTurretRProjectileState(index, PROJECTILE_STATE_LOST)
        endcase
        case PROJECTILE_STATE_INACTIVE: `[1014]
            rearTurretRProjectile[index].state = PROJECTILE_STATE_INACTIVE
        endcase
    endselect
EndFunction

Function ChangeRearTurretMProjectileState(index, newState)
    select newState
        case PROJECTILE_STATE_FIRED:    `[1011]
            rearTurretMProjectile[index].state = PROJECTILE_STATE_FIRED
        endcase
        case PROJECTILE_STATE_LOST:     `[1012]
            rearTurretMProjectile[index].state = PROJECTILE_STATE_LOST
            DeleteSprite(rearTurretMProjectile[index].sprID)
            rearTurretMProjectile[index].sprID  = CloneSprite(projectileSpriteID)
            SetSpriteGroup(rearTurretMProjectile[index].sprID, -1)
            SetSpritePhysicsOn(rearTurretMProjectile[index].sprID, DYNAMIC)
            rearTurretMProjectile[index].width#   = GetSpriteWidth(rearTurretMProjectile[index].sprID)
            rearTurretMProjectile[index].height#  = GetSpriteHeight(rearTurretMProjectile[index].sprID)
            rearTurretMProjectile[index].state = PROJECTILE_STATE_INACTIVE
            SetParticlesVisible(rearTurretMParticles[index].particleID, INVISIBLE) ` *** Recycle Particle Emitter
            rearTurretMParticles[index].active = FALSE
        endcase
        case PROJECTILE_STATE_IMPACT:   `[1013]
            rearTurretMProjectile[index].state = PROJECTILE_STATE_IMPACT
            SetAnimationToHeadOMunition(rearTurretMProjectile[index].SprID, rearTurretMProjectile[index].impactSprID)
            PlaySprite(rearTurretMProjectile[index].impactSprID,FRAME_RATE_4,0,1,7)
            ChangeRearTurretMProjectileState(index, PROJECTILE_STATE_LOST)
        endcase
        case PROJECTILE_STATE_INACTIVE: `[1014]
            rearTurretMProjectile[index].state = PROJECTILE_STATE_INACTIVE
        endcase
    endselect
EndFunction


Function CheckRearTurretProjectilesState()
    if (turretRear.fired = TRUE)
        for x = 0 to projectileLimit
            if (rearTurretLProjectile[x].state = PROJECTILE_STATE_FIRED)
                if (rearTurretLProjectile[x].nose_x# <= WorldBorderLeft())  then ChangeRearTurretLProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretLProjectile[x].nose_y# <= WorldBorderUp())    then ChangeRearTurretLProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretLProjectile[x].nose_y# >= WorldBorderDown())  then ChangeRearTurretLProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretLProjectile[x].nose_x# >= WorldBorderRight()) then ChangeRearTurretLProjectileState(x, PROJECTILE_STATE_LOST)
            endif
            if (rearTurretRProjectile[x].state = PROJECTILE_STATE_FIRED)
                if (rearTurretRProjectile[x].nose_x# <= WorldBorderLeft())  then ChangeRearTurretRProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretRProjectile[x].nose_y# <= WorldBorderUp())    then ChangeRearTurretRProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretRProjectile[x].nose_y# >= WorldBorderDown())  then ChangeRearTurretRProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretRProjectile[x].nose_x# >= WorldBorderRight()) then ChangeRearTurretRProjectileState(x, PROJECTILE_STATE_LOST)
            endif
            if (rearTurretMProjectile[x].state = PROJECTILE_STATE_FIRED)
                if (rearTurretMProjectile[x].nose_x# <= WorldBorderLeft())  then ChangeRearTurretMProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretMProjectile[x].nose_y# <= WorldBorderUp())    then ChangeRearTurretMProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretMProjectile[x].nose_y# >= WorldBorderDown())  then ChangeRearTurretMProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretMProjectile[x].nose_x# >= WorldBorderRight()) then ChangeRearTurretMProjectileState(x, PROJECTILE_STATE_LOST)
            endif
        next x
    endif
EndFunction



` ****** Top Turret Projectiles FINITE STATE MACHINES **************

Function ChangeTopTurretLProjectileState(index, newState)
    select newState
        case PROJECTILE_STATE_FIRED:    `[1011]
            topTurretLProjectile[index].state = PROJECTILE_STATE_FIRED
        endcase
        case PROJECTILE_STATE_LOST:     `[1012]
            topTurretLProjectile[index].state = PROJECTILE_STATE_LOST
            DeleteSprite(topTurretLProjectile[index].sprID)
            topTurretLProjectile[index].sprID  = CloneSprite(projectileSpriteID)
            SetSpriteGroup(topTurretLProjectile[index].sprID, -1)
            SetSpritePhysicsOn(topTurretLProjectile[index].sprID, DYNAMIC)
            topTurretLProjectile[index].width#   = GetSpriteWidth(topTurretLProjectile[index].sprID)
            topTurretLProjectile[index].height#  = GetSpriteHeight(topTurretLProjectile[index].sprID)
            topTurretLProjectile[index].state = PROJECTILE_STATE_INACTIVE
            SetParticlesVisible(topTurretLParticles[index].particleID, INVISIBLE) ` *** Recycle Particle Emitter
            topTurretLParticles[index].active = FALSE
        endcase
        case PROJECTILE_STATE_IMPACT:   `[1013]
            topTurretLProjectile[index].state = PROJECTILE_STATE_IMPACT
            SetAnimationToHeadOMunition(topTurretLProjectile[index].SprID, topTurretLProjectile[index].impactSprID)
            PlaySprite(topTurretLProjectile[index].impactSprID,FRAME_RATE_4,NO_LOOP,1,7)
            ChangeTopTurretLProjectileState(index, PROJECTILE_STATE_LOST)
        endcase
        case PROJECTILE_STATE_INACTIVE: `[1014]
            topTurretLProjectile[index].state = PROJECTILE_STATE_INACTIVE
        endcase
    endselect
EndFunction


Function ChangeTopTurretRProjectileState(index, newState)
    select newState
        case PROJECTILE_STATE_FIRED:    `[1011]
            topTurretRProjectile[index].state = PROJECTILE_STATE_FIRED
        endcase
        case PROJECTILE_STATE_LOST:     `[1012]
            topTurretRProjectile[index].state = PROJECTILE_STATE_LOST
            DeleteSprite(topTurretRProjectile[index].sprID)
            topTurretRProjectile[index].sprID  = CloneSprite(projectileSpriteID)
            SetSpriteGroup(topTurretRProjectile[index].sprID, -1)
            SetSpritePhysicsOn(topTurretRProjectile[index].sprID, DYNAMIC)
            topTurretRProjectile[index].width#   = GetSpriteWidth(topTurretRProjectile[index].sprID)
            topTurretRProjectile[index].height#  = GetSpriteHeight(topTurretRProjectile[index].sprID)
            topTurretRProjectile[index].state = PROJECTILE_STATE_INACTIVE
            SetParticlesVisible(topTurretRParticles[index].particleID, INVISIBLE) ` *** Recycle Particle Emitter
            topTurretRParticles[index].active = FALSE
        endcase
        case PROJECTILE_STATE_IMPACT:   `[1013]
            topTurretRProjectile[index].state = PROJECTILE_STATE_IMPACT
            SetAnimationToHeadOMunition(topTurretRProjectile[index].SprID, topTurretRProjectile[index].impactSprID)
            PlaySprite(topTurretRProjectile[index].impactSprID,FRAME_RATE_4,NO_LOOP,1,7)
            ChangeTopTurretRProjectileState(index, PROJECTILE_STATE_LOST)
        endcase
        case PROJECTILE_STATE_INACTIVE: `[1014]
            topTurretRProjectile[index].state = PROJECTILE_STATE_INACTIVE
        endcase
    endselect
EndFunction

Function ChangeTopTurretMProjectileState(index, newState)
    select newState
        case PROJECTILE_STATE_FIRED:    `[1011]
            topTurretMProjectile[index].state = PROJECTILE_STATE_FIRED
        endcase
        case PROJECTILE_STATE_LOST:     `[1012]
            topTurretMProjectile[index].state = PROJECTILE_STATE_LOST
            DeleteSprite(topTurretMProjectile[index].sprID)
            topTurretMProjectile[index].sprID  = CloneSprite(projectileSpriteID)
            SetSpriteGroup(topTurretMProjectile[index].sprID, -1)
            SetSpritePhysicsOn(topTurretMProjectile[index].sprID, DYNAMIC)
            topTurretMProjectile[index].width#   = GetSpriteWidth(topTurretMProjectile[index].sprID)
            topTurretMProjectile[index].height#  = GetSpriteHeight(topTurretMProjectile[index].sprID)
            topTurretMProjectile[index].state = PROJECTILE_STATE_INACTIVE
            SetParticlesVisible(topTurretMParticles[index].particleID, INVISIBLE) ` *** Recycle Particle Emitter
            topTurretMParticles[index].active = FALSE
        endcase
        case PROJECTILE_STATE_IMPACT:   `[1013]
            topTurretMProjectile[index].state = PROJECTILE_STATE_IMPACT
            SetAnimationToHeadOMunition(topTurretMProjectile[index].SprID, topTurretMProjectile[index].impactSprID)
            PlaySprite(topTurretMProjectile[index].impactSprID,FRAME_RATE_4,NO_LOOP,1,7)
            ChangeTopTurretMProjectileState(index, PROJECTILE_STATE_LOST)
        endcase
        case PROJECTILE_STATE_INACTIVE: `[1014]
            topTurretMProjectile[index].state = PROJECTILE_STATE_INACTIVE
        endcase
    endselect
EndFunction

Function CheckTopTurretProjectilesState()
    if (turretTop.fired = TRUE)
        for x = 0 to projectileLimit
            if (topTurretLProjectile[x].state = PROJECTILE_STATE_FIRED)
                if (topTurretLProjectile[x].nose_x# <= WorldBorderLeft())  then ChangeTopTurretLProjectileState(x, PROJECTILE_STATE_LOST)
                if (topTurretLProjectile[x].nose_y# <= WorldBorderUp())    then ChangeTopTurretLProjectileState(x, PROJECTILE_STATE_LOST)
                if (topTurretLProjectile[x].nose_y# >= WorldBorderDown())  then ChangeTopTurretLProjectileState(x, PROJECTILE_STATE_LOST)
                if (topTurretLProjectile[x].nose_x# >= WorldBorderRight()) then ChangeTopTurretLProjectileState(x, PROJECTILE_STATE_LOST)
            endif
            if (topTurretRProjectile[x].state = PROJECTILE_STATE_FIRED)
                if (topTurretRProjectile[x].nose_x# <= WorldBorderLeft())  then ChangeTopTurretRProjectileState(x, PROJECTILE_STATE_LOST)
                if (topTurretRProjectile[x].nose_y# <= WorldBorderUp())    then ChangeTopTurretRProjectileState(x, PROJECTILE_STATE_LOST)
                if (topTurretRProjectile[x].nose_y# >= WorldBorderDown())  then ChangeTopTurretRProjectileState(x, PROJECTILE_STATE_LOST)
                if (topTurretRProjectile[x].nose_x# >= WorldBorderRight()) then ChangeTopTurretRProjectileState(x, PROJECTILE_STATE_LOST)
            endif
            if (topTurretMProjectile[x].state = PROJECTILE_STATE_FIRED)
                if (topTurretMProjectile[x].nose_x# <= WorldBorderLeft())  then ChangeTopTurretMProjectileState(x, PROJECTILE_STATE_LOST)
                if (topTurretMProjectile[x].nose_y# <= WorldBorderUp())    then ChangeTopTurretMProjectileState(x, PROJECTILE_STATE_LOST)
                if (topTurretMProjectile[x].nose_y# >= WorldBorderDown())  then ChangeTopTurretMProjectileState(x, PROJECTILE_STATE_LOST)
                if (topTurretMProjectile[x].nose_x# >= WorldBorderRight()) then ChangeTopTurretMProjectileState(x, PROJECTILE_STATE_LOST)
            endif
        next x
    endif
EndFunction


` ****** Front Turret Projectiles FINITE STATE MACHINES **************

Function ChangeFrontTurretLProjectileState(index, newState)
    select newState
        case PROJECTILE_STATE_FIRED:    `[1011]
            frontTurretLProjectile[index].state = PROJECTILE_STATE_FIRED
        endcase
        case PROJECTILE_STATE_LOST:     `[1012]
            frontTurretLProjectile[index].state = PROJECTILE_STATE_LOST             ` *** Recycle Projectile
            DeleteSprite(frontTurretLProjectile[index].sprID)
            frontTurretLProjectile[index].sprID  = CloneSprite(projectileSpriteID)
            SetSpriteGroup(frontTurretLProjectile[index].sprID, -1)
            SetSpritePhysicsOn(frontTurretLProjectile[index].sprID, DYNAMIC)
            frontTurretLProjectile[index].width#   = GetSpriteWidth(frontTurretLProjectile[index].sprID)
            frontTurretLProjectile[index].height#  = GetSpriteHeight(frontTurretLProjectile[index].sprID)
            frontTurretLProjectile[index].state = PROJECTILE_STATE_INACTIVE
            SetParticlesVisible(frontTurretLParticles[index].particleID, INVISIBLE) ` *** Recycle Particle Emitter
            frontTurretLParticles[index].active = FALSE
        endcase
        case PROJECTILE_STATE_IMPACT:   `[1013]
            frontTurretLProjectile[index].state = PROJECTILE_STATE_IMPACT
            SetAnimationToHeadOMunition(frontTurretLProjectile[index].SprID, frontTurretLProjectile[index].impactSprID)
            PlaySprite(frontTurretLProjectile[index].impactSprID,FRAME_RATE_4,NO_LOOP,1,7)
            ChangeFrontTurretLProjectileState(index, PROJECTILE_STATE_LOST)
        endcase
        case PROJECTILE_STATE_INACTIVE: `[1014]
            frontTurretLProjectile[index].state = PROJECTILE_STATE_INACTIVE
        endcase
    endselect
EndFunction


Function ChangeFrontTurretRProjectileState(index, newState)
    select newState
        case PROJECTILE_STATE_FIRED:    `[1011]
            frontTurretRProjectile[index].state = PROJECTILE_STATE_FIRED
        endcase
        case PROJECTILE_STATE_LOST:     `[1012]
            frontTurretRProjectile[index].state = PROJECTILE_STATE_LOST             ` *** Recycle Projectile
            DeleteSprite(frontTurretRProjectile[index].sprID)
            frontTurretRProjectile[index].sprID  = CloneSprite(projectileSpriteID)
            SetSpriteGroup(frontTurretRProjectile[index].sprID, -1)
            SetSpritePhysicsOn(frontTurretRProjectile[index].sprID, DYNAMIC)
            frontTurretRProjectile[index].width#   = GetSpriteWidth(frontTurretRProjectile[index].sprID)
            frontTurretRProjectile[index].height#  = GetSpriteHeight(frontTurretRProjectile[index].sprID)
            frontTurretRProjectile[index].state = PROJECTILE_STATE_INACTIVE
            SetParticlesVisible(frontTurretRParticles[index].particleID, INVISIBLE) ` *** Recycle Particle Emitter
            frontTurretRParticles[index].active = FALSE
        endcase
        case PROJECTILE_STATE_IMPACT:   `[1013]
            frontTurretRProjectile[index].state = PROJECTILE_STATE_IMPACT
            SetAnimationToHeadOMunition(frontTurretRProjectile[index].SprID, frontTurretRProjectile[index].impactSprID)
            PlaySprite(frontTurretRProjectile[index].impactSprID,FRAME_RATE_4,NO_LOOP,1,7)
            ChangeFrontTurretRProjectileState(index, PROJECTILE_STATE_LOST)
        endcase
        case PROJECTILE_STATE_INACTIVE: `[1014]
            frontTurretRProjectile[index].state = PROJECTILE_STATE_INACTIVE
        endcase
    endselect
EndFunction

Function ChangeFrontTurretMProjectileState(index, newState)
    select newState
        case PROJECTILE_STATE_FIRED:    `[1011]
            frontTurretMProjectile[index].state = PROJECTILE_STATE_FIRED
        endcase
        case PROJECTILE_STATE_LOST:     `[1012]
            frontTurretMProjectile[index].state = PROJECTILE_STATE_LOST             ` *** Recycle Projectile
            DeleteSprite(frontTurretMProjectile[index].sprID)
            frontTurretMProjectile[index].sprID  = CloneSprite(projectileSpriteID)
            SetSpriteGroup(frontTurretMProjectile[index].sprID, -1)
            SetSpritePhysicsOn(frontTurretMProjectile[index].sprID, DYNAMIC)
            frontTurretMProjectile[index].width#   = GetSpriteWidth(frontTurretMProjectile[index].sprID)
            frontTurretMProjectile[index].height#  = GetSpriteHeight(frontTurretMProjectile[index].sprID)
            frontTurretMProjectile[index].state = PROJECTILE_STATE_INACTIVE
            SetParticlesVisible(frontTurretMParticles[index].particleID, INVISIBLE) ` *** Recycle Particle Emitter
            frontTurretMParticles[index].active = FALSE
        endcase
        case PROJECTILE_STATE_IMPACT:   `[1013]
            frontTurretMProjectile[index].state = PROJECTILE_STATE_IMPACT
            SetAnimationToHeadOMunition(frontTurretMProjectile[index].SprID, frontTurretMProjectile[index].impactSprID)
            PlaySprite(frontTurretMProjectile[index].impactSprID,FRAME_RATE_4,NO_LOOP,1,7)
            ChangeFrontTurretMProjectileState(index, PROJECTILE_STATE_LOST)
        endcase
        case PROJECTILE_STATE_INACTIVE: `[1014]
            frontTurretMProjectile[index].state = PROJECTILE_STATE_INACTIVE
        endcase
    endselect
EndFunction


Function CheckFrontTurretProjectilesState()
    if (turretFront.fired = TRUE)
        for x = 0 to projectileLimit
            if (frontTurretLProjectile[x].state = PROJECTILE_STATE_FIRED)
                if (frontTurretLProjectile[x].nose_x# <= WorldBorderLeft())  then ChangeFrontTurretLProjectileState(x, PROJECTILE_STATE_LOST)
                if (frontTurretLProjectile[x].nose_y# <= WorldBorderUp())    then ChangeFrontTurretLProjectileState(x, PROJECTILE_STATE_LOST)
                if (frontTurretLProjectile[x].nose_y# >= WorldBorderDown())  then ChangeFrontTurretLProjectileState(x, PROJECTILE_STATE_LOST)
                if (frontTurretLProjectile[x].nose_x# >= WorldBorderRight()) then ChangeFrontTurretLProjectileState(x, PROJECTILE_STATE_LOST)
            endif
            if (frontTurretRProjectile[x].state = PROJECTILE_STATE_FIRED)
                if (frontTurretRProjectile[x].nose_x# <= WorldBorderLeft())  then ChangeFrontTurretRProjectileState(x, PROJECTILE_STATE_LOST)
                if (frontTurretRProjectile[x].nose_y# <= WorldBorderUp())    then ChangeFrontTurretRProjectileState(x, PROJECTILE_STATE_LOST)
                if (frontTurretRProjectile[x].nose_y# >= WorldBorderDown())  then ChangeFrontTurretRProjectileState(x, PROJECTILE_STATE_LOST)
                if (frontTurretRProjectile[x].nose_x# >= WorldBorderRight()) then ChangeFrontTurretRProjectileState(x, PROJECTILE_STATE_LOST)
            endif
            if (frontTurretMProjectile[x].state = PROJECTILE_STATE_FIRED)
                if (frontTurretMProjectile[x].nose_x# <= WorldBorderLeft())  then ChangeFrontTurretMProjectileState(x, PROJECTILE_STATE_LOST)
                if (frontTurretMProjectile[x].nose_y# <= WorldBorderUp())    then ChangeFrontTurretMProjectileState(x, PROJECTILE_STATE_LOST)
                if (frontTurretMProjectile[x].nose_y# >= WorldBorderDown())  then ChangeFrontTurretMProjectileState(x, PROJECTILE_STATE_LOST)
                if (frontTurretMProjectile[x].nose_x# >= WorldBorderRight()) then ChangeFrontTurretMProjectileState(x, PROJECTILE_STATE_LOST)
            endif
        next x
    endif
EndFunction


` ****** Torpedo's FINITE STATE MACHINES **************

Function ChangeLeftTorpedoState(index, newState)
    select newState
        case TORPEDO_STATE_FIRED:   `[1001]
            leftTorpedo[index].state = TORPEDO_STATE_FIRED
        endcase
        case TORPEDO_STATE_LOST:    `[1002]
            leftTorpedo[index].state = TORPEDO_STATE_LOST
            DeleteSprite(leftTorpedo[index].sprID)
            leftTorpedo[index].sprID  = CloneSprite(torpedoSpriteID)
            SetSpriteGroup(leftTorpedo[index].sprID, -1)
            SetSpritePhysicsOn(leftTorpedo[index].sprID, DYNAMIC)
            leftTorpedo[index].width#   = GetSpriteWidth(leftTorpedo[index].sprID)
            leftTorpedo[index].height#  = GetSpriteHeight(leftTorpedo[index].sprID)
            leftTorpedo[index].state = TORPEDO_STATE_INACTIVE
            SetParticlesVisible(leftTorpedoParticles[index].particleID, INVISIBLE) ` *** Recycle Particle Emitter
            leftTorpedoParticles[index].active = FALSE
        endcase
        case TORPEDO_STATE_IMPACT:  `[1003]
            leftTorpedo[index].state = TORPEDO_STATE_IMPACT
            SetAnimationToHeadOMunition(leftTorpedo[index].SprID, leftTorpedo[index].impactSprID)
            PlaySprite(leftTorpedo[index].impactSprID,FRAME_RATE_4,NO_LOOP,1,7)
            ChangeLeftTorpedoState(index, TORPEDO_STATE_LOST)
        endcase
        case TORPEDO_STATE_INACTIVE:`[1004]
            leftTorpedo[index].state = TORPEDO_STATE_INACTIVE
        endcase
    endselect
EndFunction


Function ChangeRightTorpedoState(index, newState)
    select newState
        case TORPEDO_STATE_FIRED:   `[1001]
            rightTorpedo[index].state = TORPEDO_STATE_FIRED
        endcase
        case TORPEDO_STATE_LOST:    `[1002]
            rightTorpedo[index].state = TORPEDO_STATE_LOST
            DeleteSprite(rightTorpedo[index].sprID)
            rightTorpedo[index].sprID  = CloneSprite(torpedoSpriteID)
            SetSpriteGroup(rightTorpedo[index].sprID, -1)
            SetSpritePhysicsOn(rightTorpedo[index].sprID, DYNAMIC)
            rightTorpedo[index].width#   = GetSpriteWidth(rightTorpedo[index].sprID)
            rightTorpedo[index].height#  = GetSpriteHeight(rightTorpedo[index].sprID)
            rightTorpedo[index].state = TORPEDO_STATE_INACTIVE
            SetParticlesVisible(rightTorpedoParticles[index].particleID, INVISIBLE) ` *** Recycle Particle Emitter
            rightTorpedoParticles[index].active = FALSE
        endcase
        case TORPEDO_STATE_IMPACT:  `[1003]
            rightTorpedo[index].state = TORPEDO_STATE_IMPACT
            SetAnimationToHeadOMunition(rightTorpedo[index].SprID, rightTorpedo[index].impactSprID)
            PlaySprite(rightTorpedo[index].impactSprID,FRAME_RATE_4,NO_LOOP,1,7)
            ChangeRightTorpedoState(index, TORPEDO_STATE_LOST)
        endcase
        case TORPEDO_STATE_INACTIVE:`[1004]
            rightTorpedo[index].state = TORPEDO_STATE_INACTIVE
        endcase
    endselect
EndFunction


Function CheckLeftTorpedoState()
    if (torpedo_left_fired = TRUE)
        for x = 0 to torpedoLimit
            if (leftTorpedo[x].state = TORPEDO_STATE_FIRED)                      `left Torpedo
                if (leftTorpedo[x].nose_x# <= WorldBorderLeft())  then ChangeLeftTorpedoState(x, TORPEDO_STATE_LOST)
                if (leftTorpedo[x].nose_y# <= WorldBorderUp())    then ChangeLeftTorpedoState(x, TORPEDO_STATE_LOST)
                if (leftTorpedo[x].nose_y# >= WorldBorderDown())  then ChangeLeftTorpedoState(x, TORPEDO_STATE_LOST)
                if (leftTorpedo[x].nose_x# >= WorldBorderRight()) then ChangeLeftTorpedoState(x, TORPEDO_STATE_LOST)
            endif
        next x
    endif
EndFunction

Function CheckRightTorpedoState()
    if (torpedo_right_fired = TRUE)
        for x = 0 to torpedoLimit
            if (rightTorpedo[x].state = TORPEDO_STATE_FIRED)                       ` Right Torpedo
                if (rightTorpedo[x].nose_x# <= WorldBorderLeft())  then ChangeRightTorpedoState(x, TORPEDO_STATE_LOST)
                if (rightTorpedo[x].nose_y# <= WorldBorderUp())    then ChangeRightTorpedoState(x, TORPEDO_STATE_LOST)
                if (rightTorpedo[x].nose_y# >= WorldBorderDown())  then ChangeRightTorpedoState(x, TORPEDO_STATE_LOST)
                if (rightTorpedo[x].nose_x# >= WorldBorderRight()) then ChangeRightTorpedoState(x, TORPEDO_STATE_LOST)
            endif
        next x
    endif
EndFunction


` ****** Mine's FINITE STATE MACHINES **************

Function ChangeMineState(index, newState)
    select newState
        case MINE_STATE_DEPLOYED:   `[1031]
            mine[index].state = MINE_STATE_DEPLOYED
        endcase
        case MINE_STATE_IMPACT:     `[1032]
            mine[index].state = MINE_STATE_IMPACT
        endcase
        case MINE_STATE_INACTIVE:   `[1033]
            mine[index].state = MINE_STATE_INACTIVE
        endcase
    endselect
EndFunction



// *********************** DEBUG STUFF ****************




rem **************************
rem EOF Battleship states.agc
rem **************************



