
# `noble-1` Chain Details

> Status: **STOPPED**

The `noble-1` chain will be launched as a persistent dummy chain to test basic Interchain Security functionality.

* **Chain-ID**: `noble-1`
* **denom**: `unoble`
* **Spawn time**: `2023-02-08T16:00:00.000000Z`
* **GitHub repo**: [cosmos/interchain-security](https://github.com/strangelove-ventures/noble)
* **Release**: [`v0.1.1`](https://github.com/strangelove-ventures/noble/releases/tag/v0.1.1)
* **Genesis file with CCV state:** [TBD after spawntime](noble-1-genesis.json)

* **Reference binary**: [nobled-linux-amd64](nobled-linux-amd64)
* **Binary sha256sum**: `3348e12f79e4119324fc139121cd2b09ec292cf3e2b2c49c8763830d9ac060bc`
* **Genesis file _without CCV state_:** [To be created after spawntime](noble-1-genesis-without-ccv.json), verify with `shasum -a 256 provider-1-genesis.json`
* **SHA256 for genesis file _without CCV state_**: `TBD`

The following items are included in the noble addition [proposal](https://explorer.noble.ics-testnet.strange.love/provider-1/gov/15):

* Genesis file hash
  * The SHA256 is used to verify against the genesis file (without CCV state) that the proposer has made available for review.
  * The `noble-1-genesis-without-ccv.json` file cannot be used to run the chain: it must be updated with the CCV (Cross Chain Validation) state after the spawn time is reached.
  * The genesis file includes funds for a relayer and a faucet account, and `signed_blocks_window` has been set to `10000`.
* Binary hash
  * The `nobled-linux-amd64` binary is only provided to verify the SHA256. It was built with Interchain Security release [`v1.0.0-rc3`](https://github.com/cosmos/interchain-security/releases/tag/v1.0.0-rc3). You can generate the binary following the build instructions in that repo or using one of the scripts provided here.
* Spawn time
  * Even if a proposal passes, the CCV state will not be available from the provider chain until after the spawn time is reached.

For more information regarding the noble chain creation process, see [CCV: Overview and Basic Concepts](https://github.com/cosmos/ibc/blob/main/spec/app/ics-028-cross-chain-validation/overview_and_basic_concepts.md).

## Endpoints

Endpoints are exposed as subdomains for the sentry and snapshot nodes (described below) as follows:

* `https://rpc.noble.ics-testnet.strange.love`
* `https://api.noble.ics-testnet.strange.love`
* `https://grpc.noble.ics-testnet.strange.love`
* `https://p2p.noble.ics-testnet.strange.love`

Sentries:

1. `noble1-sentry-01.noble.ics-testnet.strange.love`
2. `noble1-sentry-02.noble.ics-testnet.strange.love`

Seed nodes:

1. `change_me_once_nodekey_is_known@noble1-seed-01.noble.ics-testnet.strange.love:26656`
2. `change_me_once_nodekey_is_known@noble1-seed-02.noble.ics-testnet.strange.love:26656`

The following state sync nodes serve snapshots every 1000 blocks:

1. `noble1-state-sync-01.noble.ics-testnet.strange.love`
1. `noble1-state-sync-02.noble.ics-testnet.strange.love`

## IBC Information

Connections and channels will be posted here shortly after the chain launches.

## How to Join

The scripts provided in this repo will install Gaia and optionally set up a Cosmovisor service with the auto-download feature enabled on your machine.

#### Bash Script

The scripts provided in this repo will install `nobled` and optionally set up a Cosmovisor service on your machine. 

Run either one of the scripts provided to set up a `noble-1` service:
* `join-rs-noble-1.sh` will create a `noble-1` service.
* `join-rs-noble-1-cv.sh` will create a `cosmovisor` service.
* Both scripts must be run either as root or from a sudoer account.
* Both scripts will attempt to build a binary from the [cosmos/interchain-security] repo.

