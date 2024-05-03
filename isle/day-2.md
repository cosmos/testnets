
# ISLE Day 2: Two chain launches

For day 2, we will launch a top-N chain and an opt-in one.

* [Tasks and points available](./tasks.md#day-2)

## `test-faroe-1` chain launch 

* Top N = 67 chain

### Schedule

* 13:00: Voting period begins
* 14:00: Voting period ends
* **14:30: Spawn time**
* 14:45: Hypha nodes start
* 15:00: Chain expected to be producing blocks
* 15:30: CCV channel expected to be established
* 16:30: Validators start being rotated in and out of top N
* 14:30 (Day 3): Consumer chain is offboarded

### Instructions

* Set up a node for your validator before the spawn time
  * **`test-faroe-1` chain details will be posted the week of May 6**
* [Vote](./instructions.md#vote-on-a-proposal) YES to the `consumer-addition` proposal
* [Opt-in](./instructions.md#opt-in-to-a-consumer-chain) using a unique pubkey before the spawn time
* Start your validator node after the spawn time
  * The genesis file will be posted to this repo within three minutes after the spawn time
  * Hypha nodes will start 15 minutes after the spawn time
* [Opt-out](./instructions.md#opt-out-from-a-consumer-chain) after the CCV channel is established
* [Opt back in](./instructions.md#opt-in-to-a-consumer-chain) using a unique key after opting out
  * You can re-use the same key you used for this chain before launch
* [Set a commission rate](./instructions.md#set-a-commission-rate-in-a-consumer-chain) before the consumer chain is offboarded

## `test-galapagos-1` chain launch

* Opt-in chain

### Schedule

* 13:00: Voting period begins
* 14:00: Voting period ends
* **15:30: Spawn time**
* 15:45: Hypha nodes start
* 16:00: Chain expected to be producing blocks
* 16:30: CCV channel expected to be established
* 15:30 (Day 3): Consumer chain is offboarded

### Instructions

* Set up a node for your validator before the spawn time
  * **`test-galapagos-1` chain details will be posted the week of May 6**
* [Vote](./instructions.md#vote-on-a-proposal) YES to the `consumer-addition` proposal
* [Opt-in](./instructions.md#opt-in-to-a-consumer-chain) using a unique pubkey before the spawn time
* Start your validator node after the spawn time
  * The genesis file will be posted to this repo within three minutes after the spawn time
  * Hypha nodes will start 15 minutes after the spawn time
* [Opt-out](./instructions.md#opt-out-from-a-consumer-chain) after the CCV channel is established
* [Opt back in](./instructions.md#opt-in-to-a-consumer-chain) using a unique pubkey after opting out
  * You can re-use the same key you used for this chain before launch
* [Set a commission rate](./instructions.md#set-a-commission-rate-in-a-consumer-chain) before the consumer chain is offboarded