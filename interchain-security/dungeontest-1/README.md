
# `dungeontest-1` Chain Details

> Status: **PENDING**

The `dungeontest-1` chain is launched to test the dungeon chain.

---

<!--
  *Compress the dungeond file (due to size)*
  cp $(which dungeond) ./dungeond-linux-amd64
  shasum -a 256 dungeond-linux-amd64
  tar -czvf dungeond-linux-amd64.tar.gz dungeond-linux-amd64
  rm ./dungeond-linux-amd64

  *Get Genesis*
  cp ~/.dungeond/config/genesis.json genesis.json

  *Decompress Base Genesis*
  tar -xvzf dungeon-genesis.json.tar.gz "./network/dungeon-1/genesis.json" --one-top-level=genesis.json --strip-components 4


  *Get CCV Only from genesis*
  cat genesis.json | jq .app_state.ccvconsumer > dungeon-ccv.json

  *Genesis Without CCV Consumer*
  cp genesis.json tmp-without-ccv.json
  jq 'del(.app_state.ccvconsumer)' tmp-without-ccv.json > dungeon-genesis-without-ccv.json
  rm tmp-without-ccv.json genesis.json

  *Compress Dungeon Gneisis Without CCV*
  tar -czvf dungeon-genesis-without-ccv.json dungeon-genesis-without-ccv.json
-->


* **Chain-ID**: `dungeontest-1`
* **denom**: `udgn`
* **Spawn time**: `2024-08-28T13:30:00.000000Z`
* **Stop time**: `-`
* **GitHub repo**: [Crypto-Dungeon/dungeonchain](https://github.com/Crypto-Dungeon/dungeonchain)
* **Commit**: [`f2325ed0e0d341f4280992ac3cbc61b9a967d578`](https://github.com/Crypto-Dungeon/dungeonchain/commit/f2325ed0e0d341f4280992ac3cbc61b9a967d578) **(v0.1.0)**
* **Genesis file with CCV state:** [TBA](TBA)


* **Reference binary**: `https://github.com/Crypto-Dungeon/dungeonchain/raw/main/network/dungeontest-1/dungeond-0.1.0-amd64.tar.gz`
  * `tar -xvzf dungeond-0.1.0-amd64.tar.gz`
* **Binary sha256sum**: `e44429f3f67c2c57ced7be208092264aed712e6d7b4140e03878552d50dbb2e8`
* **Genesis file _without CCV state_:** `genesis.json.tar.gz`
  * `tar -xvzf genesis.json.tar.gz "./network/dungeontest-1/genesis.json" --one-top-level=genesis.json --strip-components 4`
* **SHA256 for genesis file _without CCV state_**: `8ee776b221f6c2440079ed5c5bb440f68741aa31988e00babcfc93ae965adb98`

The following items will be included in the consumer addition proposal:

* Genesis file hash
  * The SHA256 is used to verify against the genesis file (without CCV state) that the proposer has made available for review.
  * The `genesis.json.tar.gz` file cannot be used to run the chain: it must be updated with the CCV (Cross Chain Validation) state after the spawn time is reached.
  * The genesis file includes funds for a relayer and a faucet account, and `signed_blocks_window` has been set to `20000`.
* Binary hash
  * The `dungeond-linux-amd64` binary is only provided to verify the SHA256. It was built with commit [`f2325ed0e0d341f4280992ac3cbc61b9a967d578`](https://github.com/Crypto-Dungeon/dungeonchain/commit/f2325ed0e0d341f4280992ac3cbc61b9a967d578). You can generate the binary following the build instructions in that repo or using one of the scripts provided here.
* Spawn time
  * Even if a proposal passes, the CCV state will not be available from the provider chain until after the spawn time is reached.

## Endpoints

Persistent nodes:

<!-- TODO: Dungeon team needs to launch a node before as a peer -->
1. `9c9affab7652c9c5a2898d0dd244840c90bc8ba9@dungeon-cherry.ics-testnet.polypore.xyz:26656`
2. `4c9fe209358b0821fe48be7e449a3ed02af7b740@dungeon.ics-testnet.polypore.xyz:26656`

## IBC Information

Connections and channels will be posted here shortly after the chain launches.

## How to Join

#### Bash Scripts

Run either one of the scripts provided to set up a `dungeon` service:
* `join-rs-dungeon.sh` will create a `dungeon` service.
* `join-rs-dungeon-cv.sh` will create a `cosmovisor` service.
* Both scripts must be run either as root or from a sudoer account.
* Both scripts will attempt to build a binary from the [cosmos/interchain-security] repo.
