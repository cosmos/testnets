
# `test-locust-1` Chain Details

* **Chain-ID**: `test-locust-1`
* **denom**: `ulcst`
* **Current Gaia Version**: [`v23.1.1`](https://github.com/cosmos/gaia/releases/tag/v23.1.1)
* **Genesis File:**  [genesis.json](genesis.json)
* [Reference setup script](join-test-locust-1.sh)

## Config values to set

In `config.toml`:

```toml
[mempool]
size = 10000
max_txs_bytes = 1073741824
cache_size = 100000
keep-invalid-txs-in-cache = false
max_tx_bytes = 10485760

[consensus]
timeout_commit = "2s"

[instrumentation]
prometheus = true
namespace = "tendermint"
```

In `app.toml`:

```toml
minimum-gas-prices = "0.001ulcst"
```

## Joining as a validator

Run the setup script (or otherwise configure your node to connect to the network):

```bash
./join-test-locust-1.sh
```

Create a key:

```bash
gaiad keys add validator
```

Request funds from our faucet using your new key's address `https://faucet.polypore.xyz/request?chain=test-locust-1&address=<self-delegation wallet>`

Create a validator:

```bash
cat <<EOF > validator.json
{
  "pubkey": $(gaiad tendermint show-validator),
  "amount": "1000000ulcst",
  "moniker": "$YOUR_MONIKER_HERE",
  "identity": null,
  "website": null,
  "security": null,
  "details": null,
  "commission-rate": "0.1",
  "commission-max-rate": "0.2",
  "commission-max-change-rate": "0.01"
}
EOF
gaiad tx staking create-validator validator.json --from validator --gas auto --gas-adjustment 3 --gas-prices 0.001ulcst -y
```

## Endpoints

### Peers

* `5e74e7bbd62c87e5048944b0a9086a5798f9fd02@locust-sentry-1.ics-testnet.polypore.xyz:26656`
* `c74cf5f48de0ce2bedc0aa8118849968da47f835@locust-sentry-2.ics-testnet.polypore.xyz:26656`
* `a6ad4be73ae18f7d935f4ed21e5c64a434d0fc63@locust-sentry-3.ics-testnet.polypore.xyz:26656`
* `ce6d1f797a85f5816d1240d443bbf34572525a49@locust-sentry-4.ics-testnet.polypore.xyz:26656`

### RPC

* `https://rpc.locust-sentry-1.ics-testnet.polypore.xyz:443`
* `https://rpc.locust-sentry-2.ics-testnet.polypore.xyz:443`
* `https://rpc.locust-sentry-3.ics-testnet.polypore.xyz:443`
* `https://rpc.locust-sentry-4.ics-testnet.polypore.xyz:443`

### State sync

* `https://rpc.locust-sentry-1.ics-testnet.polypore.xyz:443`
* `https://rpc.locust-sentry-2.ics-testnet.polypore.xyz:443`
* `https://rpc.locust-sentry-3.ics-testnet.polypore.xyz:443`
* `https://rpc.locust-sentry-4.ics-testnet.polypore.xyz:443`

### Explorer

* `https://explorer.polypore.xyz/test-locust-1`
