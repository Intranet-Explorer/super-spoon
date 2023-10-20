$targetComputer = "\\FriendComputerName"

# Define the dancing banana frames
$frames = @(
    "   / \ ",
    "  |   |",
    "  \___/",
    "   / \ ",
    "  |   |",
    "  \___/",
    "   / \ ",
    "  |   |",
    "  \___/"
)

# Clear the console screen
Invoke-Command -ComputerName $targetComputer -ScriptBlock {
    Clear-Host
}

# Display the dancing banana
While ($true) {
    ForEach ($frame in $frames) {
        Invoke-Command -ComputerName $targetComputer -ScriptBlock {
            Write-Host "$using:frame" -ForegroundColor Yellow
        }
        Start-Sleep -Milliseconds 250  # Adjust animation speed as desired
        Invoke-Command -ComputerName $targetComputer -ScriptBlock {
            Clear-Host
        }
    }
}
