# Findings and Lessons Learned

## Scenario 1 — Interactive Authentication and Group Policy Troubleshooting

**Test user:** Michael Brown (`mbrown`)  
**Domain:** `lab.local`  
**Domain controller:** `LAB-DC01`

### Incident Summary

A domain user, Michael Brown, initially experienced an interactive sign-in failure when attempting to access the Windows Server virtual machine.

The investigation focused on determining whether the issue involved Active Directory account status, password requirements, group membership, or Windows interactive logon permissions.

This investigation is the original authentication and Group Policy lab scenario. It is separate from the later Alex Johnson account-lockout recovery exercise documented in the repository's evidence folder.

## Investigation and Findings

| Area | Investigation | Recorded finding |
|---|---|---|
| Account status | `Get-ADUser` | Account enabled and not locked out during later verification |
| Password policy | `Get-ADDefaultDomainPasswordPolicy` | Password expiration was identified during troubleshooting |
| Password recovery | Password reset workflow | Password reset was part of the troubleshooting process |
| Group membership | `Get-ADPrincipalGroupMembership` | Membership included `Domain Users` and `IT_Team` |
| Logon permissions | Group Policy Management | Reviewed Allow log on locally and Deny log on locally |
| Security policy | `secedit` | Exported and reviewed effective user-right assignments |
| Group Policy | `gpupdate` and `gpresult` | Policy refresh and results review performed |
| Final validation | Windows VM console | Successful interactive sign-in documented |

## Troubleshooting Approach

The investigation followed a structured troubleshooting process:

1. Checked the Active Directory account's enabled and locked-out status.
2. Reviewed password expiration and domain password policy.
3. Verified the user's group memberships.
4. Inspected interactive logon user-right assignments.
5. Reviewed Group Policy configuration and results.
6. Performed the required account and policy troubleshooting.
7. Retested interactive sign-in.

## Outcome

A successful interactive domain sign-in was documented following the troubleshooting sequence.

The evidence supports the successful final state and selected investigation steps. However, the available screenshots do not independently establish one specific policy setting as the sole root cause.

**Root cause status:** Not conclusively isolated.

## Lessons Learned

1. Authentication failures should be investigated systematically rather than automatically attributed to incorrect passwords.
2. Active Directory account status, password policies, group membership, and user-right assignments are separate security controls.
3. Group Policy can affect interactive sign-in permissions on Windows systems.
4. Deny user-right assignments take precedence over corresponding allow assignments.
5. PowerShell, `gpresult`, `secedit`, and Windows Security logs provide complementary troubleshooting information.
6. Successful validation should use the same sign-in path that originally failed.
7. Documentation should distinguish observed evidence from assumptions about root cause.

## Evidence Limitations

The screenshots document selected checkpoints in the investigation. They do not establish every intermediate change or prove that one specific configuration change independently resolved the original issue.

A repeatable follow-up test should record:

- The exact policy or account setting changed.
- The GPO responsible for the effective setting.
- The affected user or security group.
- The corresponding Security event records.
- The result of a controlled before-and-after sign-in test.

## Production Security Considerations

Domain controllers are highly sensitive systems.

Interactive logon permissions should be restricted to authorized administrative roles. Broadly granting `Domain Users` interactive console access on a production domain controller is not an appropriate troubleshooting solution.

A dedicated test GPO, controlled test accounts, and VM snapshots should be used when experimenting with security settings.

---

**Related documentation:** [Troubleshooting Runbook](troubleshooting-runbook.md)

**Scenario distinction:** This document covers Michael Brown (`mbrown`). Alex Johnson (`alex.johnson`) is documented separately in the account-lockout evidence package.
