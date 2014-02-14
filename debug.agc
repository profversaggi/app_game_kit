rem **********************
rem Battleship debug.agc
rem **********************


` **** ScreenDebug()
Function ScreenDebug()
        Print("viewOffsetX: "+Str(screen.viewOffsetX#))
        Print("viewOffsetY: "+Str(screen.viewOffsetY#))
        Print("viewOffsetIncrementX#: "+Str(screen.viewOffsetIncrementX#))
        Print("viewOffsetIncrementY#: "+Str(screen.viewOffsetIncrementY#))
        Print("Heading: "+ ship.heading$)
        `sleep(3000)
EndFunction

` **** MigrationCheckDebug()
Function MigrationCheckDebug()
    Print("VW: "+Str(GetVirtualWidth())+" VH: "+Str(GetVirtualHeight()))
    Print("SVW: "+Str(ScreenToWorldX(GetVirtualWidth()))+" SVH: "+Str(ScreenToWorldY(GetVirtualHeight())))
    Print("SVW-: "+Str(ScreenToWorldX(GetVirtualWidth()-screenWidth))+" SVH-: "+Str(ScreenToWorldY(GetVirtualHeight()-screenHeight)))
    Print("VOX: "+Str(viewOffsetX#)+" VOY: "+Str(viewOffsetY#))
    Print("SensorTR: "+Str(((ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#))+ship.absCtrX#)+" : "+Str(((ship.width#/2.0)+ship.sensorDistance#)*(Sin(angle#-ship.sensorAngle#))+ship.absCtrY#))
    Print("STR_FN X: "+Str(ShipSensorTopRightX()) +" Y: "+Str(ShipSensorTopRightY()))
    Print("SensorBR: "+Str(((ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#)+" : "+Str(((ship.width#/2.0)+ship.sensorDistance#)*(Sin(angle#+ship.sensorAngle#))+ship.absCtrY#))
    Print("SBR_FN: "+Str(ShipSensorBottomRightX()) +" Y: "+Str(ShipSensorBottomRightY()))
    Print("SensorTL: "+Str((-(ship.width#/2.0)-ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#)+" : "+Str((-(ship.width#/2.0)-ship.sensorDistance#)*(Sin(angle#+ship.sensorAngle#))+ship.absCtrY#))
    Print("SensorBL: "+Str((-(ship.width#/2.0)-ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#))+ship.absCtrX#)+" : "+Str((-(ship.width#/2.0)-ship.sensorDistance#)*(Sin(angle#-ship.sensorAngle#))+ship.absCtrY#))
    Print("Migrate-Angle: "+Str(angle#))
EndFunction

` **** ScreenMovementDebug()
Function ScreenMovementDebug()
    Print("Zoom OUT: "+Str(screen.zoom#))
    Print("Zoom IN:  "+Str(screen.zoom#))
    Print("RT: "+Str(ScreenBorderRight()))
    Print("LT: "+Str(ScreenBorderLeft()))
    Print("UP: "+Str(ScreenBorderUp()))
    Print("DN: "+Str(ScreenBorderDown()))
    Print("Heading: "+ ship.heading$)
EndFunction





` **** DeploySensorMarkers() [Old Format - Pre ShipSensors Development]
Function DeploySensorMarkers(angle#)
    SetSpritePosition(tl_BallSpriteID, (-(ship.width#/2.0)-ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#, (-(ship.width#/2.0)-ship.sensorDistance#)*(Sin(angle#+ship.sensorAngle#))+ship.absCtrY#)
    SetSpritePosition(tr_BallSpriteID, ( (ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#))+ship.absCtrX#, ( (ship.width#/2.0)+ship.sensorDistance#)*(Sin(angle#-ship.sensorAngle#))+ship.absCtrY#)
    SetSpritePosition(bl_BallSpriteID, (-(ship.width#/2.0)-ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#))+ship.absCtrX#, (-(ship.width#/2.0)-ship.sensorDistance#)*(Sin(angle#-ship.sensorAngle#))+ship.absCtrY#)
    SetSpritePosition(br_BallSpriteID, ( (ship.width#/2.0)+ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#, ( (ship.width#/2.0)+ship.sensorDistance#)*(Sin(angle#+ship.sensorAngle#))+ship.absCtrY#)
EndFunction

` **** DeployTorpedoMarkers() [Old Format - Pre ShipSensors Development]
Function DeployTorpedoMarkers(angle#)
    SetSpritePosition(tr_BallSpriteID, ( (ship.width#/5.5)+ship.sensorDistance#)*(Cos(angle#-ship.sensorAngle#))+ship.absCtrX#, ( (ship.width#/5.5)+ship.sensorDistance#)*(Sin(angle#-ship.sensorAngle#))+ship.absCtrY#)
    SetSpritePosition(br_BallSpriteID, ( (ship.width#/5.5)+ship.sensorDistance#)*(Cos(angle#+ship.sensorAngle#))+ship.absCtrX#, ( (ship.width#/5.5)+ship.sensorDistance#)*(Sin(angle#+ship.sensorAngle#))+ship.absCtrY#)
EndFunction

` **** DeployTurretMarkers()  [Old Style]
Function DeployTurretMarkers(angle#)
    SetSpritePositionByOffset(tr_BallSpriteID, ( (turretFront.width#/2.0)+turretFront.sensorDistance#)*(Cos(angle#-turretFront.sensorAngle#))+turretFront.absCtrX#-turretFront.offset, ( (turretFront.width#/2.0)+turretFront.sensorDistance#)*(Sin(angle#-turretFront.sensorAngle#))+turretFront.absCtrY#)
    SetSpritePositionByOffset(br_BallSpriteID, ( (turretFront.width#/2.0)+turretFront.sensorDistance#)*(Cos(angle#+turretFront.sensorAngle#))+turretFront.absCtrX#-turretFront.offset, ( (turretFront.width#/2.0)+turretFront.sensorDistance#)*(Sin(angle#+turretFront.sensorAngle#))+turretFront.absCtrY#)
    SetSpritePositionByOffset(bl_BallSpriteID, (30*Cos(angle#)+(turretFront.absCtrX#-turretFront.offset)),  (30*Sin(angle#)+(turretFront.absCtrY#)) )
EndFunction



` **** DeployScreenMarkers()                                        ` For Debug
Function DeployScreenMarkers()
    SetSpritePosition(tl_BallSpriteID, ScreenBorderLeft()    , ScreenBorderUp()   )
    SetSpritePosition(tr_BallSpriteID, ScreenBorderRight()-20, ScreenBorderUp()+20   )
    SetSpritePosition(bl_BallSpriteID, ScreenBorderLeft()+20 , ScreenBorderDown()-20 )
    SetSpritePosition(br_BallSpriteID, ScreenBorderRight()-20, ScreenBorderDown()-20 )
EndFunction



` **** LoadBallMarker()                                      ` For Debug
Function LoadBallMarker()
    LoadImage(ballImageID, "Ball.png")
    CreateSprite(ballSpriteID, ballImageID)
    SetSpriteSize(ballSpriteID, 5, 5)
    SetSpriteDepth(ballSpriteID,9)

    x# = GetSpriteX(ballSpriteID)
    y# = GetSpriteY(ballSpriteID)
    w# = GetSpriteWidth(ballSpriteID)/2
    h# = GetSpriteHeight(ballSpriteID)/2
    ball_abs_ctr_x# = x# + w#
    ball_abs_ctr_y# = y# + h#
    SetSpriteOffset(ballSpriteID, ball_abs_ctr_x#, ball_abs_ctr_y#)

    ballsize = 10
    SetSpriteVisible(ballSpriteID, VISIBLE)
    CloneSprite(tl_BallSpriteID, ballSpriteID)
    CloneSprite(bl_BallSpriteID, ballSpriteID)
    CloneSprite(tr_BallSpriteID, ballSpriteID)
    CloneSprite(br_BallSpriteID, ballSpriteID)
    CloneSprite(mr_BallSpriteID, ballSpriteID)
    CloneSprite(ml_BallSpriteID, ballSpriteID)

    `SetSpriteGroup(tl_BallSpriteID,-1)                  ` For Physics Debug
    `SetSpriteGroup(tr_BallSpriteID,-1)
    `SetSpritePhysicsOn(tl_BallSpriteID, DYNAMIC)
    `SetSpritePhysicsOn(tr_BallSpriteID, DYNAMIC)
EndFunction




// *********************** DEBUG STUFF ****************


Function debugTorpedoes()
    Print("TLS: "+Str(leftTorpedo[1].state))
    Print("TLS: "+Str(leftTorpedo[2].state))
    Print("TLS: "+Str(leftTorpedo[3].state))
    Print("TLS: "+Str(leftTorpedo[4].state))
    Print("TLS: "+Str(leftTorpedo[5].state))

    Print("TRS: "+Str(rightTorpedo[1].state))
    Print("TRS: "+Str(rightTorpedo[2].state))
    Print("TRS: "+Str(rightTorpedo[3].state))
    Print("TRS: "+Str(rightTorpedo[4].state))
    Print("TRS: "+Str(rightTorpedo[5].state))
EndFunction

Function debugFTProjectiles()
    Print("Nose1 X" +Str(frontTurretLProjectile[1].nose_x#))
    Print("Nose1 Y" +Str(frontTurretLProjectile[1].nose_y#))

    Print("FTLP: "+Str(frontTurretLProjectile[1].state))
    Print("FTMP: "+Str(frontTurretMProjectile[1].state))
    Print("FTRP: "+Str(frontTurretRProjectile[1].state))

    Print("FTLP: "+Str(frontTurretLProjectile[2].state))
    Print("FTMP: "+Str(frontTurretMProjectile[2].state))
    Print("FTRP: "+Str(frontTurretRProjectile[2].state))

    Print("FTLP: "+Str(frontTurretLProjectile[3].state))
    Print("FTMP: "+Str(frontTurretMProjectile[3].state))
    Print("FTRP: "+Str(frontTurretRProjectile[3].state))

    Print("FTLP: "+Str(frontTurretLProjectile[4].state))
    Print("FTMP: "+Str(frontTurretMProjectile[4].state))
    Print("FTRP: "+Str(frontTurretRProjectile[4].state))

    Print("FTLP: "+Str(frontTurretLProjectile[5].state))
    Print("FTMP: "+Str(frontTurretMProjectile[5].state))
    Print("FTRP: "+Str(frontTurretRProjectile[5].state))
EndFunction

Function debugTTProjectiles()
    Print("Nose1 X" +Str(topTurretLProjectile[1].nose_x#))
    Print("Nose1 Y" +Str(topTurretLProjectile[1].nose_y#))

    Print("TTLP: "+Str(topTurretLProjectile[1].state))
    Print("TTMP: "+Str(topTurretMProjectile[1].state))
    Print("TTRP: "+Str(topTurretRProjectile[1].state))

    Print("TTLP: "+Str(topTurretLProjectile[2].state))
    Print("TTMP: "+Str(topTurretMProjectile[2].state))
    Print("TTRP: "+Str(topTurretRProjectile[2].state))

    Print("TTLP: "+Str(topTurretLProjectile[3].state))
    Print("TTMP: "+Str(topTurretMProjectile[3].state))
    Print("TTRP: "+Str(topTurretRProjectile[3].state))

    Print("TTLP: "+Str(topTurretLProjectile[4].state))
    Print("TTMP: "+Str(topTurretMProjectile[4].state))
    Print("TTRP: "+Str(topTurretRProjectile[4].state))

    Print("TTLP: "+Str(topTurretLProjectile[5].state))
    Print("TTMP: "+Str(topTurretMProjectile[5].state))
    Print("TTRP: "+Str(topTurretRProjectile[5].state))
EndFunction


Function debugRTProjectiles()
    Print("Nose1 X" +Str(rearTurretLProjectile[1].nose_x#))
    Print("Nose1 Y" +Str(rearTurretLProjectile[1].nose_y#))

    Print("RTLP: "+Str(rearTurretLProjectile[1].state))
    Print("RTMP: "+Str(rearTurretMProjectile[1].state))
    Print("RTRP: "+Str(rearTurretRProjectile[1].state))

    Print("RTLP: "+Str(rearTurretLProjectile[2].state))
    Print("RTMP: "+Str(rearTurretMProjectile[2].state))
    Print("RTRP: "+Str(rearTurretRProjectile[2].state))

    Print("RTLP: "+Str(rearTurretLProjectile[3].state))
    Print("RTMP: "+Str(rearTurretMProjectile[3].state))
    Print("RTRP: "+Str(rearTurretRProjectile[3].state))

    Print("RTLP: "+Str(rearTurretLProjectile[4].state))
    Print("RTMP: "+Str(rearTurretMProjectile[4].state))
    Print("RTRP: "+Str(rearTurretRProjectile[4].state))

    Print("RTLP: "+Str(rearTurretLProjectile[5].state))
    Print("RTMP: "+Str(rearTurretMProjectile[5].state))
    Print("RTRP: "+Str(rearTurretRProjectile[5].state))
EndFunction


Function debugGunners()

    Print("LGLB: "+Str(gunnerLGLBBullets[1].state))
    Print("LGRB: "+Str(gunnerLGRBBullets[1].state))
    Print("LGLB: "+Str(gunnerLGLBBullets[2].state))
    Print("LGRB: "+Str(gunnerLGRBBullets[2].state))
    Print("LGLB: "+Str(gunnerLGLBBullets[3].state))
    Print("LGRB: "+Str(gunnerLGRBBullets[3].state))
    Print("LGLB: "+Str(gunnerLGLBBullets[4].state))
    Print("LGRB: "+Str(gunnerLGRBBullets[4].state))

    Print("RGLB: "+Str(gunnerRGLBBullets[1].state))
    Print("RGRB: "+Str(gunnerRGRBBullets[1].state))
    Print("RGLB: "+Str(gunnerRGLBBullets[2].state))
    Print("RGRB: "+Str(gunnerRGRBBullets[2].state))
    Print("RGLB: "+Str(gunnerRGLBBullets[3].state))
    Print("RGRB: "+Str(gunnerRGRBBullets[3].state))
    Print("RGLB: "+Str(gunnerRGLBBullets[4].state))
    Print("RGRB: "+Str(gunnerRGRBBullets[4].state))

EndFunction


Function ScreenZoomScroolDebug()
    Print("SVOX: "+Str(screen.viewOffsetX#))
    Print("SVOY: "+Str(screen.viewOffsetY#))
    Print("SZ: "+Str(screen.zoom#))
    Print("SVOX*M: "+Str(screen.viewOffsetX#*screen.magnification#))
    Print("SVOY*M: "+Str(screen.viewOffsetY#*screen.magnification#))
    Print("SBR_W: "+Str(ScreenBorderRight()))
    Print("SBR_D: "+Str(ScreenBorderDown()))
    Print("WBR: "+Str(WorldBorderRight()))
    Print("WBD: "+Str(WorldBorderDown()))
EndFunction



rem **************************
rem EOF Battleship debug.agc
rem **************************

