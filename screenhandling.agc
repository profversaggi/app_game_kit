rem ******************************
rem Battleship screenhandline.agc
rem ******************************


` *** ControlScreen()
Function ControlScreen()
    ControlZoom()
    ControlScroll()
EndFunction


` **** ControlZoom()
Function ControlZoom()
    if GetPointerState() = 1    ` If Button is Pressed
        viewOffsetX# = GetViewOffsetX()
        viewOffsetY# = GetViewOffsetY()
        ` **** Handle Individual Button Presses ....
        select GetSpriteHit(ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY()))       // Use when executing SetViewOffset()
            case 110 ` **** Zoom IN [inSpriteID]
                screen.zoom# = screen.zoom# + 0.01

                if (screen.zoom# <= screen.zoomLowerBoundary#)        ` Enforce Zoom Boundaries
                    screen.zoom# = screen.zoomLowerBoundary#
                elseif (screen.zoom# >= screen.zoomUpperBundary#)
                    screen.zoom# = screen.zoomUpperBundary#
                endif
                screen.magnification# = 1/screen.zoom#
                SetViewZoomMode(0)                                  ` Always Zoom from Top/Left
            endcase
            case 111 ` **** Zoom OUT [outSpriteID]
                screen.zoom# = screen.zoom# - 0.01

                if (screen.zoom# <= screen.zoomLowerBoundary#)        ` Enforce Zoom Boundaries
                    screen.zoom# = screen.zoomLowerBoundary#
                elseif (screen.zoom# >= screen.zoomUpperBundary#)
                    screen.zoom# = screen.zoomUpperBundary#
                endif
                screen.magnification# = 1/screen.zoom#
                SetViewZoomMode(0)                                  ` Always Zoom from Top/Left
            endcase
        endselect
    endif
    SetViewZoom(screen.zoom#)
EndFunction



` **** ControlScroll()
Function ControlScroll()
    if GetPointerState() = 1    ` If Button is Pressed
        ` **** Handle Individual Button Presses ....
        select GetSpriteHit(ScreenToWorldX(GetPointerX()), ScreenToWorldY(GetPointerY()))       // Use when executing SetViewOffset()
            case 141: ` **** Scroll Screen Left [screenScrollLButtonID]
                if (screen.viewOffsetX# <= WorldBorderLeft())
                    screen.viewOffsetX# = WorldBorderLeft()
                    screen.viewOffsetY# = GetViewOffsetY()
                else
                    screen.viewOffsetX# = screen.viewOffsetX# - 20
                    screen.viewOffsetY# = GetViewOffsetY()
                endif
            endcase
            case 143: ` **** Scroll Screen Up [screenScrollUButtonID]
                if (screen.viewOffsetY# <= WorldBorderUp())
                    screen.viewOffsetY# = WorldBorderUp()
                    screen.viewOffsetX# = GetViewOffsetX()
                else
                    screen.viewOffsetY# = screen.viewOffsetY# - 20
                    screen.viewOffsetX# = GetViewOffsetX()
                endif
            endcase
            case 142: ` **** Scroll Screen Right [screenScrollRButtonID]
                if (screen.viewOffsetX# >= WorldBorderRight()-500)
                    screen.viewOffsetX# = screen.previousViewOffsetX#
                    screen.viewOffsetY# = GetViewOffsetY()
                else
                    screen.previousViewOffsetX# = screen.viewOffsetX#
                    screen.viewOffsetX# = screen.viewOffsetX# + 20
                    screen.viewOffsetY# = GetViewOffsetY()
                endif
            endcase
            case 144: ` **** Scroll Screen Down [screenScrollDButtonID]
                if (screen.viewOffsetY# >= WorldBorderDown()-500)
                    screen.viewOffsetY# = screen.previousViewOffsetY#
                    screen.viewOffsetX# = GetViewOffsetX()
                else
                    screen.previousViewOffsetY# = screen.viewOffsetY#
                    screen.viewOffsetY# = screen.viewOffsetY# + 20
                    screen.viewOffsetX# = GetViewOffsetX()
                endif
            endcase
        endselect
    endif
    SetViewOffset(screen.viewOffsetX#, screen.viewOffsetY#)
EndFunction





// **** Determines the 4 Screen Border(s) : Account for screen Zoom and corresponding magnification

` **** X ****
Function ScreenBorderRight()
    border# = ScreenToWorldX(GetVirtualWidth())
EndFunction border#


Function ScreenBorderLeft()
    border# = ScreenToWorldX(GetVirtualWidth())  - (screenWidth*screen.magnification#)
EndFunction border#


` **** Y ****
Function ScreenBorderUp()
    border# = ScreenToWorldY(GetVirtualHeight())  - (ScreenHeight*screen.magnification#)
EndFunction border#


Function ScreenBorderDown()
    border# = ScreenToWorldY(GetVirtualHeight())
EndFunction border#



rem **********************************
rem EOF Battleship screenhandline.agc
rem **********************************






