# Active Directory Evidence Index

| File | Presentation title | What it demonstrates |
|---|---|---|
| `screenshots/2026-11-23-session/01-client-sign-in-screen-before-domain-session.png` | **Client Sign In Screen Before Domain Session** | Client sign-in screen; context for the authentication test. |
| `screenshots/2026-11-23-session/02-domain-controller-account-state-query.png` | **Domain Controller Account State Query** | PowerShell query of Alex Johnson account state and locked-account search. |
| `screenshots/2026-11-23-session/03-account-lockout-state-and-bad-password-count.png` | **Account Lockout State And Bad Password Count** | Account query showing LockedOut=True and badPwdCount=5. |
| `screenshots/2026-11-23-session/04-account-lockout-event-4740-correlation.png` | **Account Lockout Event 4740 Correlation** | Account lockout state and Event ID 4740 investigation. |
| `screenshots/2026-11-23-session/05-client-password-change-prompt.png` | **Client Password Change Prompt** | Client sign-in prompt indicating password change is required. |
| `screenshots/2026-11-23-session/06-domain-controller-event-4740-details.png` | **Domain Controller Event 4740 Details** | Domain Controller Security log details for Event ID 4740. |
| `screenshots/2026-11-23-session/07-client-domain-user-session-verification.png` | **Client Domain User Session Verification** | Client session showing domain user context and logon server checks. |
| `screenshots/2026-11-23-session/08-administrator-unlock-and-account-recovery.png` | **Administrator Unlock And Account Recovery** | Unlock-ADAccount workflow and verification that LockedOut=False. |
| `screenshots/2026-11-23-session/09-client-domain-session-after-recovery.png` | **Client Domain Session After Recovery** | Client-side domain user and logon server verification after recovery. |
| `screenshots/2026-11-23-session/10-successful-network-logon-event-4624.png` | **Successful Network Logon Event 4624** | Event ID 4624 details for a successful network logon. |
| `screenshots/2026-11-23-session/11-account-lockout-event-4740-caller-computer.png` | **Account Lockout Event 4740 Caller Computer** | Event ID 4740 showing alex.johnson and caller LAB-CLIENT01. |
| `screenshots/2026-11-23-session/12-client-group-policy-and-domain-password-policy-check.png` | **Client Group Policy And Domain Password Policy Check** | Client gpresult output and domain password policy query. |
| `screenshots/2026-11-23-session/13-repeat-account-lockout-event-4740-review.png` | **Repeat Account Lockout Event 4740 Review** | Additional Event ID 4740 event review. |
| `screenshots/2026-11-23-session/14-account-unlocked-and-bad-password-count-reset.png` | **Account Unlocked And Bad Password Count Reset** | Account state query showing LockedOut=False and badPwdCount=0. |
| `screenshots/2026-11-23-session/15-client-group-policy-results-review.png` | **Client Group Policy Results Review** | Client-side Group Policy results and domain policy command output. |
| `screenshots/2026-11-23-session/16-account-state-and-successful-logon-event-review.png` | **Account State And Successful Logon Event Review** | Account state verification and recent Event ID 4624 records. |
| `screenshots/2026-11-23-session/17-client-domain-identity-and-secure-channel-check.png` | **Client Domain Identity And Secure Channel Check** | Client whoami, logon server, and secure-channel test commands. |
| `screenshots/2026-11-23-session/18-final-client-domain-session-verification.png` | **Final Client Domain Session Verification** | Final client-side domain identity and logon-server verification. |

| `screenshots/2026-11-24-session/19-client-domain-identity-and-secure-channel-verification.jpg` | **Client Domain Identity And Secure Channel Verification** | Client `whoami` output identifies `LAB\alex.johnson`; `LOGONSERVER` points to `\\LAB-DC01`; Test-ComputerSecureChannel returns True and reports a healthy secure channel. |
| `screenshots/2026-11-24-session/20-domain-controller-account-state-and-successful-logon-review.jpg` | **Domain Controller Account State And Successful Logon Review** | Domain controller query shows the account enabled, not locked out, and `badPwdCount=0`; Security log query displays successful Event ID 4624 logons. |
