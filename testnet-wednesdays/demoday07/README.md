# Testnet Demo Day # 7: 2024-September-11

In this demo day, we will demonstrate the impact of the feemarket module in gas prices and block size.
We will post announcements in the `testnet-announcements` channel in Discord to coordinate activities during the event.

* Start time: `2024-09-11 14:30 UTC`
* End time: `2024-09-11 15:45 UTC`

## Testnet Incentives Program (TIP) Eligibility

* You must complete the tasks listed below by the time the event ends to remain eligible for TIP period 8.

## Tasks

* Task 1: Vote YES on the feemarket param change proposal.

## Timeline (UTC)

* 14:30: param change proposal goes into voting period.
  * Validators can complete task 1 at this time.
* 15:30: param change proposal passes.
  * Validators can no longer complete task 1 after this point.
  * The feemarket module is updated with the new parameters.
* 15:35: A new set of transactions is submitted by testnet coordinators to verify the new parameters work.

## Demo transactions

* We will submit two text proposals with a large character count in the `summary` field within a single block.
  * This will drive the gas price up.
  * The total gas wanted for these proposals will be ~44_000_000.
  * When the `max_block_utilization` parameter in the feemarket module is set to 30_000_000, only one of the submit proposal transactions will succeed, and the other one will fail.
  * When the `max_block_utilization` parameter in the feemarket module is set to 75_000_000, both of the submit proposal transactions will succeed.