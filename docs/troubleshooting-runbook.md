# Troubleshooting Runbook

## 1. Confirm the sign-in context

At the Windows sign-in screen, choose **Other user** and use the domain-qualified account:

```text
LAB\mbrown
```

Use the current password for the lab account. The display name (`Michael Brown`) is not necessarily the account logon name.

## 2. Check the account state

```powershell
Get-ADUser mbrown -Properties Enabled,LockedOut,PasswordExpired,PasswordLastSet |
    Select-Object Name,SamAccountName,Enabled,LockedOut,PasswordExpired,PasswordLastSet
```

Interpretation:

- `Enabled = False`: account is disabled.
- `LockedOut = True`: account is locked out.
- `PasswordExpired = True`: password must be changed.
- `PasswordLastSet`: confirms when the password was last set.

Do not assume a failed sign-in is caused by the password alone.

## 3. Review the domain password policy

```powershell
Get-ADDefaultDomainPasswordPolicy | Format-List *
```

Review minimum length, complexity, password history, maximum age, and lockout settings.

If a password reset is necessary, use the secure prompt in `scripts/02-reset-user-password.ps1`. Never place a plaintext password in a script, command history, screenshot, or Git repository.

## 4. Check group membership

```powershell
Get-ADPrincipalGroupMembership mbrown | Select-Object Name
```

Confirm the intended groups exist and that the user is a member. A group membership does not automatically guarantee a local interactive logon right; effective policy still matters.

## 5. Inspect interactive logon user rights

Open Group Policy Management and inspect the GPOs that apply to the domain controller:

```text
Computer Configuration
  > Policies
    > Windows Settings
      > Security Settings
        > Local Policies
          > User Rights Assignment
```

Review:

- **Allow log on locally**
- **Deny log on locally**

A deny assignment takes precedence over an allow assignment. Review the actual user and nested group memberships before changing either setting.

Export the effective security policy for inspection:

```powershell
secedit /export /cfg C:\secpol.cfg
Select-String C:\secpol.cfg -Pattern 'SeInteractiveLogonRight|SeDenyInteractiveLogonRight'
```

The exported values may be represented as SIDs. Resolve SIDs before deciding whether a user or group is included.

## 6. Refresh and report Group Policy

```powershell
gpupdate /force
gpresult /scope computer /r
gpresult /scope user /r
```

Run `gpresult` in the context relevant to the question. On a domain controller, computer policy and user policy results are separate sections. Check the applied GPO list, filtering, and the time policy was last applied.

## 7. Review failed logon events

Security event **4625** records failed logons. Run:

```powershell
Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    Id        = 4625
    StartTime = (Get-Date).AddHours(-2)
} -MaxEvents 10 | Format-List TimeCreated, Id, Message
```

Review the account name, logon type, status, and substatus. Correlate the event timestamp with the sign-in attempt. Event **4624** can help confirm a successful logon.

## 8. Verify the outcome

After the change:

1. Return to the VM console.
2. Sign in as `LAB\mbrown`.
3. Confirm the desktop loads.
4. Capture a screenshot that does not expose the password.
5. Record exactly which policy or account setting changed and how it was validated.

## Troubleshooting cautions

- Do not add broad groups such as `Domain Users` to DC console logon rights as a convenience.
- Do not remove deny rights without understanding why they exist.
- Avoid editing the Default Domain Controllers Policy unless the lab specifically requires it; use a dedicated test GPO where possible.
- Take a VM snapshot before changing policy.
- A successful sign-in proves the final state works; it does not by itself prove which single setting caused the original failure.
