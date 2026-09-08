param(
    [string]$ProjectPath = (Resolve-Path (Join-Path $PSScriptRoot "..")),
    [string]$UnityVersion = "6000.0.83f1"
)

$ErrorActionPreference = "Stop"
$editor = Join-Path ${env:ProgramFiles} "Unity\Hub\Editor\$UnityVersion\Editor\Unity.exe"

if (-not (Test-Path $editor)) {
    throw "Unity $UnityVersion was not found at $editor. Install that exact version in Unity Hub first."
}

$manifest = Join-Path $ProjectPath "Packages\manifest.json"
$settings = Join-Path $ProjectPath "ProjectSettings\McpUnitySettings.json"
if (-not (Test-Path $manifest)) { throw "Not a Unity project: $ProjectPath" }
if (-not (Test-Path $settings)) { throw "Missing MCP settings: $settings" }

$dependency = Select-String -Path $manifest -SimpleMatch '"com.gamelovers.mcp-unity"'
if (-not $dependency) { throw "The pinned MCP Unity package is missing from Packages/manifest.json." }

Write-Host "Opening Unity $UnityVersion with MCP bound to localhost:8090..."
Start-Process -FilePath $editor -ArgumentList @("-projectPath", $ProjectPath)

$deadline = (Get-Date).AddMinutes(5)
do {
    Start-Sleep -Seconds 3
    $listening = Test-NetConnection -ComputerName 127.0.0.1 -Port 8090 -InformationLevel Quiet -WarningAction SilentlyContinue
} until ($listening -or (Get-Date) -ge $deadline)

if (-not $listening) {
    throw "Unity opened, but MCP did not listen on localhost:8090 within five minutes. Check Tools > MCP Unity > Server Window and the Console."
}

Write-Host "MCP Unity is listening locally on 127.0.0.1:8090."
Write-Host "Keep Allow Remote Connections disabled; Hermes connectivity must use an encrypted tunnel."