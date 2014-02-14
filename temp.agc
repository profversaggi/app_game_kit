rem **********************
rem Battleship temp.agc
rem **********************

// This file is a general code repository of testing items and bits of code I might reference later




RemStart
    `SetSpritePosition(tl_BallSpriteID, 0,0)
    SetSpritePosition(tl_BallSpriteID, lineLength*Cos(-145)+ship_x#, lineLength*Sin(-145)+ship_y#)
    `SetSpritePosition(bl_BallSpriteID, 0,768-ballsize)
    SetSpritePosition(bl_BallSpriteID, lineLength*Cos(145)+ship_x#, lineLength*Sin(145)+ship_y#+ship_height#)
    `SetSpritePosition(tr_BallSpriteID, 1024-ballsize,0)
    SetSpritePosition(tr_BallSpriteID, lineLength*Cos(-45)+ship_x#+ship_width#, lineLength*Sin(-45)+ship_y#)
    `SetSpritePosition(br_BallSpriteID, 1024-ballsize,768-ballsize)
    SetSpritePosition(br_BallSpriteID, lineLength*Cos(45)+ship_x#+ship_width#, lineLength*Sin(45)+ship_y#+ship_height#)

    SetSpritePosition(tl_BallSpriteID, ship_x#-lineLength, ship_y#-lineLength)
    SetSpritePosition(bl_BallSpriteID, ship_x#-lineLength, ship_y#+ship_height#+lineLength)
    SetSpritePosition(tr_BallSpriteID, ship_x#+ship_width#+lineLength, ship_y#-lineLength)
    SetSpritePosition(br_BallSpriteID, ship_x#+ship_width#+lineLength, ship_y#+ship_height#+lineLength)

RemEnd



    ` // Offset Calculation of any given sprite using a ball ->(top left is rotation point of Ball, NOT it's center)
    ` SetSpritePosition(ballSpriteID, ship_x#+ship_width#, ship_y#)                         ` Top Right
    ` SetSpritePosition(ballSpriteID, ship_x#+ship_width#, ship_y#+ship_height#)            ` Bottom Right
    ` SetSpritePosition(ballSpriteID, ship_x#+ship_width#, ship_y#+ship_height#/2.0)        ` Middle Right
    ` SetSpritePosition(ballSpriteID, ship_x#+ship_width#/2.0, ship_y#)                     ` Top Middle
    ` SetSpritePosition(ballSpriteID, ship_x#+ship_width#/2.0, ship_y#+ship_height#)        ` Bottom Middle
    ` SetSpritePosition(ballSpriteID, ship_x#+ship_width#/2.0, ship_y#+ship_height#/2.0)     ` Absolute Center
    ` SetSpritePosition(ballSpriteID, ship_x#, ship_y#)                                     ` Top Left
    ` SetSpritePosition(ballSpriteID, ship_x#, ship_y#+ship_height#)                        ` Bottom Left
    ` SetSpritePosition(ballSpriteID, ship_x#, ship_y#+ship_height#/2)                      ` Middle Left




    RemStart
    SetSpritePosition(tl_BallSpriteID, lineLength*Cos(-145)+ship_x#, lineLength*Sin(-145)+ship_y#)
    SetSpritePosition(bl_BallSpriteID, lineLength*Cos(145)+ship_x#, lineLength*Sin(145)+ship_y#+ship_height#)
    SetSpritePosition(tr_BallSpriteID, lineLength*Cos(-45)+ship_x#+ship_width#, lineLength*Sin(-45)+ship_y#)
    SetSpritePosition(br_BallSpriteID, lineLength*Cos(45)+ship_x#+ship_width#, lineLength*Sin(45)+ship_y#+ship_height#)
    RemEnd



 `SetSpritePhysicsImpulse(ship.sprID, -(ship.width#/2.0)*(Cos(ship.angle#))+ship.absCtrX#, -(ship.width#/2.0)*(Sin(ship.angle#))+ship.absCtrY#, vx, vy)
 `SetSpritePosition(tl_BallSpriteID, (-(ship.width#/2.0)-ship.sensorDistance#)*(Cos(angle#))+ship.absCtrX#, (-(ship.width#/2.0)-ship.sensorDistance#)*(Sin(angle#))+ship.absCtrY#)
 `SetSpritePosition(tr_BallSpriteID, ( (ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#))+ship.absCtrX#, ( (ship.width#/2.0)+sensorDistance#)*(Sin(angle#))+ship.absCtrY#)





    `ship_x# = GetSpriteX(shipSpriteID)                   ` Top
    `ship_y# = GetSpriteY(shipSpriteID)                   ` Left
    `ship_width# = GetSpriteWidth(shipSpriteID)           ` Width Offset
    `ship_height# = GetSpriteHeight(shipSpriteID)         ` Height Offset

    `ship_abs_ctr_x# = ship_x#+ship_width#/2.0            ` Absolute Center X
    `ship_abs_ctr_y# = ship_y#+ship_height#/2.0           ` Absolute Center Y




    `ship_half_length# = ship_width#/2.0                  ` Length of 1/2 ship
    `Print("abs_X: "+Str(ship_abs_ctr_x#)+" abs_Y: "+Str(ship_abs_ctr_y#))
    `Print("trb_X: "+Str((ship_half_length#+lineLength)*(Cos(angle#))+ship_abs_ctr_x#)+" trb_Y: "+Str((ship_half_length#+lineLength)*(Sin(angle#))+ship_abs_ctr_y#))


    ` Note: using (-ship_half_length#) puts the marker on the tail of the ship, using (+ship_half_length#) would put it at the front.
    `lineLength = 50
    `angle# = GetSpriteAngle(shipSpriteID)
    `SetSpritePosition(tl_BallSpriteID, (-ship_half_length#-lineLength)*(Cos(angle#))+ship_abs_ctr_x#, (-ship_half_length#-lineLength)*(Sin(angle#))+ship_abs_ctr_y#)
    `SetSpritePosition(tr_BallSpriteID, (ship_half_length#+lineLength)*(Cos(angle#))+ship_abs_ctr_x#, (ship_half_length#+lineLength)*(Sin(angle#))+ship_abs_ctr_y#)



    `viewOffsetX# = viewOffsetX# + viewOffsetIncrementX
    `viewOffsetY# = viewOffsetY# + viewOffsetIncrementY
    `SetViewOffset(viewOffsetX#, viewOffsetY#)


Function MigrationCheck()
    angle# = GetSpriteAngle(ship.sprID)
    Print("Migrate-Angle: "+Str(angle#))

    Print("VW: "+Str(GetVirtualWidth())+" VH: "+Str(GetVirtualHeight()))
    Print("SVW: "+Str(ScreenToWorldX(GetVirtualWidth()))+" SVH: "+Str(ScreenToWorldY(GetVirtualHeight())))
    Print("SVW-: "+Str(ScreenToWorldX(GetVirtualWidth()-screenWidth))+" SVH-: "+Str(ScreenToWorldY(GetVirtualHeight()-screenHeight)))
    Print("VOX: "+Str(viewOffsetX#)+" VOY: "+Str(viewOffsetY#))

    Print("SensorTR: "+Str(((ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#))+ship.absCtrX#)+" : "+Str(((ship.width#/2.0)+ship.sensorDistance#)*(Sin(angle#-ship.sensorAngle#))+ship.absCtrY#))
    Print("STR_FN: "+Str(ShipSensorTopLeft()))

    Print("SensorBR: "+Str(((ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#)+" : "+Str(((ship.width#/2.0)+ship.sensorDistance#)*(Sin(angle#+ship.sensorAngle#))+ship.absCtrY#))
    Print("SBR_FN: "+Str(ShipSensorBottomRight()))

    Print("SensorTL: "+Str((-(ship.width#/2.0)-ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#)+" : "+Str((-(ship.width#/2.0)-ship.sensorDistance#)*(Sin(angle#+ship.sensorAngle#))+ship.absCtrY#))
    Print("SensorBL: "+Str((-(ship.width#/2.0)-ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#))+ship.absCtrX#)+" : "+Str((-(ship.width#/2.0)-ship.sensorDistance#)*(Sin(angle#-ship.sensorAngle#))+ship.absCtrY#))

    ` SetSpritePosition(tr_BallSpriteID, ( (ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#))+ship.absCtrX#, ( (ship.width#/2.0)+ship.sensorDistance#)*(Sin(angle#-ship.sensorAngle#))+ship.absCtrY#)
    ` SetSpritePosition(br_BallSpriteID, ( (ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#, ( (ship.width#/2.0)+ship.sensorDistance#)*(Sin(angle#+ship.sensorAngle#))+ship.absCtrY#)

    ` SetSpritePosition(tl_BallSpriteID, (-(ship.width#/2.0)-ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#, (-(ship.width#/2.0)-ship.sensorDistance#)*(Sin(angle#+ship.sensorAngle#))+ship.absCtrY#)
    ` SetSpritePosition(bl_BallSpriteID, (-(ship.width#/2.0)-ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#))+ship.absCtrX#, (-(ship.width#/2.0)-ship.sensorDistance#)*(Sin(angle#-ship.sensorAngle#))+ship.absCtrY#)



   // [TR/BR] RIGHT Border
     if ( (((ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#))+ship.absCtrX#) > ScreenToWorldX(GetVirtualWidth()) OR (((ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#) > ScreenToWorldX(GetVirtualWidth())) and (ship.heading$ = d_RIGHT)

        Print("viewOffsetX: "+Str(viewOffsetX#))
        Print("viewOffsetY: "+Str(viewOffsetY#))

        Print("viewOffsetIncrementX#: "+Str(viewOffsetIncrementX#))
        Print("viewOffsetIncrementY#: "+Str(viewOffsetIncrementY#))

        sleep(3000)
        UpdateScreenWorld()
        Print("*** Screen RIGHT ***")
        Print("Heading: "+ ship.heading$)

    // [TR/BR] LEFT Border
    elseif ((((ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#))+ship.absCtrX#) < (ScreenToWorldX(GetVirtualWidth())-screenWidth) OR  (((ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#) < (ScreenToWorldX(GetVirtualWidth())-screenWidth)) and (ship.heading$ = d_LEFT)

        Print("viewOffsetX: "+Str(viewOffsetX#))
        Print("viewOffsetY: "+Str(viewOffsetY#))

        Print("viewOffsetIncrementX#: "+Str(viewOffsetIncrementX#))
        Print("viewOffsetIncrementY#: "+Str(viewOffsetIncrementY#))

        sleep(3000)
        UpdateScreenWorld()
        Print("*** Screen LEFT ***")
        Print("Heading: "+ ship.heading$)


     endif



                ` Note: using (-ship_half_length# or -(ship.width#/2.0)) puts the force marker on the tail of the ship,
                ` using (+ship_half_length#) would put it at the front.
                `SetSpritePosition(ballSpriteID, -(ship.width#/2.0)*(Cos(ship.angle#))+ship.absCtrX#, -(ship.width#/2.0)*(Sin(ship.angle#))+ship.absCtrY#)




    SetSpriteAngle(turretTop.sprID, turretTop.angle#)
    SetSpriteAngle(turretFront.sprID, turretFront.angle#)
    SetSpriteAngle(turretRear.sprID, turretRear.angle#-180)





    ` Set Turret Guns Positions on Ship - these never change.
    SetSpritePositionByOffset(turretTop.sprID, 22*(Cos(ship.angle#))+ship.absCtrX#, 22*(Sin(ship.angle#))+ship.absCtrY#)
    SetSpritePositionByOffset(turretFront.sprID, 85*(Cos(ship.angle#))+ship.absCtrX#, 85*(Sin(ship.angle#))+ship.absCtrY#)
    SetSpritePositionByOffset(turretRear.sprID, -177*(Cos(ship.angle#))+ship.absCtrX#, -177*(Sin(ship.angle#))+ship.absCtrY#)


    turretFront.angle# = GetSpriteAngle(turretFront.sprID)
    turretRear.angle#  = GetSpriteAngle(turretRear.sprID)
    turretTop.angle#   = GetSpriteAngle(turretTop.sprID)

    Print("Ship Angle: "+Str(ship.angle#))
    Print("FT Angle: "+Str(turretFront.angle#))

    if (turretFront.moved = FALSE)
        turretFront.angle# = ship.angle#                ` Set turret angle to ship angle
        SetSpriteAngle(turretFront.sprID, ship.angle#)  ` Move turrent angle with ship angle
    elseif (turretFront.moved = TRUE)
        turretFront.angle# = ship.angle#-turretFront.angle#
        SetSpriteAngle(turretFront.sprID, ship.angle#-turretFront.angle#)
    endif



    `SetSpriteAngle(turretFront.sprID, turretFront.angle#)
    `SetSpriteAngle(turretRear.sprID, turretRear.angle#)
    `SetSpriteAngle(turretTop.sprID, turretTop.angle#)






    if (turretFront.moved = FALSE)
        turretFront.angle# = ship.angle#                ` Set turret angle to ship angle
        SetSpriteAngle(turretFront.sprID, turretFront.angle#)  ` Move turrent angle with ship angle
    endif

    if (turretRear.moved = FALSE)
        turretRear.angle# = ship.angle#-180            ` Set turret angle to ship angle -180
        SetSpriteAngle(turretRear.sprID, turretRear.angle#)  ` Move turrent angle with ship angle
    endif

    if (turretTop.moved = FALSE)
        turretTop.angle# = ship.angle#                ` Set turret angle to ship angle
        SetSpriteAngle(turretTop.sprID, turretTop.angle#)  ` Move turrent angle with ship angle
    endif



    if (turretFront.moved = FALSE)
        turretFront.angle# = ship.angle#                        ` Set turret angle to ship angle
        SetSpriteAngle(turretFront.sprID, turretFront.angle#)   ` Move turrent angle with ship angle
    elseif (turretFront.moved = TRUE)
        SetSpriteAngle(turretFront.sprID, ship.angle#-turretFront.angle#)
    endif


    `Print("Zoom#: "+Str(screen.zoom#))
    `Print("Reverse Engines: "+Str(ship.reverseEngines))
    `Print("Throttle: "+Str(ship.throttle#))
    `ScreenMovementDebug()
    `ScreenDebug()



`angle# = ship.angle#                        ` (NOTE: No Changes to angle#)
`DeploySensorMarkers(angle#)




    Print("Ship Angle: "+Str(ship.angle#))
    Print("FT Angle: "+Str(turretFront.angle#))
    Print("RT Angle: "+Str(turretRear.angle#))
    Print("TT Angle: "+Str(turretTop.angle#))




` **** DeploySensorMarkers() [Old Format - Pre ShipSensors Development]
Function DeploySensorMarkers(angle#)
    SetSpritePosition(tl_BallSpriteID, (-(ship.width#/2.0)-ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#, (-(ship.width#/2.0)-ship.sensorDistance#)*(Sin(angle#+ship.sensorAngle#))+ship.absCtrY#)
    SetSpritePosition(tr_BallSpriteID, ( (ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#))+ship.absCtrX#, ( (ship.width#/2.0)+ship.sensorDistance#)*(Sin(angle#-ship.sensorAngle#))+ship.absCtrY#)
    SetSpritePosition(bl_BallSpriteID, (-(ship.width#/2.0)-ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#))+ship.absCtrX#, (-(ship.width#/2.0)-ship.sensorDistance#)*(Sin(angle#-ship.sensorAngle#))+ship.absCtrY#)
    SetSpritePosition(br_BallSpriteID, ( (ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#, ( (ship.width#/2.0)+ship.sensorDistance#)*(Sin(angle#+ship.sensorAngle#))+ship.absCtrY#)
EndFunction





    ` **** Calculate X/Y Positions of Left Gunners, then position them
    xT_coordinate# = (-(leftGunner.x_offset))*(Cos(ship.angle#+ship.sensorAngle#))+ship.absCtrX#
    yT_coordinate# = (-(leftGunner.y_offset))*(Sin(ship.angle#+ship.sensorAngle#))+ship.absCtrY#
    SetSpritePositionByOffset(leftGunner.sprID, xT_coordinate#, yT_coordinate#)
    ` **** Calculate X/Y Positions of Right Gunners, then position them
    xB_coordinate# = (-(rightGunner.x_offset))*(Cos(ship.angle#+ship.sensorAngle#))+ship.absCtrX#
    yB_coordinate# = ((rightGunner.y_offset))*(Sin(ship.angle#+ship.sensorAngle#))+ship.absCtrY#
    SetSpritePositionByOffset(rightGunner.sprID, xB_coordinate#, yB_coordinate#)




` **** DeployTurretMarkers_Rear()  [Old Style]
Function DeployTurretMarkers_Rear(angle#)
    `SetSpritePositionByOffset(tr_BallSpriteID, ( (turretRear.width#/2.0)+turretRear.sensorDistance#)*(Cos(angle#-turretRear.sensorAngle#))+turretRear.absCtrX#-turretRear.offset, ( (turretRear.width#/2.0)+turretRear.sensorDistance#)*(Sin(angle#-turretRear.sensorAngle#))+turretRear.absCtrY#)
    `SetSpritePositionByOffset(br_BallSpriteID, ( (turretRear.width#/2.0)+turretRear.sensorDistance#)*(Cos(angle#+turretRear.sensorAngle#))+turretRear.absCtrX#-turretRear.offset, ( (turretRear.width#/2.0)+turretRear.sensorDistance#)*(Sin(angle#+turretRear.sensorAngle#))+turretRear.absCtrY#)

    `SetSpritePosition(tl_BallSpriteID, (-(ship.width#/2.0)-ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#,
    `                                   (-(ship.width#/2.0)-ship.sensorDistance#)*(Sin(angle#+ship.sensorAngle#))+ship.absCtrY#)

    turretRear.x# = GetSpriteX(turretRear.sprID)                      ` Rear Turret Data Refresh
    turretRear.y# = GetSpriteY(turretRear.sprID)
    turretRear.width# = GetSpriteWidth(turretRear.sprID)/2.0
    turretRear.height# = GetSpriteHeight(turretRear.sprID)/2.0
    turretRear.absCtrX# = turretRear.x#+turretRear.width#
    turretRear.absCtrY# = turretRear.y#+turretRear.height#

        x# = 2*((turretRear.width#/2.0)+turretRear.sensorDistance#+6)*(Cos(angle#+turretRear.sensorAngle#))+turretRear.absCtrX#-turretRear.offset
        y# = 2*((turretRear.width#/2.0)+turretRear.sensorDistance#+6)*(Sin(angle#+turretRear.sensorAngle#))+turretRear.absCtrY#


    `SetSpritePosition(tl_BallSpriteID, x#, y#)

    `turretRear.x# = GetSpriteX(turretRear.sprID)                      ` Rear
    `turretRear.y# = GetSpriteY(turretRear.sprID)
    `turretRear.width# = GetSpriteWidth(turretRear.sprID)
    `turretRear.height# = GetSpriteHeight(turretRear.sprID)
    `turretRear.absCtrX# = turretRear.x#+turretRear.width#/2
    `turretRear.absCtrY# = turretRear.y#+turretRear.height#/2

    xm# = 40*Cos(angle#)+turretRear.absCtrX#-turretRear.offset
    ym# = 40*Sin(angle#)+turretRear.absCtrY#
    SetSpritePositionByOffset(br_BallSpriteID, xm#, ym#)
    ` Notes: The (-turretRear.offset) is because the turret sprite has an offset of 20 when created so it rotates more realistically.
    ` The multiplier 50 is the distance from the rotation point to where we want the ball to appear. The angle# = GetSpriteAngle(turretRear.sprID).
    ` The measurement point is the absolute center of the sprite (absCtrX#, absCtryX#) This formula works properly and should be remembered and understood.

    ` General Formula: Lenth of Line * Cos/Sin(Angle)+(starting Point X,Y), and x-offset [if sprite is offset]

EndFunction




    `SetSpritePositionByOffset(turretFront.sprID, turretFront.offsetFromShipCtr*(Cos(ship.angle#))+ship.absCtrX#, turretFront.offsetFromShipCtr*(Sin(ship.angle#))+ship.absCtrY#)
    `SetSpritePositionByOffset(turretRear.sprID,  turretRear.offsetFromShipCtr *(Cos(ship.angle#))+ship.absCtrX#, turretRear.offsetFromShipCtr *(Sin(ship.angle#))+ship.absCtrY#)
    `SetSpritePositionByOffset(turretTop.sprID,   turretTop.offsetFromShipCtr  *(Cos(ship.angle#))+ship.absCtrX#, turretTop.offsetFromShipCtr  *(Sin(ship.angle#))+ship.absCtrY#)


    ` Position Gunners on the ship            NOTE: Port is left and starboard is right
    // NOTE: In order to place a marker (or anything) so that they maintain their position when the central object rotates, be *sure* to adjust BOTH
    // the X and Y positions, in this case dividing by 2 or dividing by 6. Also, adding 4 to the angle allows us correct placement on the ship.
    SetSpritePositionByOffset(leftGunner.sprID,  (-(ship.width#/34.0)-ship.sensorDistance#)*(Cos(ship.angle#+ship.sensorAngle#+4))+ship.absCtrX#, (-(ship.width#/34.0)-ship.sensorDistance#)*(Sin(ship.angle#+ship.sensorAngle#+4))+ship.absCtrY#)
    SetSpritePositionByOffset(rightGunner.sprID, (-(ship.width#/34.0)-ship.sensorDistance#)*(Cos(ship.angle#-ship.sensorAngle#-4))+ship.absCtrX#, (-(ship.width#/34.0)-ship.sensorDistance#)*(Sin(ship.angle#-ship.sensorAngle#-4))+ship.absCtrY#)

    `SetSpritePositionByOffset(turretFront.sprID, turretFront.offsetFromShipCtr*(Cos(ship.angle#))+ship.absCtrX#, turretFront.offsetFromShipCtr*(Sin(ship.angle#))+ship.absCtrY#)
    `SetSpritePositionByOffset(turretRear.sprID,  turretRear.offsetFromShipCtr *(Cos(ship.angle#))+ship.absCtrX#, turretRear.offsetFromShipCtr *(Sin(ship.angle#))+ship.absCtrY#)
    `SetSpritePositionByOffset(turretTop.sprID,   turretTop.offsetFromShipCtr  *(Cos(ship.angle#))+ship.absCtrX#, turretTop.offsetFromShipCtr  *(Sin(ship.angle#))+ship.absCtrY#)


    `DeployTurretMarkers(GetSpriteAngle(turretFront.sprID))





                `KEEP: SetSpritePositionByOffset(projectileMSpriteID, (27*Cos(angle#)+(xM#-turretFront.offset)),  (27*Sin(angle#)+(yM#)) )
                `SetSpritePositionByOffset(projectileRSpriteID, ( (turretFront.width#/2.0)+turretFront.sensorDistance#)*(Cos(angle#-turretFront.sensorAngle#))+turretFront.absCtrX#-turretFront.offset, ( (turretFront.width#/2.0)+turretFront.sensorDistance#)*(Sin(angle#-turretFront.sensorAngle#))+turretFront.absCtrY#)
                `SetSpritePositionByOffset(projectileLSpriteID, ( (turretFront.width#/2.0)+turretFront.sensorDistance#)*(Cos(angle#+turretFront.sensorAngle#))+turretFront.absCtrX#-turretFront.offset, ( (turretFront.width#/2.0)+turretFront.sensorDistance#)*(Sin(angle#+turretFront.sensorAngle#))+turretFront.absCtrY#)
                `SetSpritePositionByOffset(projectileMSpriteID, (30*Cos(angle#)+(turretFront.absCtrX#-turretFront.offset)),  (30*Sin(angle#)+(turretFront.absCtrY#)) )



` **** DeployTurretMarkers()  [Old Style]
Function DeployTurretMarkers(angle#)
    SetSpritePositionByOffset(tr_BallSpriteID, ( (turretFront.width#/2.0)+turretFront.sensorDistance#)*(Cos(angle#-turretFront.sensorAngle#))+turretFront.absCtrX#-turretFront.offset, ( (turretFront.width#/2.0)+turretFront.sensorDistance#)*(Sin(angle#-turretFront.sensorAngle#))+turretFront.absCtrY#)
    SetSpritePositionByOffset(br_BallSpriteID, ( (turretFront.width#/2.0)+turretFront.sensorDistance#)*(Cos(angle#+turretFront.sensorAngle#))+turretFront.absCtrX#-turretFront.offset, ( (turretFront.width#/2.0)+turretFront.sensorDistance#)*(Sin(angle#+turretFront.sensorAngle#))+turretFront.absCtrY#)
    SetSpritePositionByOffset(bl_BallSpriteID, (30*Cos(angle#)+(turretFront.absCtrX#-turretFront.offset)),  (30*Sin(angle#)+(turretFront.absCtrY#)) )
EndFunction




    if (turret$ = "left")
        x# = ((turretRear.width#/2.0)+turretRear.sensorDistance#)*(Cos(angle#+turretRear.sensorAngle#))+turretRear.absCtrX#-turretRear.offset
        y# = ((turretRear.width#/2.0)+turretRear.sensorDistance#)*(Sin(angle#+turretRear.sensorAngle#))+turretRear.absCtrY#
    elseif (turret$ = "right")
        x# = ( (turretRear.width#/2.0)+turretRear.sensorDistance#)*(Cos(angle#-turretRear.sensorAngle#))+turretRear.absCtrX#-turretRear.offset
        y# = ((turretRear.width#/2.0)+turretRear.sensorDistance#)*(Sin(angle#-turretRear.sensorAngle#))+turretRear.absCtrY#




IMPORTANT: To get the center coordinate of the end of a sprite right, see below:

    `turretRear.x# = GetSpriteX(turretRear.sprID)                      ` Rear
    `turretRear.y# = GetSpriteY(turretRear.sprID)
    `turretRear.width# = GetSpriteWidth(turretRear.sprID)/2.0
    `turretRear.height# = GetSpriteHeight(turretRear.sprID)/2.0
    `turretRear.absCtrX# = turretRear.x#+turretRear.width#
    `turretRear.absCtrY# = turretRear.y#+turretRear.height#

    SetSpritePositionByOffset(tl_BallSpriteID, 50*Cos(angle#)+turretRear.absCtrX#-turretRear.offset, 50*Sin(angle#)+turretRear.absCtrY#)
    ` Notes: The (-turretRear.offset) is because the turret sprite has an offset of 20 when created so it rotates more realistically.
    ` The multiplier 50 is the distance from the rotation point to where we want the ball to appear. The angle# = GetSpriteAngle(turretRear.sprID).
    ` The measurement point is the absolute center of the sprite (absCtrX#, absCtryX#) This formula works properly and should be remembered and understood.



Definitions:
    the front part of the boat is th bow front=BOW back=STERN left side=PORT SIDE right side=STARBOARD SIDE The front at the waterline is called the prow.
    The forward part of the deck is the fo'c'sle, from forecastle, and the most forward part of a sailing ship is the bowsprit.




    ` Upate the particles (aka the engine wake) regardless of their visible state
    x# = -(ship.width#/2.0)*(Cos(ship.angle#))+ship.absCtrX#        ` Go straight back 1/2 width
    y# = -(ship.width#/2.0)*(Sin(ship.angle#))+ship.absCtrY#        ` and 1/2 height to place wake.
    SetParticlesPosition(shipEngineWakeParticleID, x#, y#)

    x# = -(ship.width#/2.0)*(Cos(ship.angle#))+ship.absCtrX#        ` Go straight back 1/2 width
    y# = -(ship.width#/2.0)*(Sin(ship.angle#))+ship.absCtrY#        ` and 1/2 height to place wake.
    SetParticlesPosition(shipEngineWakeParticleID, x#, y#)



                                                                                    ` Torpedos
    tx# = GetSpriteX(lTorpedoSpriteID)+GetSpriteWidth(lTorpedoSpriteID)/2           ` Set offset to sprites absolute center (X+width/2, Y+height/2)
    ty# = GetSpriteY(lTorpedoSpriteID)+GetSpriteHeight(lTorpedoSpriteID)/2
    `SetSpriteOffset(lTorpedoSpriteID, px#, py#)                                    ` This causes troubles...

    CloneSprite(rTorpedoSpriteID, lTorpedoSpriteID)
    SetSpriteVisible(lTorpedoSpriteID, INVISIBLE)
    SetSpriteVisible(rTorpedoSpriteID, INVISIBLE)
                                                                                    ` Projectiles
    px# = GetSpriteX(ftProjectileMSpriteID)+GetSpriteWidth(ftProjectileMSpriteID)/2 ` Set offset to sprites absolute center (X+width/2, Y+height/2)
    py# = GetSpriteY(ftProjectileMSpriteID)+GetSpriteHeight(ftProjectileMSpriteID)/2
    `SetSpriteOffset(ftProjectileMSpriteID, px#, py#)                                ` This appears to not be needed ...




pass(ship)


Function pass(type1 as _ship)
    print("ImgID: "+Str(type1.ImgID))
    print("SprID: "+Str(type1.SprID))
EndFunction





type var1
    v1 as integer
    v2 as float
    v3 as string
endtype

type var2
    v1 as integer
    v2 as float
    v3 as string
endtype

variable1 as var1
variable2 as var2

variable1.v1=1
variable1.v2=1.5
variable1.v3="Hi"

variable2=pass(variable1,variable2)

do

    print(variable2.v1)
    print(variable2.v2)
    print(variable2.v3)
    sync()
loop


function pass(variable1 as var1,variable2 as var2)
    variable2.v1=variable1.v1
    variable2.v2=variable1.v2
    variable2.v3=variable1.v3
endfunction variable2









   for x = 1 to 45

        print("GBSID: "+Str(gunnerBulletSpriteID))
        print("X: "+Str(x))

        gunnerBullet[x].sprID = CloneSprite(gunnerBulletSpriteID)
        print("SprID: "+Str(gunnerBullet[x].sprID))
        SetSpriteGroup(gunnerBullet[x].sprID, -1)
        SetSpritePhysicsOn(gunnerBullet[x].sprID, DYNAMIC)
        LoadLeftGunnerProjectiles(gunnerBullet[x].sprID, "left", angle#)
        vx# = ordinance_speed*Cos(ship.angle#-leftGunner.angle#)
        vy# = ordinance_speed*Sin(ship.angle#-leftGunner.angle#)
        SetSpritePhysicsVelocity(gunnerBullet[x].sprID, vx#, vy#)


        gunnerBullet[x+1].sprID = CloneSprite(gunnerBulletSpriteID)
        print("SprID: "+Str(gunnerBullet[x+1].sprID))
        SetSpriteGroup(gunnerBullet[x+1].sprID, -1)
        SetSpritePhysicsOn(gunnerBullet[x+1].sprID, DYNAMIC)
        LoadLeftGunnerProjectiles(gunnerBullet[x+1].sprID, "right", angle#)
        vx# = ordinance_speed*Cos(ship.angle#-leftGunner.angle#)
        vy# = ordinance_speed*Sin(ship.angle#-leftGunner.angle#)
        SetSpritePhysicsVelocity(gunnerBullet[x+1].sprID, vx#, vy#)

    next x



                RemStart
                if (gunnerBulletCount = gunnerBulletLimit) then gunnerBulletCount = 0
                gunnerBulletCount = gunnerBulletCount + 1

                LoadLeftGunnerProjectiles(gunnerLBBullets[gunnerBulletCount].sprID, "left", angle#)
                LoadLeftGunnerProjectiles(gunnerRBBullets[gunnerBulletCount].sprID, "right", angle#)
                vx# = ordinance_speed*Cos(ship.angle#-leftGunner.angle#)
                vy# = ordinance_speed*Sin(ship.angle#-leftGunner.angle#)
                SetSpritePhysicsVelocity(gunnerLBBullets[gunnerBulletCount].sprID, vx#, vy#)
                SetSpritePhysicsVelocity(gunnerRBBullets[gunnerBulletCount].sprID, vx#, vy#)
                RemEnd





                remstart
                angle# = GetSpriteAngle(rightGunner.sprID)
                LoadRightGunnerProjectiles(tl_BallSpriteID, "left", angle#)
                LoadRightGunnerProjectiles(tr_BallSpriteID, "right", angle#)
                vx# = ordinance_speed*Cos(ship.angle#-rightGunner.angle#)
                vy# = ordinance_speed*Sin(ship.angle#-rightGunner.angle#)
                SetSpritePhysicsVelocity(tl_BallSpriteID, vx#, vy#)
                SetSpritePhysicsVelocity(tr_BallSpriteID, vx#, vy#)
                remend







            case 130 ` **** Fire Front Turret [fireTurretFrontButtonID]
                turretFront.fired = TRUE
                CheckCurrentShipState()
                angle# = GetSpriteAngle(turretFront.sprID)
                LoadFTProjectiles(ftProjectileRSpriteID, "right",  angle#)
                LoadFTProjectiles(ftProjectileLSpriteID, "left",   angle#)
                LoadFTProjectiles(ftProjectileMSpriteID, "center", angle#)
                pa# = ship.angle#-turretFront.angle#
                SetSpriteAngle(ftProjectileRSpriteID, pa#)
                SetSpriteAngle(ftProjectileLSpriteID, pa#)
                SetSpriteAngle(ftProjectileMSpriteID, pa#)
                vx# = ordinance_speed*Cos(ship.angle#-turretFront.angle#)
                vy# = ordinance_speed*Sin(ship.angle#-turretFront.angle#)
                SetSpritePhysicsVelocity(ftProjectileRSpriteID, vx#, vy#)
                SetSpritePhysicsVelocity(ftProjectileLSpriteID, vx#, vy#)
                SetSpritePhysicsVelocity(ftProjectileMSpriteID, vx#, vy#)
                SetParticlesToTailOfSprite(ftProjectileRParticleID, ftProjectileRSpriteID, pa#)
                SetParticlesToTailOfSprite(ftProjectileLParticleID, ftProjectileLSpriteID, pa#)
                SetParticlesToTailOfSprite(ftProjectileMParticleID, ftProjectileMSpriteID, pa#)
            endcase



                `remstart
                LoadRTProjectiles(rtProjectileRSpriteID, "right",  angle#)
                LoadRTProjectiles(rtProjectileLSpriteID, "left",   angle#)
                LoadRTProjectiles(rtProjectileMSpriteID, "center", angle#)
                pa# = ship.angle#-turretRear.angle#
                SetSpriteAngle(rtProjectileRSpriteID, pa#)
                SetSpriteAngle(rtProjectileLSpriteID, pa#)
                SetSpriteAngle(rtProjectileMSpriteID, pa#)
                vx# = ordinance_speed*Cos(ship.angle#-turretRear.angle#)
                vy# = ordinance_speed*Sin(ship.angle#-turretRear.angle#)
                SetSpritePhysicsVelocity(rtProjectileRSpriteID, vx#, vy#)
                SetSpritePhysicsVelocity(rtProjectileLSpriteID, vx#, vy#)
                SetSpritePhysicsVelocity(rtProjectileMSpriteID, vx#, vy#)
                SetParticlesToTailOfSprite(rtProjectileRParticleID, rtProjectileRSpriteID, pa#)
                SetParticlesToTailOfSprite(rtProjectileLParticleID, rtProjectileLSpriteID, pa#)
                SetParticlesToTailOfSprite(rtProjectileMParticleID, rtProjectileMSpriteID, pa#)
                remend



AND (GetSeconds() > fireTime + 5)


    ship.x# = GetSpriteX(ship.sprID)                   ` Top
    ship.y# = GetSpriteY(ship.sprID)                   ` Left
    ship.width# = GetSpriteWidth(ship.sprID)           ` Width Offset
    ship.height# = GetSpriteHeight(ship.sprID)         ` Height Offset
    ship.absCtrX# = ship.x#+ship.width#/2.0            ` Absolute Center X
    ship.absCtrY# = ship.y#+ship.height#/2.0           ` Absolute Center Y


    ` *** Particles Management *******
    if (turretFront.fired = TRUE)
        angle# = ship.angle#-turretFront.angle#                                             ` Front Turret Particles
        for x = 1 to projectileLimit
            if (frontTurretRParticles[x].active = TRUE)
                SetParticlesToTailOfSprite(frontTurretRParticles[x].particleID, frontTurretRProjectile[x].sprID, angle#)
                SetParticlesToTailOfSprite(frontTurretLParticles[x].particleID, frontTurretLProjectile[x].sprID, angle#)
                SetParticlesToTailOfSprite(frontTurretMParticles[x].particleID, frontTurretMProjectile[x].sprID, angle#)
            endif
        next x
    endif
    if (turretTop.fired = TRUE)
        angle# = ship.angle#-turretTop.angle#                                               ` Top Turret Particles
        for x = 1 to projectileLimit
            if (topTurretRParticles[x].active = TRUE)
                SetParticlesToTailOfSprite(topTurretRParticles[x].particleID, topTurretRProjectile[x].sprID, angle#)
                SetParticlesToTailOfSprite(topTurretLParticles[x].particleID, topTurretLProjectile[x].sprID, angle#)
                SetParticlesToTailOfSprite(topTurretMParticles[x].particleID, topTurretMProjectile[x].sprID, angle#)
            endif
        next x
    endif
    if (turretRear.fired = TRUE)
        angle# = ship.angle#-turretRear.angle#                                               ` Rear Turret Particles
        for x = 1 to projectileLimit
            if (rearTurretRParticles[x].active = TRUE)
                SetParticlesToTailOfSprite(rearTurretRParticles[x].particleID, rearTurretRProjectile[x].sprID, angle#)
                SetParticlesToTailOfSprite(rearTurretLParticles[x].particleID, rearTurretLProjectile[x].sprID, angle#)
                SetParticlesToTailOfSprite(rearTurretMParticles[x].particleID, rearTurretMProjectile[x].sprID, angle#)
            endif
        next x
    endif
    if (torpedo_left_fired = TRUE)                                                          ` Torpedo Particles
        for x = 1 to torpedoLimit
            if (leftTorpedoParticles[x].active = TRUE)
                SetParticlesToTailOfSprite(leftTorpedoParticles[x].particleID, leftTorpedo[x].sprID, ship.angle#)
            endif
        next x
    endif
    if (torpedo_right_fired = TRUE)
        for x = 1 to torpedoLimit
            if (rightTorpedoParticles[x].active = TRUE)
                SetParticlesToTailOfSprite(rightTorpedoParticles[x].particleID, rightTorpedo[x].sprID, ship.angle#)
            endif
        next x
    endif




    select GetSpriteHit(ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY())) // Use when executing SetViewOffset()

            case 118 `

            endcase

            case 136

                endif
            endcase
        endselect




rem
rem Constants for use in select/case
rem


#constant game_mainMenu 1
#constant game_mainGame 2
#constant game_mainEnd  3

game_mainState as integer = game_mainMenu


do

select game_mainState
    Case game_mainMenu:
        Print("Hi")
        game_mainState = game_mainGame
    endcase

    Case game_mainGame:
        Print(" to ")
        game_mainState = game_mainEnd
    endcase

    Case game_mainEnd:
        Print("You")
        game_mainState = game_mainMenu
    endcase
endselect
    SYNC()


loop



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
        endcase
        case PROJECTILE_STATE_IMPACT:   `[1013]
            rearTurretLProjectile[index].state = PROJECTILE_STATE_IMPACT
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
        endcase
        case PROJECTILE_STATE_IMPACT:   `[1013]
            rearTurretRProjectile[index].state = PROJECTILE_STATE_IMPACT
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
        endcase
        case PROJECTILE_STATE_IMPACT:   `[1013]
            rearTurretMProjectile[index].state = PROJECTILE_STATE_IMPACT
        endcase
        case PROJECTILE_STATE_INACTIVE: `[1014]
            rearTurretMProjectile[index].state = PROJECTILE_STATE_INACTIVE
        endcase
    endselect
EndFunction


Function CheckRearTurretProjectilesState()
    if (turretRear.fired = TRUE)
        for x = 1 to projectileLimit
            if (rearTurretLProjectile[x].state = PROJECTILE_STATE_FIRED)
                if (rearTurretMProjectileTurretLProjectile[x].nose_x# <= WorldBorderLeft())  then ChangeRearTurretLProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretMProjectileTurretLProjectile[x].nose_y# <= WorldBorderUp())    then ChangeRearTurretLProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretMProjectileTurretLProjectile[x].nose_y# >= WorldBorderDown())  then ChangeRearTurretLProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretMProjectileTurretLProjectile[x].nose_x# >= WorldBorderRight()) then ChangeRearTurretLProjectileState(x, PROJECTILE_STATE_LOST)
            endif
            if (rearTurretMProjectileTurretRProjectile[x].state = PROJECTILE_STATE_FIRED)
                if (rearTurretMProjectileTurretRProjectile[x].nose_x# <= WorldBorderLeft())  then ChangeRearTurretRProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretMProjectileTurretRProjectile[x].nose_y# <= WorldBorderUp())    then ChangeRearTurretRProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretMProjectileTurretRProjectile[x].nose_y# >= WorldBorderDown())  then ChangeRearTurretRProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretMProjectileTurretRProjectile[x].nose_x# >= WorldBorderRight()) then ChangeRearTurretRProjectileState(x, PROJECTILE_STATE_LOST)
            endif
            if (rearTurretMProjectileTurretMProjectile[x].state = PROJECTILE_STATE_FIRED)
                if (rearTurretMProjectileTurretMProjectile[x].nose_x# <= WorldBorderLeft())  then ChangeRearTurretMProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretMProjectileTurretMProjectile[x].nose_y# <= WorldBorderUp())    then ChangeRearTurretMProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretMProjectileTurretMProjectile[x].nose_y# >= WorldBorderDown())  then ChangeRearTurretMProjectileState(x, PROJECTILE_STATE_LOST)
                if (rearTurretMProjectileTurretMProjectile[x].nose_x# >= WorldBorderRight()) then ChangeRearTurretMProjectileState(x, PROJECTILE_STATE_LOST)
            endif
        next x
    endif
EndFunction




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
        endcase
        case BULLET_STATE_INACTIVE: `[1024]
            gunnerRGRBBullets[index].state = BULLET_STATE_INACTIVE
        endcase
    endselect
EndFunction




Function CheckGunnersBulletsState()
    for x = 1 to gunnerBulletLimit
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






       `screen.viewOffsetX# = screen.viewOffsetX# + (screen.viewOffsetIncrementX#*screen.viewMultiplierX)*screen.magnification#
        `screen.viewOffsetY# = screen.viewOffsetY# + (screen.viewOffsetIncrementY#*screen.viewMultiplierY)*screen.magnification#


            case 141: ` **** Scroll Screen Left [screenScrollLButtonID]
                if (screen.viewOffsetX#*screen.magnification# <= WorldBorderLeft())
                    screen.viewOffsetX# = WorldBorderLeft()
                    screen.viewOffsetY# = GetViewOffsetY()
                else
                    screen.viewOffsetX# = screen.viewOffsetX# - 20
                    screen.viewOffsetY# = GetViewOffsetY()
                endif
                SetViewOffset(screen.viewOffsetX#, screen.viewOffsetY#)
            endcase


            case 142: ` **** Scroll Screen Right [screenScrollRButtonID]
                if (screen.viewOffsetX#*screen.magnification# >= WorldBorderRight()-(screenWidth*screen.magnification#)-24)
                    screen.viewOffsetX# = screen.previousViewOffsetX#
                    screen.viewOffsetY# = GetViewOffsetY()
                else
                    screen.previousViewOffsetX# = screen.viewOffsetX#
                    screen.viewOffsetX# = screen.viewOffsetX# + 20
                    screen.viewOffsetY# = GetViewOffsetY()
                endif
                SetViewOffset(screen.viewOffsetX#, screen.viewOffsetY#)
            endcase


            case 143: ` **** Scroll Screen Up [screenScrollUButtonID]
                if (screen.viewOffsetY#*screen.magnification# <= WorldBorderUp())
                    screen.viewOffsetY# = WorldBorderUp()
                    screen.viewOffsetX# = GetViewOffsetX()
                else
                    screen.viewOffsetY# = screen.viewOffsetY# - 20
                    screen.viewOffsetX# = GetViewOffsetX()
                endif
                SetViewOffset(screen.viewOffsetX#, screen.viewOffsetY#)
            endcase


            case 144: ` **** Scroll Screen Down [screenScrollDButtonID]
                if (screen.viewOffsetY#*screen.magnification# >= WorldBorderDown() - (screenHeight*screen.magnification#)-28)
                    screen.viewOffsetY# = screen.previousViewOffsetY#
                    screen.viewOffsetX# = GetViewOffsetX()
                else
                    screen.previousViewOffsetY# = screen.viewOffsetY#
                    screen.viewOffsetY# = screen.viewOffsetY# + 20
                    screen.viewOffsetX# = GetViewOffsetX()
                endif
                SetViewOffset(screen.viewOffsetX#, screen.viewOffsetY#)
            endcase




` **** UpdateScreenWorld()
Function UpdateScreenWorld()                         ` NOTE:=> viewOffsetIncrementX# (or Y#) gets set in EngageShipPropulsion()
    if (ship.isDestroyed = FALSE)
        screen.viewOffsetX# = screen.viewOffsetX# + (screen.viewOffsetIncrementX#*screen.viewMultiplierX)*screen.magnification#
        screen.viewOffsetY# = screen.viewOffsetY# + (screen.viewOffsetIncrementY#*screen.viewMultiplierY)*screen.magnification#
        SetViewOffset(screen.viewOffsetX#, screen.viewOffsetY#)
    endif
EndFunction



` **** MigrationCheck()
` **** This function takes the ships angle, the heading direction and calls UpdateScreenWorld()
` **** to move the ViewOffset of the screen to the proper position.

Function MigrationCheck()
    angle# = GetSpriteAngle(ship.sprID)

    ` ********************************************************************************************************************
    ` * NOTE: This sections values are intimately linked with the values inherent in the function: EngageShipPropulsion()
    ` ********************************************************************************************************************

    ` ****** Top, Bottom, Right and Left Boundaries ********

     ` [TR/BR] RIGHT Border => (+45 > Angle# > +0 AND -450 < Angle# < -0)
     if ( ShipSensorTopRightX() > ScreenBorderRight() OR ShipSensorBottomRightX() > ScreenBorderRight() ) AND (ship.heading$ = d_RIGHT)
        UpdateScreenWorld()

    ` [TR/BR] LEFT Border => (+180 > Angle# > +150 AND -180 < Angle# < -150)
    elseif ( ShipSensorTopRightX() < ScreenBorderLeft() OR  ShipSensorBottomRightX() < ScreenBorderLeft() ) AND (ship.heading$ = d_LEFT)
        UpdateScreenWorld()

    ` [TR/BR] TOP Border => (-130 < Angle# < -70)
    elseif ( ShipSensorTopRightY() < ScreenBorderUp() OR ShipSensorBottomRightY() < ScreenBorderUp() ) AND (ship.heading$ = d_UP)
        UpdateScreenWorld()

    ` [TR/BR] BOTTOM Border => (+130 > Angle# > +70)
    elseif ( ShipSensorTopRightY() > ScreenBorderDown() OR ShipSensorBottomRightY() > ScreenBorderDown() ) AND (ship.heading$ = d_DOWN)
        UpdateScreenWorld()

    ` ***** Diagonal Boundaries: (Corners)  *********

    ` [TR/BR] TOP_RIGHT Border => (-70 < Angle# < -45)
    elseif ( (ShipSensorTopRightX() > ScreenBorderRight() OR ShipSensorBottomRightX() > ScreenBorderRight() ) OR (ShipSensorTopRightY() < ScreenBorderUp() OR ShipSensorBottomRightY() < ScreenBorderUp()) ) AND (ship.heading$ = d_TOP_RIGHT)
        UpdateScreenWorld()

    ` [TR/BR] TOP_LEFT Border => (-150 < Angle# < -130)
    elseif ( (ShipSensorTopRightX() < ScreenBorderLeft() OR ShipSensorBottomRightX() < ScreenBorderLeft() ) OR  (ShipSensorTopRightY() < ScreenBorderUp() OR ShipSensorBottomRightY() < ScreenBorderUp()) ) AND (ship.heading$ = d_TOP_LEFT)
        UpdateScreenWorld()

    ` [TR/BR] BOTTOM_RIGHT Border => (+70 > Angle# > +45)
    elseif ( ((ShipSensorTopRightX() > ScreenBorderRight()) OR (ShipSensorBottomRightX() > ScreenBorderRight())) OR ((ShipSensorTopRightY() > ScreenBorderDown()) OR (ShipSensorBottomRightY() > ScreenBorderDown())) ) AND (ship.heading$ = d_BOTTOM_RIGHT)
        UpdateScreenWorld()

    ` [TR/BR] BOTTOM_LEFT Border => (+150 > Angle# > +130)
    elseif ( ((ShipSensorTopRightX() < ScreenBorderLeft()) OR (ShipSensorBottomRightX() < ScreenBorderLeft())) OR ( (ShipSensorTopRightY() > ScreenBorderDown() ) OR (ShipSensorBottomRightY() > ScreenBorderDown()) ) ) AND (ship.heading$ = d_BOTTOM_LEFT)
        UpdateScreenWorld()
    endif
EndFunction






    if (turretFront.state = TURRETFRONT_STATE_DEPLOYED)
        SetSpritePhysicsOff(turretFront.sprID)
        DeleteSprite(turretFront.sprID)
    endif

    if (turretRear.state = TURRETREAR_STATE_DEPLOYED)
        SetSpritePhysicsOff(turretRear.sprID)
        DeleteSprite(turretRear.sprID)
    endif

    if (turretTop.state = TURRETTOP_STATE_DEPLOYED)
        SetSpritePhysicsOff(turretTop.sprID)
        DeleteSprite(turretTop.sprID)
    endif

    if (leftGunner.state = LEFTGUNNER_STATE_DEPLOYED)
        SetSpritePhysicsOff(leftGunner.sprID)
        DeleteSprite(leftGunner.sprID)
    endif

    if (rightGunner.state = RIGHTGUNNER_STATE_DEPLOYED)
        SetSpritePhysicsOff(rightGunner.sprID)
        DeleteSprite(rightGunner.sprID)
    endif





************* KEEP THESE *********************



    `LoadImage(turretExplodeAnimImageID, "turret-explosion-sprite-sheet.png")
    `LoadImage(turretExplodeAnimImageID, "turret-explosion-sprite-sheet2.png")
    LoadImage(turretExplodeAnimImageID, "turret-explosion-sprite-sheet3.png")
    CreateSprite(turretExplodeAnimSpriteID, turretExplodeAnimImageID)
    SetSpriteSize(turretExplodeAnimSpriteID, 100, -1)
    SetSpriteDepth(turretExplodeAnimSpriteID, animationDepth)
    x# = GetSpriteX(turretExplodeAnimSpriteID)
    y# = GetSpriteY(turretExplodeAnimSpriteID)
    w# = GetSpriteWidth(turretExplodeAnimSpriteID)
    h# = GetSpriteHeight(turretExplodeAnimSpriteID)
    SetSpriteOffset(turretExplodeAnimSpriteID, x#+(w#/2), y#+(h#)) ` Note: Since the animated sprite sits upright,
    SetSpriteGroup(turretExplodeAnimSpriteID, -1)                  ` in order to rotate it properly, we need the offset to be
    SetSpritePhysicsOn(turretExplodeAnimSpriteID, DYNAMIC)         ` in the middle of the bottom of the default sprite position.
    `SetSpriteAnimation(turretExplodeAnimSpriteID, 146, 146, 42)
    `SetSpriteAnimation(turretExplodeAnimSpriteID, 146, 139, 44)
    SetSpriteAnimation(turretExplodeAnimSpriteID, 146, 145, 42)
    SetSpritePositionByOffset(turretExplodeAnimSpriteID, 500, 300)

    LoadImage(shipExplodeAnimImageID, "ship-explosion-sprite-sheet2.png")
    CreateSprite(shipExplodeAnimSpriteID, shipExplodeAnimImageID)
    SetSpriteSize(shipExplodeAnimSpriteID, 150, -1)
    SetSpriteDepth(shipExplodeAnimSpriteID, animationDepth)
    SetSpriteGroup(shipExplodeAnimSpriteID, -1)
    SetSpritePhysicsOn(shipExplodeAnimSpriteID, DYNAMIC)
    SetSpriteAnimation(shipExplodeAnimSpriteID, 68, 68, 135)
    SetSpritePosition(shipExplodeAnimSpriteID, 500, 200)



    ` **** Ship Explosion Animation (Non-Sprite Sheet)
    LoadImage(shipBlowUpAnimImageID,"theship.png")
    CreateSprite(shipBlowUpAnimSpriteID, shipBlowUpAnimImageID)
    SetSpriteAnimation(shipBlowUpAnimSpriteID, 700, 700, 68)
    for i = 1 to 68
        LoadImage(2000+i,"ship_"+right("000"+str(i),3)+".png")
        CreateSprite(2000+i, 2000+i)
        SetSpriteSIze(2000+i, 200, -1)
        SetSpriteDepth(2000+i, animationDepth)
        AddSpriteAnimationFrame(shipBlowUpAnimSpriteID, 2000+i)
        DeleteSprite(2000+i)
    next i

    AddSpriteAnimationFrame(shipBlowUpAnimSpriteID, 2068)
    SetSpriteGroup(shipBlowUpAnimSpriteID, -1)
    SetSpritePhysicsOn(shipBlowUpAnimSpriteID, DYNAMIC)
    `SetSpritePosition(shipBlowUpAnimSpriteID, 600, 100)

************* KEEP THESE *********************

    ` **** Ship Explosion Animation (Non-Sprite Sheet Vintage)
    LoadImage(shipBlowUpAnimImageID,"theship.png")
    CreateSprite(shipBlowUpAnimSpriteID, shipBlowUpAnimImageID)
    SetSpriteAnimation(shipBlowUpAnimSpriteID, 700, 700, 68)

    for i = 1 to 68
        LoadImage(2000+i,"ship_"+right("000"+str(i),3)+".png")
        CreateSprite(2000+i, 2000+i)
        SetSpriteSIze(2000+i, 200, -1)
        SetSpriteDepth(2000+i, animationDepth)
        AddSpriteAnimationFrame(shipBlowUpAnimSpriteID, 2000+i)
        DeleteSprite(2000+i)
    next i

    x# = GetSpriteX(shipBlowUpAnimSpriteID)
    y# = GetSpriteY(shipBlowUpAnimSpriteID)
    w# = GetSpriteWidth(shipBlowUpAnimSpriteID)
    h# = GetSpriteHeight(shipBlowUpAnimSpriteID)
    SetSpriteOffset(shipBlowUpAnimSpriteID, x#+(w#/2), y#+(h#/2))   ` Note: We need to offset to the absolute center of this animation.
    AddSpriteAnimationFrame(shipBlowUpAnimSpriteID, 2068)           ` *** Add in the last (clear) frame of the animation
    `SetSpriteGroup(shipBlowUpAnimSpriteID, -1)
    `SetSpritePhysicsOn(shipBlowUpAnimSpriteID, DYNAMIC)
    SetSpritePositionbyoffset(shipBlowUpAnimSpriteID, 500, 500)
    SetSpriteVisible(shipBlowUpAnimSpriteID, INVISIBLE)


************* KEEP THESE *********************



    `LoadImage(turretExplodeAnimImageID, "turret-explosion-sprite-sheet.png")
    `LoadImage(turretExplodeAnimImageID, "turret-explosion-sprite-sheet2.png")
    LoadImage(turretExplodeAnimImageID, "turret-explosion-sprite-sheet3.png")
    CreateSprite(turretExplodeAnimSpriteID, turretExplodeAnimImageID)
    SetSpriteSize(turretExplodeAnimSpriteID, 100, -1)
    SetSpriteDepth(turretExplodeAnimSpriteID, animationDepth)
    x# = GetSpriteX(turretExplodeAnimSpriteID)
    y# = GetSpriteY(turretExplodeAnimSpriteID)
    w# = GetSpriteWidth(turretExplodeAnimSpriteID)
    h# = GetSpriteHeight(turretExplodeAnimSpriteID)
    SetSpriteOffset(turretExplodeAnimSpriteID, x#+(w#/2), y#+(h#/2))
    `SetSpriteAnimation(turretExplodeAnimSpriteID, 146, 146, 42)
    `SetSpriteAnimation(turretExplodeAnimSpriteID, 146, 139, 44)
    SetSpriteAnimation(turretExplodeAnimSpriteID, 146, 145, 42)
    SetSpriteVisible(turretExplodeAnimSpriteID, INVISIBLE)




    LoadImage(shipExplodeAnimImageID, "ship-explosion-sprite-sheet2.png")
    CreateSprite(shipExplodeAnimSpriteID, shipExplodeAnimImageID)
    SetSpriteSize(shipExplodeAnimSpriteID, 150, -1)
    SetSpriteDepth(shipExplodeAnimSpriteID, animationDepth)
    x# = GetSpriteX(shipExplodeAnimSpriteID)
    y# = GetSpriteY(shipExplodeAnimSpriteID)
    w# = GetSpriteWidth(shipExplodeAnimSpriteID)
    h# = GetSpriteHeight(shipExplodeAnimSpriteID)
    SetSpriteOffset(shipExplodeAnimSpriteID, x#+(w#/2), y#+(h#/2))
    SetSpriteAnimation(shipExplodeAnimSpriteID, 68, 68, 135)
    SetSpriteVisible(shipExplodeAnimSpriteID, INVISIBLE)




************* KEEP THESE *********************



                    SetSpriteVisible(shipExplodeAnimSpriteID, VISIBLE)
                    PlaySprite(shipExplodeAnimSpriteID,42,0,1,135)

                    SetSpriteVisible(turretExplodeAnimSpriteID, VISIBLE)
                    `PlaySprite(turretExplodeAnimSpriteID,42,0,1,42)
                    `PlaySprite(turretExplodeAnimSpriteID,42,0,1,44)
                    PlaySprite(turretExplodeAnimSpriteID,42,0,1,42)




                Print("P["+Str(x)+"]: "+Str(frontTurretRParticles[x].active))



    if (turretFront.isDestroyed = TRUE)
        if (GetSpritePlaying(fTurretExplodeAnimSpriteID) = 0)
            SetAnimationToCenterOfFrontTurret(ftFireSmokeAnimaSpriteID, angle#)
            SetSpriteVisible(ftFireSmokeAnimaSpriteID, VISIBLE)
            PlaySprite(ftFireSmokeAnimaSpriteID,42,1,1,58)
        endif
    endif



************* KEEP THESE *********************



    CreateSprite(ttFireSmokeAnimSpriteID, turretSmokeFireAnimImageID)
    SetSpriteDepth(ttFireSmokeAnimSpriteID, animationDepth)
    SetSpriteSize(ttFireSmokeAnimSpriteID, 60, -1)
    SetSpriteAnimation(ttFireSmokeAnimSpriteID, 256, 211, 26)
    for i = 1 to 26
        LoadImage(2200+i,"firesmoke_"+right("000"+str(i),3)+".png")
        CreateSprite(2200+i, 2200+i)
        SetSpriteDepth(2200+i, animationDepth)
        AddSpriteAnimationFrame(ttFireSmokeAnimSpriteID, 2200+i)
        DeleteSprite(2200+i)
    next i
    x# = GetSpriteX(ttFireSmokeAnimSpriteID)
    y# = GetSpriteY(ttFireSmokeAnimSpriteID)
    w# = GetSpriteWidth(ttFireSmokeAnimSpriteID)
    h# = GetSpriteHeight(ttFireSmokeAnimSpriteID)
    SetSpriteOffset(ttFireSmokeAnimSpriteID, x#+(w#/2), y#+(h#/2))   ` Note: We need to offset to the absolute center of this animation.
    SetSpriteVisible(ttFireSmokeAnimSpriteID, INVISIBLE)





        ` *** This 'while' section halts the animation until thr first one finished to then launch the 2nd
        animationPlaying = GetSpritePlaying(rTurretExplodeAnimSpriteID)
        while animationPlaying = 1
            Sync() ` Sync is required to properly complete the looping
            animationPlaying = GetSpritePlaying(rTurretExplodeAnimSpriteID)
        endwhile



        if (GetSpriteFirstContact(frontTurretLProjectile[1].sprID))
            `spr2 = GetSpriteContactSpriteID2()
            print("collision with sprite:" + str(GetSpriteContactSpriteID2()))
            sleep(2000)
        endif




    LoadImage(bulletImpactImageID, "bullet-impact-blast.png")
    CreateSprite(bulletImpactSpriteID, bulletImpactImageID)
    SetSpriteSize(bulletImpactSpriteID, 50, -1)
    SetSpriteDepth(bulletImpactSpriteID, bulletDepth)
    SetSpritePosition(bulletImpactSpriteID, 150, 150)
    `SetSpriteVisible(bulletImpactSpriteID, INVISIBLE)




    LoadImage(gunnerExplodeAnimImageID, "gunner-explosion-sprite-sheet.png")
    CreateSprite(lGunnerExplosionAminSpriteID, gunnerExplodeAnimImageID)
    SetSpriteSize(lGunnerExplosionAminSpriteID, 100, -1)
    SetSpriteDepth(lGunnerExplosionAminSpriteID, animationDepth)
    x# = GetSpriteX(lGunnerExplosionAminSpriteID)
    y# = GetSpriteY(lGunnerExplosionAminSpriteID)
    w# = GetSpriteWidth(lGunnerExplosionAminSpriteID)
    h# = GetSpriteHeight(lGunnerExplosionAminSpriteID)
    SetSpriteOffset(lGunnerExplosionAminSpriteID, x#+(w#/2), y#+(h#/2))
    SetSpriteAnimation(lGunnerExplosionAminSpriteID, 146, 145, 42)
    SetSpriteVisible(lGunnerExplosionAminSpriteID, INVISIBLE)

    CloneSprite(rGunnerExplosionAminSpriteID, lGunnerExplosionAminSpriteID)
    x# = GetSpriteX(rGunnerExplosionAminSpriteID)
    y# = GetSpriteY(rGunnerExplosionAminSpriteID)
    w# = GetSpriteWidth(rGunnerExplosionAminSpriteID)
    h# = GetSpriteHeight(rGunnerExplosionAminSpriteID)
    SetSpriteOffset(rGunnerExplosionAminSpriteID, x#+(w#/2), y#+(h#/2))
    SetSpriteAnimation(rGunnerExplosionAminSpriteID, 146, 145, 42)
    SetSpriteVisible(rGunnerExplosionAminSpriteID, INVISIBLE)



    LoadImage(projectileImpactImageID, "projectile-impact-blast-sprite-sheet.png")
    CreateSprite(projectileImpactSpriteID, projectileImpactImageID)
    SetSpriteSize(projectileImpactSpriteID, 100, -1)
    SetSpriteDepth(projectileImpactSpriteID, animationDepth)
    x# = GetSpriteX(projectileImpactSpriteID)
    y# = GetSpriteY(projectileImpactSpriteID)
    w# = GetSpriteWidth(projectileImpactSpriteID)
    h# = GetSpriteHeight(projectileImpactSpriteID)
    SetSpriteOffset(projectileImpactSpriteID, x#+(w#/2), y#+(h#/2))
    SetSpriteAnimation(projectileImpactSpriteID, 350, 60, 7)
    SetSpriteVisible(projectileImpactSpriteID, INVISIBLE)







    LoadImage(turretExplodeAnimImageID, "turret-explosion-sprite-sheet4.png")
    CreateSprite(fTurretExplodeAnimSpriteID, turretExplodeAnimImageID)
    SetSpriteSize(fTurretExplodeAnimSpriteID, 150, -1)
    SetSpriteDepth(fTurretExplodeAnimSpriteID, animationDepth)
    x# = GetSpriteX(fTurretExplodeAnimSpriteID)
    y# = GetSpriteY(fTurretExplodeAnimSpriteID)
    w# = GetSpriteWidth(fTurretExplodeAnimSpriteID)
    h# = GetSpriteHeight(fTurretExplodeAnimSpriteID)
    SetSpriteOffset(fTurretExplodeAnimSpriteID, x#+(w#/2), y#+(h#/2))
    SetSpriteAnimation(fTurretExplodeAnimSpriteID, 68, 68, 135)
    SetSpriteVisible(fTurretExplodeAnimSpriteID, INVISIBLE)



    LoadImage(cannonFireAnimImageID, "cannonblastsmall.png")
    CreateSprite(ftCannonFireAnimSpriteID, cannonFireAnimImageID)
    SetSpriteSize(ftCannonFireAnimSpriteID, 80, -1)
    SetSpriteDepth(ftCannonFireAnimSpriteID, animationDepth)
    x# = GetSpriteX(ftCannonFireAnimSpriteID)
    y# = GetSpriteY(ftCannonFireAnimSpriteID)
    w# = GetSpriteWidth(ftCannonFireAnimSpriteID)
    h# = GetSpriteHeight(ftCannonFireAnimSpriteID)
    SetSpriteOffset(ftCannonFireAnimSpriteID, x#+(w#/2), y#+(h#)) ` Note: Since the animated sprite sits upright,
    `SetSpriteGroup(ftCannonFireAnimSpriteID, -1)                  ` in order to rotate it properly, we need the offset to be
    `SetSpritePhysicsOn(ftCannonFireAnimSpriteID, DYNAMIC)         ` in the middle of the bottom of the default sprite position.
    SetSpriteAnimation(ftCannonFireAnimSpriteID, 41, 93, 40)




    global ship.damage.turretFrontLimit   = 34
    global ship.damage.turretTopLimit     = 34
    global ship.damage.turretRearLimit    = 34
    global ship.damage.gunnerLeftLimit    = 20
    global ship.damage.gunnerRightLimit   = 20
    global ship.damage.limit              = 142

    turretFront     as integer
    turretTop       as integer
    turretRear      as integer
    gunnerLeft      as integer
    gunnerRight     as integer
    total            as integer
    turretFrontLimit as integer
    turretTopLimit   as integer
    turretRearLimit  as integer
    gunnerLeftLimit  as integer
    gunnerRightLimit as integer
    limit            as integer






Type _shipDamage
    turretFront as integer
    turretTop   as integer
    turretRear  as integer
    gunnerLeft  as integer
    gunnerRight as integer
    total       as integer
    turretFrontLimit as integer
    turretTopLimit   as integer
    turretRearLimit  as integer
    gunnerLeftLimit  as integer
    gunnerRightLimit as integer
    limit            as integer
EndType





         print("TypeDef_183: "+ spriteLookup[GetSpriteContactSpriteID2()].typeDefinition+".state" )
         sync()
         sleep(4000)

    `spriteLookup[GetSpriteContactSpriteID2()].typeDefinition

    `for i=1 to 32
    `    LoadImage(100+i,"water_"+right("000"+str(i),3)+".png")
    `    setImageWrapU(100+i, 1)
    `    setImageWrapV(100+i, 1)
    `next i




        for i = 1 to enemy_limit
        Print("enemy["+Str(i)+"].SprID :"+ Str(myenemy[i].sprID))
        next i



        +"_"+Str(GetSpriteContactSpriteID2())





        for i = 1 to enemy_limit
            Print("enemy["+Str(i)+"].SprID :"+ Str(myenemy[i].sprID))
            Print("SL_SprID: "+Str(spriteLookup[myenemy[i].sprID].sprID))
            Print("SL_LI: "+Str(spriteLookup[myenemy[i].sprID].localIndex))
            Print("enemy["+Str(i)+"].state :"+ Str(myenemy[i].state))
        next i




    print("sprIndex: "+Str(sprIndex))
    print("amount: "+Str(amount))
    print("localIndex: "+ Str(spriteLookup[sprIndex].localIndex))
    print("damage total: "+Str(myenemy[spriteLookup[sprIndex].localIndex].damage.total))
    print("damage limit: "+Str(myenemy[spriteLookup[sprIndex].localIndex].damage.limit))





    print("sprIndex: "+Str(sprIndex))
    print("amount: "+Str(amount))
    print("localIndex: "+ Str(spriteLookup[sprIndex].localIndex))
    print("damage total: "+Str(myenemy[spriteLookup[sprIndex].localIndex].damage.total))
    print("damage limit: "+Str(myenemy[spriteLookup[sprIndex].localIndex].damage.limit))
    sync()
    sleep(5000)



    print("SprIndex: "+Str(sprIndex))
    print("Object: "+object$)
    print("Amt: "+Str(amount))
    print("localIndex: "+ Str(spriteLookup[sprIndex].localIndex))

    print("SL_sprID: "+ Str(spriteLookup[sprIndex].sprID))
    print("SL_TD: "+ spriteLookup[sprIndex].typeDefinition)
    print("SL_LID: "+ Str(spriteLookup[sprIndex].localIndex))

    sync()
    sleep(3000)



Function CheckEnemiesDamages()
    for i = 1 to enemy_limit
        if (GetSpriteExists(myenemy[i].sprID) = EXISTS) AND (myenemy[i].damage.total >= myenemy[i].damage.limit) then ChangeMyEnemyState(i, ENEMY_STATE_DESTROYED)
        if (GetSpriteExists(attackBoats[i].sprID) = EXISTS) AND (attackBoats[i].damage.total >= attackBoats[i].damage.limit) then ChangeAttackBoatsState(i, ENEMY_STATE_DESTROYED)
    next i
EndFunction





                            angle# = GetSpriteAngle(enemy.sprID)           ` Angle
                            evx# = torpedo_speed*Cos(angle#)     ` The vector is in the direction of the angle of the enemy
                            evy# = torpedo_speed*Sin(angle#)
                            SetSpritePhysicsVelocity(enemy.sprID, evx#, evy#)  ` Move the enemy ...



    ` *** ENEMY AI DEBUG TEST *****
    SeekTarget(enemy.sprID, turretRear.sprID)
    FleeTarget(enemy.sprID, turretFront.sprID)
    print("Distance: "+(Str(distanceFromAtoB(enemy.sprID, turretFront.sprID))))


************* KEEP THESE *********************




    `SeekTarget(enemy.sprID, turretRear.sprID)


    `Print("OX: "+(Str(GetSpriteX(enemy.sprID))))
    `Print("OY: "+(Str(GetSpriteY(enemy.sprID))))
    `Print("TX: "+(Str(GetSpriteX(turretFront.sprID))))
    `Print("TY: "+(Str(GetSpriteY(turretFront.sprID))))

    FleeTarget(enemy.sprID, turretFront.sprID)

    `print("Distance: "+(Str(distanceFromAtoB(enemy.sprID, turretFront.sprID))))
    Print("VX: "+Str(GetSpritePhysicsVelocityX(ship.sprID)))
    Print("VY: "+Str(GetSpritePhysicsVelocityY(ship.sprID)))

    SetSpriteVisible(gunnerBulletSpriteID, VISIBLE)
    `SetSpritePosition(gunnerBulletSpriteID, GetSpriteX(ship.sprID)+GetSpritePhysicsVelocityX(ship.sprID), GetSpriteY(ship.sprID)+GetSpritePhysicsVelocityY(ship.sprID))
    CheckCurrentShipState()

    ` **** Inspiration:
    `x# = -(ship.width#/2.0)*(Cos(ship.angle#))+ship.absCtrX#
    `y# = -(ship.width#/2.0)*(Sin(ship.angle#))+ship.absCtrY#

    x_offset# = ship.absCtrX#   ` Moving the rotation point (x,y) from the Default TLC to somewhere else.
    y_offset# = ship.absCtrY#   ` Is this case the absolute center of the sprite (our ultimate target)

    ` This will be our "*Directly* Proportional to distance bewteen the object and target" factor
    ` Note: Should never be less than 1.
    lineLengthX# = ship.width#  ` Length of line distance projected from the new rotation point
    lineLengthY# = ship.width#  ` in this case it's the entire length of the ship (or width)

    angle# = ship.angle#

    x# = (lineLengthX#*(Cos(angle#)))+x_offset#
    y# = (lineLengthY#*(Sin(angle#)))+y_offset#

    ` This will be our "*Inversely* Proportional to distance bewteen the object and target" factor
    vx# = GetSpritePhysicsVelocityX(ship.sprID) ` The velocities of the physics enabled sprite.
    vy# = GetSpritePhysicsVelocityY(ship.sprID)

    SetSpritePositionByOffset(gunnerBulletSpriteID, x#, y#)



    print("Min 5-6: "+Str(min(5,6)))
    print("Min 6-5: "+Str(min(6,5)))
    print("Min 4-4: "+Str(min(4,4)))


    Print("Speed: "+ Str(speed#))
    `Print("Speed2: "+ Str(speed2#))
    Print("Distance: "+ Str(distance#))
    Print("deceleration: "+ Str(deceleration))
    Print("factor: "+ Str(factor#))
    Print("enemy_vehicle_speed: "+Str(enemy_vehicle_speed))





RemStart
    LoadImage(shapeSquareImageID, "shape-square.png")
    CreateSprite(shapeSquareSpriteID, shapeSquareImageID)
    SetSpriteSize(shapeSquareSpriteID, 50, -1)
    SetSpriteDepth(shapeSquareSpriteID, AISteeringDepth)
    SetSpriteGroup(shapeSquareSpriteID, ENEMIES_GROUP)
    SetSpritePhysicsOn(shapeSquareSpriteID, DYNAMIC)
    SetSpritePosition(shapeCircleSpriteID, 10240, 7600)
    SetSpriteActive(shapeSquareSpriteID, 1)
    SetSpriteVisible(shapeSquareSpriteID, INVISIBLE)
    SetSpritePhysicsIsSensor(shapeSquareSpriteID, SENSOR)

    LoadImage(shapeRectangleImageID, "shape-rectangle.png")
    CreateSprite(shapeRectangleSpriteID, shapeRectangleImageID)
    SetSpriteSize(shapeRectangleSpriteID, 100, -1)
    SetSpriteDepth(shapeRectangleSpriteID, AISteeringDepth)
    SetSpriteGroup(shapeRectangleSpriteID, ENEMIES_GROUP)
    SetSpritePhysicsOn(shapeRectangleSpriteID, DYNAMIC)
    SetSpritePosition(shapeCircleSpriteID, 10240, 7550)
    SetSpriteActive(shapeRectangleSpriteID, 1)
    SetSpriteVisible(shapeRectangleSpriteID, INVISIBLE)
    SetSpritePhysicsIsSensor(shapeRectangleSpriteID, SENSOR)
RemEnd





select quadrant
        case    1
        endcase
endselect



    Print("GS: "+Str(GetSeconds()))
    Print("WT: "+Str(enemyWanderTimeChange))
    Print("WT+1/2 : "+Str(enemyWanderTimeChange + HALF_SECOND))
    Print("EWDC: "+Str(enemywanderDirection))




    if ((GetSeconds() > enemyWanderTimeChange + HALF_SECOND) AND (enemywanderDirection = UNCHANGED))
        enemyWanderTimeChange = GetSeconds()
        enemywanderDirection = CHANGED
    endif



    ` *** Core of Arrive
    distance# = distanceFromAtoB(object, target)
    targetThreshold = 5
    if (distance# > targetThreshold)
        decelerationTweeker# = .03
        speed# = distance# / (FAST * decelerationTweeker#)
        speed# = min(speed#, enemy_vehicle_speed)
    else
        speed# = 0  ` Immediately stops vehicle, sets velocity to zero.
    endif





Function WanderAround(object, index)


    diameter# = 200                 ` taken from the physical width of the sprite, but it could be distance
    radius# = diameter#/2
    area# = PI * (radius#*radius#)
    circumference# = PI*diameter#

    ovx# = GetSpritePhysicsVelocityX(object) ` The velocities of the physics enabled sprites.
    ovy# = GetSpritePhysicsVelocityY(object)


    if (index = SINGLETON)
        x# = (enemy.width#+ovx#+50)*(Cos(enemy.angle#))+enemy.absCtrX#
        y# = (enemy.width#+ovy#+50)*(Sin(enemy.angle#))+enemy.absCtrY#
        SetSpriteVisible(enemy.steering.sprID, VISIBLE)
        steeringSprID = enemy.steering.sprID
    else
        x# = (attackBoats[index].width#+ovx#+50)*(Cos(attackBoats[index].angle#))+attackBoats[index].absCtrX#
        y# = (attackBoats[index].width#+ovy#+50)*(Sin(attackBoats[index].angle#))+attackBoats[index].absCtrY#
        SetSpriteVisible(attackBoats[index].steering.sprID, VISIBLE)
        steeringSprID = attackBoats[index].steering.sprID
    endif

    timeTweek# = Random(0.1, 1.0)

    if ((GetSeconds() > enemyWanderTimeChange + timeTweek#) AND (enemywanderDirection = UNCHANGED))
        enemyWanderTimeChange = GetSeconds()
        enemywanderDirection = CHANGED


        quadrant = random(1,4)
        select quadrant
            case    1
                angle# = random(0, 90)
            endcase
            case    2
                angle# = random(91, 160)
            endcase
            case    3
                angle# = random(200, 270)
            endcase
            case    4
                angle# = random(271, 360)
            endcase
        endselect
        SetSpritePositionByOffset(steeringSprID, radius#*Cos(angle#)+x#, radius#*Sin(angle#)+y#)
    endif

    ` *** Core of Arrive
    distance# = distanceFromAtoB(object, steeringSprID)
    print("distance#: "+Str(distance#))
    targetThreshold = 50

    if (distance# > targetThreshold)
        decelerationTweeker# = .03
        speed# = distance# / (FAST * decelerationTweeker#)
        speed# = min(speed#, enemy_vehicle_speed)
        print("speed#: "+Str(speed#))
    else
        speed# = 0  ` Immediately stops vehicle, sets velocity to zero.
    endif


    PointAtTarget(object, steeringSprID)
    PropelVehicle(object, speed#)

EndFunction







    dim nodes$[5] as string = ["A", "B", "C", "D", "E"]
    dim booleanData[25] as integer = [0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0]
    index = 1


    for i = 0 to mapNodesSize -1
        for j = 0 to mapNodesSize -1
                myMatrix[i, j].isConnected = booleanData[index]
                Print("NodeName: "+ nodes$[i])
                Print("index: "+ Str(index))
                inc index
                Print("M["+Str(i)+","+Str(j)+"]= "+Str(myMatrix[i, j].isConnected))
                Sync()
                sleep(1000)
        next j
    next i





    SetSpritePositionByOffset(myNodes[0].SprID, 5000, 1000) `A      ` **** Place Nodes on Screen
    SetSpritePositionByOffset(myNodes[1].SprID, 6000, 1000) `B
    SetSpritePositionByOffset(myNodes[2].SprID, 6000, 2000) `C
    SetSpritePositionByOffset(myNodes[3].SprID, 5500, 3500) `D
    SetSpritePositionByOffset(myNodes[4].SprID, 5000, 2000) `E



    `Function AddDamageToEnemy(sprIndex, object$, amount)
    `AddDamageToEnemy(GetSpriteContactSpriteID2(), spriteLookup[GetSpriteContactSpriteID2()].typeDefinition, frontTurretLProjectile[i].damage)

                            Print("M["+Str(myNodes[n_index].matrixIndex)+","+Str(j)+"]= "+Str(myMatrix[myNodes[n_index].matrixIndex, j]))
                            Sync()
                            sleep(1000)



                            enemy.node.currentTargetIndex = NONE
                            enemy.node.lastVisited_1 = NONE
                            Print("M["+Str(myNodes[n_index].matrixIndex)+","+Str(j)+"]= "+Str(myMatrix[myNodes[n_index].matrixIndex, j]))




************* KEEP THESE *********************



                        enemy.node.currentTargetIndex = n_index     ` The current node index just visited now.
                        for j = 0 to mapNodesSize -1                ` Itterate down the list of node connections
                            if (myMatrix[myNodes[n_index].matrixIndex, j] = CONNECTED)  ` Once we find a connection
                                if     (myNodes[n_index].matrixIndex = enemy.node.lastVisited_1)    ` If it matches, we're been there already
                                elseif (myNodes[n_index].matrixIndex = enemy.node.lastVisited_2)
                                elseif (myNodes[n_index].matrixIndex = enemy.node.lastVisited_3)
                                elseif (myNodes[n_index].matrixIndex = enemy.node.lastVisited_4)
                                elseif (myNodes[n_index].matrixIndex = enemy.node.lastVisited_5)
                                else
                                    if  (enemy.node.lastVisited_1 = FALSE)
                                        enemy.node.lastVisited_1 = n_index
                                    elseif (enemy.node.lastVisited_2 = FALSE)
                                        enemy.node.lastVisited_2 = n_index
                                    elseif (enemy.node.lastVisited_3 = FALSE)
                                        enemy.node.lastVisited_3 = n_index
                                    elseif (enemy.node.lastVisited_4 = FALSE)
                                        enemy.node.lastVisited_4 = n_index
                                    elseif (enemy.node.lastVisited_5 = FALSE)
                                        enemy.node.lastVisited_5 = n_index
                                        enemy.node.lastVisited_1 = FALSE                    ` Set the rest of the previous to false
                                        enemy.node.lastVisited_2 = FALSE
                                        enemy.node.lastVisited_3 = FALSE
                                        enemy.node.lastVisited_4 = FALSE
                                    endif
                                    enemy.node.currentTargetIndex = j                       ` This is the Node Index of our new target
                                    enemy.node.currentTargetSprID = spriteLookup[j].sprID   ` This is the Node Sprite ID of our new target
                                    enemy.arrivedAtTarget = FALSE
                                    PatrolArea(object, enemy.node.currentTargetSprID)
                                endif
                            endif
                        next j




Function PatrolArea(object)
        ` NOTE: This function gets called once and then must be left alone ....

        o_index = spriteLookup[object].localIndex                 ` Use Global spriteLookup Table to get UDT info
        o_designation$ = spriteLookup[object].typeDefinition
        n_index = spriteLookup[targetNode].localIndex
        n_designation$ = spriteLookup[targetNode].typeDefinition

        select o_designation$
            case    SINGLE_ENEMY_BOAT   `["enemy"]

                for i = 0 to mapNodesSize -1
                    if (myNodes[i].visited = FALSE)

                        targetNode = myNodes[i].SprID
                        myNodes[i].visited = TRUE
                        ArriveAtTarget(object, targetNode, FAST)

                    endif
                next i
            endcase
            case    ATTACK_BOAT          `["attackboat"]
                    if (attackBoats[index].arrivedAtTarget = FALSE)
                        ArriveAtTarget(object, targetNode, FAST)
                    elseif (attackBoats[index].arrivedAtTarget = TRUE)

                    endif
            endcase
        endselect

EndFunction




            print("AAT: "+ Str(enemy.arrivedAtTarget))
            print("ENLV_1: "+Str(enemy.node.lastVisited_1))
            print("ENLV_2: "+Str(enemy.node.lastVisited_2))
            print("ENLV_3: "+Str(enemy.node.lastVisited_3))
            print("ENLV_4: "+Str(enemy.node.lastVisited_4))
            print("ENLV_5: "+Str(enemy.node.lastVisited_5))





` ****** STACK Operations ********
`global dim myStack[MY_STACKMAX] as integer

Function InitializeStack(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            myStackTopIndex = ZERO
        endcase
    endselect
EndFunction


Function IsStackEmpty(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (myStackTopIndex = NULL)
                stackState = EMPTY
            else
                stackState = NOT_EMPTY
            endif
        endcase
    endselect
EndFunction stackState


Function IsStackFull(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (myStackTopIndex = MY_STACKMAX)
                stackState = FULL
            else
                stackState = NOT_FULL
            endif
        endcase
    endselect
EndFunction stackState


Function GetStackTop(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (IsStackEmpty(stack) = NOT_EMPTY)
                returnItem = myStack[myStackTopIndex]
            elseif IsStackEmpty(stack) = EMPTY
                returnItem = EMPTY
            endif
        endcase
    endselect
EndFunction returnItem


Function PushOnStack(stack as string, item)
    select stack
        case MY_STACK:            `"myStack"
            if (IsStackFull(stack) = NOT_FULL)
                inc myStackTopIndex
                myStack[myStackTopIndex] = item
                operationResult = SUCCESS
                if (myStackTopIndex = MY_STACKMAX) then myStackState = FULL
            else
                operationResult = FAILURE
            endif
        endcase
    endselect
EndFunction operationResult


Function PopOffStack(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (IsStackEmpty(stack) = NOT_EMPTY)
                myStack[myStackTopIndex] = NULL
                dec myStackTopIndex
                operationResult = SUCCESS
                if (myStackTopIndex = ZERO)
                    myStackTopIndex = NULL    ` Signal an Empty Stack
                    myStackState = EMPTY      ` Set the Stack Global Stack State
                endif
            else
                operationResult = FAILURE
            endif
        endcase
    endselect
EndFunction operationResult


Function PrintStack(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (IsStackEmpty(stack) = EMPTY)
                Print("Stack Empty")
            else
                for i = 1 to myStackTopIndex
                    print("myStack["+Str(i)+"]: "+Str(myStack[i]))
                next i
            endif
        endcase
    endselect
EndFunction







` ****** QUEUE Operations ********
`global dim myQueue[MY_QUEUEMAX] as integer

Function InitializeQueue(queue as string)
    select queue
        case MY_QUEUE:            `"myQueue"
            myQueueFrontIndex = ZERO
            myQueueRearIndex  = ZERO
        endcase
    endselect
EndFunction


Function IsQueueEmpty(queue as string)
    select queue
        case MY_QUEUE:            `"myQueue"
            if (myQueueRearIndex = NULL)
                queueState = EMPTY
            else
                queueState = NOT_EMPTY
            endif
        endcase
    endselect
EndFunction queueState


Function IsQueueFull(queue as string)
    select queue
        case MY_QUEUE:            `"myQueue"
            if (myQueueRearIndex = MY_QUEUEMAX)
                queueState = FULL
            else
                queueState = NOT_FULL
            endif
        endcase
    endselect
EndFunction queueState


Function GetQueueFront(queue as string)
    select queue
        case MY_QUEUE:            `"myQueue"
            if (IsQueueEmpty(queue) = NOT_EMPTY)
                returnItem = myQueue[myQueueFrontIndex]
            elseif (IsQueueEmpty(queue) = EMPTY)
                returnItem = EMPTY
            endif
        endcase
    endselect
EndFunction returnItem


Function PushOnQueue(queue as string, item)
    select queue
        case MY_QUEUE:            `"myQueue"
            if (IsQueueFull(queue) = NOT_FULL)
                inc myQueueRearIndex
                myQueue[myQueueRearIndex] = item
                operationResult = SUCCESS
                if (myQueueRearIndex = MY_QUEUEMAX) then myQueueState = FULL
            else
                operationResult = FAILURE
            endif
        endcase
    endselect
EndFunction operationResult


Function PopOffQueue(queue as string)
    select queue
        case MY_QUEUE:            `"myQueue"
            if (IsQueueEmpty(queue) = NOT_EMPTY)
                myQueue[myQueueFrontIndex] = NULL
                ShiftQueueContentsDown(queue)
                operationResult = SUCCESS
                dec myQueueRearIndex
                if (myQueueRearIndex = ZERO)
                    myQueueRearIndex = NULL   ` Signal and empty queue
                    myQueueState = EMPTY      ` Set the Global Queue State
                endif
            else
                operationResult = FAILURE
            endif
        endcase
    endselect
EndFunction operationResult


Function ShiftQueueContentsDown(queue as string)
    select queue
        case MY_QUEUE:            `"myQueue"
            for i = 1 to MY_QUEUEMAX -1        ` Since we're copying from the next in line, stop at 1 before last element
                myQueue[i] = myQueue[i+1]
            next i
            myQueue[MY_QUEUEMAX] = NULL
        endcase
    endselect
EndFunction


Function PrintQueue(queue as string)
    select queue
        case MY_QUEUE:            `"myQueue"
                if (IsQueueEmpty(queue) = EMPTY)
                    Print("Queue Empty")
                else
                    for i = 1 to myQueueRearIndex
                        print("myQueue["+Str(i)+"]: "+Str(myQueue[i]))
                    next i
                endif
        endcase
    endselect
EndFunction




`InitializeStack(MY_STACK)
InitializeQueue(MY_QUEUE)

`PushOnStack(MY_STACK, 1)
`PushOnStack(MY_STACK, 2)
`PushOnStack(MY_STACK, 3)
`PrintStack(MY_STACK)

PushOnQueue(MY_QUEUE, 1)
PushOnQueue(MY_QUEUE, 2)
PushOnQueue(MY_QUEUE, 3)
PushOnQueue(MY_QUEUE, 4)
PushOnQueue(MY_QUEUE, 5)
PushOnQueue(MY_QUEUE, 6)
PushOnQueue(MY_QUEUE, 7)
PushOnQueue(MY_QUEUE, 8)
PrintQueue(MY_QUEUE, )

Print("****")

`PopOffStack(MY_STACK)
`PopOffStack(MY_STACK)
`PopOffStack(MY_STACK)
`PopOffStack(MY_STACK)
`PrintStack(MY_STACK)

PopOffQueue(MY_QUEUE)
PopOffQueue(MY_QUEUE)
PopOffQueue(MY_QUEUE)
PopOffQueue(MY_QUEUE)
PopOffQueue(MY_QUEUE)
PrintQueue(MY_QUEUE)

Sync()
Sleep(7000)





InitializeStack(DSF_STACK)

PushOnStack(DSF_STACK, 1)
PushOnStack(DSF_STACK, 2)
PushOnStack(DSF_STACK, 3)
PrintStack(DSF_STACK)

Print("****")

PopOffStack(DSF_STACK)
PopOffStack(DSF_STACK)
PrintStack(DSF_STACK)


Sync()
Sleep(7000)




` ****** STACK Operations ********
`global dim myStack[MY_STACKMAX] as integer

Function InitializeStack(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            myStackTopIndex = ZERO
        endcase
        case DSF_STACK:            `"dfsStack"
            dfsStackTopIndex = ZERO
        endcase
    endselect
EndFunction


Function IsStackEmpty(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (myStackTopIndex = NULL)
                stackState = EMPTY
            else
                stackState = NOT_EMPTY
            endif
        endcase
        case DSF_STACK:            `"dfsStack"
            if (dfsStackTopIndex = NULL)
                stackState = EMPTY
            else
                stackState = NOT_EMPTY
            endif
        endcase
    endselect
EndFunction stackState


Function IsStackFull(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (myStackTopIndex = MY_STACKMAX)
                stackState = FULL
            else
                stackState = NOT_FULL
            endif
        endcase
        case DSF_STACK:            `"dfsStack"
            if (dfsStackTopIndex = DFS_STACKMAX)
                stackState = FULL
            else
                stackState = NOT_FULL
            endif
        endcase
    endselect
EndFunction stackState


Function GetStackTop(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (IsStackEmpty(stack) = NOT_EMPTY)
                returnItem = myStack[myStackTopIndex]
            elseif IsStackEmpty(stack) = EMPTY
                returnItem = EMPTY
            endif
        endcase
        case DSF_STACK:            `"dfsStack"
            if (IsStackEmpty(stack) = NOT_EMPTY)
                returnItem = dfsStack[myStackTopIndex]
            elseif IsStackEmpty(stack) = EMPTY
                returnItem = EMPTY
            endif
        endcase
    endselect
EndFunction returnItem


Function PushOnStack(stack as string, item)
    select stack
        case MY_STACK:            `"myStack"
            if (IsStackFull(stack) = NOT_FULL)
                inc myStackTopIndex
                myStack[myStackTopIndex] = item
                operationResult = SUCCESS
                if (myStackTopIndex = MY_STACKMAX) then myStackState = FULL
            else
                operationResult = FAILURE
            endif
        endcase
        case DSF_STACK:            `"dfsStack"
            if (IsStackFull(stack) = NOT_FULL)
                inc dfsStackTopIndex
                dfsStack[dfsStackTopIndex] = item
                operationResult = SUCCESS
                if (dfsStackTopIndex = DFS_STACKMAX) then dfsStackState = FULL
            else
                operationResult = FAILURE
            endif
        endcase
    endselect
EndFunction operationResult


Function PopOffStack(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (IsStackEmpty(stack) = NOT_EMPTY)
                myStack[myStackTopIndex] = NULL
                dec myStackTopIndex
                operationResult = SUCCESS
                if (myStackTopIndex = ZERO)
                    myStackTopIndex = NULL    ` Signal an Empty Stack
                    myStackState = EMPTY      ` Set the Stack Global Stack State
                endif
            else
                operationResult = FAILURE
            endif
        endcase
        case DSF_STACK:            `"dfsStack"
            if (IsStackEmpty(stack) = NOT_EMPTY)
                dfsStack[dfsStackTopIndex] = NULL
                dec dfsStackTopIndex
                operationResult = SUCCESS
                if (dfsStackTopIndex = ZERO)
                    dfsStackTopIndex = NULL    ` Signal an Empty Stack
                    dfsStackState = EMPTY      ` Set the Stack Global Stack State
                endif
            else
                operationResult = FAILURE
            endif
        endcase
    endselect
EndFunction operationResult


Function PrintStack(stack as string)
    select stack
        case MY_STACK:            `"myStack"
            if (IsStackEmpty(stack) = EMPTY)
                Print("Stack Empty")
            else
                for i = 1 to myStackTopIndex
                    print("myStack["+Str(i)+"]: "+Str(myStack[i]))
                next i
            endif
        endcase
        case DSF_STACK:            `"dfsStack"
            if (IsStackEmpty(stack) = EMPTY)
                Print("Stack Empty")
            else
                for i = 1 to dfsStackTopIndex
                    print("dfsStack["+Str(i)+"]: "+Str(dfsStack[i]))
                next i
            endif
        endcase
    endselect
EndFunction




tempEdge = DFSEdges[0]
PushOnStack_DFS(tempEdge)
tempEdge = DFSEdges[1]
PushOnStack_DFS(tempEdge)
tempEdge = DFSEdges[2]
PushOnStack_DFS(tempEdge)
tempEdge = DFSEdges[3]
PushOnStack_DFS(tempEdge)
tempEdge = DFSEdges[4]
PushOnStack_DFS(tempEdge)

PrintStack_DFS()

PopOffStack_DFS()
PopOffStack_DFS()
PopOffStack_DFS()
PopOffStack_DFS()
PopOffStack_DFS()
`PopOffStack_DFS()

PrintStack_DFS()

sync()
sleep(5000)




tempEdge = DFSEdges[0]
PushOnStack_DFS(tempEdge)
tempEdge = DFSEdges[1]
PushOnStack_DFS(tempEdge)
tempEdge = DFSEdges[2]
PushOnStack_DFS(tempEdge)
tempEdge = DFSEdges[3]
PushOnStack_DFS(tempEdge)
tempEdge = DFSEdges[4]
PushOnStack_DFS(tempEdge)

PrintStack_DFS()

PopOffStack_DFS()
PopOffStack_DFS()

PrintStack_DFS()

tempEdge = GetStackTop_DFS()
print("tempEdge["TE"]: "+Str(tempEdge.edge1)+"-"+ Str(tempEdge.edge2))

sync()
sleep(5000)


Print("Node["+Str(i)+", "+Str(j)+"] E1: "+Str(DFSAdjacencyMatrix[i,j].edge1)+"-E2: "+Str(DFSAdjacencyMatrix[i,j].edge2))




tempEdge = DFSAdjacencyMatrix[1,1]
PushOnStack_DFS(tempEdge)
tempEdge = DFSAdjacencyMatrix[1,2]
PushOnStack_DFS(tempEdge)
tempEdge = DFSAdjacencyMatrix[1,3]
PushOnStack_DFS(tempEdge)
tempEdge = DFSAdjacencyMatrix[1,4]
PushOnStack_DFS(tempEdge)
tempEdge = DFSAdjacencyMatrix[1,5]
PushOnStack_DFS(tempEdge)

PrintStack_DFS()

PopOffStack_DFS()
PopOffStack_DFS()

PrintStack_DFS()

tempEdge = GetStackTop_DFS()
print("tempEdge["TE"]: "+Str(tempEdge.parentNode)+"-"+ Str(tempEdge.destinationNode))

sync()
sleep(5000)





    enemy.width#     = GetSpriteWidth(attackBoatSpriteID)
    enemy.height#    = GetSpriteHeight(attackBoatSpriteID)
    enemy.angle#     = GetSpriteAngle(attackBoatSpriteID)
    enemy.x#         = GetSpriteX(attackBoatSpriteID)
    enemy.y#         = GetSpriteY(attackBoatSpriteID)
    enemy.absCtrX#   = enemy.x#+enemy.width#/2.0
    enemy.absCtrY#   = enemy.y#+enemy.height#/2.0


    CloneSprite(tl_BallSpriteID, ballSpriteID)
    CloneSprite(bl_BallSpriteID, ballSpriteID)
    CloneSprite(tr_BallSpriteID, ballSpriteID)
    CloneSprite(br_BallSpriteID, ballSpriteID)


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






        if angle# < -70 and angle# > -135           ` Up
                vector_x# = ZERO
                vector_y# = -force#

        elseif angle# > 70 and angle# < 130        ` Down
                vector_x# = ZERO
                vector_y# = force#

        elseif angle# > 150 and angle# > -150       ` Left
                vector_x# = -force#
                vector_y# = ZERO

        elseif angle# > -45 and angle# < 45         ` Right
                vector_x# = force#
                vector_y# = ZERO

        elseif angle# <= -45 and angle# >= -70      ` Top-Right
                vector_x# =  force#
                vector_y# = -force#

        elseif angle# <= -130 and angle# >= -180    ` Top-Left
                vector_x# = -force#
                vector_y# = -force#

        elseif angle# <= 90 and angle# >= 45        ` Bottom-Right
                vector_x# =  force#
                vector_y# =  force#

        elseif angle# <= 180 and angle# >= 90       ` Botom-Left
                vector_x# =  -force#
                vector_y# =  force#
        endif





        print("i:"+Str(i))
        print("goalName$: "+goalName$)
        print("tempGoal.goalName:"+tempGoal.goalName)
        Sync()
        Sleep(500)




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




        case G_AVOID_OBSTACLE_ENEMY_FB_SENSOR:    `["G_AVOID_OBSTACLE_ENEMY_FB_SENSOR"]
            angle# = GetSpriteAngle(enemy.sprID)
            sensorLocation$ = "frontBottom"
            SetForceVectors(enemy.sprID, sensorLocation$)   ` Depending on the angle of the enemy, this FN will determine the proper vectors and their forces
            x# = GetSpriteXByOFfset(enemy.sprID)
            y# = GetSpriteYByOFfset(enemy.sprID)
            SetSpritePhysicsImpulse(enemy.sprID, x#, y#, enemy.forceVector.x, enemy.forceVector.y)
        endcase

        case G_AVOID_OBSTACLE_ENEMY_MB_SENSOR:    `["G_AVOID_OBSTACLE_ENEMY_MB_SENSOR"]
            angle# = GetSpriteAngle(enemy.sprID)
            sensorLocation$ = "midBottom"
            SetForceVectors(enemy.sprID, sensorLocation$)
            x# = GetSpriteXByOFfset(enemy.sprID)
            y# = GetSpriteYByOFfset(enemy.sprID)
            SetSpritePhysicsImpulse(enemy.sprID, x#, y#, enemy.forceVector.x, enemy.forceVector.y)
        endcase

        case G_AVOID_OBSTACLE_ENEMY_BB_SENSOR:    `["G_AVOID_OBSTACLE_ENEMY_BB_SENSOR"]
            angle# = GetSpriteAngle(enemy.sprID)
            sensorLocation$ = "backBottom"
            SetForceVectors(enemy.sprID, sensorLocation$)
            x# = GetSpriteXByOFfset(enemy.sprID)
            y# = GetSpriteYByOFfset(enemy.sprID)
            SetSpritePhysicsImpulse(enemy.sprID, x#, y#, enemy.forceVector.x, enemy.forceVector.y)
        endcase




                select  sensorLocation$
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




**** Horizontal ******

    SetSpritePositionByOffset(obstacle[1].sprID, 1500, 1000)
    SetSpritePhysicsOn(obstacle[1].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[2].sprID, 1900, 1030)
    SetSpritePhysicsOn(obstacle[2].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[3].sprID, 2300, 990)
    SetSpritePhysicsOn(obstacle[3].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[4].sprID, 2700, 1030)
    SetSpritePhysicsOn(obstacle[4].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[5].sprID, 3100, 990)
    SetSpritePhysicsOn(obstacle[5].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[6].sprID, 3500, 1030)
    SetSpritePhysicsOn(obstacle[6].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[7].sprID, 3900, 990)
    SetSpritePhysicsOn(obstacle[7].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[8].sprID, 4300, 1030)
    SetSpritePhysicsOn(obstacle[8].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[9].sprID, 4700, 990)
    SetSpritePhysicsOn(obstacle[9].sprID, STATIC)



**** Vertical *****

    SetSpritePositionByOffset(obstacle[1].sprID, 3100, 1500)
    SetSpritePhysicsOn(obstacle[1].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[2].sprID, 3180, 1800)
    SetSpritePhysicsOn(obstacle[2].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[3].sprID, 3175, 2100)
    SetSpritePhysicsOn(obstacle[3].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[4].sprID, 3150, 2350)
    SetSpritePhysicsOn(obstacle[4].sprID, STATIC)

    SetSpritePositionByOffset(obstacle[5].sprID, 3100, 2700)
    SetSpritePhysicsOn(obstacle[5].sprID, STATIC)

    SetSpritePositionByOffset(obstacle[6].sprID, 3090, 3100)
    SetSpritePhysicsOn(obstacle[6].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[7].sprID, 3070, 3450)
    SetSpritePhysicsOn(obstacle[7].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[8].sprID, 3140, 3850)
    SetSpritePhysicsOn(obstacle[8].sprID, STATIC)
    SetSpritePositionByOffset(obstacle[9].sprID, 3300, 4250)
    SetSpritePhysicsOn(obstacle[9].sprID, STATIC)



***** BALL Cluster *****

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
    SetSpritePositionByOffset(obstacle[9].sprID, 3650, 2100)
    SetSpritePhysicsOn(obstacle[9].sprID, STATIC)





        PrintStack(GOAL_STACK)
        Print("Enemy Degrees: "+Str(GetSpriteAngle(enemy.sprID)))
        Print("FVX: "+Str(enemy.forceVector.x))
        Print("FVY: "+Str(enemy.forceVector.y))

rem *************************
rem EOF Battleship temp.agc
rem *************************







