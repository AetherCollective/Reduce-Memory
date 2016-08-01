#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=C:\ISN AutoIt Studio\autoitstudioicon.ico
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_requestedExecutionLevel=highestAvailable
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Misc.au3>
_Singleton("memory-reducer")
Global $list,$interval

;~~~~Settings~~~~

$list = IniRead(@ScriptDir&"\"&"Reduce Memory.ini","Settings","Processes","")
if $list = "" Then
do
	IniWrite(@ScriptDir&"\"&"Reduce Memory.ini","Settings","Processes","chrome.exe;explorer.exe;svchost.exe;MapleStory.exe")
	$list = IniRead(@ScriptDir&"\"&"Reduce Memory.ini","Settings","Processes","")
until $list <> ""
EndIf
Global $processlist = StringSplit($list, "|;,")

$interval = IniRead(@ScriptDir&"\"&"Reduce Memory.ini","Settings","Interval in Milliseconds","") ; interval at which the memory is freed, anything below this will almost certainly only slow down your system.
if $interval = "" Then
do
	IniWrite(@ScriptDir&"\"&"Reduce Memory.ini","Settings","Interval in Milliseconds","2000")
	$interval = IniRead(@ScriptDir&"\"&"Reduce Memory.ini","Settings","Interval in Milliseconds","")
until $interval <> ""
EndIf

;~~~~Settings~~~~

While 1
	$timer = TimerInit()
	For $i = 1 To $processlist[0]
		$Processes = ProcessList($processlist[$i]) ;get Multiple Processes
		For $i = 1 To $Processes[0][0] ; For Each found unique PID
			_ReduceMemory($Processes[$i][1]) ;Set Priority
		Next
	Next
	_ReduceMemory(4)
	_ReduceMemory() ; also reduce the memory used by the script itself...
	IniWrite(@ScriptDir&"\"&"Reduce Memory.log","Log","Time To Complete",TimerDiff($timer))
	Sleep($interval)
WEnd

Func Bye()
	Exit
EndFunc   ;==>Bye

;I don't remember who was the author of this UDF... (it's not me)
Func _ReduceMemory($i_PID = -1)
	If $i_PID <> -1 Then
		Local $ai_Handle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $i_PID)
		Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', $ai_Handle[0])
		DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $ai_Handle[0])
	Else
		Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', -1)
	EndIf
	Return $ai_Return[0]
EndFunc   ;==>_ReduceMemory