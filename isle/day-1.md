# ISLE Day 1: Warm-up

Day 1 will involve launching a single top-N chain to introduce Partial Set Security to the testnet.

* [Tasks and points available](./tasks.md#day-1)

## `test-easter-1` chain launch

* Top N = 80 chain

### Schedule

* 13:30: Voting period begins for consumer-addition proposal
* 14:30: Voting period ends for consumer-addition proposal
* **15:00: Spawn time**
* 15:15: Hypha nodes start
* 15:30: Chain expected to be producing blocks
* 16:00: CCV channel expected to be established
* 17:00: Validators start being rotated in and out of top N
* 15:00 (Day 2): Consumer chain is offboarded via consumer-removal proposal

### Instructions

* Set up a node for your validator before the spawn time
  * **`test-easter-1` chain details will be posted the week of May 6**
* [Vote](./instructions.md#vote-on-a-proposal) YES to the `consumer-addition` proposal
* [Assign a consensus key](./instructions.md#assign-a-consensus-key-for-a-consumer-chain) using a unique pubkey before the spawn time
* Start your validator node after the spawn time
  * The genesis file will be posted to this repo within three minutes after the spawn time
  * Hypha nodes will start 15 minutes after the spawn time
* [Opt-in](./instructions.md#opt-in-to-a-consumer-chain) after the CCV channel is established
* [Set a commission rate](./instructions.md#set-a-commission-rate-in-a-consumer-chain) before the consumer chain is offboarded