
# `provider` Chain Details

The provider chain functions as an analogue of the Cosmos Hub. Its governance parameters will provide short voting periods to accelerate the creation of consumer chains.

* **Chain-ID**: `provider`
* **denom**: `uatom`
* **Current Gaia Version**: [`v9.0.0-rc7`](https://github.com/cosmos/gaia/releases/tag/v9.0.0-rc7)
* **Genesis File:**  [provider-genesis.json](provider-genesis.json), verify with `shasum -a 256 provider-genesis.json`
* **Genesis sha256sum**: `91870bfb8671f5d60c303f9da8e44b620a5403f913359cc6b212150bfc3e631d`
* Launch Date: 2023-02-02
* Launch Gaia Version: [`v9.0.0-rc2`](https://github.com/cosmos/gaia/releases/tag/v9.0.0-rc2)

## Endpoints

Endpoints are exposed as subdomains for the sentry and snapshot nodes (described below) as follows:

* `https://rpc.<node-name>.rs-testnet.polypore.xyz:443`
* `https://rest.<node-name>.rs-testnet.polypore.xyz:443`
* `https://grpc.<node-name>.rs-testnet.polypore.xyz:443`
* `p2p.<node-name>.rs-testnet.polypore.xyz:26656`

Sentries:

1. `provider-sentry-01.rs-testnet.polypore.xyz`
2. `provider-sentry-02.rs-testnet.polypore.xyz`

Seed nodes:

1. `08ec17e86dac67b9da70deb20177655495a55407@provider-seed-01.rs-testnet.polypore.xyz:26656`
2. `4ea6e56300a2f37b90e58de5ee27d1c9065cf871@provider-seed-02.rs-testnet.polypore.xyz:26656`

The following state sync nodes serve snapshots every 1000 blocks:

1. `provider-state-sync-01.rs-testnet.polypore.xyz`
2. `provider-state-sync-02.rs-testnet.polypore.xyz`

## Block Explorer

* https://explorer.rs-testnet.polypore.xyz

## Consumer Chains IBC Data

Connections and channels will be posted here shortly after a consumer chain launches.

### Clients

* `07-tendermint-1`
  * Counterparty: [`baryon-1`](/replicated-security/baryon-1/README.md) `07-tendermint-0`

### Channels

* `channel-2`: provider port
  * Counterparty: [`baryon-1`](/replicated-security/baryon-1/README.md) `channel-0`
* `channel-3`: transfer port
  * Counterparty: [`baryon-1`](/replicated-security/baryon-1/README.md) `channel-1`

## Faucet

* Visit `faucet.rs-testnet.polypore.xyz` to request tokens and check your address balance.

## How to Join

The scripts provided in this repo will install Gaia and optionally set up a Cosmovisor service with the auto-download feature enabled on your machine.

You can choose to (not) use state sync. Your node will sync much faster if you use state sync, but it will not keep all the state locally.

### Bash Script

Run either one of the scripts provided in this repo to join the provider chain:
* `join-rs-provider.sh` will create a `gaiad` service.
* `join-rs-provider-cv.sh` will create a `cosmovisor` service.
* Both scripts must be run either as root or from a sudoer account.
* Both scripts will attempt to download the amd64 binary from the Gaia [releases](https://github.com/cosmos/gaia/releases) page. You can modify the `CHAIN_BINARY_URL` to match your target architecture if needed.

#### State Sync Option

* By default, the scripts will attempt to use state sync to catch up quickly to the current height. To turn off state sync, set `STATE_SYNC` to `false` (you should set this to false if the chain has less than 1000 blocks).

## Creating a Validator

> If there are any consumer chains on the testnet, you must be running a node in those as well, or your validator will get jailed due to downtime depending on each consumer chain's `slashing` paramentes.

Once you have some tokens in your self-delegation account, you can submit the `create-validator` transaction.

Submit the `create-validator` transaction.
```bash
gaiad tx staking create-validator \
--amount 1000000uatom \
--pubkey "$(gaiad tendermint show-validator)" \
--moniker <your moniker> \
--chain-id provider \
--commission-rate 0.10 \
--commission-max-rate 1.00 \
--commission-max-change-rate 0.1 \
--min-self-delegation 1000000 \
--gas auto \
--from <self-delegation-account>
```

You can verify the validator was created in the block explorer, or in the command line:
```
gaiad q staking validators -o json | jq '.validators[].description.moniker'
```
