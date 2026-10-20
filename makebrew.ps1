param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Packages
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "MAKEBREW: WinGet is not installed."
}

if ($Packages.Count -eq 0) {
    Write-Host "Usage: makebrew <software|command>"
    exit 2
}

$action = $Packages[0]
$rest = @($Packages | Select-Object -Skip 1)

switch ($action) {
    "update"    { & winget source update @rest }
    "upgrade"   { & winget upgrade --all @rest }
    "list"      { & winget list @rest }
    "search"    { & winget search @rest }
    "uninstall" { & winget uninstall @rest }
    default     { & winget install --name $action @rest }
}

exit $LASTEXITCODE
