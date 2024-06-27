# Testnet Game Day # 3: 2024-Jul-03

For our third game day, we'll have fun with permissioned proposals on cosmwasm.
We'll post announcements in the `testnet-announcements` channel in Discord
activities during the event.

* Start time: `2024-07-03 14:30 UTC`
* End time: `2024-07-03 16:30 UTC`

## Tasks

* Task 1: Vote on the `store-instantiate` proposal
* Task 2: Execute the new `gameday03` contract as many times as you like

### Testnet Incentives Program (TIP) Eligibility

* Task 1 will be counted as an eligibility criterion for TIP period 6.
* Task 2 is optional, but isn't it fun to stress-test the chain?

### Task 1: voting

The goal of task 1 is for us to pass a new `store-instantiate` proposal.
The proposal is up as `TBD.` Here's what it looks like:

```json

```

Vote on it:

```bash
gaiad tx gov vote TBD yes --from $MY_WALLET --gas auto --gas-adjustment 1.5 --gas-prices 0.005uatom
```

### [Optional] Task 2: executing the contract

The contract deployed is a simple counter. We can get its address by:


```bash
gaiad q wasm list-contracts-by-code 0
```

It'll return a list of contracts like:

```json
```

Let's call the address CONTRACT_ADDR. We can query the contract's current state by:

```bash
gaiad q wasm contract-state smart $CONTRACT_ADDR '{"get_count":{}}'
```

It'll return something like:

```json
{
    "data": {
        "count": 100
    }
}
```

If we execute it, we can increment the counter:

```bash
gaiad tx wasm execute $CONTRACT_ADDR '{"increment":{}}' --from $MY_WALLET --gas auto --gas-adjustment 1.5 --gas-prices 0.005uatom
```

Let's see how high we can get that counter over the course of an hour!
