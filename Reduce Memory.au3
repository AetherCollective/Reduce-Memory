#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Reduce Memory.exe
#AutoIt3Wrapper_Outfile_x64=Reduce Memory_x64.exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_requestedExecutionLevel=highestAvailable
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Misc.au3>
#include <AutoItConstants.au3>
_Singleton("memory-reducer")
Global $list = IniRead(@ScriptDir & "\" & "Reduce Memory.ini", "Settings", "Processes", "empty")
If $list = "empty" Then Exit MsgBox(0, "Reduce Memory", "Unable to read " & @ScriptDir & "\" & "Reduce Memory.ini" & @CRLF & "Please ensure that the file exists and is correctly formatted.")
Global $processlist = StringSplit($list, "|", $STR_NOCOUNT)
Global $interval = IniRead(@ScriptDir & "\" & "Reduce Memory.ini", "Settings", "Interval in Milliseconds", "2000") ; interval at which the memory is freed, anything below this will almost certainly only slow down your system.
While 1
	$timer = TimerInit()
	For $i = 0 To UBound($processlist) - 1
		$Processes = ProcessList($processlist[$i]) ;get PID for Multiple Processes using the process name
		For $i = 0 To UBound($Processes, $UBOUND_ROWS) - 1 ; For each found unique PID
			_ReduceMemory($Processes[$i][1]) ;Reduce memory of PID
		Next
	Next
	_ReduceMemory(4) ; Reduce the memory of the system process.
	_ReduceMemory() ; also reduce the memory used by the script itself...
	IniWrite(@ScriptDir & "\" & "Reduce Memory.log", "Log", "Time To Complete", TimerDiff($timer))
	Sleep($interval)
WEnd

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
