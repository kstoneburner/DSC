﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^!#r::
	msgbox reload code
	reload
return

::@pf::
::#pf::
	temp=%clipboard%
	clipboard=print(f"{}")
	send ^v
	send {left}{left}{left}
	sleep,100
	clipboard=%temp%
RETURN

