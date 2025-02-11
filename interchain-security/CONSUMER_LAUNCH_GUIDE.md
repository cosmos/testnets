# Consumer Chain Launch Process

This guide is intended for consumer chain teams that are looking to be onboarded on to the Interchain Security testnet.

## Interchain Security Testnet Overview

* The Interchain Security (ICS) testnet is to be used to launch and test consumer chains. We recommend consumer chains to launch on the testnet before launching on the mainnet.
* All information about the ICS testnet is available in this [repository](https://github.com/cosmos/testnets/tree/master/interchain-security).
* The testnet coordinators (Hypha) have majority voting power in the ICS testnet. This means we need to work with you to bring your chain live and also to successfully pass any governance proposals you make.

## Chain Onboarding Process

For teams looking to join the ICS testnet, the onboarding process can be broken down in four phases:

* Testing and Integration 
* Planning with Testnet Coordinators
* Consumer Chain Creation
* Chain Launch

### Local Testing and Integration

During this phase, your team will run integration tests with the following elements of an Interchain Security testnet:
* Gaia provider chain
  * Visit the provider chain [page](./provider/) for details on which Gaia version is currently being used.
* Relayers
  * You will be responsible for running the relayer that relays the first set of Validator Set Change packets between provider and consumer chain. You should be proficient in setting up and running either [Hermes](https://github.com/informalsystems/hermes) or [rly](https://github.com/cosmos/relayer).

By the end of this phase, you are able to launch a consumer chain within a local testnet or CI workflow that resembles the testnet (or mainnet) environment.

### Planning with Testnet Coordinators

Once you have a binary release ready, you can begin planning the launch with the testnet coordinators (Hypha).

The goals of this phase are to update this repository with all the information validators need to join the network and to produce a `consumer-addition` proposal to be submitted in the provider chain.

We expect you to run the minimum infrastructure required to make your consumer chain usable by testnet participants. This means running:

1. **Seed/persistent nodes**  
2. **Relayer** it must be launched before the chain times out, preferably right after blocks start being produced.
    * **IMPORTANT**: Make sure you have funds to pay gas fees for the relayer. You will likely need to set up an adequately funded genesis account for this purpose.

Additionally, you may want to run:
- a faucet such as this simple [REST faucet](https://github.com/hyphacoop/cosmos-rest-faucet) (it may need a separate funded account in the genesis file as well)
- a block explorer such as [ping.pub](https://github.com/ping-pub/explorer)

## ✍️ Submitting a PR for a new chain

Each consumer chain gets its own directory. You can use the [`test-conmod-1`](./stopped/test-conmod-1/) chain as reference. Feel free to clone the `test-conmod-1` directory, modify it for your consumer chain, and make a PR with the relevant information.

Hypha will be reviewing the PR to ensure it meets the following criteria:

#### README includes:
- [ ] Consumer chain repo and release or tag name.
- [ ] Build instructions for chain binary.
- [ ] Checksum of genesis file without CCV.
- [ ] Checksum of reference binary.
- [ ] Instructions on to join
- [ ] Installation steps 
- Endpoints
  - [ ] Seeds OR persistent peers
  - [ ] State sync nodes (if any)

See the `test-conmod-1` chain [page](./stopped/test-conmod-1) for reference.

#### `chain_id` must be identical in the following places:
 - [ ] `README`
 - [ ] genesis file
 - [ ] create-consumer JSON file
 - [ ] bash script

We recommend choosing a `chain_id` with the suffix `-1`, even if it's a subsequent test of the same chain, e.g. `testchain-second-rehearsal-1`.

#### Binary checksum validation
 - [ ] `shasum -a 256 <binary>` matches the checksum in the proposal
 - [ ] `shasum -a 256 <binary>` matches `README`

#### Bash script
  - [ ] version built in script must match `README`
  - [ ] seeds or persistent peers must match `README`

#### Genesis file
- [ ] Genesis time must be no later than one day before the expected launch date
- [ ] Accounts and balances: Properly funded accounts (e.g., gas fees for relayer, faucet, etc.)
- [ ] Bank balance denom matches denom in `README`
- [ ] Slashing parameters: Set `signed_blocks_window` and `min_signed_per_window` adequately to ensure validators have at least 12 hours to join the chain after launch without getting jailed
- [ ] `shasum -a 256 <genesis file without CCV>` matches the checksum in the proposal
- [ ] `shasum -a 256 <genesis file without CCV>` matches the checksum in the `README`
- [ ] The genesis file is correctly formed: `<consumer binary or gaiad> validate-genesis /path/to/genesis-without-ccv.json` returns without error

See the `test-conmod-1` chain [genesis](./stopped/test-conmod-1/conmod-genesis-pre-spawn.json) for reference.

#### `create-consumer` JSON file

  - [ ] If set, the spawn time must match the genesis time
  - [ ] `revision_height: 1`
  - [ ] `revision_number: 1` (only if the `chain_id` ends in `-1`)
  - [ ] `transfer_timeout_period: 1800000000000`. This value should be smaller than `blocks_per_distribution_transmission * block_time`.
  - [ ] `ccv_timeout_period: 2419200000000000`. This value must be larger than the unbonding period, the default is 28 days. 
  - [ ] `unbonding_period: 1728000000000000` (given current provider params)

See the JSON file below and the [Interchain Security docs](https://cosmos.github.io/interchain-security/consumer-development/onboarding) for reference:

```json
{
    "chain_id": "test-ics-1",
    "metadata": {
        "name": "consumer chain",
        "description": "no description",
        "metadata": "{\"forge_json_url\": \"...\", \"stage\": \"mainnet\"}"
    },
    "initialization_parameters": {
        "initial_height": {
            "revision_number": 1,
            "revision_height": 1
        },
        "genesis_hash": "",
        "binary_hash": "",
        "spawn_time": null,
        "unbonding_period": 1728000000000000,
        "ccv_timeout_period": 2419200000000000,
        "transfer_timeout_period": 3600000000000,
        "consumer_redistribution_fraction": "0.75",
        "blocks_per_distribution_transmission": 1000,
        "historical_entries": 10000,
        "distribution_transmission_channel": "",
        "connection_id": ""
    },
    "power_shaping_parameters": {
        "top_N": 0,
        "validators_power_cap": 0,
        "validator_set_cap": 0,
        "allowlist": [
            "cosmosvalcons..."
        ],
        "denylist": [
            "cosmosvalcons..."
        ],
        "min_stake": 0,
        "allow_inactive_vals": false,
        "prioritylist": [
            "cosmosvalcons..."
        ]
    },
    "infraction_parameters": {
        "double_sign": {
            "slash_fraction": "0.05",
            "jail_duration": 9223372036854775807,
            "tombstone": true
        },
        "downtime": {
            "slash_fraction": "0.0001",
            "jail_duration": 600000000000,
            "tombstone": false
        }
    },
    "allowlisted_reward_denoms": {
        "denoms": [
            "ibc/...",
            "ibc/..."
        ]
    }
}
```

#### Node configuration
  - [ ] `minimum_gas_prices`
  - [ ] Check with Hypha about any other chain-specific params

--------------

## Consumer Chain Creation

The following will take place during the chain creation phase:

* Your team will submit `create-consumer` transaction with a command that looks like this:
  ```
  gaiad tx provider create-consumer create.json --from <account name> --chain-id provider --gas auto --gas-adjustment 2 --gas-prices 0.005uatom -y
  ```
* After the `create-consumer` transaction goes on chain, a consumer ID will be created. You will obtain this ID with the `gaiad q provider list-consumer-chains` command.
* You will open a pull request to add the new consumer chain entry to this repo and update the [schedule page](SCHEDULE.md) with the launch date.
* You will announce the upcoming launch in the Interchain Security `announcements` channel of the Cosmos Network Discord Server. If you need permissions for posting, please reach out to us.
* Validators will opt-in to the chain using the consumer ID.
* You will submit an `update-consumer` transaction to set the spawn time after enough validators have opted-in. See the JSON file below for reference:

```json
{
    "consumer_id": "<consumer id>",
    "metadata": {
        "name": "consumer chain",
        "description": "no description",
        "metadata": "{\"forge_json_url\": \"...\", \"stage\": \"mainnet\"}"
    },
    "initialization_parameters": {
        "initial_height": {
            "revision_number": 1,
            "revision_height": 1
        },
        "genesis_hash": "",
        "binary_hash": "",
        "spawn_time": "<current time>",
        "unbonding_period": 1728000000000000,
        "ccv_timeout_period": 2419200000000000,
        "transfer_timeout_period": 3600000000000,
        "consumer_redistribution_fraction": "0.75",
        "blocks_per_distribution_transmission": 1000,
        "historical_entries": 10000,
        "distribution_transmission_channel": "",
        "connection_id": ""
    }
}
```

## Chain Launch

After the spawn time is reached, the Cross-Chain Validation (CCV) state will be available on the provider chain and the new IBC client will be created. At this point, you will be able to:
* Collect the Cross-Chain Validation (CCV) state from the provider chain.
  ```
  gaiad q provider consumer-genesis <consumer-id> -o json > ccv-state.json
  ```
* Update the CCV state with the reward denoms.
  ```
  jq '.params.reward_denoms |= ["<your chain denom>"]' ccv-state.json > ccv-denom.json
  jq '.params.provider_reward_denoms |= ["uatom"]' ccv-denom.json > ccv-provider-denom.json
  ```
* Update the genesis file with the CCV state
  ```
  jq -s '.[0].app_state.ccvconsumer = .[1] | .[0]' <consumer genesis without CCV state> ccv-provider-denom.json > <consumer genesis file with CCV state>
  ```
* Publish the genesis file with CCV state to the testnets repo.
* Post the link to the genesis file and the SHA256 hash to the Interchain Security `interchain-security-testnet` channel of the Cosmos Network Discord Server.
* Ensure the required peers are online for people to connect to.

The consumer chain will start producing blocks as soon as 66.67% of voting power comes online. You will be able to start the relayer afterwards:

* Query the IBC client ID of the provider chain.
  ```
  gaiad q provider list-consumer-chains
  ````
* Create the required IBC connections and channels for the CCV channel to be established. Using Hermes:
  ```
  hermes create connection --a-chain <consumer chain ID> --a-client 07-tendermint-0 --b-client <provider chain client ID> 
  hermes create channel --a-chain <consumer chain ID> --a-port consumer --b-port provider --order ordered --a-connection connection-0 --channel-version 1
  ```
* Start the relayer
  * The trusting period fraction is set to `0.25` on the provider chain, so you should use a trusting period of 5 days in your relayer configuration.

Finally, the testnet coordinators will:
* Trigger a validator set update in the provider chain to establish the CCV channel and verify the validator set has been updated in the consumer chain.
* Announce the chain is interchain secured.
* Update the testnets repo with the IBC information.

## Talk to us

If you're a consumer chain looking to launch, please get in touch with Hypha. You can reach Lexa Michaelides at `lexa@hypha.coop` or on Telegram.
