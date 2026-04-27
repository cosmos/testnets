# Testnet Demo Day # 25: 2026-Apr-28

In this demo day, we will continue exploring the `x/tokenfactory` module introduced in Gaia v26.

* End time: `2026-04-28 14:30 UTC`

## Testnet Participation Eligibility

* You must complete the tasks listed below by the time the event ends to earn points for the April 2026 period.
* Available points: 3

### Tasks

* (1 point) Task 1: Instantiate a tokenfactory wasm contract
* (1 point) Task 2: Create a denom through the wasm contract
* (1 point) Task 3: Mint tokens through the wasm contract

## The `x/tokenfactory` Module

The `tokenfactory` module introduces the ability to create new tokens in a permissionless manner. This module includes bindings to perform operations via CosmWasm contracts.

For this demo day, we will ask validators to create and mint tokens using a sample contract. We have uploaded a minimal [sample contract](https://github.com/cosmos/tokenfactory/tree/main/wasm-demo/contracts/tokenfactory) with code `360` to the provider testnet that allows the contract owner to create and mint tokens. You will have to instantiate and then execute this contract.
 
> All transactions must be signed by your validator's self-delegation address.

### Task 1: Instantiate 

* Instantiate contract with code `360`.

```
txhash=$(gaiad tx wasm instantiate 360 "{}" --label "Token Factory Contract" --no-admin --from <self-delegation address> --gas-prices 0.005uatom --gas auto --gas-adjustment 1.5 -y)
```
* Save the contract address.
```
contract_address=$(gaiad q tx $txhash -o json | jq -r '.events[] | select(.type=="wasm").attributes[] | select(.key=="_contract_address").value')
```

### Task 2: Create denom

* Create a new denom. For this example, we will call it `my-token`.
  * The `--amount` argument transfers the 10 ATOM required to cover the denom creation fee.
```
gaiad tx wasm execute $contract_address '{ "create_denom": { "subdenom": "my-token" } }' --from <self-delegation address> --amount 10000000uatom --gas auto --gas-prices 0.005uatom --gas-adjustment 1.5 -y
```
* Obtain the new token denom.
```
denom=$(gaiad q tokenfactory denoms-from-admin $contract_address -o json | jq -r '.denoms[0]')
```

### Task 3: Mint tokens

* Mint tokens to your self-delegation address.
```
gaiad tx wasm execute $contract_address "{ \"mint_tokens\": {\"amount\": \"1000000\", \"denom\": \"$denom\", \"mint_to_address\": \"<self-delegation address>\"}}"  --from <self-delegation address> --gas auto --gas-prices 0.005uatom --gas-adjustment 1.5 -y
```

* You should have the following entry in your balances now.
```
gaiad q bank balance <self-delegation wallet> $denom -o json | jq -r '.balance.amount' 
```

