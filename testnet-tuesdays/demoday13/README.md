# Testnet Demo Day #13: 2025-Feb-4

Join us for a demo day on **February 4th, 2025**. We'll be demonstrating the
use of smart contracts to create on-chain multisigs. This demo is powered by
the [cw-plus](https://github.com/CosmWasm/cw-plus) project, a simple set of
smart contracts you can use as building blocks for your own use cases.

* **Start Time:** `2025-02-04 14:00 UTC`
* **End Time:** `2025-02-04 16:00 UTC`


## TIP Points

* You'll earn one point for instantiating a contract during the event.

## Getting Started: Contract Instantiation

This `parameters.json` will instantiate a multisig with two addresses of equal weight.
Both must vote for a transaction to be executed.

```json
{
  "voters": [
    {
      "addr": "MULTISIG_ADDR_1",
      "weight": 1
    },
    {
      "addr": "MULTISIG_ADDR_2", 
      "weight": 1
    }
  ],
  "threshold": {
    "absolute_count": {
      "weight": 2
    }
  },
  "max_voting_period": {
    "time": 3600
  }
}
```

To instantiate the multisig, run this command:

```bash
gaiad tx wasm instantiate 66 "$(cat ./parameters.json)" --admin="MY_ADDRESS"
```

**This is the only task that yields TIP points.**

## Interacting with Your Contract

Let's find our contract's address:

```bash
gaiad q wasm list-contracts-by-creator MY_ADDRESS
```

Now we can send our contract money! Try doing a regular `gaiad tx bank send`
to fund it. Once the contract has a balance, we can use it to disburse funds
with multisig approval.

### Step 1: Propose a Transaction

The first step is to propose a transaction. Save the following JSON as `propose.json`:

```json
{
  "propose": {
    "title": "Send tokens",
    "description": "Transfer 1000 uatom to recipient",
    "msgs": [
      {
        "bank": {
          "send": {
            "to_address": "RECEPIENT",
            "amount": [
              {
                "denom": "uatom",
                "amount": "1000"
              }
            ]
          }
        }
      }
    ],
    "latest": null
  }
}
```

Then send the proposal:

```bash
gaiad tx wasm execute CONTRACT_ADDR "$(cat propose.json)" --from MY_ADDRESS
```

### Step 2: Voting on the Proposal

Each multisig member needs to vote on the proposal before execution. Save the following JSON as `vote.json`:

```json
{
  "vote": {
    "proposal_id": 1,
    "vote": "yes"
  }
}
```

Sign with the first multisig address:

```bash
gaiad tx wasm execute CONTRACT_ADDR "$(cat vote.json)" --from MULTISIG_ADDR_1
```

Sign with the second multisig address:

```bash
gaiad tx wasm execute CONTRACT_ADDR "$(cat vote.json)" --from MULTISIG_ADDR_2
```

### Step 3: Executing the Proposal

Once both votes are in, you can execute the proposal from any address that can
execute the contract. Save the following JSON as `execute.json`:

```json
{
  "execute": {
    "proposal_id": 1
  }
}
```

Run the execution command:

```bash
gaiad tx wasm execute CONTRACT_ADDR "$(cat execute.json)" --from MY_ADDRESS
```
