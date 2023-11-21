$fontsToCheck = @("Font1.ttf", "Font2.ttf", "Font3.ttf", "Font4.ttf", "Font5.ttf")
$fontsFolder = "$env:windir\Fonts"
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

foreach ($font in $fontsToCheck) {
    $fontPath = Join-Path -Path $fontsFolder -ChildPath $font

    # Check if the font is installed
    if (-not (Test-Path $fontPath)) {
        Write-Host "Installing $font..."
        
        # Copy the font file to the Fonts folder (update the source path of the font file)
        $sourcePath = "C:\Path\To\Font\Files\$font"
        Copy-Item -Path $sourcePath -Destination $fontPath

        # Add a registry entry for the font
        $fontName = $font -replace "\..+$", ""  # Removes file extension
        Set-ItemProperty -Path $registryPath -Name "$fontName (TrueType)" -Value $font
    } else {
        Write-Host "$font is already installed."
    }
}

Write-Host "Font check and installation complete."
