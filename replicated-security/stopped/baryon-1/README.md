
# `baryon-1` Chain Details

> Status: **STOPPED**

The `baryon-1` chain will be launched as a Neutron persistent chain to test Interchain Security functionality.

* **Chain-ID**: `baryon-1`
* **denom**: `untrn`
* **minimum-gas-prices**: `0untrn`
* **timeout_commit**: `2s`
* **Spawn time**: `2023-02-07T15:00:00.000000Z`
* **GitHub repo**: [neutron-org/neutron](https://github.com/neutron-org/neutron.git)
* **Release**: [`v0.2.0`](https://github.com/neutron-org/neutron/releases/tag/v0.2.0)
* **Genesis file with CCV state:** [baryon-1-genesis.json](baryon-1-genesis.json)

* **Reference binary**: [neutrond-linux-amd64](./neutrond-linux-amd64)
* **Binary sha256sum**: `16a5fe8860b8c15eb11057b622e8749704c18d0e1dedae2e100ab397e732a708`
* **Genesis file _without CCV state_:** [baryon-1-genesis-without-ccv.json](baryon-1-genesis-without-ccv.json), verify with `shasum -a 256 baryon-1-genesis-without-ccv.json`
* **SHA256 for genesis file _without CCV state_**: `3a3bf846787b5c1f624a3ab1aca155375852d10d4108e9617aeba52744fa1980`


* Genesis file hash
  * The SHA256 is used to verify against the genesis file (without CCV state) that the proposer has made available for review.
  * The `baryon-1-genesis-without-ccv.json` file cannot be used to run the chain: it must be updated with the CCV (Cross Chain Validation) state after the spawn time is reached.
  * The genesis file includes funds for a relayer and a faucet account as well as account with funds for different internal needs, `signed_blocks_window` has been set to `864000`, and `min_signed_per_window` has been set to `5%`.
* Binary hash
  * The `neutrond-linux-amd64` binary is only provided to verify the SHA256. It was built with Interchain Security release [`v0.2.0`](https://github.com/neutron-org/neutron/releases/tag/v0.2.0). You can generate the binary following the build instructions in that repo or using one of the scripts provided here.
* Spawn time
  * Even if a proposal passes, the CCV state will not be available from the provider chain until after the spawn time is reached.

For more information regarding the consumer chain creation process, see [CCV: Overview and Basic Concepts](https://github.com/cosmos/ibc/blob/main/spec/app/ics-028-cross-chain-validation/overview_and_basic_concepts.md).

## Endpoints

Endpoints are exposed as subdomains for the sentry and snapshot nodes (described below) as follows:

* `https://rpc.baryon.ntrn.info`
* `https://rest.baryon.ntrn.info`
* `https://grpc.baryon.ntrn.info`

Seed nodes:

1. `e2c07e8e6e808fb36cca0fc580e31216772841df@p2p.baryon.ntrn.info:26656`

The following state sync node serve snapshots every 1000 blocks:

1. `https://rpc.baryon.ntrn.info:443`

## IBC Information

Connections and channels will be posted here shortly after the chain launches.

### Clients

* `07-tendermint-0`
  * Counterparty: [`provider`](/replicated-security/provider/README.md) `07-tendermint-1`

### Channels

* `channel-0`: consumer port
  * Counterparty: [`provider`](/replicated-security/provider/README.md) `channel-2`
* `channel-1`: transfer port
  * Counterparty: [`provider`](/replicated-security/provider/README.md) `channel-3`

## How to Join

> Please be aware that state sync is not working at the time (new nodes must sync from genesis). This will be fixed in an upcoming `baryon-1` upgrade.

### Hardware Requirements

* 4 Cores
* 32 GB RAM
* 2x512 GB SSD

### Software Versions

| Name               | Version  |
|--------------------|----------|
| Neutron            | v0.2.0   |
| Go                 | > 1.18   |

The scripts provided in this repo will install Neutron and set up a Cosmovisor service with the auto-download feature enabled on your machine.

#### Bash Script

The script provided in this repo will install `neutrond` and set up a Cosmovisor service on your machine. 

Run script provided to set up a `baryon-1` service:
* `join-rs-baryon-1.sh` will create a `baryon-1` service with `cosmovisor` support.
* Script must be run either as root or from a sudoer account.
* Script will attempt to build a binary from the [neutron-org/neutron] repo.

### Node manual installation

Build and install neutron binary. 

```
$ git clone -b v0.2.0 https://github.com/neutron-org/neutron.git
$ cd neutron
$ make install
```

after installation please check installed version by running:

`neutrond version --long`

You should see the following:
```
name: neutron
server_name: neutrond
version: 0.2.0
commit: 4ebd7ae7ab1e614e8fbd9a18a8c86d8045ae787c

``` 
