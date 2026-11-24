[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Identity
)

Import-Module ActiveDirectory -ErrorAction Stop

$securePassword = Read-Host "Enter a new password for $Identity" -AsSecureString

if ($PSCmdlet.ShouldProcess($Identity, "Reset Active Directory password")) {
    Set-ADAccountPassword -Identity $Identity -Reset -NewPassword $securePassword -ErrorAction Stop
    Write-Host "Password reset command completed for $Identity." -ForegroundColor Green
}
