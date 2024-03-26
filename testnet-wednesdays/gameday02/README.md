# Testnet Game Day # 2: 2024-Mar-27

For our second game day, we will explore the features of the Liquid Staking Module.
We will post announcements in the `testnet-announcements` channel in Discord to coordinate activities during the event.

* Start time: `2023-03-27 14:30 UTC`
* End time: `2023-03-27 16:00 UTC`

## Tasks

* Task 1: Bond shares
* Task 2: Tokenize shares
* (Optional) Task 3: Collect as many different liquid tokens as possible

### Testnet Incentives Program (TIP) Eligibility

* Tasks 1 and 2 will be counted as eligibility criteria for TIP period 4.
  * We will check that your validator has non-zero values for bond shares and liquid shares.
* Task 3 is optional, but we will post the rankings in this repo after the event is over!


### Task 1 sample: Bond shares

The goal of task 1 is to reach a non-zero value in the validator's `validator_bond_shares` field.

We created three accounts to illustrate one way to tokenize shares:

* `cosmos1fee375h0nmrymuray7jayqu9l7esg5g4z4u85u` - demo validator self-delegation wallet
  * `cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0` - demo validator address
* `cosmos1unrnuggv9psnn2yxexz0pgp4aedhnpfeelmzlx` - bonding wallet
* `cosmos15tp9z8jarf0sgwzzfel9gunyr9tcxh5qw4es65` - tokenizing wallet

After creating a validator with 5ATOM in self-delegation, we delegate an additional 5ATOM from the bonding wallet:

```
gaiad tx staking delegate cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 5000000uatom --from cosmos1unrnuggv9psnn2yxexz0pgp4aedhnpfeelmzlx --gas auto --gas-adjustment 1.5 --gas-prices 0.005uatom -y
```

We can query the validator to show us the delegator shares (now 10_000_000), bond shares, and liquid shares.
```
gaiad q staking validator cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 -o json | jq '.delegator_shares'
"10000000.000000000000000000"

gaiad q staking validator cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 -o json | jq '.validator_bond_shares'
"0.000000000000000000"

gaiad q staking validator cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 -o json | jq '.liquid_shares'
"0.000000000000000000"
```

Next, we bond the shares from the bonding wallet:
```
gaiad tx staking validator-bond cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 --from cosmos1unrnuggv9psnn2yxexz0pgp4aedhnpfeelmzlx --gas auto --gas-adjustment 1.5 --gas-prices 0.005uatom -y
```

The validator now shows the 5_000_000 validator bond shares.
```
gaiad q staking validator cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 -o json | jq '.delegator_shares'
"10000000.000000000000000000"

gaiad q staking validator cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 -o json | jq '.validator_bond_shares'
"5000000.000000000000000000"

gaiad q staking validator cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 -o json | jq '.liquid_shares'
"0.000000000000000000"
```

### Task 2 sample: Tokenize shares

The goal of task 2 is to reach a non-zero value in the validator's `liquid_shares` field.

We delegate 4ATOM from the tokenizing wallet first.
```
gaiad tx staking delegate cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 4000000uatom --from cosmos15tp9z8jarf0sgwzzfel9gunyr9tcxh5qw4es65 --gas auto --gas-adjustment 1.5 --gas-prices 0.005uatom -y
```
The validator now shows the increase in delegator shares.
```
gaiad q staking validator cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 -o json | jq '.delegator_shares'
"14000000.000000000000000000"

gaiad q staking validator cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 -o json | jq '.validator_bond_shares'
"5000000.000000000000000000"

gaiad q staking validator cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 -o json | jq '.liquid_shares'
"0.000000000000000000"
```
We can query the tokenizing wallet balances before submitting the tokenize transaction:
```
gaiad q bank balances cosmos15tp9z8jarf0sgwzzfel9gunyr9tcxh5qw4es65
balances:
- amount: "5999161"
  denom: uatom
```

Next, we tokenize 2ATOM from the tokenizing wallet.
```
gaiad tx staking tokenize-share cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 2000000uatom cosmos15tp9z8jarf0sgwzzfel9gunyr9tcxh5qw4es65 --from cosmos15tp9z8jarf0sgwzzfel9gunyr9tcxh5qw4es65 --gas auto --gas-adjustment 1.5 --gas-prices 0.005uatom -y
```
Querying the validator shows a non-zero amount in liquid shares:
```
gaiad q staking validator cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 -o json | jq '.delegator_shares'
"14000000.000000000000000000"

gaiad q staking validator cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 -o json | jq '.validator_bond_shares'
"5000000.000000000000000000"

gaiad q staking validator cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0 -o json | jq '.liquid_shares'
"2000000.000000000000000000"
```
The liquid tokens are also added to the tokenizing wallet balances:
```
gaiad q bank balances cosmos15tp9z8jarf0sgwzzfel9gunyr9tcxh5qw4es65
balances:
- amount: "2000000"
  denom: cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0/6
- amount: "5996484"
  denom: uatom
```

### [Optional] Task 3 sample: Send liquid tokens to the self-delegation wallet

The liquid tokens can be transferred just like any other denom. If you want to attempt task 3, you would send liquid tokens to your validator's self-delegation wallet with a bank send transaction:
```
gaiad tx bank send cosmos15tp9z8jarf0sgwzzfel9gunyr9tcxh5qw4es65 cosmos1fee375h0nmrymuray7jayqu9l7esg5g4z4u85u 1000000cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0/6 --from cosmos15tp9z8jarf0sgwzzfel9gunyr9tcxh5qw4es65 --gas auto --gas-adjustment 1.5 --gas-prices 0.005uatom -y
```
The balances for the validator self-delegation wallet include the new denom:
```
gaiad q bank balances cosmos1fee375h0nmrymuray7jayqu9l7esg5g4z4u85u
balances:
- amount: "1000000"
  denom: cosmosvaloper1fee375h0nmrymuray7jayqu9l7esg5g48pgjc0/6
- amount: "4998976"
  denom: uatom

```
