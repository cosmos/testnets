# Cosmos-Hub Vega Upgrade Testnet Instructions

This repository provides instructions and files to help test the Cosmos Hub Vega upgrade locally or with a public testnet.

This Vega upgrade will integrate new releases of Cosmos-SDK v0.44.2 and IBC 1.2.1 into Gaia.

## Versions
For the testnet instructions in this repository, we'll be running with the following versions:

- **Before the upgrade:** Chain ID `cosmoshub-4`, Gaia version `v5.0.5`
- **After the upgrade:** Chain ID `cosmoshub-4`, Gaia version: [`v6.0.0-rc3`](https://github.com/cosmos/gaia/releases/tag/v6.0.0-rc3)

Note that the Chain ID will not change after the upgrade.

## Testnets 🎛️ 

You can test out the upgrade locally or join us on the public testnet.

### Local testnet 
You can run a local testnet with a modified exported genesis file. Find detailed instructions in [local-testnet/README.md](local-testnet/README.md). You can either modify the genesis file yourself by following the readme or use the modified genesis file we've [prepared](local-testnet/modified_genesis_local_testnet/genesis.json.gz).

### Public testnet
We're inviting the community to participate in a public testnet for the Vega upgrade. Follow the instructions in [public-testnet/README.md](public-testnet/README.md).
