
# `consumer-1` Chain Details

> Status: **STOPPED**

The `consumer-1` chain will be launched as a persistent dummy chain to test basic Interchain Security functionality.

* **Chain-ID**: `consumer-1`
* **denom**: `ucon`
* **Spawn time**: `2023-01-26T15:00:00.000000Z`
* **GitHub repo**: [cosmos/interchain-security](https://github.com/cosmos/interchain-security)
* **Release**: [`v1.0.0-rc3`](https://github.com/cosmos/interchain-security/releases/tag/v1.0.0-rc3)
* **Genesis file with CCV state:** [consumer-1-genesis.json](consumer-1-genesis.json)

* **Reference binary**: [consumer-1-linux-amd64](consumer-1-linux-amd64)
* **Binary sha256sum**: `376cdbd3a222a3d5c730c9637454cd4dd925e2f9e2e0d0f3702fc922928583f1`
* **Genesis file _without CCV state_:** [consumer-1-genesis-without-ccv.json](consumer-1-genesis-without-ccv.json), verify with `shasum -a 256 provider-1-genesis.json`
* **SHA256 for genesis file _without CCV state_**: `d86d756e10118e66e6805e9cc476949da2e750098fcc7634fd0cc77f57a0b2b0`

The following items are included in the consumer addition [proposal](https://explorer.rs-testnet.polypore.xyz/provider-1/gov/5):

* Genesis file hash
  * The SHA256 is used to verify against the genesis file (without CCV state) that the proposer has made available for review.
  * The `consumer-1-genesis-without-ccv.json` file cannot be used to run the chain: it must be updated with the CCV (Cross Chain Validation) state after the spawn time is reached.
  * The genesis file includes funds for a relayer and a faucet account, and `signed_blocks_window` has been set to `10000`.
* Binary hash
  * The `consumer-1-linux-amd64` binary is only provided to verify the SHA256. It was built with Interchain Security release [`v1.0.0-rc3`](https://github.com/cosmos/interchain-security/releases/tag/v1.0.0-rc3). You can generate the binary following the build instructions in that repo or using one of the scripts provided here.
* Spawn time
  * Even if a proposal passes, the CCV state will not be available from the provider chain until after the spawn time is reached.

For more information regarding the consumer chain creation process, see [CCV: Overview and Basic Concepts](https://github.com/cosmos/ibc/blob/main/spec/app/ics-028-cross-chain-validation/overview_and_basic_concepts.md).

## Endpoints

Endpoints are exposed as subdomains for the sentry and snapshot nodes (described below) as follows:

* `http://rpc.<node-name>.rs-testnet.polypore.xyz`
* `http://rest.<node-name>.rs-testnet.polypore.xyz`
* `http://grpc.<node-name>.rs-testnet.polypore.xyz`
* `p2p.<node-name>.rs-testnet.polypore.xyz:26656`

Sentries:

1. `consumer1-sentry-01.rs-testnet.polypore.xyz`
2. `consumer1-sentry-02.rs-testnet.polypore.xyz`

Seed nodes:

1. `08ec17e86dac67b9da70deb20177655495a55407@consumer1-seed-01.rs-testnet.polypore.xyz:26656`
2. `4ea6e56300a2f37b90e58de5ee27d1c9065cf871@consumer1-seed-02.rs-testnet.polypore.xyz:26656`

The following state sync nodes serve snapshots every 1000 blocks:

1. `consumer1-state-sync-01.rs-testnet.polypore.xyz`
1. `consumer1-state-sync-02.rs-testnet.polypore.xyz`

## IBC Information

Connections and channels will be posted here shortly after the chain launches.

## How to Join

The scripts provided in this repo will install Gaia and optionally set up a Cosmovisor service with the auto-download feature enabled on your machine.

#### Bash Script

The scripts provided in this repo will install `interchain-security-cd` and optionally set up a Cosmovisor service on your machine. 

Run either one of the scripts provided to set up a `consumer-1` service:
* `join-rs-consumer-1.sh` will create a `consumer-1` service.
* `join-rs-consumer-1-cv.sh` will create a `cosmovisor` service.
* Both scripts must be run either as root or from a sudoer account.
* Both scripts will attempt to build a binary from the [cosmos/interchain-security] repo.

