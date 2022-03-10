# Cosmos Hub Testnets

This repository contains current and archived genesis files, scripts, and configurations for Cosmos Hub testnets. Key network information is present here, but for step-by-step instructions on how to join whichever testnet is currently running, please check out the tutorial in [Cosmos Hub documentation](https://hub.cosmos.network/main/hub-tutorials/join-testnet.html). You can also find legacy network information [here](legacy/README.md).

## Network Information for Active Testnets

### v7-Theta Upgrade testnet

This testnet targets validators who want to test their uprade readiness with Theta before mainnet launch. It mirrors the state of mainnet before with modifications to an exported genesis to enable liveness and with convenient parameters to simulate a governance permissioned software upgrade.

- **Launch date**: 2022-03-10
- **Chain-ID**: `theta-testnet-001`
- **Gaia Version:** `release/v6.0.0`
- **Genesis File:** `https://github.com/cosmos/testnets/raw/master/v7-theta/public-testnet/genesis.json.gz`
- **Genesis sha256sum**: `522d7e5227ca35ec9bbee5ab3fe9d43b61752c6bdbb9e7996b38307d7362bb7e`
- **Block Explorer**: https://explorer.theta-testnet.polypore.xyz
- **Faucet**: Please ask in the `#validator-verified` channel in the Cosmos Developers discord
- **Endpoints**: We are running nodes named `sentry-01`, `sentry-02`, `state-sync-01`, and `state-sync-02`, with endpoints as follows:
  - RPC: `https://rpc.<node-name>.theta-testnet.polypore.xyz`
  - REST:`https://rest.<node-name>.theta-testnet.polypore.xyz`
  - GRPC: `https://grpc.<node-name>.theta-testnet.polypore.xyz`
  - P2P: `https://p2p.<node-name>.theta-testnet.polypore.xyz`
- **Peers**: You can add these in your persistent peer list.
```
5c9850dc5ec603b0c97ffd8d67bde3221b877acf@p2p.sentry-01.theta-testnet.polypore.xyz:26656
208683ee734ba3cec1cfc0c8bcbc326969641952@p2p.sentry-02.theta-testnet.polypore.xyz:26656
58e9d022962a3875fa22d7146949d0dc34e51ba6@p2p.state-sync-01.theta-testnet.polypore.xyz:26656
6954e0479cd71fa01aeed15e1a3b87c06433d827@p2p.state-sync-02.theta-testnet.polypore.xyz:26656
```

### Vega Upgrade testnet

This testnet targets validators and integrators who want to test their tooling with Vega. It mirrors the state of mainnet before the Vega testnet with modifications to enable liveness and with convenient parameters to simulate a governance permissioned software upgrade.

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

### Developer nets

#### v7-Theta DevNet

- **Launch date:** 2022-03-10
- **Chain ID**: `theta-devnet`
- **Software version:** We'll be tracking this branch until an RC has been cut: https://github.com/cosmos/gaia/tree/theta-prepare
- **Endpoints:**
  - **RPC:** `https://rpc.one.theta-devnet.polypore.xyz`
  - **REST:** `https://rest.one.theta-devnet.polypore.xyz`

#### testnet.cosmos.network

This [developer testnet](https://tutorials.cosmos.network/connecting-to-testnet/testnet-tutorial.html) targets developers who want to test applications against testnet gaia nodes. Unlike the upgrade testnets, this testnet doesn't mirror the state of the mainnet. As of January 2022, it was running gaia version 5.0.8. 

## Cosmos Hub Testnet Plan

The  goals of the  Cosmos Hub testnet program are to build confidence among validators and full node operators to test upcoming software upgrades; provide developers with a low-risk production-like environment to test integrations with Cosmos Hub; and to make historical hub software releases and states readily available for testing and querying. Beyond these goals, testnets could also become a site for R&D for new development and governance approaches in a fast-moving and live context.

We are expecting the roll out as follows:

### 1. Rolling testnets for each gaia upgrade.

These testnets aim to help validators set up robust automation around upgrades using Cosmovisor. This phase includes working directly with validators to understand current pain points and develop tools and processes to support their workflows. The `v6-vega` testnet was in Q4 2021 and we are currently working on `v7-Theta` testnet for Q1 2022.

Based on learnings from vega, we will configure `v7-Theta` so that:
* Testnet coordinators will operate 4+ validators with combined voting power exceeding 75% total power
* These validators will require an addition of ~550M bonded test ATOM (current bonded ATOM are ~180M) and a corresponding increase in total supply.
* Tesnet coordinators control a faucet with >175M liquid tokens
* Testnet coordinators can reward validators with limited edition secondary tokens that are named after their release (`Theta`, `Rho`, `Epsilon`, `Lambda`). The testnets will have a fixed supply of 1000 each of such tokens.

### 2. Persistent testnet.

After the `v7-Theta` testnet we will assess whether we can continue using the same testnets on a persistent basis for future upgrades.






