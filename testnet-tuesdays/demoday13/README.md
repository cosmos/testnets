# Testnet Demo Day #13: 2025-Feb-4

Join us for a demo day on **February 4th, 2025**. We'll be demonstrating the
use of smart contracts to create on-chain multisigs. This demo is powered by
the [cw-plus](https://github.com/CosmWasm/cw-plus) project, a simple set of
smart contracts you can use as building blocks for your own use cases.

* **Start Time:** `2025-02-04 14:00 UTC`
* **End Time:** `2025-02-04 17:00 UTC`


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
gaiad tx wasm instantiate 66 "$(cat ./parameters.json)" --admin="MY_SELF_DELEGATION_ADDR" --label=my-contract
```

**This is the only task that yields TIP points. You must use your
self-delegation address as the contract's admin so we can track your
participation!**

Note that MULTISIG_ADDR_1 and MULTISIG_ADDR_2 need not be the same
as your self-delegation address.

## Interacting with Your Contract

Let's find our contract's address:

```bash
gaiad q wasm list-contracts-by-creator MY_SELF_DELEGATION_ADDR
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
            "to_address": "RECIPIENT",
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

Then send the proposal. It has to come from one of the two addresses in the multisig:

```bash
gaiad tx wasm execute CONTRACT_ADDR "$(cat propose.json)" --from MULTISIG_ADDR_1
```

### Step 2: Voting on the Proposal

Since the first address proposed the transaction, it's automatically voted yes.
The remaining member needs to vote before it can be executed. Save the
following JSON as `vote.json`:

```json
{
  "vote": {
    "proposal_id": 1,
    "vote": "yes"
  }
}
```

Sign with the second multisig address:

```bash
gaiad tx wasm execute CONTRACT_ADDR "$(cat vote.json)" --from MULTISIG_ADDR_2
```

### Step 3: Executing the Proposal

Once both votes are in, you can execute the proposal from any address in the
multisig. Save the following JSON as `execute.json`:

```json
{
  "execute": {
    "proposal_id": 1
  }
}
```

Run the execution command:

```bash
gaiad tx wasm execute CONTRACT_ADDR "$(cat execute.json)" --from MULTISIG_ADDR_1
```
