# ISLE Testnet 🏝️

Welcome to the **Interchain Security ⚡ Lightning 🌩️ Experiment** testnet!

The ISLE testnet is a one-week incentivized testnet program that will introduce validators to the features in Partial Set Security, also known as Interchain Security 2.0. 

This folder contains the event plan and information on the tasks that must be completed to collect points.

## Partial Set Security

Partial Set Security (PSS) allows consumer chains to set the portion of the validator set they want to secure the chain with. A provider chain has an available voting power of N = 100. Under PSS, consumer chains have an option to launch with different `N` values:

* **Top N** chains
  * `0 < N <= 100`
  * Only the validators in the "top N" must validate in the consumer chain.
  * Validators not in the top N have the option to opt-in before or after the chain launches.
* **Opt-in** chains
  * `N = 0`
  * Participating in the consumer chain is optional for all validators.

## Testnet Events

* The [`provider`](https://github.com/cosmos/testnets/tree/master/interchain-security/provider) chain of the Interchain Security testnet will act as the provider chain for all consumer chains.
  * If you haven't done so, you must [create a validator](https://github.com/cosmos/testnets/blob/master/interchain-security/VALIDATOR_JOINING_GUIDE.md) in the provider chain before the ISLE testnet events begin.
* All events will involve a consumer chain launch and require validators to sign blocks and submit transactions. Some examples include:
  * Voting YES on consumer addition proposals
  * Opting in to consumer chains
  * Signing on the first N blocks of a consumer chain
* The power distribution will be adjusted during the program so that all validators will have the option to opt-out from and opt back into top N chains at some point.
  * Validators will risk being jailed for downtime if they are not running a consumer chain at the time while they are in the top N of the validator set.
* The full list of tasks and associated points can be found [here](./tasks.md). 
* We will compile a list of Frequently Asked Questions regarding PSS and this testnet [here](./FAQ.md).

## Timeline

**⚠️ Please be aware that the schedule, tasks, and point breakdown are subject to change ⚠️** 

* May 13: [Warm-up](./day-1.md)
  * Launch a top N = 80 chain
* May 14: [Two chain launches](./day-2.md)
  * Launch a top N = 67 chain
  * Launch an opt-in chain
* May 15: [No-show chain launch](./day-3.md)
  * Pass an opt-in chain proposal for which nobody opts in
* May 16: [Mainnet chain preview](./day-4.md)
* May 17: [ICS 2.0 playground](./day-5.md)
