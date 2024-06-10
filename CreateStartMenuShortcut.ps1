param (
    [string]$FilePath
)

# Function to check if the script is running as administrator
function Test-IsAdmin {
    return ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
}

if (-not (Test-IsAdmin)) {
    Start-Process powershell.exe -WindowStyle Hidden -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`" -FilePath `"$FilePath`"" -Verb RunAs
    exit
}

try {
    # Extract the base name of the file without extension
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($FilePath)

    # Define the shortcut path
    $shortcutPath = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$baseName.lnk"

    # Create a shortcut
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $FilePath
    $shortcut.Save()
} catch {
    # Suppress errors
}
