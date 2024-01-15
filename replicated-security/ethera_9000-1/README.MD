# `ethera_9000-1` Chain Details

The `ethera_9000-1` chain will be launched as an Aether persistent chain to test Interchain Security functionality.

- **Chain-ID**: `ethera_9000-1`
- **denom**: `ataeth`
- **Spawn time**: `2024-01-17T14:00:00.000000000Z`
- **Genesis file with CCV state:** [ethera_9000-1-genesis.json](./ethera_9000-1-genesis.json) (available after chain spawn time)
- **Reference binary**: [aetherd-linux-amd64](./aetherd-linux-amd64)
- **Binary sha256sum**: `810bb1172a64a59084171a16f1558b76addd556d5d1de7c130514f636d793dc9`
- **Genesis file _without CCV state_:** [ethera_9000-1-genesis-without-ccv.json](./ethera_9000-1-genesis-without-ccv.json), verify with `shasum -a 256 ethera_9000-1-genesis-without-ccv.json`
- **SHA256 for genesis file _without CCV state_**: `9f271f7e9d4aa791e9df5bf6a0c0557d7f805fb62ffce7ac3e1c49b0c124857f`
- **Version**: `v1.8.2-rc0`

- Genesis file hash
  - The SHA256 is used to verify against the genesis file (without CCV state) that the proposer has made available for review.
  - The [ethera_9000-1-genesis-without-ccv.json](./ethera_9000-1-genesis-without-ccv.json) file cannot be used to run the chain: it must be updated with the CCV (Cross Chain Validation) state after the spawn time is reached.
  - The genesis file includes funds for two relayers and faucet accounts as well as account with funds for different internal needs, `signed_blocks_window` has been set to `10000`, and `min_signed_per_window` has been set to `5%`.
- Binary hash
  - Built with Interchain Security release [`v3.1.0`](https://github.com/cosmos/interchain-security/releases/tag/v3.1.0).
  - aetherd-darwin-amd64: `dd3beaa1963414e3dcae38f47239e7e43f4d3a1bd72d8c75107400758b5c558d`
  - aetherd-darwin-arm64: `4a90f636f27188b29f9ac9a7ea1b3a63a18b1bf946f5a3b89b1d2876a04e868c`
  - aetherd-linux-amd64: `810bb1172a64a59084171a16f1558b76addd556d5d1de7c130514f636d793dc9`
  - aetherd-linux-arm64: `277854d05a1093fa4d8e041830679c42281bd1ebe7c022b3a481f1e8ae31b3c1`
  - aetherd-windows-amd64.exe: `63e41262c7f50f6f1a9329f9b914539746f549eca03bf180f35bb019c84726d8`
- Spawn time
  - Even if a proposal passes, the CCV state will not be available from the provider chain until after the spawn time is reached.

For more information regarding the consumer chain creation process, see [CCV: Overview and Basic Concepts](https://github.com/cosmos/ibc/blob/main/spec/app/ics-028-cross-chain-validation/overview_and_basic_concepts.md).

## Endpoints

Endpoints are exposed as subdomains for the sentry and snapshot nodes (described below) as follows (available after chain spawn time):

- https://rpc.ethera.aetherevm.com
- https://rest.ethera.aetherevm.com
- https://grpc.ethera.aetherevm.com

Seed nodes:

1. e6830209e30448357e64a77279c5784b0d0232ee@p2p1.ethera.aetherevm.com:26656
1. 88266f83878399bffd8c3d627a1f401cc389b81f@p2p2.ethera.aetherevm.com:26656

## IBC Information

Connections and channels will be posted here shortly after the chain launches.

## How to Join

### Hardware Requirements

- 4 Cores
- 32 GB RAM
- 2x512 GB SSD

### Software Versions

| Name   | Version    |
| ------ | ---------- |
| Aether | v1.8.2-rc0 |
| Go     | > 1.20     |

#### Bash Script

The scripts provided in this repo will install Aether and optionally set up a `Cosmovisor` service with the auto-download feature enabled on your machine.

Run script provided to set up a `aetherd` service without `Cosmovisor`:

- [join_ethera_9000-1.sh](./join_ethera_9000-1.sh) will create a `aetherd` service.
- Script must be run either as root or from a sudoer account.

Or run the second script provided to set up a `aetherd` service with `Cosmovisor`:

- [join_ethera_9000-1_cv.sh](./join_ethera_9000-1_cv.sh) will create a `cosmosvisor-aetherd` service.
- Script must be run either as root or from a sudoer account.

### Node manual installation

Install Aether binary.

```
$ wget https://github.com/cosmos/testnets/raw/master/replicated-security/ethera_9000-1/aetherd-linux-amd64 -O aetherd
```

After installation please check installed version by running:

`aetherd version --long`

You should see the following:

```
name: aether
server_name: aetherd
version: 1.8.2-rc0
```
