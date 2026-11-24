
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Identity
)

Import-Module ActiveDirectory -ErrorAction Stop

$securePassword = Read-Host "Enter a new password for $Identity" -AsSecureString

if ($PSCmdlet.ShouldProcess($Identity, "Reset password and require change at next logon")) {
    try {
        Set-ADAccountPassword -Identity $Identity `
            -Reset `
            -NewPassword $securePassword `
            -ErrorAction Stop

        Set-ADUser -Identity $Identity `
            -ChangePasswordAtLogon $true `
            -ErrorAction Stop

        Write-Host "Password reset completed." -ForegroundColor Green
        Write-Host "Password change at next logon enabled."
    }
    catch {
        Write-Error "Password reset workflow failed: $_"
        throw
    }
}
