# Testnet Demo Day # 16: 2025-Jun-10

In this demo day, we will explore features introduced in Gaia v24:
* x/liquid module
* Expedited option for all proposals 

We will post announcements in the `testnet-announcements` channel in Discord to coordinate activities during the event.

* Start time: `2025-06-10 13:30 UTC`
* End time: `2025-06-10 14:00 UTC`

## x/liquid module

The `liquid` module has replaced the `lsm` one. To tokenize delegations, a delegator can submit a `gaiad tx liquid tokenize-share` transaction, specifying:
* The validator operator address
* The amount of shares to tokenize
* The owner of the tokenized shares 

We will ask validators to delegate 1 ATOM to the `demo-day` validator (`cosmosvaloper1euwz7vyqtnlkx8da7z4jdrr6ymghaly4ddwn5q`) and tokenize it from their self-delegation wallets:

* Delegate 1 ATOM
```
gaiad tx staking delegate cosmosvaloper1euwz7vyqtnlkx8da7z4jdrr6ymghaly4ddwn5q 1000000uatom --from <self-delegation-wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```
* Tokenize 1 ATOM
```
gaiad tx liquid tokenize-share cosmosvaloper1euwz7vyqtnlkx8da7z4jdrr6ymghaly4ddwn5q 1000000uatom <self-delegation-wallet> --from <self-delegation-wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```

## Expedited Option for All Proposals

We will put two expedited governance proposals into voting period at the start of the event.
* One proposal will set the downtime jail duration to 5 minutes (down from 10 minutes) in the slashing module.
* One proposal will add an address to the code_upload_access field of the wasm module.

We will ask validators to vote YES on both proposals to signal their participation in this demo day.
```
gaiad tx gov vote 271 yes --from <self-delegation-wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```
```
gaiad tx gov vote 272 yes --from <self-delegation-wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```

## Testnet Incentives Program (TIP) Eligibility

* You must complete the tasks listed below by the time the event ends to earn points for the June 2025 TIP period.
* Available points: 3

### Tasks

* (1 point) Task 1: Tokenize 1 ATOM from delegations to the `demo-day` validator (`cosmosvaloper1euwz7vyqtnlkx8da7z4jdrr6ymghaly4ddwn5q`).
* (1 point) Task 2: Vote on the expedited proposal (ID 271) to update the `slashing` module parameters.
* (1 point) Task 3: Vote on the expedited proposal (ID 272) to add an address to the `wasm` module code_upload_acess.


## Schedule (approximate times in UTC)

| Time  | Event                                              |
| :---: | :------------------------------------------------- |
| 13:30 | Expedited proposals are put in voting period       |
| 14:00 | Expedited proposals reach the end of voting period |
