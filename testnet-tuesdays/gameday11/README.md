# Testnet Game Day # 11: CosmWasm Colour Battle

* 2025-Sep-9
* Start time: `13:30 UTC`
* End time: `15:00 UTC`

### Summary

* The Cosmos Hub has made CosmWasm fully permissionless, which means anybody can store new contracts on chain without a governance proposal.
* We will showcase the CosmWasm module by having validators engage in a _friendly_ game of "Zone Control".
* We will divide this Game Day in two phases: a warm-up and the colour battle.
  * The warm-up phase will have participants store, instantiate, and execute a sample CosmWasm contract.
  * The colour battle phase will have participants attempt to fill a 2D array with a specific value by executing a contract.


### Timeline (times in UTC)

| Time  | Event          | Available tasks |
| :---: | :------------- | :-------------: |
| 13:30 | Phase 1 begins |        1        |
| 13:45 | Phase 2 begins |       1,2       |
| 15:00 | Game Day ends  |        -        |


## Testnet Incentives Program (TIP) Eligibility

This event will be part of the September 2025 TIP period and will be worth up to **two points**.

1. (1 point) Task 1: [Store a contract code](#task-1-store-a-contract-on-chain) using your self-delegation wallet address.
2. (1 point) Task 2: [Execute the phase 2 contract](#task-2-set-a-point) using your self-delegation wallet address.
3. (Bragging rights only!): Control the most points by the end of Game Day (block height `TBA`).

## Phase 1: CosmWasm Warm-up

Phase 1 will involve uploading a contract code. This folder includes a sample counter [contract](counter.wasm), which allows a user to increment and query a counter variable held in state.

### Task 1: Store a contract on chain

Send a `store` transaction and use the hash to obtain the contract code id.
```bash
tx_hash=$(gaiad tx wasm store counter.wasm --from <self-delegation wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -o json -y | jq -r '.txhash')
# Wait for the transaction to go on chain
code_id=$(gaiad query tx $tx_hash -o json | jq -r '.events[] | select(.type=="store_code").attributes[] | select(.key=="code_id").value')
```

### Instantiate a contract

Send an `instantiate` transaction and use the hash to obtain the contract address.
```bash
tx_hash=$(gaiad tx wasm instantiate $code_id '{"count":1}' --label "test-counter" --no-admin --from <self-delegation wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -o json -y | jq -r '.txhash')
# Wait for transaction to go on chain
contract_address=$(gaiad query tx $tx_hash -o json | jq -r '.events[] | select(.type=="instantiate").attributes[] | select(.key=="_contract_address").value')
```

### Query a contract

You can obtain the current counter value with a `get_count` query:
```bash
gaiad q wasm contract-state smart $contract_address '{"get_count":{}}' -o json  | jq -r '.data.count'
```

### Execute a contract

Increase the counter value with:
```bash
gaiad tx wasm execute $contract_address '{"increment":{}}' --from <self-delegation wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```
You can query the count afterwards to confirm the value increased.

## Phase 2: Colour Battle

We're playing an on-chain version of "Zone Control"!
* The goal of the game is to cover as many points on a 128x128 grid with your team colour by the end of the event.
* We will tally the number of points each team has claimed and announce the winner team shortly afterwards.

There will be four teams, each one named after a colour:

| Team name | Colour hex code | Starting area |
|:-----:|:------:|:-----:|
|<span style="color:#FFABCA; font-weight:bold">=></span> Carnation <span style="color:#FFABCA; font-weight:bold"><=</span> | `FFABCA` | `[0,0]` - `[63,63]` |
|<span style="color:#5A3776; font-weight:bold">=></span> Eminence <span style="color:#5A3776; font-weight:bold"><=</span> | `5A3776` | `[64,0]` - `[127,63]` |
| <span style="color:#AFAED4; font-weight:bold">=></span> Periwinkle <span style="color:#AFAED4; font-weight:bold"><=</span> | `AFAED4` |  `[0,64]` - `[63,127]` |
| <span style="color:#FFD28B; font-weight:bold">=></span> Sunset <span style="color:#FFD28B; font-weight:bold"><=</span> | `FFD28B` | `[64,64]` - `[127,127]` |



> **We will kick off Phase 2 by announcing the contract address and team assignments!**

The grid will look like this at the beginning of the event:

![Colour Battle Starting State](battle-start.png)

### `bitmap-pay` Contract

We will instantiate a contract based on the [`bitmap-pay`](https://github.com/hyphacoop/cosmos-wasm-samples/tree/main/bitmap-pay) example from the [cosmos-wasm-samples](https://github.com/hyphacoop/cosmos-wasm-samples) repo.
* There is a cost associated with setting a point. It is the sum of the supply and update costs:
* **Supply cost**: The more points are set on the grid, the higher the cost will be to set any additional point.
  * This will stop increasing when all 16,384 points have been set.
* **Update cost**: The more times a point is set, the higher the cost will be to update it again.
  * This will **not** stop increasing.

### Task 2: Set a point

First, obtain the cost of the point you are interested in with the `get_cost` query.
* Both x and y coordinates will have a range of `[0,127]`.
```bash
gaiad q wasm contract-state smart <contract address> '{"get_cost":{"x":<x coordinate>,"y",<y coordinate>}}' -o json  | jq -r '.data'
```

Then, execute the `set_point` function to set a point in the grid:
```bash
gaiad tx wasm execute <contract address> '{"set":{"x":<x coordinate>,"y":<y coordinate>,"z":"<your team colour hex code>"}}' --from <self-delegation wallet> --amount <cost>uatom --gas auto --gas-adjustment 3 --gas-prices $GAS_PRICE -y
```

You can confirm the point was set with the `get_point` query:
```bash
gaiad q wasm contract-state smart <contract address> '{"get_point":{"x":<x coordinate>,"y",<y coordinate>}}' -o json  | jq -r '.data'
```

There is also a `get_grid` query, which will return the full grid in a single string of 6-character chunks:
```bash
gaiad q wasm contract-state smart <contract address> '{"get_grid":{}}' -o json  | jq -r '.data.z_values'
```