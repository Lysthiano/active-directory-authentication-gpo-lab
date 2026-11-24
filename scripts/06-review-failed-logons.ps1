[CmdletBinding()]
param(
    [ValidateRange(1, 168)]
    [int]$HoursBack = 2,

    [ValidateRange(1, 100)]
    [int]$MaxEvents = 10
)

$startTime = (Get-Date).AddHours(-$HoursBack)

Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    Id        = 4625
    StartTime = $startTime
} -MaxEvents $MaxEvents -ErrorAction SilentlyContinue |
    Select-Object TimeCreated, Id, ProviderName, Message |
    Format-List
