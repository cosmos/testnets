# v7-Theta Testnets

As per the Cosmos Hub [roadmap](https://github.com/cosmos/gaia/blob/main/docs/roadmap/cosmos-hub-roadmap-2.0.md) Gaia v7-Theta (v7.0.x) is planned to be released in Q1 2022 and contains the following:
- Cosmos SDK v0.45.1
- Gravity DEX: Liquidity v1.4.6
- IBC 3.0.0
- Interchain Account Module

The chain-id will remain `cosmoshub-4` during the upgrade.

We have a number of ways you can test out the coming release, through local, developer, and public testnets.

## Theta Developer testnet

Integrators such as exchanges and wallets who want to test againt theta endpoints early may do so using the Theta devnet.

### Chain ID

`theta-devnet`

### Software version

We'll be tracking this branch until an RC has been cut: https://github.com/cosmos/gaia/tree/theta-prepare

### Endpoints

- **RPC:** `https://rpc.one.theta-devnet.polypore.xyz`
- **REST:** `https://rest.one.theta-devnet.polypore.xyz`

### Add to Keplr

Use this [jsfiddle](https://jsfiddle.net/hba2rxd0/4/).

**NOTE:** We'll be re-running these devnets regularly with fresh state. If you'd like us to add you to our genesis accounts each time, please make a PR with a cosmos address and stating that you'd like to be automatically included in future devnets.

## Theta Public testnet

We're running a public testnet to help validators participated in a simulated upgrade to the `v7-Theta` release candidate before upgrade on the mainnet.

You can find quickstart instructions [here](public-testnet/README.md).

### Chain ID
`theta-testnet-001`

### Genesis

Zipped genesis file is included [in this repository](public-testnet/genesis.json.gz).

Unzip and verify with shasum:
```
shasum -a 256 genesis.json
522d7e5227ca35ec9bbee5ab3fe9d43b61752c6bdbb9e7996b38307d7362bb7e genesis.json
```
### Endpoints

Endpoints are exposed as subdomains for the sentry and snapshot nodes (described below) as follows:

* `rpc.<node-name>.theta-testnet.polypore.xyz`
* `rest.<node-name>.theta-testnet.polypore.xyz`
* `grpc.<node-name>.theta-testnet.polypore.xyz`
* `p2p.<node-name>.theta-testnet.polypore.xyz`

We're running two sentries:

1. `https://sentry-01.theta-testnet.polypore.xyz`
2. `https://sentry-02.theta-testnet.polypore.xyz`

And the following nodes also serve snapshots every 1000 blocks:

3. `https://state-sync-01.theta-testnet.polypore.xyz`
4. `https://state-sync-02.theta-testnet.polypore.xyz`

### Persistent peers

```
5c9850dc5ec603b0c97ffd8d67bde3221b877acf@p2p.sentry-01.theta-testnet.polypore.xyz:26656
208683ee734ba3cec1cfc0c8bcbc326969641952@p2p.sentry-02.theta-testnet.polypore.xyz:26656
58e9d022962a3875fa22d7146949d0dc34e51ba6@p2p.state-sync-01.theta-testnet.polypore.xyz:26656
6954e0479cd71fa01aeed15e1a3b87c06433d827@p2p.state-sync-02.theta-testnet.polypore.xyz:26656
```

### Add to Keplr

Use this [jsfiddle](https://jsfiddle.net/kht96uvo/1/).

## Theta Local testnet

If you'd like to test out the upgrade using our local testnet, please follow the local testnet [instructions](local-testnet/README.md). This will allow you to bring up a single validator blockchain starting from `v6.0.0` and test the upgrade to `v7.0.0`.

We use an [exported genesis file](exported_genesis.json.tar.gz) and made [modifications](local-testnet/modified_genesis.json.tar.gz).

These modifications replace an existing validator (Coinbase Custory) with a new validator accounts that we control. User account [mnemonic](local-testnet/mnemonic.txt) and the [private validator key](local-testnet/priv_validator_key.json) are provided in this repo.
