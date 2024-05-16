# Frequently Asked Questions

## Day 3: launching `test-ibiza-1`
### Is the minimum commission parameter on the `provider` inherited by the consumer chain?
Yes -- while validators can set a per-chain commission rate on consumer chains, that commission rate must be >= than the minimum commission on the provider.

On the Hub, our min commission right now is 5% so all consumer chain commissions will need to be >5%.

## Day 2: launching `test-faroe-1` and `test-galapagos-1`
### What would happen if you’re validating an opt-in chain and assign a new pubkey without opting out?
You would continue validating that chain with the new pubkey as soon as the next valset update is sent over the CCV channel.

### When does the change take effect when a validator opts out?
Valset updates are communicated via the CCV channel, and the epoch on which they are communicated is set on the provider side. For the ICS testnet, our epoch is 50 blocks (or ~5min) so changes in voting power are only communicated every 5 min.

### What happens to the chain and valset if a Top N consumer chain is offboarded by the Hub?
If a consumer-removal governance proposal passes, the following will happen:

On the provider side
* The CCV channel will be closed.
* The consumer chain will no longer be listed as a consumer chain.

On the consumer side
* The CCV channel will be closed.    The chain will continue producing blocks until it loses enough voting power.
* The chain will stop receiving validator set updates.
* The log will output the following line on every block:

    `ERR CCV channel "channel-0" was closed - shutdown consumer chain since it is not secured anymore module=x/host-ccvconsumer`



## Day 1: launching `test-easter-1`

### What does ‘Top N’ mean?
It means that only the top N% of the validator set will be automatically included in the validator set of the consumer chain and required to run it (otherwise they will be slashed). This is similar to how Neutron and Stride (using Replicated Security with a 5% soft opt-out) require 95% of the Hub’s validator set to run those consumer chains or face slashing penalties. The remaining 5% of the set can choose to validate if they wish, but are not required to do so.

### How do I calculate if I’m in the top N or not?
The percentage in Top N refers to the voting power percentage, not the number of validators. 

So if there are 180 validators in the active set on the Hub and we have a Top N=80% chain, you would check to see if your voting power is in the top 80% of the active set. 

It does NOT refer to the rank! This is important!

### Can chains change their N number?
Not right now! It’s on the roadmap for ICS 2.0 though.

The logic for setting the N parameter for a consumer chain occurs on the provider side so it could be adjusted via a state migration on the provider if absolutely necessary.

### What different ways are there to opt-in to a consumer chain with an assigned key?
There are two ways to opt-in to a consumer chain using an assigned key:
* Submit the assign-consensus-key transaction and the opt-in transaction separately, without specifying a pubkey in the opt-in transaction.
* Submit the opt-in transaction using the pubkey as an argument.


### Do I have to opt-in before I can sign blocks?
Yes! There is a specific opt-in transaction that must be sent before you are able to sign blocks, even if you have created a validator node for the chain.

**Opting-in** means sending the opt-in transaction, which is possible at any time as long as the consumer chain’s chain-id is known to the provider chain:
when the consumer-addition proposal is in deposit or voting period
when the proposal has passed and we are awaiting spawn time
when the chain is running and the CCV channel has been established

**Validating** means signing blocks, which is only possible if the validator has already opted-in or is part of the Top N% (in which case they are automatically opted-in).

### What happens if I opt-in after spawn?
If you send the opt-in tx after spawn and after the chain is interchain-secured (i.e. after the CCV channel has been established) then you’ll be opted-in, become a validator for the consumer chain, and start signing blocks. 

If you send the opt-in tx after spawn but before the chain is interchain-secured (i.e., before the CCV channel has been established), you will not actually be opted-in until the CCV channel is live, as that channel is what sends valset updates between the consumer and provider chains.


### What is the point of setting the commission rate per-chain?
On the validator side, you might want to set higher commissions for a low-profit chain, for example. You could determine your own business logic for whether it's worth it to validate a chain based on the commission rate you could sustain.



## Pre-existing FAQ
* Can I assign a consensus keys while a consumer-addition proposal is in voting period?
  * Yes.
* Can I assign a consensus key during the voting period for a consumer-addition proposal if I am not in the top N?
  * Yes.
* Can I opt in to an Opt-in chain after its consumer-addition proposal voting period is over but before the spawn time?
  * Yes.
* Can I opt in to an Opt-in chain after the spawn time if nobody else opted in?
  * No, the consumer chain will not be added if nobody opted in by the spawn time. At least one validator, regardless of its voting power, must opt in before the spawn time arrives so the chain can start.
* Can all validators opt out of an Opt-in chain?
  * Yes, the consumer chain will halt with an `ERR CONSENSUS FAILURE` error after the opt-out message for the last validator is received.
* Can I set a commission rate for a chain I have not opted in to?
  * Yes.




* Can I assign a consensus keys while a consumer-addition proposal is in voting period?
  * Yes.
* Can I assign a consensus key during the voting period for a consumer-addition proposal if I am not in the top N?
  * Yes.
* Can I opt in to an Opt-in chain after its consumer-addition proposal voting period is over but before the spawn time?
  * Yes.
* Can I opt in to an Opt-in chain after the spawn time if nobody else opted in?
  * No, the consumer chain will not be added if nobody opted in by the spawn time. At least one validator, regardless of its voting power, must opt in before the spawn time arrives so the chain can start.
* Can all validators opt out of an Opt-in chain?
  * Yes, the consumer chain will halt with an `ERR CONSENSUS FAILURE` error after the opt-out message for the last validator is received.
* Can I set a commission rate for a chain I have not opted in to?
  * Yes.
