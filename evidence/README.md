# Active Directory Evidence Index

This index documents the screenshots collected during the Alex Johnson (`alex.johnson`) account-lockout and help desk recovery investigation.

**Domain:** `lab.local`  
**Domain Controller:** `LAB-DC01`  
**Client:** `LAB-CLIENT01`  
**Test User:** `alex.johnson`

> All screenshot paths below are relative to the repository root. The images are stored directly in `evidence/`, not in separate session subdirectories.

## November 23, 2026 — Account Lockout Investigation

| Evidence file | Presentation title | What it demonstrates |
|---|---|---|
| `evidence/01-client-sign-in-screen-before-domain-session.png` | Client Sign-In Screen | Initial client sign-in context |
| `evidence/02-domain-controller-account-state-query.png` | Domain Controller Account State | Active Directory account investigation |
| `evidence/03-account-lockout-state-and-bad-password-count.png` | Account Lockout State | LockedOut=True and badPwdCount=5 |
| `evidence/04-account-lockout-event-4740-correlation.png` | Lockout Event Correlation | Account lockout investigation |
| `evidence/05-client-password-change-prompt.png` | Password Change Prompt | Client password-change requirement |
| `evidence/06-domain-controller-event-4740-details.png` | Event ID 4740 Details | Domain controller Security event review |
| `evidence/07-client-domain-user-session-verification.png` | Domain User Session | Client domain identity and logon server |
| `evidence/08-administrator-unlock-and-account-recovery.png` | Account Recovery | Unlock-ADAccount workflow |
| `evidence/09-client-domain-session-after-recovery.png` | Client Session After Recovery | Client authentication after recovery |
| `evidence/10-successful-network-logon-event-4624.png` | Successful Logon Event | Event ID 4624 |
| `evidence/11-account-lockout-event-4740-caller-computer.png` | Lockout Caller Computer | Event ID 4740 identifying LAB-CLIENT01 |
| `evidence/12-client-group-policy-and-domain-password-policy-check.png` | Policy Verification | Client Group Policy and password policy review |
| `evidence/13-repeat-account-lockout-event-4740-review.png` | Repeat Lockout Event Review | Additional Event ID 4740 investigation |
| `evidence/14-account-unlocked-and-bad-password-count-reset.png` | Recovery Verification | LockedOut=False and badPwdCount=0 |
| `evidence/15-client-group-policy-results-review.png` | Group Policy Results | Client-side policy results |
| `evidence/16-account-state-and-successful-logon-event-review.png` | Account and Logon Review | Account state and Event ID 4624 |
| `evidence/17-client-domain-identity-and-secure-channel-check.png` | Secure Channel Verification | Client identity and secure-channel test |
| `evidence/18-final-client-domain-session-verification.png` | Final Client Session | Final domain identity and logon server verification |

## November 24, 2026 — Additional Validation

| Evidence file | Presentation title | What it demonstrates |
|---|---|---|
| `evidence/20-domain-controller-account-state-and-successful-logon-review.jpg` | Domain Controller Final Review | Account enabled, unlocked, badPwdCount=0, and successful Event ID 4624 records |

## Evidence Interpretation

The collected evidence supports the following conclusions:

1. The account experienced a lockout documented by Event ID 4740.
2. The caller computer was identified as `LAB-CLIENT01`.
3. Administrative account recovery was performed.
4. The account was subsequently verified as unlocked.
5. The bad password count was reset to zero.
6. Successful authentication was documented through Event ID 4624.
7. Client domain identity and secure-channel verification were performed.

## Evidence Limitations

The available screenshots do not establish:

- A captured Event ID 4625 failed-logon record.
- Event ID 4771 Kerberos pre-authentication failure.
- Event ID 4776 credential validation failure.
- Successful application of a domain GPO where the captured results do not demonstrate it.

These should only be added when supporting evidence is collected.

## Repository Organization

All indexed screenshots are currently stored directly in:

`evidence/`

The original Michael Brown authentication and Group Policy screenshots are retained in the same directory but belong to Scenario 1, not this account-lockout investigation.

The index should be updated whenever new evidence is added or existing evidence is renamed.
