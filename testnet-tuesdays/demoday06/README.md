# Testnet Demo Day # 6: 2024-August-7

In this demo day, we will demonstrate the consumer modification feature of Interchain Security.
We will post announcements in the `testnet-announcements` channel in Discord to coordinate activities during the event.

* Start time: `2024-08-07 14:58 UTC`
* End time: `2024-08-07 15:58 UTC`

## Testnet Incentives Program (TIP) Eligibility

* You must complete the tasks listed below by the time the event ends to remain eligible for TIP period 7.

## Tasks

* Task 1: Vote YES on the consumer-modification proposal for `test-conmod-1`.

## Timeline (UTC)

* 10:58: `consumer-modification` proposal goes into voting period.
  * Validators can complete task 1 at this time.
* 15:58: `consumer-modification` proposal passes.
  * Validators can no longer complete task 1 after this point.
* 15:58: The `test-conmod-1` chain is updated with the new parameters.
* 17:00: A `consumer-removal` proposal goes into voting period to stop the `test-conmod-1` chain 24 hours after its spawn time.

### Validator queries
You can try to opt in before and after the proposal passes!
* Check who has opted in with `gaiad q provider consumer-opted-in-validators test-conmod-1`
* Check which chains a validator must validate on with `gaiad q provider has-to-validate <cosmosvalcons>`
* Check the `test-conmod-1` validator set with `gaiad q tendermint-validator-set --node https://rpc.conmod-node.ics-testnet.polypore.xyz:443`