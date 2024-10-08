# Testnet Demo Day # 8: 2024-October-09

In this demo day, we'll demonstrate permissionless consumer launches.
This will consist of two tasks:
1. You will create your own opt-in consumer chain
1. You will opt into a consumer chain we created

Note that you're not expected to run infrastructure for either of these new chains; submitting the transactions on the provider chain is enough.

We will post announcements in the `testnet-announcements` channel in Discord to coordinate activities during the event.

* Start time: `2024-10-09 14:30 UTC`
* End time: `2024-10-09 16:30 UTC`

## Testnet Incentives Program (TIP) Eligibility

* You must complete the tasks listed below by the time the event ends to remain eligible for TIP period 8.

### Tasks

* Task 1: Create an opt-in consumer chain
* Task 2: Opt into our consumer chain

## Task 1: Create an opt-in consumer chain
You'll have to create a JSON file containing the details for your consumer chain. Make sure you fill in `chain_id`, `metadata.name`, and `metadata.description`.
**Don't submit a create-consumer with chain_id `hypha-consumer-1` please!**
```json
{
  "chain_id": "hypha-consumer-1",
  "metadata": {
    "name": "hypha-consumer",
    "description": "My consumer chain",
    "metadata": "ipfs://"
  },
  "initialization_parameters": {
    "initial_height": {
      "revision_number": 1,
      "revision_height": 1
    },
    "genesis_hash": "WjJWdVgyaGhjMmc9",
    "binary_hash": "WW1sdVgyaGhjMmc9",
    "spawn_time": "2024-10-09T17:00:00.000000-00:00",
    "unbonding_period": 1728000000000000,
    "ccv_timeout_period": 2419200000000000,
    "transfer_timeout_period": 3600000000000,
    "consumer_redistribution_fraction": "0.75",
    "blocks_per_distribution_transmission": 1000,
    "historical_entries": 10000
  },
  "power_shaping_parameters": {
    "topN": 0
  }
}
```

At that point, you can run `create-consumer` to create the consumer chain:

```
gaiad tx provider create-consumer consumer-addition.json
```

If you do `gaiad q tx provider list-consumer-chains` now, you should be able to see your new chain.

## Task 2: Opt into our consumer chain

* Look at the list in `gaiad q tx provider list-consumer-chains`. You should be able to find one with chain_id `hypha-consumer-1`.
* One of its fields is the `consumer_id`--note how this **is a numerical id that's different from the `chain_id`**
    * Starting in v20, the `consumer_id` will be used for all `provider` transactions.
* However, there may be multiple chains with chain_id `hypha-consumer-1`
* We need to verify that it's the right `hypha-consumer-1`. Do this by doing `gaiad q provider consumer-chain $CONSUMER_ID` and
  verifying that the `owner_address` is  `cosmos1arjwkww79m65csulawqngr7ngs4uqu5hx9ak2a`
* Once you're sure, you may use the consumer_id to opt-in: `gaiad tx provider opt-in $CONSUMER_ID`
