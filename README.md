# Active Directory Authentication & Account Lockout Troubleshooting Lab

A hands-on Windows Server 2022 home lab documenting two separate Active Directory troubleshooting scenarios involving authentication, Group Policy, account lockouts, and identity management.

## Lab Environment

- Domain: `lab.local`
- Domain Controller: `LAB-DC01`
- Client: `LAB-CLIENT01`
- Platform: Virtualized Windows Server environment
- Tools: Active Directory PowerShell, Group Policy Management, Event Viewer, `gpresult`, and `secedit`

---

## Project Overview: Two Separate Scenarios

**Important:** This repository documents two different troubleshooting exercises. They involve different test accounts and must not be presented as one continuous incident.

### Scenario 1: Interactive Authentication & Group Policy Troubleshooting

**Test User:** Michael Brown (`mbrown`)

**Problem:** The user experienced an interactive Windows sign-in failure.

Investigation included:
- Active Directory account status verification.
- Password expiration and password policy review.
- Group membership verification.
- Allow Log on Locally policy inspection.
- Deny Log on Locally policy inspection.
- Group Policy refresh and review.
- Interactive sign-in validation.

**Outcome:** Successful interactive domain sign-in was documented.

**Evidence:** 
- `evidence/01-logon-rights-policy-review.jpeg`
- `evidence/02-successful-domain-sign-in.jpeg`

The available evidence documents the troubleshooting process and successful outcome. It does not independently establish one setting as the sole cause of the original failure.

### Scenario 2: Active Directory Account Lockout & Help Desk Recovery

**Test User:** Alex Johnson (`alex.johnson`)

**Problem:** The domain account experienced repeated authentication failures and became locked out.

Investigation included:
- Domain password policy validation.
- Account lockout threshold and duration review.
- Security Event ID 4740 investigation.
- Identification of the calling computer (`LAB-CLIENT01`).
- Account recovery using `Unlock-ADAccount`.
- Verification of account status and bad password count.
- Successful authentication validation using Event ID 4624.

**Outcome:** The account was unlocked, the bad password count was reset, and subsequent successful authentication was documented.

**Important evidence limitations:**
- Event ID 4740 confirms the account lockout.
- Event ID 4624 documents successful authentication.
- Do not claim Event ID 4625, 4771, or 4776 evidence unless the corresponding records are captured.
- Do not claim successful domain GPO application where the screenshots do not establish it.

See:
- `evidence/README.md`
- `evidence/EVIDENCE-INDEX.md`

---

## Repository Structure

```text
active-directory-authentication-gpo-lab/
│
├── README.md
├── LICENSE
│
├── docs/
│   ├── troubleshooting-runbook.md
│   └── findings-and-lessons.md
│
├── scripts/
│   ├── 01-audit-user.ps1
│   ├── 02-reset-user-password.ps1
│   ├── 03-check-group-membership.ps1
│   ├── 04-export-logon-rights.ps1
│   ├── 05-refresh-and-report-gpo.ps1
│   └── 06-review-failed-logons.ps1
│
└── evidence/
    ├── README.md
    ├── EVIDENCE-INDEX.md
    └── screenshots and investigation evidence
```

## Technical Skills Demonstrated

- Active Directory administration
- Identity and Access Management (IAM)
- Windows Server 2022
- PowerShell scripting
- Group Policy troubleshooting
- Password and account-lockout policies
- Windows Security event investigation
- Authentication troubleshooting
- Help Desk incident documentation
- Technical evidence collection

## Security Considerations

This is a controlled personal lab, not a production environment.

- Never broadly grant Domain Users interactive logon access to domain controllers.
- Restrict domain controller access to authorized administrators.
- Review deny and allow user-right assignments before changing policies.
- Use VM snapshots before security-policy modifications.
- Never commit passwords, recovery keys, or sensitive production information.

## Project Conclusion

This project demonstrates two distinct Active Directory support workflows.

The first focuses on investigating interactive authentication and Group Policy issues involving Michael Brown.

The second demonstrates account-lockout investigation, event correlation, account recovery, and successful authentication involving Alex Johnson.

Together, these exercises demonstrate practical Windows administration, IAM, troubleshooting, and entry-level IT support skills.
