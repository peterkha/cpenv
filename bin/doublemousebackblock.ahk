~XButton1::return  ; Set A_PriorHotkey.
#If A_PriorHotkey != "" && A_TimeSincePriorHotkey < 200
XButton1::return  ; Block hotkey.
