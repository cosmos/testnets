# Testnet Demo Day # 9: 2024-October-23

In this demo day, we'll demonstrate rewards accumulation for consumer chains.
As of gaia v21, it is no longer necessary to go through a governance proposal
to register an IBC denom as a valid reward token. This can now be set on a
per-chain basis, and we've launched a chain to demonstrate it.

There will only be one task for TIP eligibility:

* You must opt into our consumer chain (consumer ID TBDID) to signal attendance
  and remain eligible for TIP.



**You do not need to run infrastructure to be eligible. You will not be jailed
for not running infra.** However, we will be running infrastructure for this
chain, and you're welcome to join us! If you do so, you'll be able to collect
rewards from the dummy consumer chain.

We will post announcements in the `testnet-announcements` channel in Discord to coordinate activities during the event.

* Start time: `2024-10-25 13:30 UTC`
* End time: `2024-10-25 16:30 UTC`

## Collecting IBC-denominated rewards

Our consumer chain was created from the following JSON:
```json
{
  "chain_id": "alpaca-1",
  "metadata": {
    "name": "alpaca-1",
    "description": "My consumer alpaca",
    "metadata": "ipfs://"
  },
  "allowlisted_reward_denoms": {"denoms": ["ibc/TBDDENOM"]},
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

Notice how the `allowlisted_reward_denoms` parameter allows for adding the
denom as a registered reward denom without the need for a governance proposal.


**You should opt into our chain:**

```bash
gaiad tx provider opt-in TBDID
```

You can see the rewards we've accumulated from running this chain by:

```bash
gaiad q distribution rewards cosmos1arjwkww79m65csulawqngr7ngs4uqu5hx9ak2a
```

Note how the `total` contains a line like the following:

```
4173687.606765600000000000ibc/TBDDENOM
```

Try running some infra for this consumer chain and accumulating some rewards of your own!
