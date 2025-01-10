# Testnet Demo Day # 1: 2024-Feb-7

For our first-ever demo day, we will demonstrate what happens to the depositor account when a proposal does not pass.
We will post announcements in the `testnet-announcements` channel in Discord to coordinate activities during the event.

* Start time: `2023-02-07 15:00 UTC`
* Estimated end time: `2023-02-07 17:00 UTC`

## Recap

* 37 validators participated
* The event runtime was exactly 2 hours
* Five proposals were submitted and voted on to reach a specific outcome:
  * Prop 101: Pass by voting YES
  * Prop 102: Reject by voting NO
  * Prop 103: Reject by voting NO_WITH_VETO
  * Prop 104: Reject by voting ABSTAIN
  * Prop 105: Reject by not voting
* Each proposal was submitted from a different account
* Each proposer account had a starting balance of 11 ATOM
  * Ending balances of proposers for proposals 101, 102, and 104: ~11 ATOM
  * Ending balances of proposers for proposals 103 and 105 : ~1 ATOM (the 10ATOM deposit was burned)

### Lessons learned & findings

* It is possible to vote multiple times while the proposal remains active, and only the last vote will be counted in the tally.
* The Mintscan block explorer will hide proposals that are being vetoed by default, but they can be shown using the "Show All (Include Spam)" checkbox.

## Tasks

All tasks will be performed in the `provider` chain of the [Interchain Security Testnet](/interchain-security/provider/README.md).

* Task 1: Vote YES on proposal [101](https://explorer.ics-testnet.polypore.xyz/provider/gov/101)
* Task 2: Vote NO on proposal [102](https://explorer.ics-testnet.polypore.xyz/provider/gov/102)
* Task 3: Vote NOWITHVETO on proposal [103](https://explorer.ics-testnet.polypore.xyz/provider/gov/103)
* Task 4: Vote ABSTAIN on proposal [104](https://explorer.ics-testnet.polypore.xyz/provider/gov/104)
* Task 5: DO NOT VOTE on proposal [105](https://explorer.ics-testnet.polypore.xyz/provider/gov/105)

## Testnet Incentives Program (TIP) Eligibility

* You must vote (or not vote) according to the tasks listed above.
