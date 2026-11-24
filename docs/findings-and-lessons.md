# Findings and Lessons Learned

## Lab scenario

A test domain user, Michael Brown (`mbrown`), could not initially complete an interactive sign-in to the Windows Server virtual machine.

## Checks performed

| Area | Investigation | Recorded finding |
|---|---|---|
| Account status | `Get-ADUser` | Account enabled; not locked out in the later verification |
| Password | Password-expiration check and reset workflow | Password expiration was identified earlier in the troubleshooting |
| Group membership | `Get-ADPrincipalGroupMembership` | `Domain Users` and `IT_Team` |
| Logon rights | Group Policy Management / `secedit` | Reviewed Allow log on locally and Deny log on locally |
| Group Policy | `gpupdate` / `gpresult` | Refreshed and reviewed policy application |
| Final test | VM console sign-in | Successful sign-in observed |

## What I learned

1. A sign-in failure should be investigated systematically rather than treated as a password-only problem.
2. Active Directory account state, password policy, group membership, and user-right assignments are separate controls.
3. Group Policy can define interactive logon rights on a domain controller.
4. A deny user-right assignment overrides an allow assignment.
5. `gpresult`, `secedit`, and Security event logs provide evidence to support troubleshooting.
6. Final validation should be performed from the same sign-in path that originally failed.

## Evidence limitations

The screenshots document selected points in the lab. They do not establish every intermediate change or prove that a single setting was solely responsible for the initial failure. A repeatable follow-up test should record the exact GPO, its scope, the affected group, and the corresponding Security event data.

## Production lesson

Interactive logon to domain controllers should be tightly restricted. In a real organization, users should normally sign in to managed workstations, while domain controllers are administered only by authorized personnel using approved administrative access paths.
