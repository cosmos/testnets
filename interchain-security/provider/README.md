
# `provider` Chain Details

The provider chain functions as an analogue of the Cosmos Hub. Its governance parameters will provide short voting periods to accelerate the creation of consumer chains.

* **Chain-ID**: `provider`
* **denom**: `uatom`
* **Current Gaia Version**: [`v20.0.0-rc0`](https://github.com/cosmos/gaia/releases/tag/v20.0.0-rc0), upgraded from v19 at block height `8361100`.
* **Genesis File:**  [provider-genesis.json](provider-genesis.json), verify with `shasum -a 256 provider-genesis.json`
* **Genesis sha256sum**: `91870bfb8671f5d60c303f9da8e44b620a5403f913359cc6b212150bfc3e631d`
* Launch Date: 2023-02-02
* Launch Gaia Version: [`v9.0.0-rc2`](https://github.com/cosmos/gaia/releases/tag/v9.0.0-rc2)

## v21.0.0-rc0 Upgrade

The provider chain will upgrade to Gaia [v21.0.0-rc0](https://github.com/cosmos/gaia/releases/tag/v21.0.0-rc0) on **October 16, 2024**.

* **Upgrade height: `8787650`**
  * Proposal ID: [201](https://explorer.polypore.xyz/provider/gov/201)
  * Mintscan countdown: https://www.mintscan.io/ics-testnet-provider/block/8787650
  * Target upgrade time: `13:30 UTC`

## Endpoints

### RPC

* `https://rpc.provider-sentry-01.ics-testnet.polypore.xyz`
* `https://rpc.provider-sentry-02.ics-testnet.polypore.xyz`
* `https://rpc-rs.cosmos.nodestake.top`

### API

* `https://rest.provider-sentry-01.ics-testnet.polypore.xyz`
* `https://rest.provider-sentry-02.ics-testnet.polypore.xyz`
* `https://api-rs.cosmos.nodestake.top`

### gRPC

* `https://grpc.provider-sentry-01.ics-testnet.polypore.xyz`
* `https://grpc.provider-sentry-02.ics-testnet.polypore.xyz`
* `https://grpc-rs.cosmos.nodestake.top`


### Seeds

1. `08ec17e86dac67b9da70deb20177655495a55407@provider-seed-01.ics-testnet.polypore.xyz:26656`
2. `4ea6e56300a2f37b90e58de5ee27d1c9065cf871@provider-seed-02.ics-testnet.polypore.xyz:26656`

### State sync

1. `https://provider-state-sync-01.ics-testnet.polypore.xyz:443`
2. `https://provider-state-sync-02.ics-testnet.polypore.xyz:443`

## Add to Keplr

Use this [jsfiddle](https://jsfiddle.net/uw4ar8qt/2/).

## Block Explorers

* https://explorer.polypore.xyz/provider/
* https://explorer.nodestake.org/cosmos-ics-testnet
* https://www.mintscan.io/ics-testnet-provider

## Snapshot

* https://nodestake.top/cosmos

## Faucet

* Visit `faucet.polypore.xyz` to request tokens and check your address balance.
* Request tokens through the [🚰┇testnet-faucet](https://discord.com/channels/669268347736686612/953697793476821092) Discord channel.

## Consumer Chains IBC Data

Connections and channels will be posted here shortly after a consumer chain launches.

### Clients

* `07-tendermint-28`
  * Counterparty: [`pion-1`](/interchain-security/pion-1/README.md) `07-tendermint-68`

### Connections

* `connection-19`
  * Counterparty: [`pion-1`](/interchain-security/pion-1/README.md) `connection-42`

### Channels

* `channel-31`: provider port
  * Counterparty: [`pion-1`](/interchain-security/pion-1/README.md) `channel-95`
* `channel-32`: transfer port
  * Counterparty: [`pion-1`](/interchain-security/pion-1/README.md) `channel-96`

## How to Join

The scripts provided in this repo will install Gaia and optionally set up a Cosmovisor service with the auto-download feature enabled on your machine.

You can choose to (not) use state sync. Your node will sync much faster if you use state sync, but it will not keep all the state locally.

### Bash Script

Run either one of the scripts provided in this repo to join the provider chain:
* `join-ics-provider.sh` will create a `gaiad` service.
* `join-ics-provider-cv.sh` will create a `cosmovisor` service.
* Both scripts must be run either as root or from a sudoer account.
* Both scripts will attempt to download the amd64 binary from the Gaia [releases](https://github.com/cosmos/gaia/releases) page. You can modify the `CHAIN_BINARY_URL` to match your target architecture if needed.

#### State Sync

* By default, the scripts will attempt to use state sync to catch up quickly to the current height.

#### Sync from Genesis

To sync from genesis, you will need to start with Gaia `v9.0.0-rc2`. First, modify the bash script as follows:
* Turn off state sync by setting `STATE_SYNC` to `false`.
* Set `CHAIN_BINARY_URL` to `'https://github.com/cosmos/gaia/releases/download/v9.0.0-rc2/gaiad-v9.0.0-rc2-linux-amd64'`, or run `git checkout v9.0.0-rc2` if you are building from source.

Run the script, and then follow the procedure below to upgrade to the latest version:

* Stop the service
  * `systemctl stop provider`, or `systemctl stop cv-provider` if you are using Cosmovisor.
* Set `halt-height = 168100` in `~/.gaia/config/app.toml`.
* Start the service.
  * `systemctl start provider`, or `systemctl start cv-provider` if you are using Cosmovisor.
* When the node reaches height `168100`, stop the service.
* Set `halt-height = 228100` in `~/.gaia/config/app.toml`.
* Replace the `v9.0.0-rc2` binary with the `v9.0.0-rc6` one in `~/go/bin`, or `~/.gaia/cosmovisor/current/bin` if you are using Cosmovisor.
* Start the service.
* When the node reaches height `228100`, stop the service.
* Set `halt-height = 1534600` in `~/.gaia/config/app.toml`.
* Replace the `v9.0.0-rc6` binary with the `v9.0.1-rc0` one.
* Start the service.
* When the node reaches height `1534600`, stop the service.
* Replace the `v9.0.0-rc6` binary with the `v9.1.0` one in `~/go/bin`, or `~/.gaia/cosmovisor/current/bin` if you are using Cosmovisor.
* When the node reaches height `1634770`, it will attempt to upgrade to Gaia `v10`. You can use Cosmovisor's auto-download feature or install the `v10.0.0-rc0` release binary.
* When the node reaches height `2532935`, it will attempt to upgrade to Gaia `v11`. You can use Cosmovisor's auto-download feature or install the `v11.0.0-rc0` release binary.
* When the node reaches height `2929050`, it will attempt to upgrade to Gaia `v12`. You can use Cosmovisor's auto-download feature or install the `v12.0.0-rc0` release binary.
* When the node reaches height `3313600`, it will attempt to upgrade to Gaia `v13`. You can use Cosmovisor's auto-download feature or install the `v13.0.0-rc0` release binary.
* When the node reaches height `3891450`, it will attempt to upgrade to Gaia `v14`. You can use Cosmovisor's auto-download feature or install the `v14.0.0-rc0` release binary.
* Before the node reaches height `4064500`, stop the service.
* Set `halt-height = 4064550` in `~/.gaia/config/app.toml`.
* Start the service.
* When the node reaches height `4064550`, stop the service.
* Replace the `v14.0.0-rc0` binary with the `v14.1.0-rc0` one.
* Set `halt-height = 0` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `5208900`, it will attempt to upgrade to Gaia `v15`. You can use Cosmovisor's auto-download feature or install the `v15.0.0-rc0` release binary.
* Before the node reaches height `5309400`, stop the service.
* Set `halt-height = 5309400` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `5309400`, stop the service.
* Replace the `v15.0.0-rc0` binary with the `v15.0.0-rc1` one.
* Set `halt-height = 0` in `~/.gaia/config/app.toml` and start the service.
* Before the node reaches height `5425200`, stop the service.
* Set `halt-height = 5425200` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `5425200`, stop the service.
* Replace the `v15.0.0-rc1` binary with the `v15.0.0-rc3` one.
* Set `halt-height = 0` in `~/.gaia/config/app.toml` and start the service.
* Before the node reaches height `5793400`, stop the service.
* Set `halt-height = 5793400` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `5793400`, stop the service.
* Replace the `v15.0.0-rc3` binary with the `v15.1.0` one.
* Set `halt-height = 0` in `~/.gaia/config/app.toml` and start the service.
* Before the node reaches height `5887600`, stop the service.
* Set `halt-height = 5887600` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `5887600`, stop the service.
* Replace the `v15.1.0` binary with the `v15.2.0` one.
* Set `halt-height = 0` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `6183000`, it will attempt to upgrade to Gaia `v16`. You can use Cosmovisor's auto-download feature or install the `v16.0.0-rc2` release binary.
* When the node reaches height `6380200`, it will attempt to upgrade to Gaia `v17`. You can use Cosmovisor's auto-download feature or install the `v17.0.0-rc0` release binary.
* Before the node reaches height `6882500`, stop the service.
* Set `halt-height = 6882500` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `6882500`, stop the service.
* Replace the `v17.0.0-rc0` binary with the `v17.2.0` one.
* Set `halt-height = 0` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `7093050`, it will attempt to upgrade to Gaia `v18`. You can use Cosmovisor's auto-download feature or install the `v18.0.0-rc3` release binary.
* Before the node reaches height `7303050`, stop the service.
* Set `halt-height = 7303050` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `7303050`, stop the service.
* Replace the `v18.0.0-rc3` binary with the `v18.1.0` one.
* Set `halt-height = 0` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `7513200`, it will attempt to upgrade to Gaia `v19`. You can use Cosmovisor's auto-download feature or install the `v19.0.0-rc0` release binary.
* Before the node reaches height `7618800`, stop the service.
* Set `halt-height = 7618800` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `7618800`, stop the service.
* Replace the `v19.0.0-rc0` binary with the `v19.0.0-rc3` one.
* Set `halt-height = 0` in `~/.gaia/config/app.toml` and start the service.
* Before the node reaches height `7724100`, stop the service.
* Set `halt-height = 7724100` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `7724100`, stop the service.
* Replace the `v19.0.0-rc3` binary with the `v19.0.0-rc4` one.
* Set `halt-height = 7947500` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `7947500`, stop the service.
* Replace the `v19.0.0-rc4` binary with the `v19.1.0` one.
* Set `halt-height = 0` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `8361100`, it will attempt to upgrade to Gaia `v20`. You can use Cosmovisor's auto-download feature or install the `v20.0.0-rc0` release binary.
* Before the node reaches height `8681200`, stop the service.
* Set `halt-height = 8681200` in `~/.gaia/config/app.toml` and start the service.
* When the node reaches height `8681200`, stop the service.
* Replace the `v20.0.0-rc0` binary with the `v20.0.0` one.
* When the node reaches height `8787650`, it will attempt to upgrade to Gaia `v21`. You can use Cosmovisor's auto-download feature or install the `v21.0.0-rc0` release binary.