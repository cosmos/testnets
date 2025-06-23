# Testnet Demo Day # 17: 2025-Jun-24

In this demo day, we will continue to explore the `x/liquid` module introduced in Gaia v24.
We will post announcements in the `testnet-announcements` channel in Discord to coordinate activities during the event.

* Start time: `2025-06-24 13:30 UTC`
* End time: `2025-06-24 14:30 UTC`

## x/liquid module

The `liquid` module has replaced the `lsm` one. To tokenize delegations, a delegator can submit a `gaiad tx liquid tokenize-share` transaction, specifying:
* The validator operator address
* The amount of shares to tokenize
* The owner of the tokenized shares 

We will ask validators to:
- Delegate 2 ATOM to the `demo-day` validator (`cosmosvaloper1j39clwz90tzgjem2xdxs8dptchpza0x5a0wv4a`)
- Tokenize shares into two liquid tokens (1 ATOM per tokenization)
- Transfer 1 ATOM of tokenized shares to a rewards collection account (`cosmos1u7r9gyum6z5lvgl5k3u5m0q2g30ru55huz9nk7`)
- Redeem 1 ATOM of tokenized shares back into delegations

> All transactions must be signed by your validator's self-delegation wallet.

### 1. Tokenize shares

* Delegate 2 ATOM to the `demo-day` validator
```
gaiad tx staking delegate cosmosvaloper1j39clwz90tzgjem2xdxs8dptchpza0x5a0wv4a 2000000uatom --from <self-delegation-wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```
* Tokenize 1 ATOM for ownership transfer
```
gaiad tx liquid tokenize-share cosmosvaloper1j39clwz90tzgjem2xdxs8dptchpza0x5a0wv4a 1000000uatom <self-delegation-wallet> --from <self-delegation-wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```
* Tokenize 1 ATOM for redeeming tokens (it is the same command, but it will result in a different denom)
```
gaiad tx liquid tokenize-share cosmosvaloper1j39clwz90tzgjem2xdxs8dptchpza0x5a0wv4a 1000000uatom <self-delegation-wallet> --from <self-delegation-wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```

At this point, you should have two different tokenized shares from the demo day validator in your wallet balances (`XXX` and `YYY` will depend on when you submit the `tokenize-share` transaction):
```
gaiad q bank balances <self-delegation-wallet>
...
- amount: "1000000"
  denom: cosmosvaloper1j39clwz90tzgjem2xdxs8dptchpza0x5a0wv4a/XXX
- amount: "1000000"
  denom: cosmosvaloper1j39clwz90tzgjem2xdxs8dptchpza0x5a0wv4a/YYY
...
```

### 2. Transfer tokenized share ownership

* Obtain the record ID for one of the denoms that represent tokenized shares
```
gaiad q liquid tokenize-share-record-by-denom cosmosvaloper1j39clwz90tzgjem2xdxs8dptchpza0x5a0wv4a/XXX
```

* Transfer ownership of one tokenized share denom to `cosmos1u7r9gyum6z5lvgl5k3u5m0q2g30ru55huz9nk7`
```
gaiad tx liquid transfer-tokenize-share-record <record ID> cosmos1u7r9gyum6z5lvgl5k3u5m0q2g30ru55huz9nk7 --from <self-delegation-wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```

### 3. Redeem tokenized shares

* Redeem tokens for the denom whose ownership was not transferred
```
gaiad tx liquid redeem-tokens 1000000cosmosvaloper1j39clwz90tzgjem2xdxs8dptchpza0x5a0wv4a/YYY --from <self-delegation-wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```

## Testnet Incentives Program (TIP) Eligibility

* You must complete the tasks listed below by the time the event ends to earn points for the June 2025 TIP period.
* Available points: 3

### Tasks

* (1 point) Task 1: Tokenize 2 ATOM from delegations to the `demo-day` validator (`cosmosvaloper1j39clwz90tzgjem2xdxs8dptchpza0x5a0wv4a`).
* (1 point) Task 2: Transfer ownership of 1 ATOM of tokenized shares to `cosmos1u7r9gyum6z5lvgl5k3u5m0q2g30ru55huz9nk7`.
* (1 point) Task 3: Redeem 1 ATOM of tokenized shares from the `demo-day` validator.
