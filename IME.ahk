;����
setLayout(Layout,WinID){
DllCall("SendMessage", "UInt", WinID, "UInt", "80", "UInt", "1", "UInt", (DllCall("LoadKeyboardLayout", "Str", Layout, "UInt", "257")))
}
sendbyclip(var_string)
{
    ClipboardOld = %ClipboardAll%
    Clipboard =%var_string%
	ClipWait
    send ^v
    sleep 100
    Clipboard = %ClipboardOld%  ; Restore previous contents of clipboard.
}



Gui +LastFound
hWnd := WinExist()
DllCall( "RegisterShellHookWindow", UInt,hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )

OnMessage( MsgNum, "ShellMessage")
Return


ShellMessage( wParam,lParam ) {
  If ( wParam = 1 )
  {
		WinGetclass, WinClass, ahk_id %lParam%
		;MsgBox,%Winclass%
		;ʹ���������뷨
		If Winclass in TXGuiFoundation,       ;��Ҫ������������Ĵ�������
		{
		  winget,WinID,id,ahk_class %WinClass%
		  ;����
		  setLayout("00000804",WinID)
		}

		;ʹ��Ӣ�����뷨
		if (InStr(Winclass,"HwndWrapper") or InStr(Winclass,"dopus") or Winclass in Notepad++,OpusApp)
		{
			  winget,WinID,id,ahk_class %WinClass%

			  ;Ӣ��
			  setLayout("00000409",WinID)

		}


	}
}

;��vs2012���Զ��л���Ӣ�����뷨
#IfWinActive, ahk_class HwndWrapper
:*:// ::
	;//�ӿո� ʱ �л����������뷨
	winget,WinID,id,ahk_class HwndWrapper
	setLayout("00000409",WinID)
	sendbyclip("//")
	setLayout("00000804",WinID)
return
:Z*:///::
	;///ע��ʱ �л����������뷨��Ҳ��������///�ӿո�
	winget,WinID,id,ahk_class HwndWrapper
	setLayout("00000409",WinID)
	sendbyclip("//")
	SendInput /
	setLayout("00000804",WinID)
return

#IfWinActive, ahk_class HwndWrapper
:*:" ::
	;���żӿո� ʱ �л����������뷨
	winget,WinID,id,ahk_class HwndWrapper
	setLayout("00000409",WinID)
	SendInput "
	setLayout("00000804",WinID)
return

#IfWinActive, ahk_class HwndWrapper
:*:`;`n::
	;�ֺżӻس� ʱ �л���Ӣ�����뷨
	winget,WinID,id,ahk_class HwndWrapper
	setLayout("00000409",WinID)
	sendbyclip(";")
	SendInput `n
return

#IfWinActive, ahk_class HwndWrapper
:Z?*:`;`;::
	;�����ֺ�ʱ �л���Ӣ�����뷨
	winget,WinID,id,ahk_class HwndWrapper
	setLayout("00000409",WinID)
return

#IfWinActive, ahk_class HwndWrapper
:Z?*:  ::
	;���������ո� �л����������뷨
	winget,WinID,id,ahk_class HwndWrapper
	setLayout("00000409",WinID)
	setLayout("00000804",WinID)
return

#IfWinActive




