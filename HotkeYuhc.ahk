;脚本基本配置
IfExist, HotkeYuhc.ico
{
	Menu TRAY, Icon, HotkeYuhc.ico
}

Menu, Tray, NoStandard
Menu, Tray, Add, 帮助, HelpSoft
Menu, Tray, Add, 关于, AboutSoft
Menu, Tray, Add, 退出, ExitSoft

#^!r::
RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Run\, AutoHotKey, %A_AhkPath%
Return

#^!a::
AboutSoft:
TickCount1 := Floor(A_TickCount / 60000)
TickCount2 := Floor(A_TickCount / 1000 - TickCount1 * 60)
MsgBox, 64, About, Hi %A_UserName%!`nToday is %A_YYYY%-%A_MM%-%A_DD%(%A_YDay%), %A_Hour%:%A_Min%, Elapsed Time: %TickCount1%min %TickCount2%s`n`nThe Script is created by Yuhc.`nRecent Version: Core Ver%A_AhkVersion%, Script Ver1.3.0912
Return

#^!h::
HelpSoft:
MsgBox, 4128, Help, Win+Ctrl+Alt+H 帮助`nWin+Ctrl+Alt+A 关于`nWin+Q 退出`nWin+N 运行记事本`nWin+T 一分钟计时器`nWin+Ctrl+T 计时器`nWin+C 获取鼠标所在位置颜色`nWin+P Get Mouse Position`nCtrl+Alt+Shift+E 显示或隐藏文件扩展名`nCtrl+Alt+Shift+H 显示或隐藏系统文件`nWin+Ctrl+C 得到选中文件的路径`nWin+Ctrl+Alt+W 建立Wifi热点（暂固定名称和密码）`nWin+Ctrl+W 开启Wifi热点`nWin+Ctrl+G 关闭Wifi热点
Return

#q::
ExitSoft:
	ExitApp
Return

;----------------------------------------------------------------------
;Reverse the Wheel
WheelUp::
Send {WheelDown}
Return

WheelDown::
Send {WheelUp}
Return

;Get Mouse Position (Win+P)
#p::
	MouseGetPos, MouseX, MouseY
	MsgBox X=%MouseX%, Y=%MouseY%
Return

;----------------------------------------------------------------------
;Get the Screen Color (Win+C)
#c::
	MouseGetPos, MouseX, MouseY
	PixelGetColor, color, %MouseX%, %MouseY%, RBG
	StringRight color, color, 6
	Clipboard = #%color%
	tooltip, #%Clipboard% has been sent to the Clipboard
	sleep 2000
	tooltip,
Return

;Get the Selected File's Path (Ctrl+Win+C)
^#c::
Send ^c
Sleep, 200
Clipboard=%Clipboard%
tooltip,%Clipboard%
Sleep, 500
Tooltip,
Return

;----------------------------------------------------------------------

;软件快捷运行
#!e::Run D:\Program Files\Youdao\Dict\Application\YodaoDict.exe	;有道词典
#!q::Run D:\Program Files\Tencent\QQ\Bin\QQ.exe					;腾讯QQ
#!f::Run D:\Program Files\Foobar2000\foobar2000.exe				;Foobar2000
#!t::Run D:\Program Files\TTPlayer\TTPlayer.exe					;千千静听
#!m::Run D:\Program Files\Maxthon3\Bin\Maxthon.exe					;傲游
#!u::Run D:\Program Files\uTorrent\uTorrent.exe					;uTorrent
#!b::Run D:\Program Files\Deny Sticker\sticker.exe					;便签
#!a::Run F:\UsefulToys\QQCapture.exe								;屏幕截图
#!p::Run F:\UsefulToys\符号表情输入.exe							;符号表情输入

;----------------------------------------------------------------------

#n::Run notepad
#j::Run www.yuhc.me

;#z::
;Click Left
;;MouseClick, Left
;Return
;#x::
;Click Right
;;MouseClick, Right
;Return

;自定义短语
::/mail::yuhc123@126.com
::/yhc::
	Clipboard = Hangchen Yu
	Send ^v
Return

;获取当天时间
::/dd::
	d = %A_YYYY%-%A_MM%-%A_DD%
	Clipboard = %d%
	Send ^v
Return

;计时器
#t::
	MsgBox 计时开始
	Sleep, 60000
	MsgBox 计时结束（1分钟）
Return

;加强版计时器，输入时间为秒
#^t::
	InputBox, time, 输入框, 输入倒计时秒数
	time := time * 1000
	Sleep, %time%
	MsgBox 计时结束（%time%毫秒）
Return

;显示 / 隐藏 文件扩展名：
;点击键盘上的 AppsKey ，弹出右键，选择“刷新(e)”
^!+e::
	If value = 0
		value = 1
	Else
		value = 0
	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, HideFileExt, %Value%
	Send { AppsKey } e
Return

;显示 / 隐藏 隐藏系统文件：
^!+h::
	If value = 1
		value = 2
	Else
		value = 1
	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, Hidden, %Value%
	Send { AppsKey } e
Return

;Wifi热点创建
^#w::
Run, %comspec% /c netsh wlan set hostednetwork mode=allow ssid=Yuhc key=309123456
Traytip, 建立Wifi热点, SSID=Yuhc Key=309123456, 500
Return
^#k::
Run, %comspec% /c netsh wlan start hostednetwork
Traytip, ,开启Wifi热点, 1000
Return
^#g::
Run, %comspec% /c netsh wlan stop hostednetwork
Traytip, ,关闭Wifi热点, 1000
Return
