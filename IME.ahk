;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AHK�汾��		1.1.23.01
; ���ԣ�		����
; ���ߣ�		lspcieee <lspcieee@gmail.com>
����վ��		http://www.lspcieee.com/
; �ű����ܣ�	�Զ��л����뷨
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;=====��������
;�������뷨�ķ���
GroupAdd,cn,ahk_exe QQ.exe  ;QQ
GroupAdd,cn,ahk_exe WINWORD.EXE ;word
GroupAdd,cn,ahk_exe MindManager.exe

;Ӣ�����뷨�ķ���
GroupAdd,en,ahk_exe devenv.exe  ;Visual Studio
GroupAdd,en,ahk_exe dopus.exe 
GroupAdd,en,ahk_class Notepad++

;�༭������
GroupAdd,editor,ahk_exe devenv.exe  ;Visual Studio
GroupAdd,editor,ahk_exe notepad.exe ;���±�
GroupAdd,editor,ahk_class Notepad++




;����
;�Ӽ��������뵽����
sendbyclip(var_string)
{
    ClipboardOld = %ClipboardAll%
    Clipboard =%var_string%
	ClipWait
    send ^v
    sleep 100
    Clipboard = %ClipboardOld%  ; Restore previous contents of clipboard.
}


setChineseLayout(){
	;�����������뷨�л���ݼ��������ʵ��������á�
	send {Ctrl Down}{Shift}
	send {Ctrl Down},
	send {Ctrl Down}{Shift}
	send {Ctrl Down},
	send {Ctrl Up}
}
setEnglishLayout(){
	;����Ӣ�����뷨�л���ݼ��������ʵ��������á�
	send {Ctrl Down}{Shift}
	send {Ctrl Down},
	send {Ctrl Down}{Shift}
	send {Ctrl Down},

	send {Ctrl Down}{Space}
	send {Ctrl Up}
}

;�����Ϣ�ص�ShellMessage�����Զ��������뷨
Gui +LastFound
hWnd := WinExist()
DllCall( "RegisterShellHookWindow", UInt,hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage")

ShellMessage( wParam,lParam ) {
	If ( wParam = 1 )
	{
		WinGetclass, WinClass, ahk_id %lParam%
		;MsgBox,%Winclass%
		Sleep, 1000
		WinActivate,ahk_class %Winclass%
		;WinGetActiveTitle, Title
		;MsgBox, The active window is "%Title%".
		IfWinActive,ahk_group cn
		{
			setChineseLayout()
			TrayTip,AHK, ���Զ��л����������뷨
			return
		}
		IfWinActive,ahk_group en
		{
			setEnglishLayout()
			TrayTip,AHK, ���Զ��л���Ӣ�����뷨
			return
		}
	}
}

;�����б༭�����Զ��л���Ӣ�����뷨
#IfWinActive,ahk_group editor
:*:// ::
	;//�ӿո� ʱ �л����������뷨
	setEnglishLayout()
	sendbyclip("//")
	setChineseLayout()
return
:Z*:///::
	;///ע��ʱ �л����������뷨��Ҳ��������///�ӿո�
	setEnglishLayout()
	sendbyclip("//")
	SendInput /
	setChineseLayout()
return
:*:" ::
	;���żӿո� ʱ �л����������뷨
	setEnglishLayout()
	SendInput "
	setChineseLayout()
return
:*:`;`n::
	;�ֺżӻس� ʱ �л���Ӣ�����뷨
	setEnglishLayout()
	sendbyclip(";")
	SendInput `n
return
:Z?*:`;`;::
	;�����ֺ�ʱ �л���Ӣ�����뷨
	setEnglishLayout()
return
:Z?*:  ::
	;���������ո� �л����������뷨
	setEnglishLayout()
	setChineseLayout()
return

#IfWinActive






