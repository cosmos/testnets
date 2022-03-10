### Vega Upgrade testnet

> Deprecated since March 2022 in favor of [v7-Theta Testnet](../v7-Theta/)

This testnet targets validators and integrators who want to test their tooling with Vega. It mirrors the state of mainnet before the Vega testnet with modifications to enable liveness and with convenient parameters to simulate a governance permissioned software upgrade.

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

- **Launch date**: 2021-11-05
- **Chain-ID**: `vega-test`
- **Gaia Version:** `release/v6.0.0-rc3`
- **Genesis File:** `https://github.com/cosmos/vega-test/raw/master/public-testnet/modified_genesis_public_testnet/genesis.json.gz`
- **Genesis sha256sum**: `89d1cb03d1dbe4eb803319f36f119651457de85246e185d6588a88e9ae83f386`
- **Endpoints**:
  
| Node              | Node ID                                    | Public IP      | Ports                                                 |
| ----------------- | ------------------------------------------ | -------------- | ----------------------------------------------------- |
| HYPHA "Coinbase"    | `99b04a4efd48846f654da25532c85bd1fa6a6a39` | `198.50.215.1` | p2p: `46656`, rpc: `46657`, api: `4317`, grpc: `4090` |
| HYPHA "Certus-one"  | `1edc806e29bfb380dc0298ce4fded8e3e8554e2a` | `198.50.215.1` | p2p: `36656`, rpc: `36657`, api: `3327`, grpc: `3080` |
| Interchain "Binance" Sentry | `66a9e52e207c8257b791ff714d29100813e2fa00` | `143.244.151.9` | p2p: `26656 `, rpc: `26657 ` , api: `1317 `, grpc: `9090` |

- **Peers with state-sync snapshots**
  * `5303f0b47c98727cd7b19965c73b39ce115d3958@134.122.35.247:26656`
  * `9e1e3ce30f22083f04ea157e287d338cf20482cf@165.22.235.50:26656`
  * `b7feb9619bef083e3a3e86925824f023c252745b@143.198.41.219:26656`
- **[Network statistics](https://monitor.prod.earthball.xyz/d/UJyurCTWz/cosmos-dashboard?orgId=2)**
- **[Block Explorer](https://vega-explorer.hypha.coop/)**
- **Faucet**: Please make an issue in the [vega-test](https://github.com/cosmos/vega-test) repsository or ask in the `#validator-verified` channel in the Cosmos Developers discord
- 
