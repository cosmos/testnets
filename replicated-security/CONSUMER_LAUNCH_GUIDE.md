# Consumer Chain Launch Process

This guide is intended for consumer chain teams that are looking to be onboarded on to the Replicated Security testnet.

## Replicated Security Testnet Overview

* The Replicated Security (RS) testnet is to be used to launch and test consumer chains. We recommend consumer chains to launch on the testnet before launching on the mainnet.
* All information about the RS testnet is available in this [repository](https://github.com/cosmos/testnets/tree/master/replicated-security).
* The testnet coordinators (Hypha) have majority voting power in the RS testnet. This means we need to work with you to bring your chain live and also to successfully pass any governance proposals you make.

## Chain Onboarding Process

For teams looking to join the RS testnet, the onboarding process can be broken down in four phases:

* Testing and Integration 
* Planning with Testnet Coordinators
* Proposal Submission
* Chain Launch

### Local Testing and Integration

During this phase, your team will run integration tests with the following elements of a replicated security testnet:
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

Each consumer chain has its own directory. You can use the [`slasher`](./slasher/) chain as reference- feel free to clone the slasher directory, modify it for your consumer chain, and make a PR with the relevant information:

#### Binary and endpoints information

  * Consumer chain repo and release or tag name.
  * Build instructions for chain binary.
  * Genesis file without CCV state and checksum.
  * Reference binary and checksum.
  * Support node information: persistent peers and/or seeds must be provided.
  * Bash scripts for joining the chain are recommended.
  * See the `slasher` chain [page](./slasher) for reference.

#### Genesis file

  * Genesis time: Set to the spawn time in the `consumer-addition` proposal.
  * Accounts and balances: Properly funded accounts (e.g., gas fees for relayer, faucet, etc.).
  * Slashing parameters: Set `signed_blocks_window` and `min_signed_per_window` adequately to ensure validators have at least 12 hours to join the chain after launch without getting jailed.
  * See the `slasher` chain [genesis](./slasher/slasher-genesis-without-ccv.json) for reference.

#### Launch date and time
  * This time will be listed as the spawn time in the `consumer-addition` proposal and will gate the launch (the chain cannot be started prior to the spawn time).

#### `consumer-addition` proposal

  * Spawn time: Must match the genesis time
  * Unbonding period: `1728000000000000`. This value should be smaller than the provider unbonding period (21 days vs 20 days in the provider chain).
  * Transfer timeout period: `1800000000000`. This value should be smaller than `blocks per distribution transmission * average block time`.
  * CCV timeout period: `2419200000000000`. This value must be larger than the unbonding period, the default is 28 days. 
  * See the `slasher` chain consumer-addition [proposal](./slasher/proposal-slasher.json) and [Interchain Security time-based parameters](https://github.com/cosmos/interchain-security/blob/main/docs/params.md#time-based-parameters) for reference.

### Proposal Submission

When you make your proposal, please let us know well in advance. The current voting period is five minutes, which means we’ll need to vote right after you submit your proposal. We recommend submitting the proposal together with us on a call.

The following will take place during the proposal submission phase:

* Your team will submit the `consumer-addition` proposal with a command that looks like this:
  ```
  gaiad tx gov submit-proposal consumer-addition proposal.json --from <account name> --chain-id provider --gas auto --fees 500uatom -b block -y
  ```
* Testnet coordinators will vote on it shortly afterwards to make sure it passes.
* You will open a pull request to add the new consumer chain entry to this repo and update the [schedule page](SCHEDULE.md) with the launch date.
* You will announce the upcoming launch, including the spawn time, in the Interchain Security `announcements` channel of the Cosmos Network Discord Server. If you need permissions for posting, please reach out to us.

### Chain Launch

After the spawn time is reached, the Cross-Chain Validation (CCV) state will be available on the provider chain and the new IBC client will be created. At this point, you will be able to:
* Collect the Cross-Chain Validation (CCV) state from the provider chain.
  ```
  gaiad q provider consumer-genesis <chain-id> -o json > ccv-state.json
  ```
* Update the genesis file with the CCV state.
  ```
  jq -s '.[0].app_state.ccvconsumer = .[1] | .[0]' <consumer genesis without CCV state> ccv-state.json > <consumer genesis file with CCV state>
  ```
* Publish the genesis file with CCV state to the testnets repo.
* Post the link to the genesis file and the SHA256 hash to the Interchain Security `replicated-security-testnet` channel of the Cosmos Network Discord Server.
* Ensure the required peers are online for people to connect to.

The consumer chain will start producing blocks as soon as 66.67% of the provider chain's voting power comes online. You will be able to start the relayer afterwards:

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