rem **********************
rem Battleship damages.agc
rem **********************


Function CheckDamages()
    CheckShipDamages()
    CheckEnemiesDamages()
    `DebugDamages()
EndFunction



// ********************** ENEMIES ********************

` **** CheckEnemiesDamages()
Function CheckEnemiesDamages()
    for i = 1 to enemy_limit
        if ((GetSpriteExists(enemy.sprID) = EXISTS) AND (enemy.damage.total >= enemy.damage.limit)) then ChangeEnemyState(ENEMY_STATE_DESTROYED)
        if ((GetSpriteExists(myenemy[i].sprID) = EXISTS) AND (myenemy[i].damage.total >= myenemy[i].damage.limit)) then ChangeMyEnemyState(i, ENEMY_STATE_DESTROYED)
        if ((GetSpriteExists(attackBoats[i].sprID) = EXISTS) AND (attackBoats[i].damage.total >= attackBoats[i].damage.limit)) then ChangeAttackBoatsState(i, ENEMY_STATE_DESTROYED)
    next i
EndFunction



` **** AddDamageToEnemy(object$, amount)
Function AddDamageToEnemy(sprIndex, object$, amount)
    index = spriteLookup[sprIndex].localIndex
    select object$
        case    SINGLE_ENEMY_BOAT   `["enemy"]
            if (enemy.damage.total >= enemy.damage.limit)
                enemy.damage.total = enemy.damage.limit
            else
                enemy.damage.total = enemy.damage.total + amount
            endif
        endcase
        case    ENEMY_BOAT          `["myenemy"]
            if (myenemy[index].damage.total >= myenemy[index].damage.limit)
                myenemy[index].damage.total = myenemy[index].damage.limit
            else
                myenemy[index].damage.total = myenemy[index].damage.total + amount
            endif
        endcase
        case    ATTACK_BOAT          `["attackboat"]
            if (attackBoats[index].damage.total >= attackBoats[index].damage.limit)
                attackBoats[index].damage.total = attackBoats[index].damage.limit
            else
                attackBoats[index].damage.total = attackBoats[index].damage.total + amount
            endif
        endcase
    endselect
EndFunction


// ******************* THE BATTLESHIP*********************

`                 Target SprID & Damage
` **** AddDamageToShip(object$, amount)
Function AddDamageToShip(object$, amount)
    select object$
        case    TURRET_FRONT           `["turretFront"]
            if (ship.damage.turretFront >= ship.damage.turretFrontLimit)
                ship.damage.turretFront = ship.damage.turretFrontLimit
            else
                ship.damage.turretFront = ship.damage.turretFront + amount
            endif
        endcase
        case    TURRET_TOP           `["turretTop"]
            if (ship.damage.turretTop >= ship.damage.turretTopLimit)
                ship.damage.turretTop = ship.damage.turretTopLimit
            else
                ship.damage.turretTop = ship.damage.turretTop + amount
            endif
        endcase
        case    TURRET_REAR            `["turretRear"]
            if (ship.damage.turretRear >= ship.damage.turretRearLimit)
                ship.damage.turretRear = ship.damage.turretRearLimit
            else
                ship.damage.turretRear = ship.damage.turretRear + amount
            endif
        endcase
        case    GUNNER_LEFT            `["gunnerLeft"]
            if (ship.damage.gunnerLeft >= ship.damage.gunnerLeftLimit)
                ship.damage.gunnerLeft = ship.damage.gunnerLeftLimit
            else
                ship.damage.gunnerLeft = ship.damage.gunnerLeft + amount
            endif
        endcase
        case    GUNNER_RIGHT           `["gunnerRight"]
            if (ship.damage.gunnerRight >= ship.damage.gunnerRightLimit)
                ship.damage.gunnerRight = ship.damage.gunnerRightLimit
            else
                ship.damage.gunnerRight = ship.damage.gunnerRight + amount
            endif
        endcase
    endselect
EndFunction


` **** GetDamageToShip(object$)
Function GetDamageToShip(object$)
    damage as integer
        select object$
        case    TURRET_FRONT           `["turretFront"]
            damage = ship.damage.turretFront
        endcase
        case    TURRET_TOP             `["turretTop"]
            damage = ship.damage.turretTop
        endcase
        case    TURRET_REAR            `["turretRear"]
            damage = ship.damage.turretRear
        endcase
        case    GUNNER_LEFT            `["gunnerLeft"]
            damage = ship.damage.gunnerLeft
        endcase
        case    GUNNER_RIGHT           `["gunnerRight"]
            damage = ship.damage.gunnerRight
        endcase
    endselect
endFunction damage


` **** CheckShipDamages()
Function CheckShipDamages()
    ship.damage.total = GetDamageToShip(TURRET_FRONT) + GetDamageToShip(TURRET_TOP) + GetDamageToShip(TURRET_REAR) + GetDamageToShip(GUNNER_LEFT) + GetDamageToShip(GUNNER_RIGHT)
    if (GetDamageToShip(TURRET_FRONT) >= ship.damage.turretFrontLimit)  then ChangeFrontTurretState(TURRETFRONT_STATE_DESTROYED)
    if (GetDamageToShip(TURRET_TOP)   >= ship.damage.turretTopLimit)    then ChangeTopTurretState(TURRETTOP_STATE_DESTROYED)
    if (GetDamageToShip(TURRET_REAR)  >= ship.damage.turretRearLimit)   then ChangeRearTurretState(TURRETREAR_STATE_DESTROYED)
    if (GetDamageToShip(GUNNER_LEFT)  >= ship.damage.gunnerLeftLimit)   then ChangeLeftGunnerState(LEFTGUNNER_STATE_DESTROYED)
    if (GetDamageToShip(GUNNER_RIGHT) >= ship.damage.gunnerRightLimit)  then ChangeRightGunnerState(RIGHTGUNNER_STATE_DESTROYED)
    if (ship.damage.total >= ship.damage.limit) then ChangeShipState(SHIP_STATE_DESTROYED)

EndFunction






rem ****************************
rem EOF Battleship damages.agc
rem ****************************



