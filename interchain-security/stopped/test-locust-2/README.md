# `test-locust-2` Chain Details

* **Chain-ID**: `test-locust-2`
* **denom**: `ulcst`
* **Current Gaia Version**: Custom: [v24.0.99-alpha0](https://github.com/hyphacoop/gaia/releases/tag/v24.0.99-alpha0)
* **Genesis File:**  [genesis.json](genesis.json)
* [Reference setup script](join-test-locust-2.sh)

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
./join-test-locust-2.sh
```

Create a key:

```bash
gaiad keys add validator
```

Request funds from our faucet using your new key's address `https://faucet.polypore.xyz/request?chain=test-locust-2&address=<self-delegation wallet>`

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

* `25960d16ce876eb6a5d7cbbc728bad58c57ec6a2@locust-sentry-1.ics-testnet.polypore.xyz:26656`
* `5e45ae91ca5d2551aeaee41b1ed5d302c9771fe5@locust-sentry-2.ics-testnet.polypore.xyz:26656`
* `0479695c665a55f0deac3912c2d5faafd681cf75@locust-sentry-3.ics-testnet.polypore.xyz:26656`
* `4828cebecd894bec1124177440065e8c537bfbda@locust-sentry-4.ics-testnet.polypore.xyz:26656`

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

* `https://explorer.polypore.xyz/test-locust-2`
