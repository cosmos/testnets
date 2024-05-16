# ISLE Task List 📋

**⚠️ Please be aware that the schedule, tasks and point breakdown are subject to change ⚠️** 

* 30 tasks available
* Maximum score: 129 points

## Day 1

* May 13, 2024
* **20 points available**

### `test-easter-1`

| Task ID | Task                                                                                                  | Completion window starts   | Completion window ends               | Points |
| :------ | :---------------------------------------------------------------------------------------------------- | :------------------------- | :----------------------------------- | :----: |
| 1       | [Vote](./instructions.md#vote-on-a-proposal) YES on consumer-addition proposal                        | Voting period start        | Voting period end                    |   1    |
| 2       | [Assign](./instructions.md#assign-a-consensus-key-for-a-consumer-chain) a unique pubkey before launch | Voting period start        | Spawn time                           |   2    |
| 3       | [Opt in](./instructions.md#opt-in-to-a-consumer-chain) before or after launch                         | Voting period start | Chain is offboarded                  |   5    |
| 4       | Sign within 600 blocks after the CCV channel is established                                           | CCV channel is established | CCV channel established + 600 blocks |   10   |
| 5       | [Set commission rate](./instructions.md#set-a-commission-rate-in-a-consumer-chain)                    | Voting period start        | Chain is offboarded                  |   2    |

## Day 2

* May 14, 2024
* **58 points available**

### `test-faroe-1`

| Task IDs | Task                                                                                                      | Completion window starts   | Completion window ends               | Points |
| :------- | :-------------------------------------------------------------------------------------------------------- | :------------------------- | :----------------------------------- | :----: |
| 6        | [Vote](./instructions.md#vote-on-a-proposal) YES on consumer-addition proposal                            | Voting period start        | Voting period end                    |   1    |
| 7        | [Assign](./instructions.md#assign-a-consensus-key-for-a-consumer-chain) a unique pubkey before launch   | Voting period start        | Spawn time                           |   2    |
| 8        | [Opt in](./instructions.md#opt-in-to-a-consumer-chain) for the first time before or after launch         | Voting period start | Chain is offboarded                  |   5    |
| 9        | Sign within 600 blocks after the CCV channel is established                                               | CCV channel is established | CCV channel established + 600 blocks |   10   |
| 10       | [Opt out](./instructions.md#opt-out-from-a-consumer-chain) after launch                                   | CCV channel is established | Chain is offboarded                  |   5    |
| 11       | [Opt in](./instructions.md#opt-in-to-a-consumer-chain) with a unique pubkey after opting out after launch in a single tx | CCV channel is established | Chain is offboarded                  |   5    |
| 12       | [Set commission rate](./instructions.md#set-a-commission-rate-in-a-consumer-chain)                        | Voting period start        | Chain is offboarded                  |   2    |


### `test-galapagos-1`

| Task IDs | Task                                                                                      | Completion window starts   | Completion window ends | Points |
| :------- | :---------------------------------------------------------------------------------------- | :------------------------- | :--------------------- | :----: |
| 13       | [Vote](./instructions.md#vote-on-a-proposal) YES on consumer-addition proposal            | Voting period start        | Voting period end      |   1    |
| 14       | [Opt in](./instructions.md#opt-in-to-a-consumer-chain) with a unique pubkey before launch in a single tx| Voting period start        | Spawn time             |   5    |
| 15*      | Sign within 10 blocks after the CCV channel is established                                                              | Spawn time                 | CCV channel established + 10 blocks               |   10   |
| 16*      | Sign within 100 blocks after the CCV channel is established                                                              | Spawn time                 | CCV channel established + 100 blocks            |   5    |
| 17       | [Opt out](./instructions.md#opt-out-from-a-consumer-chain) after launch                   | CCV channel is established | Chain is offboarded    |   5    |
| 18       | [Opt in](./instructions.md#opt-in-to-a-consumer-chain) with a unique pubkey after launch in a single tx  | CCV channel is established | Chain is offboarded    |   5    |
| 19       | [Set commission rate](./instructions.md#set-a-commission-rate-in-a-consumer-chain)        | Voting period start        | Chain is offboarded    |   2    |

\* Tasks 15 and 16 are mutually exclusive

## Day 3

* May 15, 2024
* **3 points available**

### `test-hans-1`

| Task IDs | Task                                                                           | Completion window starts         | Completion window ends         | Points |
| :------- | :----------------------------------------------------------------------------- | :------------------------------- | :----------------------------- | :----: |
| 20       | [Vote](./instructions.md#vote-on-a-proposal) YES on consumer-addition proposal | Voting period start / ~13:00 UTC | Voting period end / ~14:00 UTC |   1    |
| 21       | Do NOT opt in                                                                  | Voting period start / ~13:00 UTC | Voting period end / ~14:00 UTC |   2    |

## Day 4

* May 16, 2024
* **18 points available**

### `test-ibiza-1`

| Task IDs | Task                                                                                      | Completion window starts   | Completion window ends | Points |
| :------- | :---------------------------------------------------------------------------------------- | :------------------------- | :--------------------- | :----: |
| 22       | [Vote](./instructions.md#vote-on-a-proposal) YES on consumer-addition proposal            | Voting period start        | Voting period end      |   1    |
| 23+      | [Opt in](./instructions.md#opt-in-to-a-consumer-chain) with a unique pubkey before launch in a single tx | Voting period start        | Spawn time             |   5    |
| 24*      | Sign within 10 blocks after the CCV channel is established                                                                | Spawn time                 | CCV channel established + 10 blocks               |   10   |
| 25*      | Sign within 100 blocks after the CCV channel is established                                                             | Spawn time                 | CCV channel established + 100 blocks              |   5    |
| 26+      | [Opt in](./instructions.md#opt-in-to-a-consumer-chain) with a unique pubkey after launch in a single tx  | CCV channel is established | Chain is offboarded    |   2    |
| 27       | [Set commission rate](./instructions.md#set-a-commission-rate-in-a-consumer-chain)        | Voting period start        | Chain is offboarded    |   2    |

\+ Tasks 23 and 26 are mutually exclusive: only one opt-in transaction will be counted  
\* Tasks 24 and 25 are mutually exclusive

## Day 5

* May 17, 2024
* **10 points available**

### `test-java-1`

| Task IDs | Task                                                                                     | Completion window starts   | Completion window ends | Points |
| :------- | :--------------------------------------------------------------------------------------- | :------------------------- | :--------------------- | :----: |
| 28*      | Sign within 2400 blocks after the CCV channel is established                                                              | Spawn time                 | CCV channel established + 2400 blocks               |   10   |

\* It is intentional that there are no points for opting-in or assigning a unique key. We hope you will use what you've learned and do those operations properly, but the only thing that counts is that you actually sign blocks for `test-java-1`

## ISLE-wide tasks

* **20 points available**

| Task IDs | Task                | Completion window starts  | Completion window ends            | Points |
| :------- | :------------------ | :------------------------ | :-------------------------------- | :----: |
| 29+      | Do not get jailed   | Day 1 voting period start | `test-ibiza-1` is offboarded |   10   |
| 30*      | High achiever bonus | Day 1 voting period start | `test-java-1` is offboarded |   10   |

\+ Must remain unjailed for the whole week *excluding* `test-java-1` 

\* Participants who complete day 5 with a full score will get an additional 10 points.
