
# `removeme` Chain Details

> Status: **SCHEDULED**

The `removeme` chain will be launched to test the a bug fix on the provider chain: a `consumer-removal` proposal that passes should result in the consumer chain stopping at the specified `stop_time` and not before.

* **Chain-ID**: `removeme`
* **denom**: `urem`
* **Spawn time**: `2023-03-28T19:00:00.000000Z`
* **GitHub repo**: [cosmos/interchain-security](https://github.com/cosmos/interchain-security)
* **Version**: [`v1.1.0`](https://github.com/cosmos/interchain-security/releases/tag/v1.1.0)
* **Genesis file with CCV state:** `removeme-genesis.json`

* **Reference binary**: `removeme-linux-amd64`
* **Binary sha256sum**: `ec1848bd0018732f1ae771c2b0f857c5def9a5fb7736001d640e1da337b41d9e`
* **Genesis file _without CCV state_:** `removeme-genesis-without-ccv.json`
* **SHA256 for genesis file _without CCV state_**: `79054737030e8e4f15eeda0fe279427ad8932671377a3fc86e7af2da7ae2763b`

The following items will be included in the consumer addition proposal:

* Genesis file hash
  * The SHA256 is used to verify against the genesis file (without CCV state) that the proposer has made available for review.
  * The `removeme-genesis-without-ccv.json` file cannot be used to run the chain: it must be updated with the CCV (Cross Chain Validation) state after the spawn time is reached.
  * The genesis file includes the following adjustments:
    * Funds for a relayer account
    * `signed_blocks_window` has been set to `100 000`
* Binary hash
  * The `removeme-linux-amd64` binary is only provided to verify the SHA256. It was built with commit [`6a856d183cd6fc6f24e856e0080989ab53752102`](https://github.com/cosmos/interchain-security/commit/6a856d183cd6fc6f24e856e0080989ab53752102) of the Interchain Security repo (v1.1.0). You can generate the binary following the build instructions in that repo or using one of the scripts provided here.
* Spawn time
  * Even if a proposal passes, the CCV state will not be available from the provider chain until after the spawn time is reached.

For more information regarding the consumer chain creation process, see [CCV: Overview and Basic Concepts](https://github.com/cosmos/ibc/blob/main/spec/app/ics-028-cross-chain-validation/overview_and_basic_concepts.md).

## Endpoints

Persistent nodes:

1. `b7d0bd260fca7a5a19c7631b15f6068891faa60e@removeme-apple.rs-testnet.polypore.xyz:26656`
2. `49d75c6094c006b6f2758e45457c1f3d6002ce7a@removeme-banana.rs-testnet.polypore.xyz:26656`
3. `f2520026fb9086f1b2f09e132d209cbe88064ec1@removeme-cherry.rs-testnet.polypore.xyz:26656`

## IBC Information

Connections and channels will be posted here shortly after the chain launches.

## How to Join

#### Bash Scripts

The scripts provided in this repo will install a malicious branch of `interchain-security-cd` and optionally set up a Cosmovisor service on your machine. 

Run either one of the scripts provided to set up a `removeme` service:
* `join-rs-removeme.sh` will create a `removeme` service.
* `join-rs-removeme-cv.sh` will create a `cosmovisor` service.
* Both scripts must be run either as root or from a sudoer account.
* Both scripts will attempt to build a binary from the [cosmos/interchain-security] repo.
