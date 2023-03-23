
![Noble banner](https://raw.githubusercontent.com/strangelove-ventures/noble-networks/main/Twitter_Banner.png)
# Noble Chain Information

> Status: **[MOVED](https://github.com/strangelove-ventures/noble-networks/tree/main/mainnet/noble-1#noble-chain-information)**

## Noble has moved

On `2023-03-23` a stop consumer-chain proposal was submitted to remove noble from the replicated security testnet.  You can find out more information [here](https://github.com/strangelove-ventures/noble-networks/tree/main/mainnet/noble-1#noble-chain-information)


## Historical Info
The `noble-1` chain will be launched as a persistent dummy chain to test basic Interchain Security functionality.

* **Chain-ID**: `noble-1`
* **denom**: `unoble`
* **Spawn time**: `2023-02-09T16:00:00.000000Z`
* **GitHub repo**: [strangelove-ventures/noble-1](https://github.com/strangelove-ventures/noble)
* **Release**: [`v0.2.0`](https://github.com/strangelove-ventures/noble/releases/tag/v0.2.0) 
* **Genesis file with CCV state:** [noble-1-genesis.json](https://raw.githubusercontent.com/strangelove-ventures/cosmos-testnets/master/replicated-security/noble-1/noble-1-genesis.json)

* **Genesis file _without CCV state_:** (noble-1-genesis-without-ccv.json), verify with `shasum -a 256 noble-1-genesis-without-ccv.json`
* **SHA256 for genesis file _without CCV state_**: `54be5eb26d18d6927914db5971c925eedc5f91112beb0529ae4d1450334de282`

The following items are included in the noble addition [proposal](https://explorer.noble.ics-testnet.strange.love/provider-1/gov/15):

* Genesis file hash
  * The SHA256 is used to verify against the genesis file (without CCV state) that the proposer has made available for review.
  * The `noble-1-genesis-without-ccv.json` file cannot be used to run the chain: it must be updated with the CCV (Cross Chain Validation) state after the spawn time is reached.
  * The `signed_blocks_window` has been set to `10000`.

* Spawn time
  * Even if a proposal passes, the CCV state will not be available from the provider chain until after the spawn time is reached.

For more information regarding the noble chain creation process, see [CCV: Overview and Basic Concepts](https://github.com/cosmos/ibc/blob/main/spec/app/ics-028-cross-chain-validation/overview_and_basic_concepts.md).

## Verify Binary Checksum.
Binary checksums can differ based on many things to include go, libc, and make versions. To get a consistent checksum you can use something like docker to verify.

  * [Linux amd64 build](nobled-linux-amd64)
  * Version: `v0.2.0`
  * SHA256: `ed9e62a09b0dbac58e722ccc28b64c9925dfde6efe0c77552ae45b2092cd2dfa`
  * The `nobled-linux-amd64` binary is only provided to verify the SHA256. It was built with Interchain Security release [`v1.0.0-rc1`](https://github.com/strangelove-ventures/noble/blob/9cb79bde70dd1144e2d760930af27a6127ecc2ef/go.mod#L9). You can generate the binary following the build instructions in this repo.

  Example of using a volume mount to get the binary outside of the container onto your ubuntu server.
  ```
  #run on your ubuntu server
  # use the `realpath` for the volume mount.
  docker run -v /home/ubuntu/go/bin:/root/go/bin -it --entrypoint /bin/bash ghcr.io/strangelove-ventures/checksum:v.0.1.0
  ```
  ```
  # run inside docker container.
  git clone https://github.com/strangelove-ventures/noble.git
  cd noble
  git fetch
  git checkout v0.2.0
  make install
  sha256sum ~/go/bin/nobled
  ```
  expected return `ed9e62a09b0dbac58e722ccc28b64c9925dfde6efe0c77552ae45b2092cd2dfa`  
  
  Now, verify the checksum on your local ubuntu server  
  ```
  #run on your ubuntu server
  sha256sum /home/ubuntu/go/bin/nobled
  ```
  expected return `ed9e62a09b0dbac58e722ccc28b64c9925dfde6efe0c77552ae45b2092cd2dfa` 

## Endpoints

RPC:

1. `http://noble-rpc.ics-testnet:26657`

Seed nodes:

1. `233598946a15427b9541376e7cfc30dab07c4327@35.247.60.27:26656`
2. `359d63178736911e3e4c716f2491cafaa687351a@34.168.48.1:26656`
3. `3d2516052fd8b134428971d1218a149bba6e44be@35.247.10.56:26656`

## IBC Information

### Clients

* `07-tendermint-0`
  * Counterparty: [`provider`](/replicated-security/provider/README.md) `07-tendermint-2`

### Channels

* `channel-1`: consumer port
  * Counterparty: [`provider`](/replicated-security/provider/README.md) `channel-5`
* `channel-2`: transfer port
  * Counterparty: [`provider`](/replicated-security/provider/README.md) `channel-6`

## How to Join

The scripts provided in this repo will install Noble and optionally set up a Cosmovisor service with the auto-download feature enabled on your machine.

#### Bash Script

The scripts provided in this repo will install `nobled` and optionally set up a Cosmovisor service on your machine. 

Run either one of the scripts provided to set up a `noble-1` service:
* `join-rs-noble-1.sh` will create a `noble-1` service.
* `join-rs-noble-1-cv.sh` will create a `cosmovisor` service.
* Both scripts must be run either as root or from a sudoer account.
* Both scripts will attempt to build a binary from the [cosmos/noble-1] repo.

