@echo off
SETLOCAL

REM Check if the script is running with administrative privileges
NET SESSION >NUL 2>&1
IF NOT %ERRORLEVEL% EQU 0 (
    ECHO Requesting administrative privileges...
    powershell -Command "Start-Process '%0' -Verb RunAs"
    EXIT /B
)

:: Get the current script directory
SET "scriptDir=%~dp0"

:: Define the paths relative to the script directory
set "iconPath=%scriptDir%shortcut.ico"
set "scriptPath=%scriptDir%SilentRun.vbs"

echo Script directory: %scriptDir%

:: Update the registry with the correct paths
reg add "HKCR\*\shell\Create Start Menu Shortcut" /ve /d "Create Start Menu Shortcut" /f
reg add "HKCR\*\shell\Create Start Menu Shortcut" /v "Icon" /t REG_SZ /d "%iconPath%" /f
reg add "HKCR\*\shell\Create Start Menu Shortcut\command" /ve /d "wscript.exe \"%scriptPath%\" \"%%1\"" /f

:: Clean up temporary files
del "%scriptDir%add_context_menu_temp.reg"

echo Installation completed.

ENDLOCAL
