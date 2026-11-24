[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Identity
)

Import-Module ActiveDirectory -ErrorAction Stop

Get-ADPrincipalGroupMembership -Identity $Identity |
    Sort-Object Name |
    Select-Object Name, GroupScope, GroupCategory, DistinguishedName |
    Format-Table -AutoSize
