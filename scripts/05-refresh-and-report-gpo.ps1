[CmdletBinding()]
param()

Write-Host "Refreshing Group Policy..." -ForegroundColor Cyan
gpupdate.exe /force
if ($LASTEXITCODE -ne 0) {
    Write-Warning "gpupdate returned exit code $LASTEXITCODE"
}

Write-Host "`nComputer policy summary:" -ForegroundColor Cyan
gpresult.exe /scope computer /r

Write-Host "`nUser policy summary:" -ForegroundColor Cyan
gpresult.exe /scope user /r
