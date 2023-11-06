# Define the process name
$processName = ''

# Get the list of all running processes with the specified name
$runningProcesses = Get-Process | Where-Object { $_.Name -eq $processName }

# Check if the process is running
if ($runningProcesses) {
    # Stop the running processes
    $runningProcesses | Stop-Process -Force
    Write-Output "Process '$processName.exe' has been stopped."
} else {
    Write-Output "Process '$processName.exe' is not running."
}
