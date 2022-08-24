# Scheduled Upgrades 🗓️ 

## Schedule

| Date                       | Testnet plan                |
| -------------------------- | --------------------------- |
| March 10 2022  | ✅  Launch testnet chain with Gaia v6.0.0 (previous version)  |
| March 16 2022  | ✅  Submit v7-Theta software [upgrade proposal](https://testnet.cosmos.bigdipper.live/proposals/66)           |
| March 16 2022  | ✅  Voting ends                 |
| March 17 2022  | ✅  Theta upgrade ([Gaia v7.0.0-rc0](https://github.com/cosmos/gaia/releases/tag/v7.0.0-rc0)) is live on the testnet |
| October 2022  |   Submit v8-Rho software [upgrade proposal]()           |
| October 2022  |   Voting ends                 |
| October 2022  |   Rho upgrade ([Gaia v8.0.0-rc0](https://github.com/cosmos/gaia/releases/tag/v8.0.0-rc0)) is live on the testnet |


## 2022-10 v8-Rho upgrade

* **Version before upgrade**: `v7.0.x`
* **Version after upgrade**: `v8.0.0-rc0`


### Validators participating in upgrade testing


### Upgrade height and binaries


## 2022-03-17 v7-Theta upgrade

* **Version before upgrade**: `v6.0.x`
* **Version after upgrade**: `v7.0.0-rc0`


The v7-Theta upgrade was successfully completed on **March 17th, 2022 at 16:14 UTC (12:14 PM ET)**. The upgrade halt height was `9283650`, and blocks were being produced 7 minutes later.

Relevant log lines:
```
Mar 17 12:07:40 earth cosmovisor[822]: 12:07PM ERR UPGRADE "v7-Theta" NEEDED at height: 9283650
Mar 17 12:14:42 earth cosmovisor[13563]: 12:14PM INF finalizing commit of block hash=D83798E929BA7FB1F740C7E583EC2918EC40EDD3249B14BC72876130053BD0EE height=9283651 module=consensus num_txs=0 root=17F5C1754B53350A543A6BB29DE5E35A9DB9874AF89117220117213E53E38344
```

### Validators participating in upgrade testing

* 0base.vc
* 20MB Lab
* Cosmic Validator - Testnet
* Everstake
* Itachi
* KalpaTech
* P2P.ORG Validator
* Provalidator
* StakeWithUs
* Stakely.io
* WeStaking

Thank you to all participating validators! These validators received `THETA` tokens to their self-delegation addresses as part of our [collectables program](https://interchain-io.medium.com/cosmos-hub-theta-testnet-token-collectables-d08967ba2875)!

### Upgrade height and binaries

* Upgrade height: `9283650` 
* Estimated update time: 16:00 UTC
* On-chain proposal:

```bash=
gaiad tx gov submit-proposal software-upgrade v7-Theta \
--title v7-Theta \
--deposit 500000uatom \
--upgrade-height 9283650 \
--upgrade-info '{"binaries": {"linux/amd64": "https://github.com/cosmos/gaia/releases/download/v7.0.0-rc0/gaiad-v7.0.0-rc0-linux-amd64?checksum=sha256:4e95eaca51d6e0ab61b7a759aafc4b4674c270b8ffa764cb953d3808a1f9e264","linux/arm64": "https://github.com/cosmos/gaia/releases/download/v7.0.0-rc0/gaiad-v7.0.0-rc0-linux-arm64?checksum=sha256:574916076c6e0960fa980522ed9a404967a6f4c306448d09649a11e5626cd991","darwin/amd64": "https://github.com/cosmos/gaia/releases/download/v7.0.0-rc0/gaiad-v7.0.0-rc0-darwin-amd64?checksum=sha256:547182dd4456e8d71ff5256484458f0690a865d5c9f2185286dd9ab71dd11b10","windows/amd64": "https://github.com/cosmos/gaia/releases/download/v7.0.0-rc0/gaiad-v7.0.0-rc0-windows-amd64.exe?checksum=sha256:4eea1a32af3ed79632cfc8cca7088a10b3d89f767310e3c24fe31ad99492f6c8"}}' \
--description "This on-chain upgrade governance proposal is to adopt gaia v7.0.0 which includes a number of updates, fixes and new modules. By voting YES to this proposal, you approve of adding these updates to the Cosmos Hub.\n\n# Background\n\nSince the last v6-Vega upgrade at height 86950000 there have been a number of updates, fixes and new modules added to the Cosmos SDK, IBC and Tendermint.\n\nThis is a proposal to adopt the first release candiate for the [v7-Theta](https://github.com/cosmos/gaia/blob/main/docs/roadmap/cosmos-hub-roadmap-2.0.md#v7-theta-upgrade-expected-q1-2022) upgrade on the public testnet.\n\nIt contains the following changes:\n\n* (gaia) bump [cosmos-sdk](https://github.com/cosmos/cosmos-sdk) to [v0.45.1](https://github.com/cosmos/cosmos-sdk/releases/tag/v0.45.1). See [CHANGELOG.md](https://github.com/cosmos/cosmos-sdk/blob/v0.45.1/CHANGELOG.md#v0451---2022-02-03) for details.\n* (gaia) bump [ibc-go](https://github.com/cosmos/ibc-go) module to [v3.0.0](https://github.com/cosmos/ibc-go/releases/tag/v3.0.0). See [CHANGELOG.md](https://github.com/cosmos/ibc-go/blob/v3.0.0/CHANGELOG.md#v300---2022-03-15) for details.\n* (gaia) add [interhcian account](https://github.com/cosmos/ibc-go/tree/main/modules/apps/27-interchain-accounts) module (interhchain-account module is part of ibc-go module).\n* (gaia) bump [liquidity](https://github.com/gravity-devs/liquidity/x/liquidity) module to [v1.5.0](https://github.com/Gravity-Devs/liquidity/releases/tag/v1.5.0). See [CHANGELOG.md](https://github.com/Gravity-Devs/liquidity/blob/v1.5.0/CHANGELOG.md#v150---20220223) for details.\n* (gaia) bump [packet-forward-middleware](https://github.com/strangelove-ventures/packet-forward-middleware) module to [v2.1.1](https://github.com/strangelove-ventures/packet-forward-middleware/releases/tag/v2.1.1).\n* (gaia) add migration logs for upgrade process.\n\n# On-Chain Upgrade Process\nWhen the network reaches the halt height, the state machine program of the Cosmos Hub will be halted. The classic method for upgrading requires all validators and node operators to manually substitute the existing state machine binary with the new binary. There is also a newer method that relies on Cosmovisor to swap the binaries automatically. Cosmovisor also includes the ability to download the binaries automatically before swapping them. To test a simulated local upgrade please see the local testnet documentation. Because it is an onchain upgrade process, the blockchain will be continued with all the accumulated history with continuous block height." \
--fees 1500uatom \
--gas auto \
--from <key_name> \
--chain-id theta-testnet-001 \
--node tcp://localhost:26657 \
--yes
```