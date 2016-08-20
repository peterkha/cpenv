#SingleInstance force
 
;;;;;;;;TODO;;;;;;;;;;;;
;;  - Add method for holding mouse button
;;  - Context-sensitive hotkeys http://www.autohotkey.com/docs/commands/Hotkey.htm
 
;; Original - apocalypse~r <https://autohotkey.com/board/topic/41487-xbox-360-controller-as-mouse-hotkeys/>
 
;; Modified - Matlock42 <https://autohotkey.com/boards/viewtopic.php?f=6&t=13329>
 
 
; Increase the following value to make the mouse cursor move faster:
JoyMultiplier = 0.075
 
; The following value is the number of milliseconds between volume changes
; Decrease it to have the volume change faster:
VolumeDelay = 100
 
; Decrease the following value to require less joystick displacement-from-center
; to start moving the mouse.  However, you may need to calibrate your joystick
; -- ensuring it's properly centered -- to avoid cursor drift. A perfectly tight
; and centered joystick could use a value of 1:
JoyThreshold = 7
 
; Change the following to true to invert the Y-axis, which causes the mouse to
; move vertically in the direction opposite the stick:
InvertYAxis := false
 
; Change these values to use joystick button numbers other than 1, 2, and 3 for
; the left, right, and middle mouse buttons.  Available numbers are 1 through 32.
; Use the Joystick Test Script to find out your joystick's numbers more easily.
ButtonLeft = 1
ButtonRight = 2
ButtonMiddle = 3
ButtonY = 4
ButtonLB = 5
ButtonRB = 6
ButtonSelect = 7
ButtonStart = 8
ButtonLS = 9
ButtonRS = 10
 
; If your joystick has a POV control, you can use it as a mouse wheel.  The
; following value is the number of milliseconds between turns of the wheel.
; Decrease it to have the wheel turn faster:
WheelDelay = 100
 
; If your system has more than one joystick, increase this value to use a joystick
; other than the first:
JoystickNumber = 1
 
; END OF CONFIG SECTION -- Don't change anything below this point unless you want
; to alter the basic nature of the script.
 
JoystickPrefix = %JoystickNumber%Joy
;Hotkey, %JoystickPrefix%%ButtonLeft%, ButtonLeft
;Hotkey, %JoystickPrefix%%ButtonRight%, ButtonRight
;Hotkey, %JoystickPrefix%%ButtonMiddle%, ButtonMiddle
;Hotkey, %JoystickPrefix%%ButtonY%, ButtonY
;Hotkey, %JoystickPrefix%%ButtonLB%, ButtonLB
;Hotkey, %JoystickPrefix%%ButtonRB%, ButtonRB
;Hotkey, %JoystickPrefix%%ButtonSelect%, ButtonSelect
;Hotkey, %JoystickPrefix%%ButtonStart%, ButtonStart
Hotkey, %JoystickPrefix%%ButtonLS%, ButtonLS
Hotkey, %JoystickPrefix%%ButtonRS%, ButtonRS
 
; Calculate the axis displacements that are needed to start moving the cursor:
JoyThresholdUpper := 50 + JoyThreshold
JoyThresholdLower := 50 - JoyThreshold
if InvertYAxis
    YAxisMultiplier = -1
else
    YAxisMultiplier = 1
 
SetTimer, WatchJoystick, 10  ; Monitor the movement of the joystick.
 
; SetTimer, WatchVolume, %VolumeDelay% ; Monitor the Volume control
 
GetKeyState, JoyInfo, %JoystickNumber%JoyInfo
; IfInString, JoyInfo, P  ; Joystick has POV control, so use it as a mouse wheel.
;     SetTimer, MouseWheel, %WheelDelay%
 
return  ; End of auto-execute section.
 
 
; The subroutines below do not use KeyWait because that would sometimes trap the
; WatchJoystick quasi-thread beneath the wait-for-button-up thread, which would
; effectively prevent mouse-dragging with the joystick.
 
ButtonLeft:
SetMouseDelay, -1  ; Makes movement smoother.
MouseClick, left,,, 1, 0, D  ; Hold down the left mouse button.
SetTimer, WaitForLeftButtonUp, 10
return
 
ButtonRight:
SetMouseDelay, -1  ; Makes movement smoother.
MouseClick, right,,, 1, 0, D  ; Hold down the right mouse button.
SetTimer, WaitForRightButtonUp, 10
return
 
ButtonMiddle:
SetMouseDelay, -1  ; Makes movement smoother.
MouseClick, middle,,, 1, 0, D  ; Hold down the middle mouse button.
SetTimer, WaitForMiddleButtonUp, 10
return
 
ButtonY:
yDown := true
	Loop 
	{
		KeyWait, %JoystickPrefix%%ButtonLB%, D T0.02
		If not ErrorLevel
		{
			Send ^+{Tab}
			break
		}
		KeyWait, %JoystickPrefix%%ButtonRB%, D T0.02
		If not ErrorLevel
		{
			Send ^{Tab}
			break
		}
		KeyWait, %JoystickPrefix%%ButtonRB%, D T0.02
		If not ErrorLevel
		{
			Send ^{Tab}
			break
		}
		KeyWait, %JoystickPrefix%%ButtonSelect%, D T0.02
		If not ErrorLevel
		{
			SendInput !{Tab}
			break
		}
 
		Sleep 10
	}
yDown := false
return
 
ButtonRB_Chrome:
Send ^l
return
 
ButtonLB_Chrome:
Send ^k
return
 
 
ButtonLB:
if !yDown
{
	Send !{Left} ;Alt + ?
}
return
 
ButtonRB:
if !yDown
{
	Send !{Right} ;Alt + ?
}
return
 
ButtonStart:
Send {LWin}
Return
 
ButtonSelect:
if !yDown{
	Send #{P}
}
return
 
ButtonLS:
;reserved for Radial Menu

return
 
ButtonRS:
Send {Click}
return
 
WaitForLeftButtonUp:
if GetKeyState(JoystickPrefix . ButtonLeft)
    return  ; The button is still, down, so keep waiting.
; Otherwise, the button has been released.
SetTimer, WaitForLeftButtonUp, off
SetMouseDelay, -1  ; Makes movement smoother.
MouseClick, left,,, 1, 0, U  ; Release the mouse button.
return
 
WaitForRightButtonUp:
if GetKeyState(JoystickPrefix . ButtonRight)
    return  ; The button is still, down, so keep waiting.
; Otherwise, the button has been released.
SetTimer, WaitForRightButtonUp, off
MouseClick, right,,, 1, 0, U  ; Release the mouse button.
return
 
WaitForMiddleButtonUp:
if GetKeyState(JoystickPrefix . ButtonMiddle)
    return  ; The button is still, down, so keep waiting.
; Otherwise, the button has been released.
SetTimer, WaitForMiddleButtonUp, off
MouseClick, middle,,, 1, 0, U  ; Release the mouse button.
return
 
WatchJoystick:
MouseNeedsToBeMoved := false  ; Set default.
SetFormat, float, 03
GetKeyState, joyx, %JoystickNumber%JoyU
GetKeyState, joyy, %JoystickNumber%JoyR
 
if joyx > %JoyThresholdUpper%
{
    MouseNeedsToBeMoved := true
    DeltaX := joyx - JoyThresholdUpper
}
else if joyx < %JoyThresholdLower%
{
    MouseNeedsToBeMoved := true
    DeltaX := joyx - JoyThresholdLower
}
else
    DeltaX = 0
if joyy > %JoyThresholdUpper%
{
    MouseNeedsToBeMoved := true
    DeltaY := joyy - JoyThresholdUpper
}
else if joyy < %JoyThresholdLower%
{
    MouseNeedsToBeMoved := true
    DeltaY := joyy - JoyThresholdLower
}
else
    DeltaY = 0
if MouseNeedsToBeMoved
{	
	; Set up custom mouse movement profile here. Default is cubic profile, but can be replaced with linear or custom.
 
	SignX := signMM(DeltaX)
	SignY := signMM(DeltaY)
 
	moveX := ((Abs((DeltaX * JoyMultiplier) ** 3) < 1) ? (1*SignX) : ((DeltaX * JoyMultiplier) ** 3) )
	moveY := ((Abs((DeltaY * JoyMultiplier) ** 3) < 1) ? (1*SignY) : ((DeltaY * JoyMultiplier) ** 3) )* YAxisMultiplier
 
    SetMouseDelay, -1  ; Makes movement smoother.
	MouseMove, moveX , moveY , 0, R
}
return
 
WatchVolume:
VolumeNeedsToBeMoved := false
VolumeMultiplier = 1
GetKeyState, joyz, %JoystickNumber%JoyZ
 
 
if joyz > %JoyThresholdUpper%
{
    VolumeNeedsToBeMoved:= true
    Send {Volume_Down %VolumeMultiplier%}
}
else if joyz < %JoyThresholdLower%
{
    VolumeNeedsToBeMoved:= true
    Send {Volume_Up %VolumeMultiplier%}
}
else
    VolumeNeedsToBeMoved:= false
return
 
MouseWheel:
GetKeyState, JoyPOV, %JoystickNumber%JoyPOV
if JoyPOV < 0  ; No angle.
    return
else if (JoyPOV > 31500)  ; Forward
    Send {WheelUp}
else if JoyPOV between 0 and 4500   ; Forward
	Send {WheelUp}
else if JoyPOV between 4501 and 13500 ; Right
	Send {WheelRight}
else if JoyPOV between 13501 and 22500  ; Back
    Send {WheelDown}
else									; Left
	Send {WheelLeft}  
return
 
 
 
signMM(n)
{
	if (n > 0)
		return 1
	else if(n < 0)
		return -2	; found issue with MouseNeedsToBeMoved not recognizing -1 as movement
	else
		return 0
}
