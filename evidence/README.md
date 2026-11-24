# Active Directory Account Lockout Investigation & Help Desk Recovery

Repository: https://github.com/Lysthiano/active-directory-account-lockout-lab

This evidence package organizes the captured Windows Server 2022 / Windows client lab screenshots for the `lab.local` domain. The test account shown in the lab is `alex.johnson`; the domain controller is `LAB-DC01`, and the client is `LAB-CLIENT01`.

## Evidence highlights

- Domain password and account-lockout policy validation: minimum password length 12, password history 10, maximum password age 90 days, lockout threshold 5 attempts, lockout duration 15 minutes, and observation window 15 minutes.
- Account lockout observed for `alex.johnson`, including Event ID **4740** and caller computer `LAB-CLIENT01`.
- Account recovery performed with `Unlock-ADAccount`; subsequent checks show `LockedOut=False` and `badPwdCount=0`.
- Successful logon evidence includes Event ID **4624**.
- Client domain identity and secure-channel verification are included.

## Folder guide

- `screenshots/curated/` — six previously selected, presentation-ready screenshots.
- `screenshots/2026-11-23-session/` — timestamped evidence from the November 23 lab session, arranged in investigation order.
- `EVIDENCE-INDEX.md` — presentation titles and a short description for each November 23 capture.

## Evidence gaps / accuracy notes

The supplied captures establish Events **4740** and **4624**. They do **not** currently establish a captured Event ID **4625** failed-logon record, nor do they prove Events 4771 or 4776. Add those screenshots only after collecting them from the appropriate Security logs. Some captures show Group Policy results with no domain GPO listed as applied; do not describe a domain GPO as successfully applied based on these screenshots.

## Suggested README embeds

Use relative paths from the repository root, for example:

```markdown
![Account lockout event 4740](screenshots/2026-11-23-session/11-account-lockout-event-4740-caller-computer.png)
![Account recovery verification](screenshots/2026-11-23-session/14-account-unlocked-and-bad-password-count-reset.png)
![Successful logon event 4624](screenshots/2026-11-23-session/10-successful-network-logon-event-4624.png)
```


## Additional evidence captured November 24, 2026

- Client-side identity and domain controller secure-channel validation.
- Domain-controller account recovery state (`LockedOut=False`, `badPwdCount=0`).
- Recent successful authentication records (Event ID 4624).

