# Testnet Demo Day # 20: 2025-Aug-12

In this demo day, we will leverage a couple of testnets outside of `provider` to explore the capabilities of IBC.

* Start time: `2025-08-12 13:30 UTC`
* End time: `2025-08-12 15:00 UTC`

### Testnet Incentives Program (TIP) Eligibility

* You must complete the tasks listed below by the time the event ends to earn points for the August 2025 TIP period.
* Available points: 4

#### Tasks

* (1 point) Task 1: Send `provider` uatom to `gaia-devnet`.
  * Send the tokens from your self-delegation wallet to `cosmos1ccv4kg2jkejcc2wp5wvyjvt2w3s3u3lhn3huxp`.
* (2 points) Task 2: Send `gaia-devnet` uatom to `cosmos1ccv4kg2jkejcc2wp5wvyjvt2w3s3u3lhn3huxp` in `gaia-devnet` from an Interchain Accounts controller in `provider`.
  * Set your self-delegation address in the ICA transaction memo.
* (1 point) Task 3: Send `provider` uatom to `gaia-devnet` using Packet Forward Middleware (PFM).
  * Set your self-delegation wallet address as the recipient.


> Please note that all the transactions listed in this document are sent from the `provider` chain. Queries that use the `--node` flag communicate with other chains.

## 1. IBC Transfer

The simplest transaction we can run with IBC is a token transfer from chain A to chain B. You can use the `tx ibc-transfer` command to send uatom from `provider` via IBC as follows:

```
gaiad tx ibc-transfer transfer transfer <channel-id> <recipient> --from <sender>> <amount>uatom --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```

We have set up the following channels between the `provider` and `gaia-devnet` chain:

| `provider`       | `gaia-devnet`  |
| ---------------- | -------------- |
| `channel-513`    | `channel-11`   |
| `connection-265` | `connection-3` |


### Task 1: Send tokens from `provider` to `gaia-devnet`
* Send 1000 uatom from your validator self-delegation wallet to `cosmos1ccv4kg2jkejcc2wp5wvyjvt2w3s3u3lhn3huxp` via `channel-513`.
* You can use this command as reference:
   ```
   gaiad tx ibc-transfer transfer transfer channel-513 cosmos1ccv4kg2jkejcc2wp5wvyjvt2w3s3u3lhn3huxp 1000uatom --from my_wallet --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
   ```

One way to check if the transfer went through is to look for a change in the recipient balance.
```
gaiad q bank balances cosmos1ccv4kg2jkejcc2wp5wvyjvt2w3s3u3lhn3huxp --node https://rpc.gaia-devnet.polypore.xyz
balances:
- amount: "1000"
  denom: ibc/5FEB332D2B121921C792F1A0DBF7C3163FF205337B4AFE6E14F69E8E49545F49
```
```
gaiad q ibc-transfer denom 5FEB332D2B121921C792F1A0DBF7C3163FF205337B4AFE6E14F69E8E49545F49 --node https://rpc.gaia-devnet.polypore.xyz
denom:
  base: uatom
  trace:
  - channel_id: channel-11
    port_id: transfer
```

> Visit the [IBC docs](hhttps://ibc.cosmos.network/v10/apps/transfer/ics20-v1/overview/) for more details on token transfers!


## 2. Interchain Accounts (ICA)

Interchain Accounts allow an account in a _controller_ chain to submit transactions through an account in a _host_ chain.

For this demo, we will register an account in `gaia-devnet` to submit a bank send transaction from a controller account in `provider`. We will use the `provider` IBC connection listed above (`connection-265`).

### Task 2: Send tokens in `gaia-devnet` using Interchain Accounts

* Step 1: Register an account in `gaia-devnet`. The following command will set `my_wallet` as the controller in `provider`.
   ```
   gaiad tx interchain-accounts controller register connection-265 --ordering ORDER_ORDERED --version "" --from my_wallet --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
   ```
* Step 2: Obtain the registered account address.
  ```
   gaiad q interchain-accounts controller interchain-account <my_wallet cosmos address> connection-265
   address: <host account address>
   ```
* Step 3: Fund the `gaia-devnet` account.
  * Visit `https://faucet.polypore.xyz/request?address=<host account address>&chain=gaia-devnet`
* Step 4: Generate the transaction.
  * Set the `from_address` field in [message.json](message.json) to your host account address.
  * Use the following command as reference (replace `cosmos1j7qzunvzx4cdqya80wvnrsmzyt9069d3gwhu5p` with your self-delegation wallet address in the `memo` field):
  ```
  gaiad tx interchain-accounts host generate-packet-data "$(cat message.json)" --encoding proto3 --memo "cosmos1j7qzunvzx4cdqya80wvnrsmzyt9069d3gwhu5p" > send-packet-data.json
  ```
* Step 5: Submit the packet data transaction
  ```
   gaiad tx interchain-accounts controller send-tx connection-265 send-packet-data.json --from my_wallet --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
  ```

One way to check if the transfer went through is to look for a change in the recipient balance.
```
gaiad q bank balances cosmos1ccv4kg2jkejcc2wp5wvyjvt2w3s3u3lhn3huxp --node https://rpc.gaia-devnet.polypore.xyz
balances:
- amount: "1000"
  denom: ibc/5FEB332D2B121921C792F1A0DBF7C3163FF205337B4AFE6E14F69E8E49545F49
- amount: "2000000"
  denom: uatom
```

> Visit the [IBC docs](https://ibc.cosmos.network/v10/apps/interchain-accounts/overview/) for more details on Interchain Accounts!

## 3. Packet Forward Middleware (PFM)


The PFM module allows us to send tokens from chain A to chain C if there is a chain B between them (`A->B->C`).

We have set up the following channels to link `provider` to `gaia-devnet` through a third chain, `test-enoki-1` ([Enoki](https://github.com/hyphacoop/cosmos-enoki/) is Hypha's reference Interchain binary):

### `provider` - `test-enoki-1`

| `provider`       | `test-enoki-1` |
| ---------------- | -------------- |
| `channel-512`    | `channel-6`    |
| `connection-264` | `connection-3` |


### `test-enoki-1` - `gaia-devnet`

| `test-enoki-1` | `gaia-devnet`  |
| -------------- | -------------- |
| `channel-4`    | `channel-10`   |
| `connection-2` | `connection-2` |


For this demo, we will send a packet from `provider` to `test-enoki-1`, which will forward it to `gaia-devnet`:

| Source                    | Forwarding chain            | Destination   |
| ------------------------- | --------------------------- | ------------- |
| `provider` channel-512 -> | `test-enoki-1` channel-4 -> | `gaia-devnet` |

PFM uses JSON-encoded data in the `memo` field to set the packet route. This data looks as follows if we want to tell the forwarding chain we want to set `cosmos1ccv4kg2jkejcc2wp5wvyjvt2w3s3u3lhn3huxp` as the receiver in the destination chain:
```json
{
  "forward": {
    "receiver": "cosmos1ccv4kg2jkejcc2wp5wvyjvt2w3s3u3lhn3huxp",
    "port": "transfer",
    "channel": "channel-4",
    "timeout": "10m"
  }
}
```

### Task 3: Send tokens from `gaia-devnet` to `provider` using PFM

* Use the following command as reference (replace `cosmos1j7qzunvzx4cdqya80wvnrsmzyt9069d3gwhu5p` with your self-delegation wallet):
  ```
  gaiad tx ibc-transfer transfer transfer channel-512 "pfm" --memo "{\"forward\": {\"receiver\": \"cosmos1ccv4kg2jkejcc2wp5wvyjvt2w3s3u3lhn3huxp\",\"port\": \"transfer\",\"channel\": \"channel-4\",\"timeout\": \"10m\"}}" 1000uatom --from cosmos1j7qzunvzx4cdqya80wvnrsmzyt9069d3gwhu5p --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
  ```

One way to check if the transfer went through is to look for a change in the recipient balance.
```
gaiad q bank balances cosmos1ccv4kg2jkejcc2wp5wvyjvt2w3s3u3lhn3huxp --node https://rpc.gaia-devnet.polypore.xyz
balances:
- amount: "1000000"
  denom: ibc/305DB945ADCBD56CFA2DE8C5C1516CFF2696A3B060E98514A7D4BF664F1D30A1
- amount: "1000"
  denom: ibc/5FEB332D2B121921C792F1A0DBF7C3163FF205337B4AFE6E14F69E8E49545F49
- amount: "2000000"
  denom: uatom
```

```
gaiad q ibc-transfer denom 305DB945ADCBD56CFA2DE8C5C1516CFF2696A3B060E98514A7D4BF664F1D30A1 --node https://rpc.gaia-devnet.polypore.xyz
denom:
  base: uatom
  trace:
  - channel_id: channel-10
    port_id: transfer
  - channel_id: channel-6
    port_id: transfer
```

> Visit the [ibc-apps repo](https://github.com/cosmos/ibc-apps/tree/main/middleware/packet-forward-middleware) for more details on PFM!
