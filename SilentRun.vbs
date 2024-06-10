Set objShell = CreateObject("WScript.Shell")
Set args = WScript.Arguments
filePath = args(0)

' Get the path of the current script
scriptPath = WScript.ScriptFullName
scriptPath = Left(scriptPath, InStrRev(scriptPath, "\"))

' Build the command to run the PowerShell script
command = "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & scriptPath & "CreateStartMenuShortcut.ps1"" -FilePath """ & filePath & """"
objShell.Run command, 0, True
