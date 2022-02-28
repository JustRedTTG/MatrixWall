#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         SegoCode

 Script Function:
	Set live wallpapers on your Windows desktop usig mpv and weebp.

#ce ----------------------------------------------------------------------------

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include <WinAPIShPath.au3>
#include <GuiComboBox.au3>


#Region ### START Koda GUI section ### Form=
$form = GUICreate("github.com/SegoCode", 513, 72, 183, 124, -1, $WS_EX_ACCEPTFILES)
GUISetOnEvent($GUI_EVENT_DROPPED, -1)
$applyb = GUICtrlCreateButton("Apply", 432, 8, 75, 25)
$resetb = GUICtrlCreateButton("Reset", 432, 40, 75, 25)
$browseb = GUICtrlCreateButton("Browse", 352, 40, 75, 25)
$inputPath = GUICtrlCreateInput("", 8, 8, 417, 25)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
$winStart = GUICtrlCreateCheckbox("Set on windows startup", 8, 40, 137, 25)
Opt("TrayMenuMode", 1)
Opt("TrayOnEventMode", 1)
#EndRegion ### END Koda GUI section ###

;Detect multiple screen 
$multiScreen = False
If int(_WinAPI_GetSystemMetrics($SM_CMONITORS)) > 1 Then
	$multiScreen = True
	$comboScreens = GUICtrlCreateCombo("", 225, 41, 120, 0, $CBS_DROPDOWNLIST)
	_GUICtrlComboBox_SetItemHeight($comboScreens, 17)
	For $i = 0 To int(_WinAPI_GetSystemMetrics($SM_CMONITORS)) -1
		 GUICtrlSetData($comboScreens, "Apply on screen " & $i+1)
	Next
EndIf

;Service
Run(@WorkingDir & "\tools\autoPause.exe", "", @SW_HIDE)

;Autorun
If $CmdLine[0] > 0 Then
	GUICtrlSetData($inputPath, $CmdLine[1])
	setwallpaper()
	Exit
Else
	GUISetState(@SW_SHOW)
EndIf

;Init gui
GUICtrlSendMsg($inputPath, $EM_SETCUEBANNER, False, "Browse and select video")
GUICtrlSetState($winStart, $GUI_DISABLE)

;Check updates
Run(@WorkingDir & "\tools\updater.exe", "", @SW_HIDE)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $applyb
			If $multiScreen Then
				setwallpaperMultiScreen()
			Else
				setwallpaper()
			EndIf
		Case $browseb
			browsefiles()
		Case $winStart
			onWinStart()
		Case $resetb
			reset()
	EndSwitch
WEnd

Func onWinStart()
	If GUICtrlRead($winStart) = $GUI_CHECKED Then
		$FileName = @WorkingDir & "\AutoWall.exe"
		$args = GUICtrlRead($inputPath)
		$LinkFileName = @AppDataDir & "\Microsoft\Windows\Start Menu\Programs\Startup\" & "\AutoWall.lnk"
		$WorkingDirectory = @WorkingDir
		FileCreateShortcut($FileName, $LinkFileName, $WorkingDirectory, '"' & $args & '"', "", "", "", "", @SW_SHOWNORMAL)
	Else
		FileDelete(@AppDataDir & "\Microsoft\Windows\Start Menu\Programs\Startup\AutoWall.lnk")
	EndIf
EndFunc   ;==>onWinStart

Func setwallpaperMultiScreen()
	$oldwork = @WorkingDir
	$weebp = @WorkingDir & "\weebp\wp.exe "
	$webview = @WorkingDir & "\tools\webView.exe"
	
	FileChangeDir(@WorkingDir & "\mpv\")
	RunWait($weebp & "run mpv " & '"' & GUICtrlRead($inputPath) & '"' & " --screen="& _GUICtrlComboBox_GetCurSel($comboScreens)+1 &" --loop=inf --player-operation-mode=pseudo-gui --force-window=yes --input-ipc-server=\\.\pipe\mpvsocket", "", @SW_HIDE)
	Run($weebp & "add --wait --fullscreen --class mpv", "", @SW_HIDE)
EndFunc   ;==>setwallpaperMultiScreen

Func setwallpaper()
	$oldwork = @WorkingDir
	$weebp = @WorkingDir & "\weebp\wp.exe "
	$webview = @WorkingDir & "\tools\webView.exe"

	$inputUdf = GUICtrlRead($inputPath)
	If _WinAPI_UrlIs($inputUdf) == 0 Then
		killAll()
		FileChangeDir(@WorkingDir & "\mpv\")
		Run($weebp & "run mpv " & '"' & GUICtrlRead($inputPath) & '"' & " --loop=inf --player-operation-mode=pseudo-gui --force-window=yes --input-ipc-server=\\.\pipe\mpvsocket", "", @SW_HIDE)
		Run($weebp & "add --wait --fullscreen --class mpv", "", @SW_HIDE)
	Else
		If StringInStr(GUICtrlRead($inputPath), "steamcommunity.com") Then
			$idSteam = StringSplit(GUICtrlRead($inputPath), "?id=", 1)
			ShellExecute("https://steamworkshopdownloader.io/extension/embedded/" & $idSteam[2])
			GUICtrlSetState($winStart, $GUI_UNCHECKED)
			GUICtrlSetState($winStart, $GUI_DISABLE)
			GUICtrlSetData($inputPath, "")
			MsgBox($MB_TOPMOST, "Download from workshop", "The download has been started in your browser, if the downloaded zip contains an .mp4 file, extract it in 'VideosHere' folder.")
		Else
			killAll()
			Run($weebp & "run " & '"' & $webview & '"' & " " & GUICtrlRead($inputPath), "", @SW_HIDE)
			Run($weebp & "add --wait --fullscreen --class webview", "", @SW_HIDE)
			GUICtrlSetState($winStart, $GUI_ENABLE)
		EndIf
	EndIf
	FileChangeDir($oldwork)
EndFunc   ;==>setwallpaper




Func browsefiles()
	Local Const $sMessage = "Select the video for wallpaper"
	Local $sFileOpenDialog = FileOpenDialog($sMessage, @WorkingDir & "\VideosHere" & "\", "Videos (*.avi;*.mp4;*.gif;*.mkv;*.webm;*.mts;*.wmv;*.flv;*.mov)", BitOR($FD_FILEMUSTEXIST, $FD_PATHMUSTEXIST))
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "Info", "No file was selected.")
		FileChangeDir(@ScriptDir)
	Else
		FileChangeDir(@ScriptDir)
		$sFileOpenDialog = StringReplace($sFileOpenDialog, "|", @CRLF)
		GUICtrlSetData($inputPath, $sFileOpenDialog)
		GUICtrlSetState($winStart, $GUI_ENABLE)
		GUICtrlSetState($winStart, $GUI_UNCHECKED)
	EndIf

EndFunc   ;==>browsefiles

Func reset()
	killAll()
	FileDelete(@AppDataDir & "\Microsoft\Windows\Start Menu\Programs\Startup\AutoWall.lnk")
	GUICtrlSetState($winStart, $GUI_UNCHECKED)
	GUICtrlSetData($inputPath, "")

EndFunc   ;==>reset


Func killAll()

	Do
		ProcessClose('mpv.exe')
	Until Not ProcessExists('mpv.exe')

	Do
		ProcessClose('wp.exe')
	Until Not ProcessExists('wp.exe')

	Do
		ProcessClose('webView.exe')
	Until Not ProcessExists('webView.exe')

	Do
		ProcessClose('Win32WebViewHost.exe')
	Until Not ProcessExists('Win32WebViewHost.exe')

	;Refresh
	Run(@WorkingDir & "\weebp\wp.exe ls", "", @SW_HIDE)

EndFunc   ;==>killAll
