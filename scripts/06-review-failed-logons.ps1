
<#
.SYNOPSIS
    Investigates Windows Security Event ID 4625 failed logons.

.DESCRIPTION
    Distinguishes matching events, no matching events,
    access denied, unavailable Security log, and unexpected errors.
#>

[CmdletBinding()]
param(
    [ValidateRange(1, 168)]
    [int]$HoursBack = 2,

    [ValidateRange(1, 100)]
    [int]$MaxEvents = 10
)

$ErrorActionPreference = 'Stop'
$startTime = (Get-Date).AddHours(-$HoursBack)

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host " FAILED LOGON INVESTIGATION - EVENT 4625" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "Computer: $env:COMPUTERNAME"
Write-Host "Time range: Last $HoursBack hour(s)"
Write-Host "Starting: $startTime"
Write-Host "Maximum records: $MaxEvents"

# Step 1: Verify Security log availability
try {
    $securityLog = Get-WinEvent -ListLog Security -ErrorAction Stop

    if (-not $securityLog.IsEnabled) {
        Write-Warning "[SECURITY LOG UNAVAILABLE] The Security log is disabled."
        return
    }
}
catch {
    $message = $_.Exception.Message

    if ($message -match '(?i)access is denied|unauthorized|permission') {
        Write-Warning "[ACCESS DENIED] Cannot inspect the Security log."
    }
    else {
        Write-Warning "[SECURITY LOG UNAVAILABLE] $message"
    }

    return
}

# Step 2: Retrieve failed logon events
try {
    $events = @(
        Get-WinEvent -FilterHashtable @{
            LogName   = 'Security'
            Id        = 4625
            StartTime = $startTime
        } -MaxEvents $MaxEvents -ErrorAction Stop
    )
}
catch {
    $message = $_.Exception.Message
    $exception = $_.Exception

    if (
        $exception -is [System.UnauthorizedAccessException] -or
        $exception -is [System.Security.SecurityException] -or
        $message -match '(?i)access is denied|unauthorized|permission'
    ) {
        Write-Warning "[ACCESS DENIED] You do not have permission to read the Security log."
        Write-Host "Try running PowerShell with an authorized administrative account."
        return
    }

    if ($message -match '(?i)no events were found|no events match') {
        Write-Host "`n[NO MATCHING EVENTS]" -ForegroundColor Yellow
        Write-Host "The Security log was accessible, but no Event ID 4625 records matched the query."
        return
    }

    if ($message -match '(?i)RPC server|service.*not running|channel.*not found|log.*not found|failed to open') {
        Write-Warning "[SECURITY LOG UNAVAILABLE] $message"
        return
    }

    Write-Warning "[UNEXPECTED ERROR] $message"
    return
}

# Step 3: Display matching records
if ($events.Count -eq 0) {
    Write-Host "`n[NO MATCHING EVENTS]" -ForegroundColor Yellow
    Write-Host "The query completed, but no Event ID 4625 records were returned."
    return
}

Write-Host "`n[EVENTS FOUND]" -ForegroundColor Green
Write-Host "Retrieved $($events.Count) failed-logon event(s)."

$events |
    Select-Object TimeCreated, Id, ProviderName, MachineName, Message |
    Format-List

Write-Host "`nInvestigation completed." -ForegroundColor Green
