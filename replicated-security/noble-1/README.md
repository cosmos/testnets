
# `noble-1` Chain Details

> Status: **STOPPED**

The `noble-1` chain will be launched as a persistent dummy chain to test basic Interchain Security functionality.

* **Chain-ID**: `noble-1`
* **denom**: `unoble`
* **Spawn time**: `2023-02-09T16:00:00.000000Z`
* **GitHub repo**: [cosmos/noble-1](https://github.com/strangelove-ventures/noble)
* **Release**: [`v0.1.1`](https://github.com/strangelove-ventures/noble/releases/tag/v0.1.1) 
* **Genesis file with CCV state:** [TBD after spawntime](noble-1-genesis.json)

* **Reference binary**: [nobled-linux-amd64](nobled-linux-amd64)
* **Binary sha256sum**: `3348e12f79e4119324fc139121cd2b09ec292cf3e2b2c49c8763830d9ac060bc`
* **Genesis file _without CCV state_:** (noble-1-genesis-without-ccv.json), verify with `shasum -a 256 noble-1-genesis-without-ccv.json`
* **SHA256 for genesis file _without CCV state_**: `74f1aa802e267ad0d98b65ed3d34cd271c074e9ff5cbc34ecd5ccfd9f69f2818`

The following items are included in the noble addition [proposal](https://explorer.noble.ics-testnet.strange.love/provider-1/gov/15):

* Genesis file hash
  * The SHA256 is used to verify against the genesis file (without CCV state) that the proposer has made available for review.
  * The `noble-1-genesis-without-ccv.json` file cannot be used to run the chain: it must be updated with the CCV (Cross Chain Validation) state after the spawn time is reached.
  * The genesis file includes funds for a relayer and a faucet account, and `signed_blocks_window` has been set to `10000`.
* Binary hash
  * The `nobled-linux-amd64` binary is only provided to verify the SHA256. It was built with Interchain Security release [`v1.0.0-rc1`](https://github.com/cosmos/noble-1/releases/tag/v1.0.0-rc1). You can generate the binary following the build instructions in that repo or using one of the scripts provided here.
* Spawn time
  * Even if a proposal passes, the CCV state will not be available from the provider chain until after the spawn time is reached.

For more information regarding the noble chain creation process, see [CCV: Overview and Basic Concepts](https://github.com/cosmos/ibc/blob/main/spec/app/ics-028-cross-chain-validation/overview_and_basic_concepts.md).

## Endpoints

RPC:

1. `http://noble.ics-testnet:26657`

Seed nodes:

1. `233598946a15427b9541376e7cfc30dab07c4327@35.247.60.27:26656`
2. `359d63178736911e3e4c716f2491cafaa687351a@34.168.48.1:26656`
3. `3d2516052fd8b134428971d1218a149bba6e44be@35.247.10.56:26656`

## IBC Information

Connections and channels will be posted here shortly after the chain launches.

## How to Join

The scripts provided in this repo will install Noble and optionally set up a Cosmovisor service with the auto-download feature enabled on your machine.

#### Bash Script

The scripts provided in this repo will install `nobled` and optionally set up a Cosmovisor service on your machine. 

Run either one of the scripts provided to set up a `noble-1` service:
* `join-rs-noble-1.sh` will create a `noble-1` service.
* `join-rs-noble-1-cv.sh` will create a `cosmovisor` service.
* Both scripts must be run either as root or from a sudoer account.
* Both scripts will attempt to build a binary from the [cosmos/noble-1] repo.

