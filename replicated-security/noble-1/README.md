
![Strangelove logo](https://raw.githubusercontent.com/strangelove-ventures/goc-public/main/sl.png)
# Noble Chain Information


The `noble-1` chain will be launched as a persistent dummy chain to test basic Interchain Security functionality.

* **Chain-ID**: `noble-1`
* **denom**: `unoble`
* **Spawn time**: `2023-02-09T16:00:00.000000Z`
* **GitHub repo**: [strangelove-ventures/noble-1](https://github.com/strangelove-ventures/noble)
* **Release**: [`v0.2.0`](https://github.com/strangelove-ventures/noble/releases/tag/v0.2.0) 
* **Genesis file with CCV state:** [TBD after spawntime](noble-1-genesis.json)

* **Genesis file _without CCV state_:** (noble-1-genesis-without-ccv.json), verify with `shasum -a 256 noble-1-genesis-without-ccv.json`
* **SHA256 for genesis file _without CCV state_**: `74f1aa802e267ad0d98b65ed3d34cd271c074e9ff5cbc34ecd5ccfd9f69f2818`

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
  * SHA256: `452c80a1982fba815450db1de2b02471db3756e59a1ce57a0f30a7ecf3f26364`
  * The `nobled-linux-amd64` binary is only provided to verify the SHA256. It was built with Interchain Security release [`v1.0.0-rc1`](https://github.com/cosmos/noble-1/releases/tag/v1.0.0-rc1). You can generate the binary following the build instructions in this repo.

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
  expected return `452c80a1982fba815450db1de2b02471db3756e59a1ce57a0f30a7ecf3f26364`  
  
  Now, verify the checksum on your local ubuntu server  
  ```
  #run on your ubuntu server
  sha256sum /home/ubuntu/go/bin/nobled
  ```
  expected return `452c80a1982fba815450db1de2b02471db3756e59a1ce57a0f30a7ecf3f26364` 

## Endpoints

RPC:

1. `http://noble-rpc.ics-testnet:26657`

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

