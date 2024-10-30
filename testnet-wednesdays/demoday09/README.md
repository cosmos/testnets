# Testnet Demo Day # 9: 2024-October-31

In this demo day, we'll demonstrate rewards accumulation for consumer chains.
As of gaia v21, it is no longer necessary to go through a governance proposal
to register an IBC denom as a valid reward token. This can now be set on a
per-chain basis, and we've launched a chain to demonstrate it.

**This will not be a TIP event.**

However, we invite you to opt into our chain, run infra for it, and collect
some rewards from it.

## Collecting IBC-denominated rewards

Our consumer chain was created from the following JSON:

```json
{
  "chain_id": "test-alpaca-4",
  "metadata": {
    "name": "test-alpaca-4",
    "description": "My consumer alpaca",
    "metadata": "ipfs://"
  },
  "allowlisted_reward_denoms": null,
  "initialization_parameters": {
    "initial_height": {
      "revision_number": 4,
      "revision_height": 1
    },
    "genesis_hash": "WjJWdVgyaGhjMmc9",
    "binary_hash": "WW1sdVgyaGhjMmc9",
    "spawn_time": "2024-10-29T19:55:00.000000-00:00",
    "unbonding_period": 1728000000000000,
    "ccv_timeout_period": 2419200000000000,
    "transfer_timeout_period": 3600000000000,
    "consumer_redistribution_fraction": "0.75",
    "blocks_per_distribution_transmission": 10,
    "historical_entries": 10000
  },
  "power_shaping_parameters": {
    "topN": 0
  }
}
```

After which we ran an `update-consumer` transaction to enable rewards:

```json
{
  "chain_id": "test-alpaca-4",
  "consumer_id": "106",
  "metadata": {
    "name": "test-alpaca-4",
    "description": "My consumer alpaca",
    "metadata": "ipfs://"
  },
  "allowlisted_reward_denoms": {"denoms": ["ibc/2DE03CDD72E687CC1135744CA441C3058AE942F19F25D193DFAB30240871CF9F"]},
  "power_shaping_parameters": {
    "topN": 0
  }
}
```

Notice how the `allowlisted_reward_denoms` parameter allows for adding the
denom as a registered reward denom without the need for a governance proposal.

You can see the rewards we've accumulated from running this chain by:

```bash
gaiad q distribution rewards cosmos1arjwkww79m65csulawqngr7ngs4uqu5hx9ak2a
```

Note how the `total` contains a line like the following:

```
4173687.606765600000000000ibc/2DE03CDD72E687CC1135744CA441C3058AE942F19F25D193DFAB30240871CF9F
```

## Running the chain

You can choose to run infrastructure for this chain and earn some rewards!
Use the info below to run it.

### test-alpaca-4

#### Chain information
* Chain ID: `test-alpaca-4`
* Opt-in
* Denom: `upac`
* Minimum gas prices: `0.005upac`
* Bech32 prefix: `consumer`
* Binary
  * [`interchain-security-cd`](https://github.com/hyphacoop/cosmos-builds/releases/download/ics-v4.5.0/interchain-security-cd-linux)
    * SHASUM: `6beb360622242b9286e2611ca5ba664ce5c83100fce904e73d7464efb038c5a3`
    * Verify with `shasum -a 256 interchain-security-cd-linux`
  * Repo: [interchain-security](https://github.com/cosmos/interchain-security/)
  * Version: [`v4.5.0`](https://github.com/cosmos/interchain-security/releases/tag/v4.5.0)
  * Built with Go 1.21.6
* Spawn time: `2024-10-29T19:55:00Z`
* Genesis file:
  * [`alpaca-genesis.json`](https://raw.githubusercontent.com/cosmos/testnets/3fd7e18ca28370cf32bdbe49586a4dd2b7a16f80/testnet-wednesdays/demoday09/alpaca-genesis.json)
  * SHASUM: `a92a1d47d739f59f4d2ba154c72c117ce8643c62531ade6c42ab5cdc036d1c3f` (verify with `shasum -a 256 valsetcap-genesis.json`)

#### Endpoints

##### Persistent peers

* `9547c9331021e0f076a359b095d01e68a63c89a2@alpaca-apple.ics-testnet.polypore.xyz:26656`

#### Node Setup

The `setup-alpaca.sh` script provided in this repo will install the chain binary.
* Ensure you fill in the `NODE_MONIKER` before running the script.
* It must be run either as root or from a sudoer account.
* The script will build the `interchain-security-cd` binary using Go 1.21.6.

#### Joining the Consumer Chain Validator Set

* Submit an opt-in transaction to join the chain
  ```
  gaiad tx provider opt-in 106 <consumer node public key>
  ```
* Copy the `alpaca-genesis.json` file to your consumer chain's home `/config/genesis.json`.
* Start your node
