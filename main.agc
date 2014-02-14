rem **************************
rem     Battleship Main Game
rem **************************


` **** Included Files
#include "parameters.agc"
#include "setupworld.agc"
#include "battleship.agc"
#include "states.agc"
#include "screenhandling.agc"
#include "collisiondetection.agc"
#include "damages.agc"
#include "debug.agc"
#include "enemies.agc"
#include "enemy_behaviors.agc"
#include "enemy_behavioral_states.agc"
#include "support_functions.agc"
`#include "dfs.agc"
#include "gdab.agc"

` **** Type Declarations

Type _spriteLookupTable
    sprID           as integer
    typeDefinition  as string
    localIndex      as integer
EndType


Type _damage                    ` Note: Most be define *above* the Type Structure it will be used in.
    turretFront      as integer
    turretTop        as integer
    turretRear       as integer
    gunnerLeft       as integer
    gunnerRight      as integer
    total            as integer
    turretFrontLimit as integer
    turretTopLimit   as integer
    turretRearLimit  as integer
    gunnerLeftLimit  as integer
    gunnerRightLimit as integer
    limit            as integer
EndType


Type _ship
        imgFile$
        imgID
        sprID
        x#
        y#
        width#
        height#
        absCtrX#
        absCtrY#
        rotateSpeed#
        angle#
        sensorDistance#
        sensorAngle#
        heading$
        vx
        vy
        rvx
        rvy
        reverseEngines
        isDestroyed
        throttle#
        throttle_engine
        stern_wake_size
        stern_wake_freq
        stern_wake_life#
        bow_wake_size
        bow_wake_freq
        bow_wake_life#
        state
        damage as _damage `Note: In order to use this Type, it *must* be defined above 'this' Type Structure.
EndType


Type _turret
        imgFile$
        imgID
        sprID
        d_imgFile$
        d_imgID
        d_sprID
        x#
        y#
        width#
        height#
        absCtrX#
        absCtrY#
        rotateSpeed#
        sensorDistance#
        sensorAngle#
        angle#
        rightStop
        leftStop
        offset
        offsetFromShipCtr
        fired
        state
        isDestroyed
EndType


Type _gunner
        imgFile$
        imgID
        sprID
        d_imgFile$
        d_imgID
        d_sprID
        x#
        y#
        width#
        height#
        absCtrX#
        absCtrY#
        rotateSpeed#
        sensorDistance#
        sensorAngle#
        angle#
        rightStop
        leftStop
        offset
        state
        isDestroyed
EndType

Type _screen
        viewOffsetX#
        viewOffsetY#
        previousViewOffsetX#
        previousViewOffsetY#
        viewOffsetIncrementX#
        viewOffsetIncrementY#
        viewMultiplierX
        viewMultiplierY
        zoom#
        zoomLowerBoundary#
        zoomUpperBundary#
        magnification#
        absCtrX#
        absCtrY#
EndType

Type _gunnerBullet
    sprID
    x#
    y#
    impactSprID
    damage as integer
    designation as string
    state
EndType

Type _turretProjectile
    sprID
    nose_x#
    nose_y#
    x#
    y#
    width#
    height#
    impactSprID
    damage as integer
    designation as string
    state
EndType

Type _torpedo
    sprID
    nose_x#
    nose_y#
    x#
    y#
    width#
    height#
    impactSprID
    damage as integer
    designation as string
    state
EndType

Type _mine
    sprID
    x#
    y#
    impactSprID
    damage as integer
    designation as string
    state
EndType

Type _projectileParticles
    particleID
    active
EndType

Type _torpedoParticles
    particleID
    active
EndType


Type _enemyDamage
    limit
    total
EndType

Type _steeringSprite
    sprID
    x#
    y#
    width#
    height#
    absCtrX#
    absCtrY#
    angle#
EndType

Type _node
    lastVisited_1        as integer
    lastVisited_2        as integer
    lastVisited_3        as integer
    lastVisited_4        as integer
    lastVisited_5        as integer
    currentTargetIndex   as integer
    currentTargetSprID   as integer
EndType

Type _sensor
    frontTopID      as integer
    frontTop_x      as float
    frontTop_y      as float
    frontBottomID   as integer
    frontBottom_x   as float
    frontBottom_y   as float
    midTopID        as integer
    midTop_x        as float
    midTop_y        as float
    midBottomID     as integer
    midBottom_x     as float
    midBottom_y     as float
    backTopID       as integer
    backTop_x       as float
    backTop_y       as float
    backBottomID    as integer
    backBottom_x    as float
    backBottom_y    as float
EndType

Type _vector
    x   as float
    y   as float
EndType


Type _enemy
    sprID
    state
    behavior_state
    isDestroyed
    steeringSprID
    arrivedAtTarget
    x#
    y#
    width#
    height#
    absCtrX#
    absCtrY#
    angle#
    node            as _node
    damage          as _enemyDamage
    vehicleSpeed    as integer
    deceleration    as integer
    inflictedDamage as integer
    designation     as string
    steering        as _steeringSprite
    obstacleSensor  as _sensor
    forceVector     as _vector
EndType

` **** Steering Shapes

Type _circleShape
    imgFile$
    imgID
    sprID
    x#
    y#
    width#
    height#
    absCtrX#
    absCtrY#
    angle#
EndType

Type _squareShape
    imgFile$
    imgID
    sprID
    x#
    y#
    width#
    height#
    absCtrX#
    absCtrY#
    angle#
EndType

Type _rectangleShape
    imgFile$
    imgID
    sprID
    x#
    y#
    width#
    height#
    absCtrX#
    absCtrY#
    angle#
EndType

Type _shipShape
    imgFile$
    imgID
    sprID
    x#
    y#
    width#
    height#
    absCtrX#
    absCtrY#
    angle#
EndType


Type _POVNavigationalNode
    parent      as integer
    child       as integer
    nodeName$    as string
    matrixIndex  as integer
    visited      as integer
    sprID
    x#
    y#
    width#
    height#
    absCtrX#
    absCtrY#
EndType


Type _goal
    goalName        as String
    satisfied       as integer
    localIndex      as integer
EndType



` **** Type Instantiations
ship             as _ship                                    ` Create a Ship Type
screen           as _screen                                  ` Create a Screen Type
turretFront      as _turret                                  ` Create (3) Turret Types
turretRear       as _turret
turretTop        as _turret
leftGunner       as _gunner                                  ` Create (2) Gunners
rightGunner      as _gunner

acircle                  as _circleShape                           ` Steering Shape Instantiations
arectangle               as _rectangleShape
asquare                  as _squareShape
aship                    as _shipShape

global dim obstacle[10]  as _squareShape                           ` Obstackes


                                                              ` These get mirrored in the Parameters constannts
enemy as _enemy                                               ` Enemy Attack Boat Singleton
global dim myenemy[ENEMY_ARRAY_MAX]      as _enemy            ` Enemy Attack Boat Hords 1
global dim attackBoats[ENEMY_ARRAY_MAX]  as _enemy            ` Enemy Attack Boat Hords 2


` **** POV Navigational Graph Nodes and Matrix
global dim myNodes[5]        as _POVNavigationalNode
global dim myMatrix[5, 5]    as integer


` **** SpriteLookupTable Arrays
global dim spriteLookup[SL_ARRAY_MAX] as _spriteLookupTable

` **** Type Instantiations of Munitions Arrays **************

        ` **** Gunner Bullets ****
global dim gunnerLGLBBullets[BULLETS_ARRAY_MAX] as _gunnerBullet           ` Left Gunner
global dim gunnerLGRBBullets[BULLETS_ARRAY_MAX] as _gunnerBullet
global dim gunnerRGLBBullets[BULLETS_ARRAY_MAX] as _gunnerBullet           ` Right Gunner
global dim gunnerRGRBBullets[BULLETS_ARRAY_MAX] as _gunnerBullet

        ` **** Projectiles ****
global dim frontTurretLProjectile[PROJECTILES_ARRAY_MAX] as _turretProjectile
global dim frontTurretRProjectile[PROJECTILES_ARRAY_MAX] as _turretProjectile   ` Front Turret
global dim frontTurretMProjectile[PROJECTILES_ARRAY_MAX] as _turretProjectile
global dim rearTurretLProjectile[PROJECTILES_ARRAY_MAX]  as _turretProjectile   ` Rear Turret
global dim rearTurretRProjectile[PROJECTILES_ARRAY_MAX]  as _turretProjectile
global dim rearTurretMProjectile[PROJECTILES_ARRAY_MAX]  as _turretProjectile
global dim topTurretLProjectile[PROJECTILES_ARRAY_MAX]   as _turretProjectile   ` Top Turret
global dim topTurretRProjectile[PROJECTILES_ARRAY_MAX]   as _turretProjectile
global dim topTurretMProjectile[PROJECTILES_ARRAY_MAX]   as _turretProjectile

        ` **** Particles (projectiles) ****
global dim frontTurretLParticles[PARTICLES_ARRAY_MAX] as _projectileParticles
global dim frontTurretRParticles[PARTICLES_ARRAY_MAX] as _projectileParticles   ` Front Turrent
global dim frontTurretMParticles[PARTICLES_ARRAY_MAX] as _projectileParticles
global dim rearTurretLParticles[PARTICLES_ARRAY_MAX]  as _projectileParticles   ` Rear Turrent
global dim rearTurretRParticles[PARTICLES_ARRAY_MAX]  as _projectileParticles
global dim rearTurretMParticles[PARTICLES_ARRAY_MAX]  as _projectileParticles
global dim topTurretLParticles[PARTICLES_ARRAY_MAX]   as _projectileParticles   ` Top Turrent
global dim topTurretRParticles[PARTICLES_ARRAY_MAX]   as _projectileParticles
global dim topTurretMParticles[PARTICLES_ARRAY_MAX]   as _projectileParticles

        ` **** Torpedo's ****
global dim leftTorpedo[TORPEDOS_ARRAY_MAX]  as _torpedo
global dim rightTorpedo[TORPEDOS_ARRAY_MAX] as _torpedo
global dim leftTorpedoParticles[TORPEDOS_ARRAY_MAX]  as _torpedoParticles
global dim rightTorpedoParticles[TORPEDOS_ARRAY_MAX] as _torpedoParticles

        ` **** Mines's ****
global dim mine[MINES_ARRAY_MAX] as _mine



` **** MAIN GAME LOGIC
InstantiateGameParameters()
SetUpDisplay()
LoadResources()                         ` Multi-Functions (Does a lot)
LoadEnemyResources()                    ` Multi-Functions (Does a lot)
SetupWorldPhysics()


`ChangeEnemyBehaviorState(SEEK, myNodes[0].sprID)
ConstructGoalStack()
InstantiateGoalConstants()
PrimeGoalStack()

` **** MAIN DO-LOOP
do
    //**** Debug
    `if (GetSpriteExists(attackBoats[1].sprID) = EXISTS) then SetSpritePositionByOffset(attackBoats[1].sprID, GetPointerX(), GetPointerY())

    AnimateWater()
    ControlScreen()                      ` Controls Screen Functions (many)...

    if (ship.state = SHIP_STATE_DEPLOYED)
        ControlShip()
        ControlGuns()
        CheckCurrentShipState()              ` As ship moves about, check it's vitals...
        UpdateShipParameters()               ` Update key ship parameters as it moves about
        UpdateMunitionsParameters()          ` Update Fired key Munitions Parameters as they fly about

        CheckStates()                        ` Does *All* of the state checking (a lot)
        CheckDamages()                       ` Does *All* of the damage reporting on all objects in the game.

        CheckAIBehaviorStates()              ` Checking Behavior States of AI Enemies

        if (EnemySensorCollissionsChecking = ON) then CheckEnemySensorCollissions()

        CheckMunitionsCollisions()           ` Does *ALL* of the munitions collision checking
        CheckWorldBorderCollisions()         ` Check for Collisions
    endif


    // **** Steering Behaviors Testing *****

        ` *********************************** BEGIN TIMER CODE *************************************
        CheckCurrentEnemiesStates()

        InterrogateGoalStack(GOAL_STACK)    ` Note: If the Goal Stack isn't activated, nothing happens including enemy sensor collission detection.

        `SetHideTarget(obstacle[7].sprID, ship.sprID, myNodes[0].sprID)
        `Hide(enemy.sprID, ship.sprID, obstacle[7].sprID, myNodes[0].sprID)

        PrintStack(GOAL_STACK)
        print("goalStackTopIndex: "+Str(goalStackTopIndex))
        Print("enemy.behavior_state: "+ Str(enemy.behavior_state))

        `Print("Enemy Degrees: "+Str(GetSpriteAngle(enemy.sprID)))
        `Print("FVX: "+Str(enemy.forceVector.x))
        `Print("FVY: "+Str(enemy.forceVector.y))

        `print("Distance: "+(Str(distanceFromAtoB(enemy.sprID, ship.sprID))))

        if (GetSpriteExists(enemy.sprID) = EXISTS) AND (GetSpriteExists(ship.sprID)  = EXISTS)
            ` SeekTarget(enemy.sprID, turretRear.sprID)
            ` FleeTarget(enemy.sprID, turretFront.sprID)
            ` PursueTarget(enemy.sprID, ship.SprID)
            ` ArriveAtTarget(enemy.sprID, ship.sprID, SLOW)
            ` EvadeTarget(enemy.sprID, ship.sprID)

            `myTimer = myTimer + 1                           ` Timer Delay for Call
            `if myTimer = 10

            `WanderAround(enemy.sprID)
            `ChangeEnemyBehaviorState(WANDER, SINGLETON)

            `for i = 1 to enemy_limit
            `    WanderAround(attackBoats[i].sprID)
            `next i

            `myTimer = 0
            `endif

          ` ChangeEnemyBehaviorState(SEEK, myNodes[0].sprID)
          ` ChangeEnemyBehaviorState(ARRIVE, myNodes[0].sprID)
          ` ChangeEnemyBehaviorState(PURSUE, ship.SprID)
          ` ChangeEnemyBehaviorState(FLEE, ship.SprID)
          ` ChangeEnemyBehaviorState(EVADE, ship.SprID)
          ` ChangeEnemyBehaviorState(PATROL, SINGLETON) ` NOTE: LoadAIPOVGraph() <-Required a POV graph to already exist

        endif
        ` *********************************** END TIMER CODE ***************************************


    Sync()
loop
End




rem **************************
rem  EOF Battleship Main Game
rem **************************
