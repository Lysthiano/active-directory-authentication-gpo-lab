[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Identity
)

Import-Module ActiveDirectory -ErrorAction Stop

Get-ADUser -Identity $Identity -Properties Enabled, LockedOut, PasswordExpired, PasswordLastSet |
    Select-Object Name, SamAccountName, Enabled, LockedOut, PasswordExpired, PasswordLastSet |
    Format-List
