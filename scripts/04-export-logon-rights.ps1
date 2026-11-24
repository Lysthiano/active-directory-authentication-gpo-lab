[CmdletBinding()]
param(
    [string]$OutputPath = 'C:\secpol-lab-export.cfg'
)

$directory = Split-Path -Parent $OutputPath
if ($directory -and -not (Test-Path -LiteralPath $directory)) {
    New-Item -ItemType Directory -Path $directory -Force | Out-Null
}

secedit.exe /export /cfg $OutputPath
if ($LASTEXITCODE -ne 0) {
    throw "secedit export failed with exit code $LASTEXITCODE"
}

Write-Host "`nExported policy to: $OutputPath" -ForegroundColor Green
Write-Host "`nInteractive logon user-right assignments:"
Select-String -Path $OutputPath -Pattern 'SeInteractiveLogonRight|SeDenyInteractiveLogonRight'

Write-Host "`nNote: exported entries can contain SIDs. Resolve them before interpreting membership."
