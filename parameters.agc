rem *******************************
rem     Battleship parameters.agc
rem *******************************


Function InstantiateGameParameters()

    ` **** MISC Constants
    #constant TRUE                      = 1         ` Logic Globals
    #constant FALSE                     = 0
    #constant ZERO                      = 0
    #constant ONE                       = 1
    #constant ON                        = 1
    #constant OFF                       = -1
    #constant NEGATIVE                  = -1
    #constant SINGLETON                 = -1
    #constant VISIBLE                   = 1
    #constant INVISIBLE                 = 0
    #constant NORMAL                    = 1
    #constant PAUSE                     = 0
    #constant GOOD_GUYS_GROUP           = -1
    #constant NAVGRAPH_GROUP            = -1
    #constant STEERING_GROUP            = -1
    #constant ENEMIES_GROUP             = 3
    #constant OBSTACLES_GROUP           = 1
    #constant DEFAULT_GROUP             = 0
    #constant FRAME_RATE_1              = 42
    #constant FRAME_RATE_2              = 35
    #constant FRAME_RATE_3              = 22
    #constant FRAME_RATE_4              = 16
    #constant FRAME_RATE_5              = 24
    #constant FRAME_RATE_6              = 40
    #constant LOOPING                   = 1
    #constant NO_LOOP                   = 0
    #constant POLYGON                   = 3
    #constant BOX                       = 2
    #constant CIRCLE                    = 1
    #constant EXISTS                    = 1
    #constant NOT_EXISTS                = 0
    #constant NULL                      = -1
    #constant EMPTY                     = -1
    #constant NOT_EMPTY                 = 1
    #constant FULL                      = 99999
    #constant NOT_FULL                  = 1
    #constant SUCCESS                   = 1
    #constant FAILURE                   = -1
    #constant FULL_STOP                 = 1
    #constant HALF_STOP                 = .5
    #constant QUARTER_STOP              = .25

    #constant NONE                      = 0
    #constant SLOW                      = 3
    #constant MEDIUM                    = 2
    #constant FAST                      = 1
    #constant SENSOR                    = 1
    #constant IS_ACTIVE                 = 1
    #constant INACTIVE                  = 0
    #constant PI                        = 3.14159
    #constant CHANGED                   = 1
    #constant UNCHANGED                 = 0
    #constant HALF_SECOND               = .5
    #constant ONE_SECOND                = 1
    #constant TWO_SECONDS               = 2
    #constant CONNECTED                 = 1
    #constant NOTCONNECTED              = -1


    ` **** Global Variables
    global screenWidth                  = 1024      ` Screen Globals
    global ScreenHeight                 = 768
    global worldWidth                   = 10240
    global worldHeight                  = 7680
    global worldAbsCtrX#                = 0
    global worldAbsCtrY#                = 0
    global screenStop$                  = "Null"

    global borderBuffer                 = 50
    global borderWarningDistance        = 500
    global buttonUp                     = TRUE      ` The state of *no* control button currently being pressed.

    global ordinance_speed              = 1800       ` Ordinance Globals
    global ordinance_entrail_size       = 3
    global ordinance_entrail_freq       = 30
    global ordinance_entrail_life#      = .1

    global torpedo_speed                = 300       ` Torpedo Globals
    global torpedo_bubbles_size         = 3
    global torpedo_bubbles_freq         = 30
    global torpedo_bubbles_life#        = .3
    global torpedo_left_fired           = FALSE
    global torpedo_right_fired          = FALSE
    global torpedoLimit                 = 5
    global leftTorpedoCount             = 0
    global rightTorpedoCount            = 0
    global leftTorpedoFireTime          = 0
    global rightTorpedoFireTime         = 0

    global gunnerBulletLimit            = 40        ` Gunner Globals
    global gunnerLBulletCount           = 0
    global gunnerRBulletCount           = 0

    global projectileLimit              = 5         ` Projectile Globals
    global frontTurretProjectileCount   = 0
    global rearTurretProjectileCount    = 0
    global topTurretProjectileCount     = 0
    global frontTurretFireTime          = 0
    global rearTurretFireTime           = 0
    global topTurretFireTime            = 0

    global mineLimit                    = 20
    global mineCount                    = 0
    global mine_deployed                = FALSE
    global mineDeploymentTime           = 0

    global waterAnimationImage          = 0         ` Water Globals
    global water_delay#                 = 0.0

    global ballSize                                 ` *** Debug Instruments
    global lineLength

    global enemy_limit                  = 2         ` *** Enemy globals
    global enemy_damage_limit           = 30
    global enemy_vehicle_speed          = 100
    global enemy_weapons_Range          = 300

    global enemyWanderTimeChange        = 0
    global enemywanderDirection

    ` *** AI Steering Behavior Navigational Maps POV
    global mapNodesSize                 = 5

    global EnemySensorCollissionsChecking = ON


    ` **** Instantiate Ship Type Parameters
    ship.rotateSpeed#                   = 0.5                   ` Lower # = slower turning speed
    ship.imgFile$                       = "battleship.png"
    ship.imgID                          = shipImageID
    ship.sprID                          = shipSpriteID
    ship.sensorDistance#                = 50
    ship.sensorAngle#                   = 10
    ship.isDestroyed                    = FALSE
    ship.reverseEngines                 = FALSE
    ship.throttle#                      = 300
    ship.stern_wake_size                = 3
    ship.stern_wake_freq                = 70
    ship.stern_wake_life#               = .5
    ship.damage.turretFrontLimit        = 34
    ship.damage.turretTopLimit          = 34
    ship.damage.turretRearLimit         = 34
    ship.damage.gunnerLeftLimit         = 20
    ship.damage.gunnerRightLimit        = 20
    ship.damage.limit                   = 142

    ship.bow_wake_size                  = 3
    ship.bow_wake_freq                  = 200
    ship.bow_wake_life#                 = 1.0

    ` **** Ship Damages
    ship.damage.turretFront             = 0
    ship.damage.turretTop               = 0
    ship.damage.turretRear              = 0
    ship.damage.gunnerLeft              = 0
    ship.damage.gunnerRight             = 0
    ship.damage.total                   = 0


    ` **** Instantiate (3) Turret Type Parameters
    turretFront.imgFile$                = "turret.png"              ` *** Front Turret
    turretFront.imgID                   = turretFrontImageID
    turretFront.sprID                   = turretFrontSpriteID
    turretFront.d_imgFile$              = "damaged-turret.png"
    turretFront.d_imgID                 = damagedTurretImageID
    turretFront.d_sprID                 = damagedFrontTurretSpriteID
    turretFront.rotateSpeed#            = 0.7
    turretFront.rightStop               = -125
    turretFront.leftStop                = 125
    turretFront.offset                  = 20
    turretFront.offsetFromShipCtr       = 75
    turretFront.sensorDistance#         = 1
    turretFront.sensorAngle#            = 12
    turretFront.fired                   = FALSE
    turretFront.isDestroyed             = FALSE

    turretRear.imgFile$                 = "turret.png"              ` *** Rear Turret
    turretRear.imgID                    = turretRearImageID
    turretRear.sprID                    = turretRearSpriteID
    turretRear.d_imgFile$               = "damaged-turret.png"
    turretRear.d_imgID                  = damagedTurretImageID
    turretRear.d_sprID                  = damagedRearTurretSpriteID
    turretRear.rotateSpeed#             = 0.7
    turretRear.rightStop                = -315
    turretRear.leftStop                 = -40
    turretRear.offset                   = 20
    turretRear.offsetFromShipCtr        = -170
    turretRear.sensorDistance#          = 1
    turretRear.sensorAngle#             = 12
    turretRear.fired                    = FALSE
    turretRear.isDestroyed              = FALSE

    turretTop.imgFile$                  = "turret.png"              ` *** Top Turret
    turretTop.imgID                     = turretTopImageID
    turretTop.sprID                     = turretTopSpriteID
    turretTop.d_imgFile$                = "damaged-turret.png"
    turretTop.d_imgID                   = damagedTurretImageID
    turretTop.d_sprID                   = damagedTopTurretSpriteID
    turretTop.rotateSpeed#              = 0.7
    turretTop.rightStop                 = -140
    turretTop.leftStop                  = 140
    turretTop.offset                    = 20
    turretTop.offsetFromShipCtr         = 19
    turretTop.sensorDistance#           = 1
    turretTop.sensorAngle#              = 12
    turretTop.fired                     = FALSE
    turretTop.isDestroyed               = FALSE

    ` ****  L/R Gunner Type Parameters
    leftGunner.imgFile$                = "gunner.png"              ` *** Left Gunner
    leftGunner.imgID                   = leftGunnerImageID
    leftGunner.sprID                   = leftGunnerSpriteID

    leftGunner.d_imgFile$              = "damaged-gunner.png"
    leftGunner.d_imgID                 = damagedGunnerImageID
    leftGunner.d_sprID                 = lDamagedGunnerSpriteID

    leftGunner.rotateSpeed#            = 1.5
    leftGunner.rightStop               = 0
    leftGunner.leftStop                = 140
    leftGunner.sensorDistance#         = 5
    leftGunner.offset                  = 7
    leftGunner.sensorAngle#            = 10

    rightGunner.imgFile$               = "gunner.png"              ` *** Right Gunner
    rightGunner.imgID                  = rightGunnerImageID
    rightGunner.sprID                  = rightGunnerSpriteID

    rightGunner.d_imgFile$             = "damaged-gunner.png"
    rightGunner.d_imgID                = damagedGunnerImageID
    rightGunner.d_sprID                = rDamagedGunnerSpriteID

    rightGunner.rotateSpeed#           = 1.5
    rightGunner.rightStop              = -140
    rightGunner.leftStop               = 0
    rightGunner.sensorDistance#        = 5
    rightGunner.offset                 = 7
    rightGunner.sensorAngle#           = 10

    ` **** Screen Type Parameters
    screen.viewOffsetX#                 = 0.0       ` Scrolling view offsets
    screen.viewOffsetY#                 = 0.0
    screen.previousViewOffsetX#         = 0.0       ` Previous Scrolling view offsets
    screen.previousViewOffsetY#         = 0.0
    screen.viewOffsetIncrementX#        = 0         ` Rate of Change for Screen offsets
    screen.viewOffsetIncrementY#        = 0
    screen.viewMultiplierX              = 1500      ` Distance Screen offsets moves
    screen.viewMultiplierY              = 750
    screen.zoom#                        = 1         ` Initial Zoom Factor
    screen.zoomLowerBoundary#           = 0.11      ` DO NOT go lower than .11 or problems
    screen.zoomUpperBundary#            = 1.0       ` DO NOT go higher than 1.0 or problems
    screen.magnification#               = 1         ` Default Magnification Factor


    ` *** AI Steering Behavior Shapes
    acircle.imgFile$                     = "shape-circle.png"
    acircle.imgID                        = shapeCircleImageID
    acircle.SprID                        = shapeCircleSpriteID

    asquare.imgFile$                     = "shape-square.png"
    asquare.imgID                        = shapeSquareImageID
    asquare.SprID                        = shapeSquareSpriteID

    arectangle.imgFile$                   = "shape-rectangle.png"
    arectangle.imgID                      = shapeRectangleImageID
    arectangle.SprID                      = shapeRectangleSpriteID

    aship.imgFile$                        = "shape-ship.png"
    aship.imgID                           = shapeShipImageID
    aship.SprID                           = shapeShipSpriteID

    ` **** Image Constants
    #constant waterImageID              = 1
    #constant leftButtonImageID         = 2
    #constant rightButtonImageID        = 3
    #constant propulsionButtonImageID   = 4
    #constant shipImageID               = 5

    #constant ballImageID               = 6         ` For Debug
    #constant tl_BallImageID            = 7         ` For Debug
    #constant bl_BallImageID            = 8         ` For Debug
    #constant tr_BallImageID            = 9         ` For Debug
    #constant br_BallImageID            = 10        ` For Debug

    #constant inImageID                 = 11
    #constant outImageID                = 12
    #constant reverseButtonImageID      = 13
    #constant throttleUpImageID         = 14
    #constant throttleDownImageID       = 15

    #constant turretFrontImageID        = 16
    #constant turretRearImageID         = 17
    #constant turretTopImageID          = 18

    #constant leftGunnerImageID         = 19
    #constant rightGunnerImageID        = 20
    #constant projectileImageID         = 21
    #constant torpedoImageID            = 22
    #constant gunnerBulletImageID       = 23
    #constant mineImageID               = 24

    #constant launchLightImageID        = 25
    #constant reloadLightImageID        = 26

    #constant cannonFireAnimImageID     = 27
    #constant gunnerFireAnimImageID     = 28
    #constant torpedoFireAnimImageID    = 29
    #constant turretExplodeAnimImageID  = 30
    #constant shipExplodeAnimImageID    = 31
    #constant shipBlowUpAnimImageID     = 32
    #constant gunnerExplodeAnimImageID  = 33
    #constant turretSmokeFireAnimImageID = 34

    #constant damagedTurretImageID      = 35
    #constant damagedGunnerImageID      = 36

    #constant attackBoatImageID         = 37

    #constant bulletImpactImageID       = 38
    #constant projectileImpactImageID   = 39
    #constant torpedoImpactImageID      = 40

    #constant shapeCircleImageID        = 41
    #constant shapeSquareImageID        = 42
    #constant shapeRectangleImageID     = 43
    #constant shapeShipImageID          = 43


    ` **** Sprite Constants
    #constant waterSpriteID              = 100
    #constant leftButtonSpriteID         = 101
    #constant rightButtonSpriteID        = 102
    #constant propulsionButtonSpriteID   = 103
    #constant shipSpriteID               = 104

    #constant ballSpriteID               = 105      ` For Debug
    #constant tl_BallSpriteID            = 106      ` For Debug
    #constant bl_BallSpriteID            = 107      ` For Debug
    #constant tr_BallSpriteID            = 108      ` For Debug
    #constant br_BallSpriteID            = 109      ` For Debug
    #constant ml_BallSpriteID            = 258      ` For Debug
    #constant mr_BallSpriteID            = 259      ` For Debug

    #constant inSpriteID                 = 110      ` Ship Control Buttons
    #constant outSpriteID                = 111
    #constant reverseButtonSpriteID      = 112
    #constant throttleUpSpriteID         = 113
    #constant throttleDownSpriteID       = 114

    #constant turretFrontSpriteID        = 115
    #constant turretRearSpriteID         = 116
    #constant turretTopSpriteID          = 117

    #constant turretFrontLButtonSPriteID  = 118     ` Turret Buttons
    #constant turretFrontRButtonSPriteID  = 119
    #constant turretRearLButtonSPriteID   = 120
    #constant turretRearRButtonSPriteID   = 121
    #constant turretTopLButtonSPriteID    = 122
    #constant turretTopRButtonSPriteID    = 123

    #constant leftGunnerSpriteID          = 124
    #constant rightGunnerSpriteID         = 125

    #constant leftGunnerLButtonSPriteID   = 126     ` Gunner Buttons
    #constant leftGunnerRButtonSPriteID   = 127
    #constant rightGunnerLButtonSPriteID  = 128
    #constant rightGunnerRButtonSPriteID  = 129

    #constant fireTurretFrontButtonID     = 130     ` Fire Buttons
    #constant fireTurretRearButtonID      = 131
    #constant fireTurretTopButtonID       = 132
    #constant fireLeftGunnerButtonID      = 133
    #constant fireRightGunnerButtonID     = 134
    #constant fireLeftTorpedoButtonID     = 135
    #constant fireRightTorpedoButtonID    = 136

    #constant projectileSpriteID          = 137     ` Turret Projectile
    #constant shipEngineWakeParticleID    = 138     ` Engine Wake
    #constant gunnerBulletSpriteID        = 139     ` Gunner Bullet
    #constant torpedoSpriteID             = 140     ` Torpedo's

    #constant screenScrollLButtonID       = 141
    #constant screenScrollRButtonID       = 142
    #constant screenScrollUButtonID       = 143
    #constant screenScrollDButtonID       = 144

    #constant deployMineButtonID          = 145
    #constant mineSpriteID                = 146

    #constant ftLaunchLightSpriteID       = 147
    #constant ftReloadLightSpriteID       = 148
    #constant ttLaunchLightSpriteID       = 149
    #constant ttReloadLightSpriteID       = 150
    #constant rtLaunchLightSpriteID       = 151
    #constant rtReloadLightSpriteID       = 152
    #constant ltpdoLaunchLightSpriteID    = 153
    #constant ltpdoReloadLightSpriteID    = 154
    #constant rtpdoLaunchLightSpriteID    = 155
    #constant rtpdoReloadLightSpriteID    = 156
    #constant mineLaunchLightSpriteID     = 157
    #constant mineReloadLightSpriteID     = 158

    #constant ftCannonFireAnimSpriteID    = 159
    #constant ttCannonFireAnimSpriteID    = 160
    #constant rtCannonFireAnimSpriteID    = 161

    #constant leftGunnerFireAnimSpriteID  = 162
    #constant rightGunnerFireAnimSpriteID = 163

    #constant leftTorpedoFireAnimSpriteID = 164
    #constant rightTorpedoFireAnimSpriteID = 165
    #constant turretExplodeAnimSpriteID   = 166
    #constant shipExplodeAnimSpriteID     = 167
    #constant shipBlowUpAnimSpriteID      = 168

    #constant fTurretExplodeAnimSpriteID  = 170
    #constant tTurretExplodeAnimSpriteID  = 171
    #constant rTurretExplodeAnimSpriteID  = 172

    #constant lGunnerExplosionAminSpriteID = 173
    #constant rGunnerExplosionAminSpriteID = 174

    #constant ftFireSmokeAnimSpriteID     = 175
    #constant ttFireSmokeAnimSpriteID     = 176
    #constant rtFireSmokeAnimSpriteID     = 177

    #constant damagedFrontTurretSpriteID  = 178
    #constant damagedRearTurretSpriteID   = 179
    #constant damagedTopTurretSpriteID    = 180
    #constant lDamagedGunnerSpriteID      = 181
    #constant rDamagedGunnerSpriteID      = 182

    #constant attackBoatSpriteID          = 183

    #constant shipSternWakeParticleID     = 194

    #constant bulletImpactSpriteID        = 195
    #constant projectileImpactSpriteID    = 196
    #constant torpedoImpactSpriteID       = 197

    #constant targetingSpriteID           = 198
    #constant steeringSpriteID            = 199

    #constant shapeCircleSpriteID         = 200
    #constant shapeSquareSpriteID         = 201
    #constant shapeRectangleSpriteID      = 202
    #constant shapeShipSpriteID           = 203



    #constant waterDepth                  = 9999    ` Sprite Depts
    #constant shipDepth                   = 99
    #constant buttonDepth                 = 10
    #constant turretDepth                 = 19
    #constant gunnerDepth                 = 19
    #constant particlesDepth              = 100
    #constant projectileDepth             = 19
    #constant bulletDepth                 = 19
    #constant torpedoDepth                = 99
    #constant mineDepth                   = 99
    #constant lightDepth                  = 10
    #constant animationDepth              = 11
    #constant targetDepth                 = 15
    #constant steeringDepth               = 101

    #constant enemyShipDepth              = 99
    #constant enemyMunitionDepth          = 19
    #constant enemyTorpedoDepth           = 99
    #constant enemyAirPlaneDepth          = 19
    #constant enemyMineDepth              = 99

    #constant AISteeringDepth             = 19

    ` **** Physics Constants
    #constant STATIC                     = 1
    #constant DYNAMIC                    = 2
    #constant KINEMATIC                  = 3

    ` **** Angles for Ship Direction and Screen Handline
    #constant d_UP                      = "UP"
    #constant d_DOWN                    = "DOWN"
    #constant d_LEFT                    = "LEFT"
    #constant d_RIGHT                   = "RIGHT"
    #constant d_TOP_LEFT                = "TOP_LEFT"
    #constant d_TOP_RIGHT               = "TOP_RIGHT"
    #constant d_BOTTOM_LEFT             = "BOTTOM_LEFT"
    #constant d_BOTTOM_RIGHT            = "BOTTOM_RIGHT"


    ` **** Finite State Machine Constants

    // ****** Munitions Constants ******
    #constant TORPEDO_STATE_FIRED       = 1001      ` Torpedos
    #constant TORPEDO_STATE_LOST        = 1002
    #constant TORPEDO_STATE_IMPACT      = 1003
    #constant TORPEDO_STATE_INACTIVE    = 1004
    #constant PROJECTILE_STATE_FIRED    = 1011      ` Turret Projectiles
    #constant PROJECTILE_STATE_LOST     = 1012
    #constant PROJECTILE_STATE_IMPACT   = 1013
    #constant PROJECTILE_STATE_INACTIVE = 1014
    #constant BULLET_STATE_FIRED        = 1021      ` Gunner Bullets
    #constant BULLET_STATE_LOST         = 1022
    #constant BULLET_STATE_IMPACT       = 1023
    #constant BULLET_STATE_INACTIVE     = 1024
    #constant MINE_STATE_DEPLOYED       = 1031      ` Navy Mines
    #constant MINE_STATE_IMPACT         = 1032
    #constant MINE_STATE_INACTIVE       = 1033
    #constant SHIP_STATE_DEPLOYED       = 1041      ` Ship
    #constant SHIP_STATE_DESTROYED      = 1042
    #constant SHIP_STATE_DAMAGED        = 1043

    // ****** Ships Guns Constants ******
    #constant TURRETFRONT_STATE_DEPLOYED  = 1044    ` Front Turret
    #constant TURRETFRONT_STATE_DESTROYED = 1045
    #constant TURRETFRONT_STATE_DAMAGED   = 1046
    #constant TURRETREAR_STATE_DEPLOYED   = 1047    ` Rear Turret
    #constant TURRETREAR_STATE_DESTROYED  = 1048
    #constant TURRETREAR_STATE_DAMAGED    = 1049
    #constant TURRETTOP_STATE_DEPLOYED    = 1050    ` Top Turret
    #constant TURRETTOP_STATE_DESTROYED   = 1051
    #constant TURRETTOP_STATE_DAMAGED     = 1052
    #constant LEFTGUNNER_STATE_DEPLOYED   = 1053    ` Left Gunner
    #constant LEFTGUNNER_STATE_DESTROYED  = 1054
    #constant LEFTGUNNER_STATE_DAMAGED    = 1055
    #constant RIGHTGUNNER_STATE_DEPLOYED  = 1056    ` Right Gunner
    #constant RIGHTGUNNER_STATE_DESTROYED = 1057
    #constant RIGHTGUNNER_STATE_DAMAGED   = 1058


    // ****** Enemy Constants ******
    #constant ENEMY_STATE_DEPLOYED        = 1059
    #constant ENEMY_STATE_DESTROYED       = 1060


    // ****** Enemy Behvaioral Constants ******
    #constant WANDER                      = 1061
    #constant SEEK                        = 1062
    #constant FLEE                        = 1063
    #constant PURSUE                      = 1064
    #constant EVADE                       = 1065
    #constant ARRIVE                      = 1066
    #constant AVOID_OBSTACLE              = 1067
    #constant FLOCK                       = 1068
    #constant IDLE                        = 1069
    #constant PATROL                      = 1070
    #constant ATTACK                      = 1071
    #constant SAFE                        = 1072
    #constant ENGAGED                     = 1073


    ` **** POV Navigational Graps Constants ****
    #constant POV_NAV_GRAPH               = "povNavGraph"

    ` **** Damages Object Constants and Globals
    #constant TURRET_FRONT                = "turretFront"
    #constant TURRET_TOP                  = "turretTop"
    #constant TURRET_REAR                 = "turretRear"
    #constant GUNNER_LEFT                 = "leftGunner"
    #constant GUNNER_RIGHT                = "rightGunner"
    #constant BATTLESHIP                  = "ship"
    #constant SINGLE_ENEMY_BOAT           = "enemy"
    #constant ENEMY_BOAT                  = "myenemy"
    #constant ATTACK_BOAT                 = "attackBoat"
    #constant ATTACK_BOAT_DAMAGE          = 50
    #constant SINGLE_ENEMY_BOAT_DAMAGE    = 25
    #constant ENEMY_BOAT_DAMAGE           = 25
                                                            `

    #constant BULLET                      = "bullet"
    #constant BULLET_DAMAGE               = 2
    #constant BULLET_MASS                 = 1
    #constant PROJECTILE                  = "projectile"
    #constant PROJECTILE_DAMAGE           = 50
    #constant PROJECTILE_MASS             = 50
    #constant TORPEDO                     = "torpedo"
    #constant TORPEDO_DAMAGE              = 30
    #constant TORPEDO_MASS                = 50
    #constant OCEAN_MINE                  = "mine"
    #constant MINE_DAMAGE                 = 30


    #constant SL_ARRAY_MAX               = 15000
    #constant BULLETS_ARRAY_MAX           = 50
    #constant PROJECTILES_ARRAY_MAX       = 5
    #constant PARTICLES_ARRAY_MAX         = 5
    #constant TORPEDOS_ARRAY_MAX          = 5
    #constant MINES_ARRAY_MAX             = 20
    #constant ENEMY_ARRAY_MAX             = 50




EndFunction




rem *******************************
rem  EOF Battleship parameters.agc
rem *******************************













