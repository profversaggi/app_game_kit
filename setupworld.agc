rem **************************
rem Battleship setupworld.agc
rem **************************



` **** LoadResources()
Function LoadResources()
    LoadWater()
    LoadControls()
    LoadShip()
    SetUpShipSpecs()
    LoadGuns()
    SetUpGunSpecs()
    `LoadBallMarker()
    CreateMunitions()
    LoadAnimations()
    LoadDamagedGuns()
EndFunction


` **** SetupWorldPhysics()
Function SetupWorldPhysics()
    `SetPhysicsDebugOn()
    SetPhysicsGravity(0,0)
    SetphysicsWallBottom(0)
    SetphysicsWallTop(0)
    SetphysicsWallLeft(0)
    SetphysicsWallRight(0)
EndFunction


` **** SetUpDisplay()
Function SetUpDisplay()
    SetDisplayAspect( 4.0/3.0 )
    SetVirtualResolution(screenWidth,screenHeight)
    SetDefaultMagFilter( 0 )
    SetDefaultMinFilter( 0 )
    `SetSyncRate( 60, 0 )
    SetOrientationAllowed(0,0,1,0)                      ` Force landscape mode
    screen.absCtrX#  = screenWidth/2
    screen.absCtrY#  = ScreenHeight/2
    worldAbsCtrX#    = worldWidth/2
    worldAbsCtrY#    = worldHeight/2
EndFunction


` **** LoadWater()
Function LoadWater()
    LoadImage(waterImageID,"water_001.png")             ` Load the first Water Image (PNG)
    setImageWrapU(waterImageID,1)
    setImageWrapV(waterImageID,1)
    for i=1 to 32                                       `Load rest of water animation Images (PNG's) ... all 32.
        LoadImage(100+i,"water_"+right("000"+str(i),3)+".png")
        setImageWrapU(100+i, 1)
        setImageWrapV(100+i, 1)
    next i
    CreateSprite(waterSpriteID,waterImageID)
    SetSpriteDepth(waterSpriteID, waterDepth)
    SetSpriteUVScale(waterSpriteID, 0.0125,0.0125 ) ` Changing UVScale makes *all* the difference in the world for the water texture ....
    SetSpriteTransparency(waterSpriteID,0)          ` Improves Performance by turning it off
    `SetSpriteSize(waterSpriteID, worldWidth, worldHeight ) ` Size of the animated water sprite (and thus the overall map) ...
    SetSpriteSize(waterSpriteID, 19600, 14700 ) ` Size of the animated water sprite (and thus the overall map) ...
EndFunction


` **** AnimateWater()
Function AnimateWater()                                 ` Animate the Water, cycle through all 32 images,
    water_delay# = water_delay# - 0.15                  ` (0.15 and 1.0 are delay duration constants)
    if water_delay# < 0.0
        water_delay# = water_delay# + 1.0
        SetSpriteImage(waterSpriteID, 101 + waterAnimationImage)
        waterAnimationImage = waterAnimationImage + 1
        if waterAnimationImage > 31 then waterAnimationImage = 0
    endif
EndFunction



Function LoadAnimations()

    ` Aanimated Gimp sprite sheet CannonFire ***************
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

    CloneSprite(ttCannonFireAnimSpriteID, ftCannonFireAnimSpriteID)
    x# = GetSpriteX(ttCannonFireAnimSpriteID)
    y# = GetSpriteY(ttCannonFireAnimSpriteID)
    w# = GetSpriteWidth(ttCannonFireAnimSpriteID)
    h# = GetSpriteHeight(ttCannonFireAnimSpriteID)
    SetSpriteOffset(ttCannonFireAnimSpriteID, x#+(w#/2), y#+(h#))
    SetSpriteAnimation(ttCannonFireAnimSpriteID, 41, 93, 40)

    CloneSprite(rtCannonFireAnimSpriteID, ftCannonFireAnimSpriteID)
    x# = GetSpriteX(rtCannonFireAnimSpriteID)
    y# = GetSpriteY(rtCannonFireAnimSpriteID)
    w# = GetSpriteWidth(rtCannonFireAnimSpriteID)
    h# = GetSpriteHeight(rtCannonFireAnimSpriteID)
    SetSpriteOffset(rtCannonFireAnimSpriteID, x#+(w#/2), y#+(h#))
    SetSpriteAnimation(rtCannonFireAnimSpriteID, 41, 93, 40)


    LoadImage(gunnerFireAnimImageID, "gunflashspritesheet.png")
    CreateSprite(leftGunnerFireAnimSpriteID, gunnerFireAnimImageID)
    SetSpriteSize(leftGunnerFireAnimSpriteID, 20, -1)
    SetSpriteDepth(leftGunnerFireAnimSpriteID, animationDepth)
    x# = GetSpriteX(leftGunnerFireAnimSpriteID)
    y# = GetSpriteY(leftGunnerFireAnimSpriteID)
    w# = GetSpriteWidth(leftGunnerFireAnimSpriteID)
    h# = GetSpriteHeight(leftGunnerFireAnimSpriteID)
    SetSpriteOffset(leftGunnerFireAnimSpriteID, x#+(w#/2), y#+(h#)) ` Note: Since the animated sprite sits upright
    SetSpriteAnimation(leftGunnerFireAnimSpriteID, 112, 200, 3)

    CloneSprite(rightGunnerFireAnimSpriteID, leftGunnerFireAnimSpriteID)
    x# = GetSpriteX(rightGunnerFireAnimSpriteID)
    y# = GetSpriteY(rightGunnerFireAnimSpriteID)
    w# = GetSpriteWidth(rightGunnerFireAnimSpriteID)
    h# = GetSpriteHeight(rightGunnerFireAnimSpriteID)
    SetSpriteOffset(rightGunnerFireAnimSpriteID, x#+(w#/2), y#+(h#)) ` Note: Since the animated sprite sits upright
    SetSpriteAnimation(rightGunnerFireAnimSpriteID, 112, 200, 3)


    LoadImage(torpedoFireAnimImageID, "torpedoblastspritesheet2.png")
    CreateSprite(leftTorpedoFireAnimSpriteID, torpedoFireAnimImageID)
    SetSpriteSize(leftTorpedoFireAnimSpriteID, 25, -1)
    SetSpriteDepth(leftTorpedoFireAnimSpriteID, animationDepth)
    x# = GetSpriteX(leftTorpedoFireAnimSpriteID)
    y# = GetSpriteY(leftTorpedoFireAnimSpriteID)
    w# = GetSpriteWidth(leftTorpedoFireAnimSpriteID)
    h# = GetSpriteHeight(leftTorpedoFireAnimSpriteID)
    SetSpriteOffset(leftTorpedoFireAnimSpriteID, x#+(w#/2), y#+(h#)) ` Note: Since the animated sprite sits upright
    SetSpriteAnimation(leftTorpedoFireAnimSpriteID, 61, 50, 7)


    CloneSprite(rightTorpedoFireAnimSpriteID, leftTorpedoFireAnimSpriteID)
    x# = GetSpriteX(rightTorpedoFireAnimSpriteID)
    y# = GetSpriteY(rightTorpedoFireAnimSpriteID)
    w# = GetSpriteWidth(rightTorpedoFireAnimSpriteID)
    h# = GetSpriteHeight(rightTorpedoFireAnimSpriteID)
    SetSpriteOffset(rightTorpedoFireAnimSpriteID, x#+(w#/2), y#+(h#)) ` Note: Since the animated sprite sits upright
    SetSpriteAnimation(rightTorpedoFireAnimSpriteID, 61, 50, 7)


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

    CloneSprite(tTurretExplodeAnimSpriteID, fTurretExplodeAnimSpriteID)
    x# = GetSpriteX(tTurretExplodeAnimSpriteID)
    y# = GetSpriteY(tTurretExplodeAnimSpriteID)
    w# = GetSpriteWidth(tTurretExplodeAnimSpriteID)
    h# = GetSpriteHeight(tTurretExplodeAnimSpriteID)
    SetSpriteOffset(tTurretExplodeAnimSpriteID, x#+(w#/2), y#+(h#/2))
    SetSpriteAnimation(tTurretExplodeAnimSpriteID, 68, 68, 135)
    SetSpriteVisible(tTurretExplodeAnimSpriteID, VISIBLE)

    SetSpriteGroup(tTurretExplodeAnimSpriteID, -1)
    SetSpritePhysicsOn(tTurretExplodeAnimSpriteID, DYNAMIC)


    CloneSprite(rTurretExplodeAnimSpriteID, fTurretExplodeAnimSpriteID)
    x# = GetSpriteX(rTurretExplodeAnimSpriteID)
    y# = GetSpriteY(rTurretExplodeAnimSpriteID)
    w# = GetSpriteWidth(rTurretExplodeAnimSpriteID)
    h# = GetSpriteHeight(rTurretExplodeAnimSpriteID)
    SetSpriteOffset(rTurretExplodeAnimSpriteID, x#+(w#/2), y#+(h#/2))
    SetSpriteAnimation(rTurretExplodeAnimSpriteID, 68, 68, 135)
    SetSpriteVisible(rTurretExplodeAnimSpriteID, INVISIBLE)


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
    `SetSpriteVisible(lGunnerExplosionAminSpriteID, INVISIBLE)

    CloneSprite(rGunnerExplosionAminSpriteID, lGunnerExplosionAminSpriteID)
    x# = GetSpriteX(rGunnerExplosionAminSpriteID)
    y# = GetSpriteY(rGunnerExplosionAminSpriteID)
    w# = GetSpriteWidth(rGunnerExplosionAminSpriteID)
    h# = GetSpriteHeight(rGunnerExplosionAminSpriteID)
    SetSpriteOffset(rGunnerExplosionAminSpriteID, x#+(w#/2), y#+(h#/2))
    SetSpriteAnimation(rGunnerExplosionAminSpriteID, 146, 145, 42)
    SetSpriteVisible(rGunnerExplosionAminSpriteID, INVISIBLE)


    ` **** Ship Explosion Animation (Non-Sprite Sheet Vintage)
    LoadImage(shipBlowUpAnimImageID,"ship_001.png")
    CreateSprite(shipBlowUpAnimSpriteID, shipBlowUpAnimImageID)
    SetSpriteDepth(shipBlowUpAnimSpriteID, animationDepth)
    SetSpriteSize(shipBlowUpAnimSpriteID, 650, 650)             ` *** This WILL alter the overall size of the animation
    SetSpriteAnimation(shipBlowUpAnimSpriteID, 256, 256, 68)    `     regardless of the SetSpriteAnimation dimmensions
                                                                `     Keeping the original image small but inflating it saves resources.
    for i = 1 to 68
        LoadImage(2000+i,"ship_"+right("000"+str(i),3)+".png")
        CreateSprite(2000+i, 2000+i)
        SetSpriteDepth(2000+i, animationDepth)
        AddSpriteAnimationFrame(shipBlowUpAnimSpriteID, 2000+i)
        DeleteSprite(2000+i)                                   ` *** Free Up Resources
    next i
    x# = GetSpriteX(shipBlowUpAnimSpriteID)
    y# = GetSpriteY(shipBlowUpAnimSpriteID)
    w# = GetSpriteWidth(shipBlowUpAnimSpriteID)
    h# = GetSpriteHeight(shipBlowUpAnimSpriteID)
    SetSpriteOffset(shipBlowUpAnimSpriteID, x#+(w#/2), y#+(h#/2))   ` Note: We need to offset to the absolute center of this animation.
    AddSpriteAnimationFrame(shipBlowUpAnimSpriteID, 2068)           ` *** Add in the last (clear) frame of the animation
    SetSpriteVisible(shipBlowUpAnimSpriteID, INVISIBLE)


    ` **** Turret Smoke and Fire Animations (Non-Sprite Sheet Vintage) ****

    LoadImage(turretSmokeFireAnimImageID, "firesmoke_001.png")
    CreateSprite(ftFireSmokeAnimSpriteID, turretSmokeFireAnimImageID)
    SetSpriteDepth(ftFireSmokeAnimSpriteID, animationDepth)
    SetSpriteSize(ftFireSmokeAnimSpriteID, 60, -1)
    SetSpriteAnimation(ftFireSmokeAnimSpriteID, 256, 211, 26)
    for i = 1 to 26
        LoadImage(2100+i,"firesmoke_"+right("000"+str(i),3)+".png")
        CreateSprite(2100+i, 2100+i)
        SetSpriteDepth(2100+i, animationDepth)
        AddSpriteAnimationFrame(ftFireSmokeAnimSpriteID, 2100+i)
    next i
    x# = GetSpriteX(ftFireSmokeAnimSpriteID)
    y# = GetSpriteY(ftFireSmokeAnimSpriteID)
    w# = GetSpriteWidth(ftFireSmokeAnimSpriteID)
    h# = GetSpriteHeight(ftFireSmokeAnimSpriteID)
    SetSpriteOffset(ftFireSmokeAnimSpriteID, x#+(w#/2), y#+(h#/2))   ` Note: We need to offset to the absolute center of this animation.
    SetSpriteVisible(ftFireSmokeAnimSpriteID, INVISIBLE)


    CreateSprite(ttFireSmokeAnimSpriteID, turretSmokeFireAnimImageID)
    SetSpriteDepth(ttFireSmokeAnimSpriteID, animationDepth)
    SetSpriteSize(ttFireSmokeAnimSpriteID, 60, -1)
    SetSpriteAnimation(ttFireSmokeAnimSpriteID, 256, 211, 26)
    for i = 1 to 26
        AddSpriteAnimationFrame(ttFireSmokeAnimSpriteID, 2100+i)
    next i
    x# = GetSpriteX(ttFireSmokeAnimSpriteID)
    y# = GetSpriteY(ttFireSmokeAnimSpriteID)
    w# = GetSpriteWidth(ttFireSmokeAnimSpriteID)
    h# = GetSpriteHeight(ttFireSmokeAnimSpriteID)
    SetSpriteOffset(ttFireSmokeAnimSpriteID, x#+(w#/2), y#+(h#/2))   ` Note: We need to offset to the absolute center of this animation.
    SetSpriteVisible(ttFireSmokeAnimSpriteID, INVISIBLE)



    CreateSprite(rtFireSmokeAnimSpriteID, turretSmokeFireAnimImageID)
    SetSpriteDepth(rtFireSmokeAnimSpriteID, animationDepth)
    SetSpriteSize(rtFireSmokeAnimSpriteID, 60, -1)
    SetSpriteAnimation(rtFireSmokeAnimSpriteID, 256, 211, 26)
    for i = 1 to 26
        AddSpriteAnimationFrame(rtFireSmokeAnimSpriteID, 2100+i)
    next i
    x# = GetSpriteX(rtFireSmokeAnimSpriteID)
    y# = GetSpriteY(rtFireSmokeAnimSpriteID)
    w# = GetSpriteWidth(rtFireSmokeAnimSpriteID)
    h# = GetSpriteHeight(rtFireSmokeAnimSpriteID)
    SetSpriteOffset(rtFireSmokeAnimSpriteID, x#+(w#/2), y#+(h#/2))   ` Note: We need to offset to the absolute center of this animation.
    SetSpriteVisible(rtFireSmokeAnimSpriteID, INVISIBLE)

    for i = 1 to 26                                                  ` *** Free Resources
        DeleteSprite(2100+i)
    next i

EndFunction



` **** LoadControls()
Function LoadControls()
    ` Left Rudder Button
    LoadImage(leftButtonImageID,"Left.png")
    CreateSprite(leftButtonSpriteID, leftButtonImageID)
    SetSpriteSize(leftButtonSpriteID, 40, -1)
    SetSpritePosition(leftButtonSpriteID, 10, 085)
    SetSpriteDepth(leftButtonSpriteID, buttonDepth)
    FixSpriteToScreen(leftButtonSpriteID, 1)

    ` Right Ruddern Button
    LoadImage(rightButtonImageID,"Right.png")
    CreateSprite(rightButtonSpriteID, rightButtonImageID)
    SetSpriteSize(rightButtonSpriteID, 40, -1)
    SetSpritePosition(rightButtonSpriteID, 55, 085)
    SetSpriteDepth(rightButtonSpriteID, buttonDepth)
    FixSpriteToScreen(rightButtonSpriteID, 1)

    ` Propulsion Button
    LoadImage(propulsionButtonImageID,"Propulsion.png")
    CreateSprite(propulsionButtonSpriteID, propulsionButtonImageID)
    SetSpriteSize(propulsionButtonSpriteID, 40, -1)
    SetSpritePosition(propulsionButtonSpriteID, 10, 120)
    SetSpriteDepth(propulsionButtonSpriteID, buttonDepth)
    FixSpriteToScreen(propulsionButtonSpriteID, 1)

    ` Reverse Button
    LoadImage(reverseButtonImageID,"Reverse.png")
    CreateSprite(reverseButtonSpriteID, reverseButtonImageID)
    SetSpriteSize(reverseButtonSpriteID, 40, -1)
    SetSpritePosition(reverseButtonSpriteID, 55, 120)
    SetSpriteDepth(reverseButtonSpriteID, buttonDepth)
    FixSpriteToScreen(reverseButtonSpriteID, 1)

    ` ThrottleUp Button
    LoadImage(throttleUpImageID,"ThrottleUp.png")
    CreateSprite(throttleUpSpriteID, throttleUpImageID)
    SetSpriteSize(throttleUpSpriteID, 40, -1)
    SetSpritePosition(throttleUpSpriteID, 10, 155)
    SetSpriteDepth(throttleUpSpriteID, buttonDepth)
    FixSpriteToScreen(throttleUpSpriteID, 1)

    ` ThrottleDown Button
    LoadImage(throttleDownImageID,"ThrottleDown.png")
    CreateSprite(throttleDownSpriteID, throttleDownImageID)
    SetSpriteSize(throttleDownSpriteID, 40, -1)
    SetSpritePosition(throttleDownSpriteID, 55, 155)
    SetSpriteDepth(throttleDownSpriteID, buttonDepth)
    FixSpriteToScreen(throttleDownSpriteID, 1)

    ` Zoom (IN) Button
    LoadImage(inImageID, "In.png")
    CreateSprite(inSpriteID, inImageID)
    SetSpriteSize(inSpriteID, 40, -1)
    SetSpritePosition(inSpriteID, 10, 190)
    SetSpriteDepth(inSpriteID, buttonDepth)
    FixSpriteToScreen(inSpriteID, 1)

    ` Zoom (OUT) Button
    LoadImage(outImageID, "Out.png")
    CreateSprite(outSpriteID, outImageID)
    SetSpriteSize(outSpriteID, 40, -1)
    SetSpritePosition(outSpriteID, 55, 190)
    SetSpriteDepth(outSpriteID, buttonDepth)
    FixSpriteToScreen(outSpriteID, 1)


    ` Scroll (Left)  Button
    CloneSprite(screenScrollLButtonID, leftButtonSpriteID)
    SetSpriteSize(screenScrollLButtonID, 40, -1)
    SetSpritePosition(screenScrollLButtonID, 10, 465)
    SetSpriteDepth(screenScrollLButtonID, buttonDepth)
    FixSpriteToScreen(screenScrollLButtonID, 1)

    ` Scroll (Right) Button
    CloneSprite(screenScrollRButtonID, rightButtonSpriteID)
    SetSpriteSize(screenScrollRButtonID, 40, -1)
    SetSpritePosition(screenScrollRButtonID, 80, 465)
    SetSpriteDepth(screenScrollRButtonID, buttonDepth)
    FixSpriteToScreen(screenScrollRButtonID, 1)

    ` Scroll (Up)    Button
    CloneSprite(screenScrollUButtonID, leftButtonSpriteID)
    SetSpriteSize(screenScrollUButtonID, 40, -1)
    SetSpritePosition(screenScrollUButtonID, 45, 445)
    SetSpriteDepth(screenScrollUButtonID, buttonDepth)
    SetSpriteAngle(screenScrollUButtonID, 90)
    FixSpriteToScreen(screenScrollUButtonID, 1)

    ` Scroll (Down)  Button
    CloneSprite(screenScrollDButtonID, rightButtonSpriteID)
    SetSpriteSize(screenScrollDButtonID, 40, -1)
    SetSpritePosition(screenScrollDButtonID, 45, 495)
    SetSpriteDepth(screenScrollDButtonID, buttonDepth)
    SetSpriteAngle(screenScrollDButtonID, 90)
    FixSpriteToScreen(screenScrollDButtonID, 1)


    ` Turret-Front: Left Button
    CloneSprite(turretFrontLButtonSPriteID, leftButtonSpriteID)
    SetSpritePosition(turretFrontLButtonSPriteID, 10, 225)
    SetSpriteDepth(turretFrontLButtonSPriteID, buttonDepth)
    FixSpriteToScreen(turretFrontLButtonSPriteID, 1)

    ` Turret-Front: Right Button
    CloneSprite(turretFrontRButtonSPriteID, rightButtonSpriteID)
    SetSpritePosition(turretFrontRButtonSPriteID, 55, 225)
    SetSpriteDepth(turretFrontRButtonSPriteID, buttonDepth)
    FixSpriteToScreen(turretFrontRButtonSPriteID, 1)

    ` Turret-Rear: Left Button
    CloneSprite(turretRearLButtonSPriteID, leftButtonSpriteID)
    SetSpritePosition(turretRearLButtonSPriteID, 10, 285)
    SetSpriteDepth(turretRearLButtonSPriteID, buttonDepth)
    FixSpriteToScreen(turretRearLButtonSPriteID, 1)

    ` Turret-Rear: Right Button
    CloneSprite(turretRearRButtonSPriteID, rightButtonSpriteID)
    SetSpritePosition(turretRearRButtonSPriteID, 55, 285)
    SetSpriteDepth(turretRearRButtonSPriteID, buttonDepth)
    FixSpriteToScreen(turretRearRButtonSPriteID, 1)

    ` Turret-Top: Left Button
    CloneSprite(turretTopLButtonSPriteID, leftButtonSpriteID)
    SetSpritePosition(turretTopLButtonSPriteID, 10, 255)
    SetSpriteDepth(turretTopLButtonSPriteID, buttonDepth)
    FixSpriteToScreen(turretTopLButtonSPriteID, 1)

    ` Turret-Top: Right Button
    CloneSprite(turretTopRButtonSPriteID, rightButtonSpriteID)
    SetSpritePosition(turretTopRButtonSPriteID, 55, 255)
    SetSpriteDepth(turretTopRButtonSPriteID, buttonDepth)
    FixSpriteToScreen(turretTopRButtonSPriteID, 1)

    ` Left Gunner: Left Button
    CloneSprite(leftGunnerLButtonSPriteID, leftButtonSpriteID)
    SetSpritePosition(leftGunnerLButtonSPriteID, 10, 315)
    SetSpriteDepth(leftGunnerLButtonSPriteID, buttonDepth)
    FixSpriteToScreen(leftGunnerLButtonSPriteID, 1)

    ` Left Gunner: Right Button
    CloneSprite(leftGunnerRButtonSPriteID, rightButtonSpriteID)
    SetSpritePosition(leftGunnerRButtonSPriteID, 55, 315)
    SetSpriteDepth(leftGunnerRButtonSPriteID, buttonDepth)
    FixSpriteToScreen(leftGunnerRButtonSPriteID, 1)

    ` Right Gunner: Left Button
    CloneSprite(rightGunnerLButtonSPriteID, leftButtonSpriteID)
    SetSpritePosition(rightGunnerLButtonSPriteID, 10, 345)
    SetSpriteDepth(rightGunnerLButtonSPriteID, buttonDepth)
    FixSpriteToScreen(rightGunnerLButtonSPriteID, 1)

    ` Right Gunner: Right Button
    CloneSprite(rightGunnerRButtonSPriteID, rightButtonSpriteID)
    SetSpritePosition(rightGunnerRButtonSPriteID, 55, 345)
    SetSpriteDepth(rightGunnerRButtonSPriteID, buttonDepth)
    FixSpriteToScreen(rightGunnerRButtonSPriteID, 1)


    ` Fire Buttons
    CloneSprite(fireTurretFrontButtonID, propulsionButtonSpriteID)
    SetSpritePosition(fireTurretFrontButtonID, 100, 225)
    SetSpriteDepth(fireTurretFrontButtonID, buttonDepth)
    FixSpriteToScreen(fireTurretFrontButtonID, 1)

    CloneSprite(fireTurretRearButtonID, propulsionButtonSpriteID)
    SetSpritePosition(fireTurretRearButtonID, 100, 285)
    SetSpriteDepth(fireTurretRearButtonID, buttonDepth)
    FixSpriteToScreen(fireTurretRearButtonID, 1)

    CloneSprite(fireTurretTopButtonID, propulsionButtonSpriteID)
    SetSpritePosition(fireTurretTopButtonID, 100, 255)
    SetSpriteDepth(fireTurretTopButtonID, buttonDepth)
    FixSpriteToScreen(fireTurretTopButtonID, 1)

    CloneSprite(fireLeftGunnerButtonID, propulsionButtonSpriteID)
    SetSpritePosition(fireLeftGunnerButtonID, 100, 315)
    SetSpriteDepth(fireLeftGunnerButtonID, buttonDepth)
    FixSpriteToScreen(fireLeftGunnerButtonID, 1)

    CloneSprite(fireRightGunnerButtonID, propulsionButtonSpriteID)
    SetSpritePosition(fireRightGunnerButtonID, 100, 345)
    SetSpriteDepth(fireRightGunnerButtonID, buttonDepth)
    FixSpriteToScreen(fireRightGunnerButtonID, 1)

    CloneSprite(fireLeftTorpedoButtonID, propulsionButtonSpriteID)
    SetSpritePosition(fireLeftTorpedoButtonID, 10, 375)
    SetSpriteDepth(fireLeftTorpedoButtonID, buttonDepth)
    FixSpriteToScreen(fireLeftTorpedoButtonID, 1)

    CloneSprite(fireRightTorpedoButtonID, propulsionButtonSpriteID)
    SetSpritePosition(fireRightTorpedoButtonID, 55, 375)
    SetSpriteDepth(fireRightTorpedoButtonID, buttonDepth)
    FixSpriteToScreen(fireRightTorpedoButtonID, 1)

    CloneSprite(deployMineButtonID, propulsionButtonSpriteID)
    SetSpritePosition(deployMineButtonID, 100, 375)
    SetSpriteDepth(deployMineButtonID, buttonDepth)
    FixSpriteToScreen(deployMineButtonID, 1)


    ` Reload / Launch Light
    LoadImage(launchLightImageID, "golight.png")
    CreateSprite(ftLaunchLightSpriteID, launchLightImageID)
    SetSpriteSize(ftLaunchLightSpriteID, 20, -1)
    SetSpritePosition(ftLaunchLightSpriteID, 145, 228)
    SetSpriteDepth(ftLaunchLightSpriteID, lightDepth)
    FixSpriteToScreen(ftLaunchLightSpriteID, 1)
    SetSpriteVisible(ftLaunchLightSpriteID, VISIBLE)

    LoadImage(reloadLightImageID, "stoplight.png")
    CreateSprite(ftReloadLightSpriteID, reloadLightImageID)
    SetSpriteSize(ftReloadLightSpriteID, 20, -1)
    SetSpritePosition(ftReloadLightSpriteID, 145, 228)
    SetSpriteDepth(ftReloadLightSpriteID, lightDepth)
    FixSpriteToScreen(ftReloadLightSpriteID, 1)
    SetSpriteVisible(ftReloadLightSpriteID, INVISIBLE)

    CloneSprite(ttLaunchLightSpriteID, ftLaunchLightSpriteID)
    SetSpritePosition(ttLaunchLightSpriteID, 145, 258)
    SetSpriteDepth(ttLaunchLightSpriteID, lightDepth)
    FixSpriteToScreen(ttLaunchLightSpriteID, 1)
    SetSpriteVisible(ttLaunchLightSpriteID, VISIBLE)

    CloneSprite(ttReloadLightSpriteID, ftReloadLightSpriteID)
    SetSpritePosition(ttReloadLightSpriteID, 145, 258)
    SetSpriteDepth(ttReloadLightSpriteID, lightDepth)
    FixSpriteToScreen(ttReloadLightSpriteID, 1)
    SetSpriteVisible(ttReloadLightSpriteID, INVISIBLE)

    CloneSprite(rtLaunchLightSpriteID, ftLaunchLightSpriteID)
    SetSpritePosition(rtLaunchLightSpriteID, 145, 288)
    SetSpriteDepth(rtLaunchLightSpriteID, lightDepth)
    FixSpriteToScreen(rtLaunchLightSpriteID, 1)
    SetSpriteVisible(rtLaunchLightSpriteID, VISIBLE)

    CloneSprite(rtReloadLightSpriteID, ftReloadLightSpriteID)
    SetSpritePosition(rtReloadLightSpriteID, 145, 288)
    SetSpriteDepth(rtReloadLightSpriteID, lightDepth)
    FixSpriteToScreen(rtReloadLightSpriteID, 1)
    SetSpriteVisible(rtReloadLightSpriteID, INVISIBLE)

    CloneSprite(ltpdoLaunchLightSpriteID, ftLaunchLightSpriteID)
    SetSpritePosition(ltpdoLaunchLightSpriteID, 21, 405)
    SetSpriteDepth(ltpdoLaunchLightSpriteID, lightDepth)
    FixSpriteToScreen(ltpdoLaunchLightSpriteID, 1)
    SetSpriteVisible(ltpdoLaunchLightSpriteID, VISIBLE)

    CloneSprite(ltpdoReloadLightSpriteID, ftReloadLightSpriteID)
    SetSpritePosition(ltpdoReloadLightSpriteID, 21, 405)
    SetSpriteDepth(ltpdoReloadLightSpriteID, lightDepth)
    FixSpriteToScreen(ltpdoReloadLightSpriteID, 1)
    SetSpriteVisible(ltpdoReloadLightSpriteID, INVISIBLE)

    CloneSprite(rtpdoLaunchLightSpriteID, ftLaunchLightSpriteID)
    SetSpritePosition(rtpdoLaunchLightSpriteID, 67, 405)
    SetSpriteDepth(rtpdoLaunchLightSpriteID, lightDepth)
    FixSpriteToScreen(rtpdoLaunchLightSpriteID, 1)
    SetSpriteVisible(rtpdoLaunchLightSpriteID, VISIBLE)

    CloneSprite(rtpdoReloadLightSpriteID, ftReloadLightSpriteID)
    SetSpritePosition(rtpdoReloadLightSpriteID, 67, 405)
    SetSpriteDepth(rtpdoReloadLightSpriteID, lightDepth)
    FixSpriteToScreen(rtpdoReloadLightSpriteID, 1)
    SetSpriteVisible(rtpdoReloadLightSpriteID, INVISIBLE)

    CloneSprite(mineLaunchLightSpriteID, ftLaunchLightSpriteID)
    SetSpritePosition(mineLaunchLightSpriteID, 112, 405)
    SetSpriteDepth(mineLaunchLightSpriteID, lightDepth)
    FixSpriteToScreen(mineLaunchLightSpriteID, 1)
    SetSpriteVisible(mineLaunchLightSpriteID, VISIBLE)

    CloneSprite(mineReloadLightSpriteID, ftReloadLightSpriteID)
    SetSpritePosition(mineReloadLightSpriteID, 112, 405)
    SetSpriteDepth(mineReloadLightSpriteID, lightDepth)
    FixSpriteToScreen(mineReloadLightSpriteID, 1)
    SetSpriteVisible(mineReloadLightSpriteID, INVISIBLE)
EndFunction


` **** LoadShip()
Function LoadShip()
    LoadImage(ship.imgID, ship.imgFile$)
    CreateSprite(ship.sprID, ship.imgID)
    SetSpriteSize(ship.sprID, 480, 50)
    SetSpritePosition(ship.sprID, 500, 600) ` Top-LHS default placement
    SetSpriteDepth(ship.sprID, shipDepth)
    SetSpriteGroup(ship.sprID, GOOD_GUYS_GROUP)               ` Required so munitions don't get affected by ship Physics
    SetSpriteShape(ship.sprID, POLYGON)                             ` Set for Ray Casting Purposes.
    SetSpritePhysicsOn(ship.sprID, DYNAMIC)
    SetSpritePhysicsDamping(ship.sprID, .05)

    spriteLookup[ship.sprID].sprID = ship.sprID
    spriteLookup[ship.sprID].typeDefinition = BATTLESHIP

    ChangeShipState(SHIP_STATE_DEPLOYED)

    CreateParticles(shipEngineWakeParticleID, 0, 0)
    SetParticlesSize(shipEngineWakeParticleID, ship.stern_wake_size)
    SetParticlesFrequency(shipEngineWakeParticleID, ship.stern_wake_freq)
    SetParticlesLife(shipEngineWakeParticleID, ship.stern_wake_life#)
    SetParticlesDepth(shipEngineWakeParticleID, particlesDepth)
    SetParticlesVisible(shipEngineWakeParticleID, INVISIBLE)
EndFunction

` **** SetUpShipSpecs()
Function SetUpShipSpecs()                              ` Fetch and store:
    ship.x# = GetSpriteX(ship.sprID)                   ` Top
    ship.y# = GetSpriteY(ship.sprID)                   ` Left
    ship.width# = GetSpriteWidth(ship.sprID)           ` Width Offset
    ship.height# = GetSpriteHeight(ship.sprID)         ` Height Offset
    ship.absCtrX# = ship.x#+ship.width#/2.0            ` Absolute Center X
    ship.absCtrY# = ship.y#+ship.height#/2.0           ` Absolute Center Y
    ship.angle# = GetSpriteAngle(ship.sprID)           ` Ship Angle
EndFunction


` **** LoadGuns()
Function LoadGuns()
    LoadImage(turretTop.imgID, turretTop.imgFile$)                      ` Turret Creation ...
    CreateSprite(turretTop.sprID, turretTop.imgID)
    SetSpriteSize(turretTop.sprID, 60, 31)
    SetSpriteDepth(turretTop.sprID, turretDepth)
    SetSpriteOffset(turretTop.sprID, (GetSpriteWidth(turretTop.sprID)/2)-turretTop.offset, GetSpriteHeight(turretTop.sprID)/2)

    SetSpriteShape(turretTop.sprID, POLYGON)
    SetSpriteGroup(turretTop.sprID, GOOD_GUYS_GROUP)
    SetSpritePhysicsOn(turretTop.sprID, DYNAMIC)

    spriteLookup[turretTop.sprID].sprID = turretTop.sprID
    spriteLookup[turretTop.sprID].typeDefinition = TURRET_TOP

    CloneSprite(turretFront.sprID,turretTop.sprID)                      ` Clone Front / Back from Top Turret
    SetSpriteShape(turretFront.sprID, POLYGON)
    SetSpriteGroup(turretFront.sprID, GOOD_GUYS_GROUP)
    SetSpritePhysicsOn(turretFront.sprID, DYNAMIC)

    spriteLookup[turretFront.sprID].sprID = turretFront.sprID
    spriteLookup[turretFront.sprID].typeDefinition = TURRET_FRONT

    CloneSprite(turretRear.sprID,turretTop.sprID)

    SetSpriteShape(turretRear.sprID, POLYGON)
    SetSpriteGroup(turretRear.sprID, GOOD_GUYS_GROUP)
    SetSpritePhysicsOn(turretRear.sprID, DYNAMIC)

    spriteLookup[turretRear.sprID].sprID = turretRear.sprID
    spriteLookup[turretRear.sprID].typeDefinition = TURRET_REAR

    SetSpriteDepth(turretTop.sprID, turretDepth-1)                      ` Set Top turret over Front turret.

    ChangeFrontTurretState(TURRETFRONT_STATE_DEPLOYED)                  ` Set States of FSM's
    ChangeRearTurretState(TURRETREAR_STATE_DEPLOYED)
    ChangeTopTurretState(TURRETTOP_STATE_DEPLOYED)

    SetTurretOnShip(turretFront.sprID, turretFront.offsetFromShipCtr)   ` Set initial Turret Guns Positions on Ship
    SetTurretOnShip(turretRear.sprID, turretRear.offsetFromShipCtr)
    SetTurretOnShip(turretTop.sprID, turretTop.offsetFromShipCtr)

    LoadImage(leftGunner.imgID, leftGunner.imgFile$)                    ` Gunner Creation .....
    CreateSprite(leftGunner.sprID, leftGunner.imgID)
    SetSpriteSize(leftGunner.sprID, 30, 15)
    SetSpriteDepth(leftGunner.sprID, gonnerDepth)
    SetSpriteOffset(leftGunner.sprID, (GetSpriteWidth(leftGunner.sprID)/2)-leftGunner.offset, GetSpriteHeight(leftGunner.sprID)/2)

    SetSpriteShape(leftGunner.sprID, POLYGON)
    SetSpriteGroup(leftGunner.sprID, GOOD_GUYS_GROUP)
    SetSpritePhysicsOn(leftGunner.sprID, DYNAMIC)

    spriteLookup[leftGunner.sprID].sprID = leftGunner.sprID
    spriteLookup[leftGunner.sprID].typeDefinition = GUNNER_LEFT

    CloneSprite(rightGunner.sprID, leftGunner.sprID)                     ` Clone Right Gunner from the Left

    SetSpriteShape(rightGunner.sprID, POLYGON)
    SetSpriteGroup(rightGunner.sprID, GOOD_GUYS_GROUP)
    SetSpritePhysicsOn(rightGunner.sprID, DYNAMIC)

    spriteLookup[rightGunner.sprID].sprID = rightGunner.sprID
    spriteLookup[rightGunner.sprID].typeDefinition = GUNNER_RIGHT

    ChangeLeftGunnerState(LEFTGUNNER_STATE_DEPLOYED)
    ChangeRightGunnerState(RIGHTGUNNER_STATE_DEPLOYED)

    SetGunnerOnShip(leftGunner.sprID, "port")                           ` Position Gunners on the ship - Port is left and starboard is right
    SetGunnerOnShip(rightGunner.sprID, "starboard")
EndFunction


Function LoadDamagedGuns()
    LoadImage(turretFront.d_imgID, turretFront.d_imgFile$)                      ` Turret Creation ...
    CreateSprite(turretFront.d_sprID, turretFront.d_imgID)
    SetSpriteSize(turretFront.d_sprID, 60, 37)
    SetSpriteDepth(turretFront.d_sprID, turretDepth)
    SetSpriteOffset(turretFront.d_sprID, (GetSpriteWidth(turretFront.d_sprID)/2)-turretFront.offset, GetSpriteHeight(turretFront.d_sprID)/2)
    SetSpriteVisible(turretFront.d_sprID, INVISIBLE)

    CloneSprite(turretTop.d_sprID, turretFront.d_sprID)
    SetSpriteOffset(turretTop.d_sprID, (GetSpriteWidth(turretTop.d_sprID)/2)-turretTop.offset, GetSpriteHeight(turretTop.d_sprID)/2)
    SetSpriteVisible(turretTop.d_sprID, INVISIBLE)

    CloneSprite(turretRear.d_sprID, turretFront.d_sprID)
    SetSpriteOffset(turretRear.d_sprID, (GetSpriteWidth(turretRear.d_sprID)/2)-turretRear.offset, GetSpriteHeight(turretRear.d_sprID)/2)
    SetSpriteVisible(turretRear.d_sprID, INVISIBLE)


    LoadImage(damagedGunnerImageID, "damaged-gunner.png")
    CreateSprite(lDamagedGunnerSpriteID, damagedGunnerImageID)

    SetSpriteSize(lDamagedGunnerSpriteID, 30, 20)
    SetSpriteDepth(lDamagedGunnerSpriteID, gonnerDepth)
    SetSpriteOffset(lDamagedGunnerSpriteID, (GetSpriteWidth(lDamagedGunnerSpriteID)/2)-leftGunner.offset, GetSpriteHeight(lDamagedGunnerSpriteID)/2)
    SetSpriteVisible(lDamagedGunnerSpriteID, INVISIBLE)

    CloneSprite(rDamagedGunnerSpriteID, lDamagedGunnerSpriteID)
    SetSpriteVisible(rDamagedGunnerSpriteID, INVISIBLE)

EndFunction



` **** SetUpGunSpecs()
Function SetUpGunSpecs()
    turretFront.angle# = GetSpriteAngle(ship.sprID)         ` Store Initial Turret Angles from the Ships Angle.
    turretRear.angle#  = GetSpriteAngle(ship.sprID) -180
    turretTop.angle#   = GetSpriteAngle(ship.sprID)
    SetSpriteAngle(turretFront.sprID, ship.angle#)           ` Set Initial Angles of the (3) Guns to the Ships Angle
    SetSpriteAngle(turretRear.sprID, ship.angle#-180)        ` Reverse the Rear Gun Turret
    SetSpriteAngle(turretTop.sprID, ship.angle#)

    turretFront.x# = GetSpriteX(turretFront.sprID)                   ` Front Turret
    turretFront.y# = GetSpriteY(turretFront.sprID)
    turretFront.width# = GetSpriteWidth(turretFront.sprID)
    turretFront.height# = GetSpriteHeight(turretFront.sprID)
    turretFront.absCtrX# = turretFront.x#+turretFront.width#/2.0
    turretFront.absCtrY# = turretFront.y#+turretFront.height#/2.0

    turretTop.x# = GetSpriteX(turretTop.sprID)                       ` Top Turret
    turretTop.y# = GetSpriteY(turretTop.sprID)
    turretTop.width# = GetSpriteWidth(turretTop.sprID)
    turretTop.height# = GetSpriteHeight(turretTop.sprID)
    turretTop.absCtrX# = turretTop.x#+turretTop.width#/2.0
    turretTop.absCtrY# = turretTop.y#+turretTop.height#/2.0

    turretRear.x# = GetSpriteX(turretRear.sprID)                      ` Rear Turret
    turretRear.y# = GetSpriteY(turretRear.sprID)
    turretRear.width# = GetSpriteWidth(turretRear.sprID)
    turretRear.height# = GetSpriteHeight(turretRear.sprID)
    turretRear.absCtrX# = turretRear.x#+turretRear.width#/2.0
    turretRear.absCtrY# = turretRear.y#+turretRear.height#/2.0

    leftGunner.x# = GetSpriteX(leftGunner.sprID)                      ` Left Gunner
    leftGunner.y# = GetSpriteY(leftGunner.sprID)
    leftGunner.width# = GetSpriteWidth(leftGunner.sprID)
    leftGunner.height# = GetSpriteHeight(leftGunner.sprID)
    leftGunner.absCtrX# = leftGunner.x#+leftGunner.width#/2.0
    leftGunner.absCtrY# = leftGunner.y#+leftGunner.height#/2.0

    rightGunner.x# = GetSpriteX(rightGunner.sprID)                      ` Right Gunner
    rightGunner.y# = GetSpriteY(rightGunner.sprID)
    rightGunner.width# = GetSpriteWidth(rightGunner.sprID)
    rightGunner.height# = GetSpriteHeight(rightGunner.sprID)
    rightGunner.absCtrX# = rightGunner.x#+rightGunner.width#/2.0
    rightGunner.absCtrY# = rightGunner.y#+rightGunner.height#/2.0
EndFunction


` **** SetTurretOnShip()
Function SetTurretOnShip(turretID, offsetFromShipCtr)
    x# = offsetFromShipCtr*Cos(ship.angle#)+ship.absCtrX#
    y# = offsetFromShipCtr*Sin(ship.angle#)+ship.absCtrY#
    SetSpritePositionByOffset(turretID, x#, y#)
EndFunction


` *** SetGunnerOnShip()
Function SetGunnerOnShip(gunnerID, shipSide$)
    if (shipSide$ = "port")              ` Left
        x# = (-(ship.width#/34.0)-ship.sensorDistance#)*(Cos(ship.angle#+ship.sensorAngle#+4))+ship.absCtrX#
        y# = (-(ship.width#/34.0)-ship.sensorDistance#)*(Sin(ship.angle#+ship.sensorAngle#+4))+ship.absCtrY#
    elseif (shipSide$ = "starboard")     ` Right
        x# = (-(ship.width#/34.0)-ship.sensorDistance#)*(Cos(ship.angle#-ship.sensorAngle#-4))+ship.absCtrX#
        y# = (-(ship.width#/34.0)-ship.sensorDistance#)*(Sin(ship.angle#-ship.sensorAngle#-4))+ship.absCtrY#
    endif
    SetSpritePositionByOffset(gunnerID, x#, y#)
EndFunction


` *** CreateMunitions()
Function CreateMunitions()

    ` *** Image Loading / Sprite Creation ***
    LoadImage(gunnerBulletImageID, "gunner-red-bullet.png")
    CreateSprite(gunnerBulletSpriteID, gunnerBulletImageID)
    SetSpriteSize(gunnerBulletSpriteID, 5, 5)
    SetSpriteDepth(gunnerBulletSpriteID, bulletDepth)
    SetSpriteVisible(gunnerBulletSpriteID, INVISIBLE)

    CloneSprite(targetingSpriteID, gunnerBulletSpriteID)
    SetSpriteSize(targetingSpriteID, 24, 24)
    SetSpriteGroup(targetingSpriteID, GOOD_GUYS_GROUP)
    SetSpriteDepth(targetingSpriteID, targetDepth)
    SetSpritePhysicsOn(targetingSpriteID, DYNAMIC)
    SetSpriteVisible(targetingSpriteID, INVISIBLE)

    LoadImage(torpedoImageID, "torpedo.png")
    CreateSprite(torpedoSpriteID, torpedoImageID)
    SetSpriteSize(torpedoSpriteID, 50, -1)
    SetSpriteDepth(torpedoSpriteID, torpedoDepth)
    SetSpriteVisible(torpedoSpriteID, INVISIBLE)
                                                                                    `
    LoadImage(projectileImageID, "projectile.png")
    CreateSprite(projectileSpriteID, projectileImageID)
    SetSpriteSize(projectileSpriteID, 20, -1)
    SetSpriteDepth(projectileSpriteID, projectileDepth)
    SetSpriteVisible(projectileSpriteID, INVISIBLE)

    LoadImage(mineImageID, "ocean-mine.png")
    CreateSprite(mineSpriteID, mineImageID)
    SetSpriteSize(mineSpriteID, 25, -1)
    SetSpriteDepth(mineSpriteID, mineDepth)
    `SetSpritePosition(mineSpriteID, 50,50)
    SetSpriteVisible(mineSpriteID, INVISIBLE)


    LoadImage(bulletImpactImageID, "bullet-impact-blast.png")
    CreateSprite(bulletImpactSpriteID, bulletImpactImageID)
    SetSpriteSize(bulletImpactSpriteID, 15, -1)
    SetSpriteDepth(bulletImpactSpriteID, bulletDepth)
    SetSpritePosition(bulletImpactSpriteID, 150, 150)
    SetSpriteVisible(bulletImpactSpriteID, INVISIBLE)


    LoadImage(projectileImpactImageID, "projectile-impact-blast-sprite-sheet.png")
    CreateSprite(projectileImpactSpriteID, projectileImpactImageID)
    SetSpriteSize(projectileImpactSpriteID, 40, -1)
    SetSpriteDepth(projectileImpactSpriteID, animationDepth)
    x# = GetSpriteX(projectileImpactSpriteID)
    y# = GetSpriteY(projectileImpactSpriteID)
    w# = GetSpriteWidth(projectileImpactSpriteID)
    h# = GetSpriteHeight(projectileImpactSpriteID)
    SetSpriteOffset(projectileImpactSpriteID, x#+(w#/2), y#+(h#/2))
    `SetSpritePositionByOffset(projectileImpactSpriteID, 600,400)
    SetSpriteAnimation(projectileImpactSpriteID, 50, 60, 7)
    `SetSpriteVisible(projectileImpactSpriteID, INVISIBLE)


    LoadImage(torpedoImpactImageID, "torpedo-impact-blast-sprite-sheet.png")
    CreateSprite(torpedoImpactSpriteID, torpedoImpactImageID)
    SetSpriteSize(torpedoImpactSpriteID, 60, -1)
    SetSpriteDepth(torpedoImpactSpriteID, animationDepth)
    x# = GetSpriteX(torpedoImpactSpriteID)
    y# = GetSpriteY(torpedoImpactSpriteID)
    w# = GetSpriteWidth(torpedoImpactSpriteID)
    h# = GetSpriteHeight(torpedoImpactSpriteID)
    SetSpriteOffset(torpedoImpactSpriteID, x#+(w#/2), y#+(h#/2))
    `SetSpritePositionByOffset(torpedoImpactSpriteID, 600,400)
    SetSpriteAnimation(torpedoImpactSpriteID, 50, 60, 7)
    `SetSpriteVisible(torpedoImpactSpriteID, INVISIBLE)



    ` *** Load the Gunner Bullets Arrays
    for x = 0 to gunnerBulletLimit
        ` ************* Left Gunner ***********
        gunnerLGLBBullets[x].sprID = CloneSprite(gunnerBulletSpriteID)    ` Left Barrel
        SetSpriteGroup(gunnerLGLBBullets[x].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(gunnerLGLBBullets[x].sprID, DYNAMIC)
        gunnerLGLBBullets[x].designation = BULLET
        gunnerLGLBBullets[x].damage = BULLET_DAMAGE
        SetSpritePhysicsMass(gunnerLGLBBullets[x].sprID, BULLET_MASS)
        gunnerLGLBBullets[x].impactSprID = CloneSprite(bulletImpactSpriteID)

        spriteLookup[gunnerLGLBBullets[x].sprID].sprID = gunnerLGLBBullets[x].sprID
        spriteLookup[gunnerLGLBBullets[x].sprID].typeDefinition = BULLET

        ChangeLeftGunnerLBulletState(x, BULLET_STATE_INACTIVE)


        gunnerLGRBBullets[x].sprID = CloneSprite(gunnerBulletSpriteID)    `Right Barrel
        SetSpriteGroup(gunnerLGRBBullets[x].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(gunnerLGRBBullets[x].sprID, DYNAMIC)
        gunnerLGRBBullets[x].designation = BULLET
        gunnerLGRBBullets[x].damage = BULLET_DAMAGE
        SetSpritePhysicsMass(gunnerLGRBBullets[x].sprID, BULLET_MASS)
        gunnerLGRBBullets[x].impactSprID = CloneSprite(bulletImpactSpriteID)

        spriteLookup[gunnerLGRBBullets[x].sprID].sprID = gunnerLGRBBullets[x].sprID
        spriteLookup[gunnerLGRBBullets[x].sprID].typeDefinition = BULLET

        ChangeLeftGunnerRBulletState(x, BULLET_STATE_INACTIVE)

        ` ************* Right Gunner ***********
        gunnerRGLBBullets[x].sprID = CloneSprite(gunnerBulletSpriteID)    `Left Barrel
        SetSpriteGroup(gunnerRGLBBullets[x].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(gunnerRGLBBullets[x].sprID, DYNAMIC)
        gunnerRGLBBullets[x].designation = BULLET
        gunnerRGLBBullets[x].damage = BULLET_DAMAGE
        SetSpritePhysicsMass(gunnerRGLBBullets[x].sprID, BULLET_MASS)
        gunnerRGLBBullets[x].impactSprID = CloneSprite(bulletImpactSpriteID)

        spriteLookup[gunnerRGLBBullets[x].sprID].sprID = gunnerRGLBBullets[x].sprID
        spriteLookup[gunnerRGLBBullets[x].sprID].typeDefinition = BULLET

        ChangeRightGunnerLBulletState(x, BULLET_STATE_INACTIVE)

        gunnerRGRBBullets[x].sprID = CloneSprite(gunnerBulletSpriteID)    `Right Barrel
        SetSpriteGroup(gunnerRGRBBullets[x].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(gunnerRGRBBullets[x].sprID, DYNAMIC)
        gunnerRGRBBullets[x].designation = BULLET
        gunnerRGRBBullets[x].damage = BULLET_DAMAGE
        SetSpritePhysicsMass(gunnerRGRBBullets[x].sprID, BULLET_MASS)
        gunnerRGRBBullets[x].impactSprID = CloneSprite(bulletImpactSpriteID)

        spriteLookup[gunnerRGRBBullets[x].sprID].sprID = gunnerRGRBBullets[x].sprID
        spriteLookup[gunnerRGRBBullets[x].sprID].typeDefinition = BULLET

        ChangeRightGunnerRBulletState(x, BULLET_STATE_INACTIVE)
    next x

    ` *** Load the Turret Projectile Arrays
    for i = 0 to projectileLimit  ` *** Load the Projectiles Arrays

        ` ************** Front Turret *****************
        frontTurretLProjectile[i].sprID = CloneSprite(projectileSpriteID)            ` *** Projectiles
        SetSpriteGroup(frontTurretLProjectile[i].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(frontTurretLProjectile[i].sprID, DYNAMIC)
        frontTurretLProjectile[i].width#  = GetSpriteWidth(frontTurretLProjectile[i].sprID)
        frontTurretLProjectile[i].height# = GetSpriteHeight(frontTurretLProjectile[i].sprID)
        frontTurretLProjectile[i].designation = PROJECTILE
        frontTurretLProjectile[i].damage = PROJECTILE_DAMAGE
        SetSpritePhysicsMass(frontTurretLProjectile[i].sprID, PROJECTILE_MASS)
        frontTurretLProjectile[i].impactSprID = CloneSprite(projectileImpactSpriteID)
        x# = GetSpriteX(frontTurretLProjectile[i].impactSprID)
        y# = GetSpriteY(frontTurretLProjectile[i].impactSprID)
        w# = GetSpriteWidth(frontTurretLProjectile[i].impactSprID)
        h# = GetSpriteHeight(frontTurretLProjectile[i].impactSprID)
        SetSpriteOffset(frontTurretLProjectile[i].impactSprID, x#+(w#/2), y#+(h#/2))
        SetSpriteAnimation(frontTurretLProjectile[i].impactSprID, 50, 60, 7)

        spriteLookup[frontTurretLProjectile[i].sprID].sprID = frontTurretLProjectile[i].sprID
        spriteLookup[frontTurretLProjectile[i].sprID].typeDefinition = PROJECTILE

        ChangeFrontTurretLProjectileState(i, PROJECTILE_STATE_INACTIVE)

        frontTurretRProjectile[i].sprID = CloneSprite(projectileSpriteID)
        SetSpriteGroup(frontTurretRProjectile[i].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(frontTurretRProjectile[i].sprID, DYNAMIC)
        frontTurretRProjectile[i].width#  = GetSpriteWidth(frontTurretRProjectile[i].sprID)
        frontTurretRProjectile[i].height# = GetSpriteHeight(frontTurretRProjectile[i].sprID)
        frontTurretRProjectile[i].designation = PROJECTILE
        frontTurretRProjectile[i].damage = PROJECTILE_DAMAGE
        SetSpritePhysicsMass(frontTurretRProjectile[i].sprID, PROJECTILE_MASS)
        frontTurretRProjectile[i].impactSprID = CloneSprite(projectileImpactSpriteID)
        x# = GetSpriteX(frontTurretRProjectile[i].impactSprID)
        y# = GetSpriteY(frontTurretRProjectile[i].impactSprID)
        w# = GetSpriteWidth(frontTurretRProjectile[i].impactSprID)
        h# = GetSpriteHeight(frontTurretRProjectile[i].impactSprID)
        SetSpriteOffset(frontTurretRProjectile[i].impactSprID, x#+(w#/2), y#+(h#/2))
        SetSpriteAnimation(frontTurretRProjectile[i].impactSprID, 50, 60, 7)

        spriteLookup[frontTurretRProjectile[i].sprID].sprID = frontTurretRProjectile[i].sprID
        spriteLookup[frontTurretRProjectile[i].sprID].typeDefinition = PROJECTILE

        ChangeFrontTurretRProjectileState(i, PROJECTILE_STATE_INACTIVE)

        frontTurretMProjectile[i].sprID = CloneSprite(projectileSpriteID)
        SetSpriteGroup(frontTurretMProjectile[i].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(frontTurretMProjectile[i].sprID, DYNAMIC)
        frontTurretMProjectile[i].width#  = GetSpriteWidth(frontTurretMProjectile[i].sprID)
        frontTurretMProjectile[i].height# = GetSpriteHeight(frontTurretMProjectile[i].sprID)
        frontTurretMProjectile[i].designation = PROJECTILE
        frontTurretMProjectile[i].damage = PROJECTILE_DAMAGE
        SetSpritePhysicsMass(frontTurretMProjectile[i].sprID, PROJECTILE_MASS)
        frontTurretMProjectile[i].impactSprID = CloneSprite(projectileImpactSpriteID)
        x# = GetSpriteX(frontTurretMProjectile[i].impactSprID)
        y# = GetSpriteY(frontTurretMProjectile[i].impactSprID)
        w# = GetSpriteWidth(frontTurretMProjectile[i].impactSprID)
        h# = GetSpriteHeight(frontTurretMProjectile[i].impactSprID)
        SetSpriteOffset(frontTurretMProjectile[i].impactSprID, x#+(w#/2), y#+(h#/2))
        SetSpriteAnimation(frontTurretMProjectile[i].impactSprID, 50, 60, 7)

        spriteLookup[frontTurretMProjectile[i].sprID].sprID = frontTurretMProjectile[i].sprID
        spriteLookup[frontTurretMProjectile[i].sprID].typeDefinition = PROJECTILE

        ChangeFrontTurretMProjectileState(i, PROJECTILE_STATE_INACTIVE)


        frontTurretLParticles[i].particleID = CreateParticles(0, 0)                     ` *** Particles
        frontTurretLParticles[i].active = FALSE
        SetParticlesSize(frontTurretLParticles[i].particleID, ordinance_entrail_size)
        SetParticlesFrequency(frontTurretLParticles[i].particleID, ordinance_entrail_freq)
        SetParticlesLife(frontTurretLParticles[i].particleID, ordinance_entrail_life#)
        SetParticlesVisible(frontTurretLParticles[i].particleID, INVISIBLE)

        frontTurretRParticles[i].particleID = CreateParticles(0, 0)
        frontTurretRParticles[i].active = FALSE
        SetParticlesSize(frontTurretRParticles[i].particleID, ordinance_entrail_size)
        SetParticlesFrequency(frontTurretRParticles[i].particleID, ordinance_entrail_freq)
        SetParticlesLife(frontTurretRParticles[i].particleID, ordinance_entrail_life#)
        SetParticlesVisible(frontTurretRParticles[i].particleID, INVISIBLE)

        frontTurretMParticles[i].particleID = CreateParticles(0, 0)
        frontTurretMParticles[i].active = FALSE
        SetParticlesSize(frontTurretMParticles[i].particleID, ordinance_entrail_size)
        SetParticlesFrequency(frontTurretMParticles[i].particleID, ordinance_entrail_freq)
        SetParticlesLife(frontTurretMParticles[i].particleID, ordinance_entrail_life#)
        SetParticlesVisible(frontTurretMParticles[i].particleID, INVISIBLE)


        ` ************** Rear Turret *****************
        rearTurretLProjectile[i].sprID = CloneSprite(projectileSpriteID)             ` *** Projectilces
        SetSpriteGroup(rearTurretLProjectile[i].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(rearTurretLProjectile[i].sprID, DYNAMIC)
        rearTurretLProjectile[i].width#  = GetSpriteWidth(rearTurretLProjectile[i].sprID)
        rearTurretLProjectile[i].height# = GetSpriteHeight(rearTurretLProjectile[i].sprID)
        rearTurretLProjectile[i].designation = PROJECTILE
        rearTurretLProjectile[i].damage = PROJECTILE_DAMAGE
        SetSpritePhysicsMass(rearTurretLProjectile[i].sprID, PROJECTILE_MASS)
        rearTurretLProjectile[i].impactSprID = CloneSprite(projectileImpactSpriteID)
        x# = GetSpriteX(rearTurretLProjectile[i].impactSprID)
        y# = GetSpriteY(rearTurretLProjectile[i].impactSprID)
        w# = GetSpriteWidth(rearTurretLProjectile[i].impactSprID)
        h# = GetSpriteHeight(rearTurretLProjectile[i].impactSprID)
        SetSpriteOffset(rearTurretLProjectile[i].impactSprID, x#+(w#/2), y#+(h#/2))
        SetSpriteAnimation(rearTurretLProjectile[i].impactSprID, 50, 60, 7)

        spriteLookup[rearTurretLProjectile[i].sprID].sprID = rearTurretLProjectile[i].sprID
        spriteLookup[rearTurretLProjectile[i].sprID].typeDefinition = PROJECTILE

        ChangeRearTurretLProjectileState(i, PROJECTILE_STATE_INACTIVE)


        rearTurretRProjectile[i].sprID = CloneSprite(projectileSpriteID)
        SetSpriteGroup(rearTurretRProjectile[i].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(rearTurretRProjectile[i].sprID, DYNAMIC)
        rearTurretRProjectile[i].width#  = GetSpriteWidth(rearTurretRProjectile[i].sprID)
        rearTurretRProjectile[i].height# = GetSpriteHeight(rearTurretRProjectile[i].sprID)
        rearTurretRProjectile[i].designation = PROJECTILE
        rearTurretRProjectile[i].damage = PROJECTILE_DAMAGE
        SetSpritePhysicsMass(rearTurretRProjectile[i].sprID, PROJECTILE_MASS)
        rearTurretRProjectile[i].impactSprID = CloneSprite(projectileImpactSpriteID)
        x# = GetSpriteX(rearTurretRProjectile[i].impactSprID)
        y# = GetSpriteY(rearTurretRProjectile[i].impactSprID)
        w# = GetSpriteWidth(rearTurretRProjectile[i].impactSprID)
        h# = GetSpriteHeight(rearTurretRProjectile[i].impactSprID)
        SetSpriteOffset(rearTurretRProjectile[i].impactSprID, x#+(w#/2), y#+(h#/2))
        SetSpriteAnimation(rearTurretRProjectile[i].impactSprID, 50, 60, 7)

        spriteLookup[rearTurretRProjectile[i].sprID].sprID = rearTurretRProjectile[i].sprID
        spriteLookup[rearTurretRProjectile[i].sprID].typeDefinition = PROJECTILE

        ChangeRearTurretRProjectileState(i, PROJECTILE_STATE_INACTIVE)

        rearTurretMProjectile[i].sprID = CloneSprite(projectileSpriteID)
        SetSpriteGroup(rearTurretMProjectile[i].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(rearTurretMProjectile[i].sprID, DYNAMIC)
        rearTurretMProjectile[i].width#  = GetSpriteWidth(rearTurretMProjectile[i].sprID)
        rearTurretMProjectile[i].height# = GetSpriteHeight(rearTurretMProjectile[i].sprID)
        rearTurretMProjectile[i].designation = PROJECTILE
        rearTurretMProjectile[i].damage = PROJECTILE_DAMAGE
        SetSpritePhysicsMass(rearTurretMProjectile[i].sprID, PROJECTILE_MASS)
        rearTurretMProjectile[i].impactSprID = CloneSprite(projectileImpactSpriteID)
        x# = GetSpriteX(rearTurretMProjectile[i].impactSprID)
        y# = GetSpriteY(rearTurretMProjectile[i].impactSprID)
        w# = GetSpriteWidth(rearTurretMProjectile[i].impactSprID)
        h# = GetSpriteHeight(rearTurretMProjectile[i].impactSprID)
        SetSpriteOffset(rearTurretMProjectile[i].impactSprID, x#+(w#/2), y#+(h#/2))
        SetSpriteAnimation(rearTurretMProjectile[i].impactSprID, 50, 60, 7)

        spriteLookup[rearTurretMProjectile[i].sprID].sprID = rearTurretMProjectile[i].sprID
        spriteLookup[rearTurretMProjectile[i].sprID].typeDefinition = PROJECTILE

        ChangeRearTurretMProjectileState(i, PROJECTILE_STATE_INACTIVE)



        rearTurretLParticles[i].particleID = CreateParticles(0, 0)                     ` *** Particles
        rearTurretLParticles[i].active = FALSE
        SetParticlesSize(rearTurretLParticles[i].particleID, ordinance_entrail_size)
        SetParticlesFrequency(rearTurretLParticles[i].particleID, ordinance_entrail_freq)
        SetParticlesLife(rearTurretLParticles[i].particleID, ordinance_entrail_life#)

        SetParticlesVisible(rearTurretLParticles[i].particleID, INVISIBLE)

        rearTurretRParticles[i].particleID = CreateParticles(0, 0)
        rearTurretRParticles[i].active = FALSE
        SetParticlesSize(rearTurretRParticles[i].particleID, ordinance_entrail_size)
        SetParticlesFrequency(rearTurretRParticles[i].particleID, ordinance_entrail_freq)
        SetParticlesLife(rearTurretRParticles[i].particleID, ordinance_entrail_life#)
        SetParticlesVisible(rearTurretRParticles[i].particleID, INVISIBLE)

        rearTurretMParticles[i].particleID = CreateParticles(0, 0)
        rearTurretMParticles[i].active = FALSE
        SetParticlesSize(rearTurretMParticles[i].particleID, ordinance_entrail_size)
        SetParticlesFrequency(rearTurretMParticles[i].particleID, ordinance_entrail_freq)
        SetParticlesLife(rearTurretMParticles[i].particleID, ordinance_entrail_life#)
        SetParticlesVisible(rearTurretMParticles[i].particleID, INVISIBLE)


        ` ************** Top Turret *****************
        topTurretLProjectile[i].sprID = CloneSprite(projectileSpriteID)              ` *** Projectiles
        SetSpriteGroup(topTurretLProjectile[i].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(topTurretLProjectile[i].sprID, DYNAMIC)
        topTurretLProjectile[i].width#  = GetSpriteWidth(topTurretLProjectile[i].sprID)
        topTurretLProjectile[i].height# = GetSpriteHeight(topTurretLProjectile[i].sprID)
        topTurretLProjectile[i].designation = PROJECTILE
        topTurretLProjectile[i].damage = PROJECTILE_DAMAGE
        SetSpritePhysicsMass(topTurretLProjectile[i].sprID, PROJECTILE_MASS)
        topTurretLProjectile[i].impactSprID = CloneSprite(projectileImpactSpriteID)
        x# = GetSpriteX(topTurretLProjectile[i].impactSprID)
        y# = GetSpriteY(topTurretLProjectile[i].impactSprID)
        w# = GetSpriteWidth(topTurretLProjectile[i].impactSprID)
        h# = GetSpriteHeight(topTurretLProjectile[i].impactSprID)
        SetSpriteOffset(topTurretLProjectile[i].impactSprID, x#+(w#/2), y#+(h#/2))
        SetSpriteAnimation(topTurretLProjectile[i].impactSprID, 50, 60, 7)

        spriteLookup[topTurretLProjectile[i].sprID].sprID = topTurretLProjectile[i].sprID
        spriteLookup[topTurretLProjectile[i].sprID].typeDefinition = PROJECTILE

        ChangeTopTurretLProjectileState(i, PROJECTILE_STATE_INACTIVE)

        topTurretRProjectile[i].sprID = CloneSprite(projectileSpriteID)
        SetSpriteGroup(topTurretRProjectile[i].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(topTurretRProjectile[i].sprID, DYNAMIC)
        topTurretRProjectile[i].width#  = GetSpriteWidth(topTurretRProjectile[i].sprID)
        topTurretRProjectile[i].height# = GetSpriteHeight(topTurretRProjectile[i].sprID)
        topTurretRProjectile[i].designation = PROJECTILE
        topTurretRProjectile[i].damage = PROJECTILE_DAMAGE
        SetSpritePhysicsMass(topTurretRProjectile[i].sprID, PROJECTILE_MASS)
        topTurretRProjectile[i].impactSprID = CloneSprite(projectileImpactSpriteID)
        x# = GetSpriteX(topTurretRProjectile[i].impactSprID)
        y# = GetSpriteY(topTurretRProjectile[i].impactSprID)
        w# = GetSpriteWidth(topTurretRProjectile[i].impactSprID)
        h# = GetSpriteHeight(topTurretRProjectile[i].impactSprID)
        SetSpriteOffset(topTurretRProjectile[i].impactSprID, x#+(w#/2), y#+(h#/2))
        SetSpriteAnimation(topTurretRProjectile[i].impactSprID, 50, 60, 7)

        spriteLookup[topTurretRProjectile[i].sprID].sprID = topTurretRProjectile[i].sprID
        spriteLookup[topTurretRProjectile[i].sprID].typeDefinition = PROJECTILE

        ChangeTopTurretRProjectileState(i, PROJECTILE_STATE_INACTIVE)

        topTurretMProjectile[i].sprID = CloneSprite(projectileSpriteID)
        SetSpriteGroup(topTurretMProjectile[i].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(topTurretMProjectile[i].sprID, DYNAMIC)
        topTurretMProjectile[i].width#  = GetSpriteWidth(topTurretMProjectile[i].sprID)
        topTurretMProjectile[i].height# = GetSpriteHeight(topTurretMProjectile[i].sprID)
        topTurretMProjectile[i].designation = PROJECTILE
        topTurretMProjectile[i].damage = PROJECTILE_DAMAGE
        SetSpritePhysicsMass(topTurretMProjectile[i].sprID, PROJECTILE_MASS)
        topTurretMProjectile[i].impactSprID = CloneSprite(projectileImpactSpriteID)
        x# = GetSpriteX(topTurretMProjectile[i].impactSprID)
        y# = GetSpriteY(topTurretMProjectile[i].impactSprID)
        w# = GetSpriteWidth(topTurretMProjectile[i].impactSprID)
        h# = GetSpriteHeight(topTurretMProjectile[i].impactSprID)
        SetSpriteOffset(topTurretMProjectile[i].impactSprID, x#+(w#/2), y#+(h#/2))
        SetSpriteAnimation(topTurretMProjectile[i].impactSprID, 50, 60, 7)

        spriteLookup[topTurretMProjectile[i].sprID].sprID = topTurretMProjectile[i].sprID
        spriteLookup[topTurretMProjectile[i].sprID].typeDefinition = PROJECTILE

        ChangeTopTurretMProjectileState(i, PROJECTILE_STATE_INACTIVE)


        topTurretLParticles[i].particleID = CreateParticles(0, 0)                     ` *** Particles
        topTurretLParticles[i].active = FALSE
        SetParticlesSize(topTurretLParticles[i].particleID, ordinance_entrail_size)
        SetParticlesFrequency(topTurretLParticles[i].particleID, ordinance_entrail_freq)
        SetParticlesLife(topTurretLParticles[i].particleID, ordinance_entrail_life#)
        SetParticlesVisible(topTurretLParticles[i].particleID, INVISIBLE)

        topTurretRParticles[i].particleID = CreateParticles(0, 0)
        topTurretRParticles[i].active = FALSE
        SetParticlesSize(topTurretRParticles[i].particleID, ordinance_entrail_size)
        SetParticlesFrequency(topTurretRParticles[i].particleID, ordinance_entrail_freq)
        SetParticlesLife(topTurretRParticles[i].particleID, ordinance_entrail_life#)
        SetParticlesVisible(topTurretRParticles[i].particleID, INVISIBLE)

        topTurretMParticles[i].particleID = CreateParticles(0, 0)
        topTurretMParticles[i].active = FALSE
        SetParticlesSize(topTurretMParticles[i].particleID, ordinance_entrail_size)
        SetParticlesFrequency(topTurretMParticles[i].particleID, ordinance_entrail_freq)
        SetParticlesLife(topTurretMParticles[i].particleID, ordinance_entrail_life#)
        SetParticlesVisible(topTurretMParticles[i].particleID, INVISIBLE)
    next i

    ` *** Load the Torpedo's Arrays
    for j = 0 to torpedoLimit

        leftTorpedo[j].sprID  = CloneSprite(torpedoSpriteID)
        SetSpriteGroup(leftTorpedo[j].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(leftTorpedo[j].sprID, DYNAMIC)
        leftTorpedo[j].width#   = GetSpriteWidth(leftTorpedo[j].sprID)
        leftTorpedo[j].height#  = GetSpriteHeight(leftTorpedo[j].sprID)
        leftTorpedo[j].designation = TORPEDO
        leftTorpedo[j].damage = TORPEDO_DAMAGE
        SetSpritePhysicsMass(leftTorpedo[j].sprID, TORPEDO_MASS)

        leftTorpedo[j].impactSprID = CloneSprite(torpedoImpactSpriteID)
        x# = GetSpriteX(leftTorpedo[j].impactSprID)
        y# = GetSpriteY(leftTorpedo[j].impactSprID)
        w# = GetSpriteWidth(leftTorpedo[j].impactSprID)
        h# = GetSpriteHeight(leftTorpedo[j].impactSprID)
        SetSpriteOffset(leftTorpedo[j].impactSprID, x#+(w#/2), y#+(h#/2))
        SetSpriteAnimation(leftTorpedo[j].impactSprID, 50, 60, 7)


        spriteLookup[leftTorpedo[j].sprID].sprID = leftTorpedo[j].sprID
        spriteLookup[leftTorpedo[j].sprID].typeDefinition = TORPEDO

        ChangeLeftTorpedoState(j, TORPEDO_STATE_INACTIVE)


        rightTorpedo[j].sprID = CloneSprite(torpedoSpriteID)
        SetSpriteGroup(rightTorpedo[j].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(rightTorpedo[j].sprID, DYNAMIC)
        rightTorpedo[j].width#   = GetSpriteWidth(rightTorpedo[j].sprID)
        rightTorpedo[j].height#  = GetSpriteHeight(rightTorpedo[j].sprID)
        rightTorpedo[j].designation = TORPEDO
        rightTorpedo[j].damage = TORPEDO_DAMAGE
        SetSpritePhysicsMass(rightTorpedo[j].sprID, TORPEDO_MASS)

        rightTorpedo[j].impactSprID = CloneSprite(torpedoImpactSpriteID)
        x# = GetSpriteX(rightTorpedo[j].impactSprID)
        y# = GetSpriteY(rightTorpedo[j].impactSprID)
        w# = GetSpriteWidth(rightTorpedo[j].impactSprID)
        h# = GetSpriteHeight(rightTorpedo[j].impactSprID)
        SetSpriteOffset(rightTorpedo[j].impactSprID, x#+(w#/2), y#+(h#/2))
        SetSpriteAnimation(rightTorpedo[j].impactSprID, 50, 60, 7)


        spriteLookup[rightTorpedo[j].sprID].sprID = rightTorpedo[j].sprID
        spriteLookup[rightTorpedo[j].sprID].typeDefinition = TORPEDO

        ChangeRightTorpedoState(j, TORPEDO_STATE_INACTIVE)

        leftTorpedoParticles[j].particleID  = CreateParticles(0, 0)
        SetParticlesSize(leftTorpedoParticles[j].particleID, torpedo_bubbles_size)
        SetParticlesFrequency(leftTorpedoParticles[j].particleID, torpedo_bubbles_freq)
        SetParticlesLife(leftTorpedoParticles[j].particleID, torpedo_bubbles_life#)
        SetParticlesVisible(leftTorpedoParticles[j].particleID, INVISIBLE)

        rightTorpedoParticles[j].particleID = CreateParticles(0, 0)
        SetParticlesSize(rightTorpedoParticles[j].particleID, torpedo_bubbles_size)
        SetParticlesFrequency(rightTorpedoParticles[j].particleID, torpedo_bubbles_freq)
        SetParticlesLife(rightTorpedoParticles[j].particleID, torpedo_bubbles_life#)
        SetParticlesVisible(rightTorpedoParticles[j].particleID, INVISIBLE)
    next j

` *** Load the Mine Array
    for m = 0 to mineLimit
        mine[m].sprID = CloneSprite(mineSpriteID)
        SetSpriteOffset(mine[m].sprID, (GetSpriteWidth(mine[m].sprID)/2), GetSpriteHeight(mine[m].sprID)/2)
        SetSpriteGroup(mine[m].sprID, GOOD_GUYS_GROUP)
        SetSpritePhysicsOn(mine[m].sprID, DYNAMIC)
        mine[m].x# = GetSpriteX(mine[m].sprID)
        mine[m].y# = GetSpriteY(mine[m].sprID)
        mine[m].designation = OCEAN_MINE
        mine[m].damage = MINE_DAMAGE

        spriteLookup[mine[m].sprID].sprID = mine[m].sprID
        spriteLookup[mine[m].sprID].typeDefinition = OCEAN_MINE

        ChangeMineState(m, MINE_STATE_INACTIVE)
    next m

EndFunction



rem ******************************
rem EOF Battleship setupworld.agc
rem ******************************



















