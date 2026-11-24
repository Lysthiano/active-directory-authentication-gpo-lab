# Active Directory Authentication & Group Policy Troubleshooting Lab

A hands-on Windows Server 2022 home lab documenting how to investigate and resolve a domain user's interactive sign-in failure by reviewing Active Directory account state, password policy, group membership, Group Policy, and Windows security events.

> **Lab environment:** Personal virtual lab using Parallels Desktop.  
> **Domain:** `lab.local`  
> **Domain controller:** `LAB-DC01`  
> **Test user:** Michael Brown (`mbrown`)  
> **Tools:** Active Directory PowerShell module, Group Policy Management, `gpresult`, `secedit`, Event Viewer / `Get-WinEvent`.

## Outcome

The test user ultimately signed in successfully to the Windows Server VM. The troubleshooting work included:

- Checking whether the account was enabled, locked out, or password-expired.
- Reviewing the domain password policy and resetting the lab user's password.
- Checking membership in `Domain Users` and `IT_Team`.
- Reviewing the **Allow log on locally** and **Deny log on locally** user-right assignments.
- Refreshing and inspecting Group Policy.
- Verifying successful interactive sign-in.

This is a learning lab, not a production change record. The exact causal change should be described as a Group Policy/logon-rights troubleshooting sequence; do not claim that one isolated setting was proven to be the sole cause unless you reproduce and validate that finding.

## Repository contents

```text
active-directory-authentication-gpo-lab/
├── README.md
├── LICENSE
├── .gitignore
├── docs/
│   ├── troubleshooting-runbook.md
│   └── findings-and-lessons.md
├── scripts/
│   ├── 01-audit-user.ps1
│   ├── 02-reset-user-password.ps1
│   ├── 03-check-group-membership.ps1
│   ├── 04-export-logon-rights.ps1
│   ├── 05-refresh-and-report-gpo.ps1
│   └── 06-review-failed-logons.ps1
└── evidence/
    ├── 01-logon-rights-policy-review.jpeg
    ├── 02-successful-domain-sign-in.jpeg
    └── README.md
```

## Prerequisites

- Windows Server 2022 domain controller in a disposable lab.
- Active Directory Domain Services installed and configured.
- Active Directory PowerShell module available.
- A lab user account such as `lab\mbrown`.
- Administrative access to run the audit and policy commands.
- A snapshot or backup before changing domain security policy.

## Quick start

Run PowerShell as an administrator on `LAB-DC01`.

1. Review the account:

   ```powershell
   .\scripts\01-audit-user.ps1 -Identity mbrown
   ```

2. Review group membership:

   ```powershell
   .\scripts\03-check-group-membership.ps1 -Identity mbrown
   ```

3. Export and inspect effective user-right assignments:

   ```powershell
   .\scripts\04-export-logon-rights.ps1
   ```

4. Refresh policy and collect results:

   ```powershell
   .\scripts\05-refresh-and-report-gpo.ps1
   ```

5. If sign-in attempts failed, inspect recent Security event 4625 records:

   ```powershell
   .\scripts\06-review-failed-logons.ps1
   ```

6. Reset the password only if required:

   ```powershell
   .\scripts\02-reset-user-password.ps1 -Identity mbrown
   ```

Scripts are diagnostic helpers. Read each script before running it. The password reset script changes the selected account's password.

## Important security note

Domain controllers are highly sensitive systems. **Do not broadly grant interactive console logon to `Domain Users` on a production domain controller.** Keep DC interactive logon restricted to specifically authorized administrative roles. This lab uses a controlled test environment to learn how user-right assignments affect sign-in.

Do not commit real passwords, recovery keys, production domain details, or screenshots containing secrets. The screenshots in this repository are from a personal lab and should be reviewed/redacted before public upload.

## Skills demonstrated

- Active Directory account administration
- Identity and Access Management (IAM)
- PowerShell administration and auditing
- Group Policy troubleshooting
- Windows user-right assignments
- Password policy and account-state validation
- Windows Security event investigation
- Authentication troubleshooting and technical documentation

## Evidence

See [`evidence/`](evidence/) for selected screenshots. The images document policy review and the successful sign-in state; they are supporting evidence, not a substitute for reproducible commands and written findings.
