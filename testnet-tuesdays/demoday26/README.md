# Testnet Demo Day # 26: CosmWasm Configs

Gaia v27.6.0 introduced the following changes to the CosmWasm configuration:

* The maximum contract size has been increased from 800 KiB to 1.6MiB (`1_677_722` bytes)
* The gRPC query allowlist now includes the following paths:
  * `/cosmos.staking.v1beta1.Query/Validator`
  *	`/cosmos.gov.v1.Query/Proposal`

We will use this demo day to demonstrate these changes.

* **Start Time:** `2026-07-27`
* **End Time:** `2026-07-28 15:00 UTC`

## Participation tracking

* [1 point] Task 1: [Upload a contract](#task-1-store-a-contract-on-chain) larger than 800 KiB (> `819,200` bytes) using your self-delegation address.

## Contract Size

* We have uploaded a contract to this repo: [large_counter_contract.wasm](large_counter_contract.wasm).
* This is the same as the [counter contract from game day 11](https://github.com/cosmos/testnets/tree/master/testnet-tuesdays/gameday11#phase-1-cosmwasm-warm-up), but it has been padded to increase its size to more than 800 KiB.

### Task 1: Store a contract on chain

Send a `store` transaction with.
```bash
tx_hash=$(gaiad tx wasm store large_counter_contract.wasm --from <self-delegation wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -o json -y | jq -r '.txhash')
# Wait for the transaction to go on chain
code_id=$(gaiad query tx $tx_hash -o json | jq -r '.events[] | select(.type=="store_code").attributes[] | select(.key=="code_id").value')
```

Once the contract has been uploaded, you can instantiate, execute, and query it just like the contract from game day 11.

## Allowlisted gRPC Queries

We have uploaded two contracts that use the allowlisted gRPC queries. You can use each of them to query either a validator or a governance proposal.

### Query a proposal

* Contract reference: [proposal-query](https://github.com/hyphacoop/cosmos-wasm-samples/tree/main/proposal-query) 
* Contract address in `provider`: `cosmos1r4dkjfa30fk74rgc3wuk44rn2xaf27j4yrxxllgxvf2um7fhl36q3ww0vc`

You can query proposal 320 this way:
```
gaiad q wasm contract-state smart cosmos1r4dkjfa30fk74rgc3wuk44rn2xaf27j4yrxxllgxvf2um7fhl36q3ww0vc '{"proposal":{"proposal_id":320}}'
```


### Query a validator

* Contract reference: [validator-query](https://github.com/hyphacoop/cosmos-wasm-samples/tree/main/validator-query)
* Contract address in `provider`: `cosmos1tmec7m2tm9cv5vg3uvx2pu86l0ztvkwa5hr906nnsvwcx9hhxk8q0hl9yu`
 
You can query the apple validator this way:
```
gaiad q wasm contract-state smart cosmos1tmec7m2tm9cv5vg3uvx2pu86l0ztvkwa5hr906nnsvwcx9hhxk8q0hl9yu '{"validator":{"validator_addr":"cosmosvaloper1arjwkww79m65csulawqngr7ngs4uqu5hr3frxw"}}'
```