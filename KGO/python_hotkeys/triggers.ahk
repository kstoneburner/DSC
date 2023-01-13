#SingleInstance Force

^#q::
	oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	oWhr.Open("GET", "http://127.0.0.1:9999?keyaction=q&ctrl=1&win=1&shift=0&alt=0", false)
	oWhr.Send()
	oWhr.Abort()
RETURN

^#w::
	oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	oWhr.Open("GET", "http://127.0.0.1:9999?keyaction=w&ctrl=1&win=1&shift=0&alt=0", false)
	oWhr.Send()
	oWhr.Abort()
RETURN

^#e::
	oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	oWhr.Open("GET", "http://127.0.0.1:9999?keyaction=e&ctrl=1&win=1&shift=0&alt=0", false)
	oWhr.Send()
	oWhr.Abort()
RETURN

^#enter::
	oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	oWhr.Open("GET", "http://127.0.0.1:9999?keyaction=enter&ctrl=1&win=1&shift=0&alt=0", false)
	oWhr.Send()
	oWhr.Abort()
RETURN

^#f1::
	oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	oWhr.Open("GET", "http://127.0.0.1:9999?keyaction=f1&ctrl=1&win=1&shift=0&alt=0", false)
	oWhr.Send()
	oWhr.Abort()
RETURN

^#f2::
	oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	oWhr.Open("GET", "http://127.0.0.1:9999?keyaction=f2&ctrl=1&win=1&shift=0&alt=0", false)
	oWhr.Send()
	oWhr.Abort()
RETURN

^#f3::
	oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	oWhr.Open("GET", "http://127.0.0.1:9999?keyaction=f3&ctrl=1&win=1&shift=0&alt=0", false)
	oWhr.Send()
	oWhr.Abort()
RETURN

^#f4::
	oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	oWhr.Open("GET", "http://127.0.0.1:9999?keyaction=f4&ctrl=1&win=1&shift=0&alt=0", false)
	oWhr.Send()
	oWhr.Abort()
RETURN

^#f5::
	oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	oWhr.Open("GET", "http://127.0.0.1:9999?keyaction=f5&ctrl=1&win=1&shift=0&alt=0", false)
	oWhr.Send()
	oWhr.Abort()
RETURN

^#!r::
	msgbox reloading
	reload
RETURN
