#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.




^#\::


	oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	oWhr.Open("GET", "http://127.0.0.1:9999?macro=somethin", false)
	;oWhr.Open("GET", "http://www.google.com", false)
	oWhr.Send()
	;MsgBox, % oWhr.ResponseText

return


^!#r::
	msgbox reloading hotkeys
	reload
return
