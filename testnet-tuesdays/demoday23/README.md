# Testnet Demo Day # 23: 2026-Feb-3

In this demo day, we will explore the `x/tokenfactory` module introduced in Gaia v26.

* Start time: `2026-02-03 14:30 UTC`
* End time: `2026-02-03 15:30 UTC`

## Testnet Participation Eligibility

* You must complete the tasks listed below by the time the event ends to earn points for the February 2026 period.
* Available points: 3

### Tasks

* (1 point) Task 1: Create a new denom
* (1 point) Task 2: Mint tokens
* (1 point) Task 3: Burn tokens


## The `x/tokenfactory` Module

The `tokenfactory` module introduces the ability to create new tokens in a permissionless manner. To create a new denom, any account can submit a `gaiad tx tokenfactory create-denom <token name>` transaction. This will:
* Charge the account a denom creation fee
* Create a new token with the `factory/<wallet address>/<token name>` denom
* Set the account that submitted the transaction as the admin account

Once a tokenfactory denom has been created, the admin account can:
* Mint and burn tokens
* Modify the denom metadata
* Change admin ownership to another account

For this demo day, we will ask validators to:
- Create a new tokenfactory denom
- Mint tokenfactory tokens
- Burn tokenfactory tokens

> All transactions must be signed by your validator's self-delegation wallet.

### Task 1: Create denom

* Create a `mytoken` denom.
```
gaiad tx tokenfactory create-denom mytoken --from <self delegation wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```

### Task 2: Mint tokens
* Mint tokens to your self-delegation account
```
gaiad tx tokenfactory mint 2000000factory/<self delegation wallet>/mytoken --from <self delegation wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```

At this point, you should have the following entry in your balances:
```
gaiad q bank balances <self delegation wallet>
...
- amount: "2000000"
  denom: factory/<self delegation wallet>/mytoken
...
```

### Task 3: Burn tokens

* Burn tokens from your self-delegation account
```
gaiad tx tokenfactory burn 1000000factory/<self delegation wallet>/mytoken --from <self delegation wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```
At this point, you should have the following entry in your balances:
```
gaiad q bank balances <self delegation wallet>
...
- amount: "1000000"
  denom: factory/<self delegation wallet>/mytoken
...
```