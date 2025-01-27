# Testnet Demo Day # 12: 2025-Jan-28

In this demo day, we will demonstrate two of the features introduced in Interchain Security v6.4.0:
* Customizable slashing and jailing
* Power shaping via priority list 

We will post announcements in the `testnet-announcements` channel in Discord to coordinate activities during the event.

* Start time: `2025-01-28 14:00 UTC`
* End time: `2025-01-28 16:00 UTC`

## Customizable Slashing and Jailing

We have launched a chain called `test-infraction-1` with strict slashing parameters to demonstrate the [infraction parameters](https://cosmos.github.io/interchain-security/adrs/adr-020-cutomizable_slashing_and_jailing) feature of Interchain Security:
* A validator only needs to go offline for about a minute to get jailed for downtime.
* A downtime infraction will result in a 10% slash.

We will ask participants to delegate stake to the `sleepy 🥱` validator (`cosmosvaloper1hv3ghgjgy4rpkw8v3f59x6ajtcv6pjyzuvvh9p`), and then we will stop its `test-infraction-1` node to trigger the 10% slashing.

## Power Shaping via Priority List

We have launched a chain called `test-priority-1` with a validator set cap of 11 to demonstrate the [priority list](https://cosmos.github.io/interchain-security/features/power-shaping#prioritylist) feature of Interchain Security.

We will ask participants to opt-in to the `test-priority-1` chain. We will submit several update consumer transactions throughout the event to add different sets of validators to the priority list and trigger an update to the `test-priority-1` validator set.

## Testnet Incentives Program (TIP) Eligibility

* You must complete the tasks listed below by the time the event ends to earn points for TIP period 11.
* Available points: 2

### Tasks

* (1 point) Task 1: Delegate at least 1 ATOM to the `sleepy 🥱` validator before it is jailed.
```
gaiad tx staking delegate cosmosvaloper1hv3ghgjgy4rpkw8v3f59x6ajtcv6pjyzuvvh9p 1000000uatom --from <self-delegation wallet> --gas auto --gas-adjustment 2 --gas-prices 0.005uatom -y
```
* (1 point) Task 2: Opt-in to the `test-priority-1` consumer chain before it is removed.
```
gaiad tx provider opt-in 141 <pubkey> --from <self-delegation wallet> --gas auto --gas-adjustment 2 --gas-prices 0.005uatom -y
```


## Schedule (approximate times in UTC)

| Time  | Event                                                                         | Responsibility       |
| :---: | :---------------------------------------------------------------------------- | :------------------- |
| 14:00 | Validators 61-70 get placed in the priority list for `test-priority-1`        | Testnet coordinators |
| 14:15 | Validators 51-60 get placed in the priority list for `test-priority-1`        | Testnet coordinators |
| 14:30 | Validators 41-50 get placed in the priority list for `test-priority-1`        | Testnet coordinators |
| 14:45 | Validators 31-40 get placed in the priority list for `test-priority-1`        | Testnet coordinators |
| 15:00 | Validators 21-30 get placed in the priority list for `test-priority-1`        | Testnet coordinators |
| 15:15 | Validators 11-20 get placed in the priority list for `test-priority-1`        | Testnet coordinators |
| 15:30 | The priority list for `test-priority-1` is cleared                            | Testnet coordinators |
| 15:35 | Sleepy validator stops signing blocks in `test-infraction-1`                  | Testnet coordinators |
| 15:45 | Sleepy validator gets jailed **and slashed!**                                 | -                    |
| 16:00 | The `test-priority-1` chain is removed with a `remove-consumer` transaction   | Testnet coordinators |
| 16:00 | The `test-infraction-1` chain is removed with a `remove-consumer` transaction | Testnet coordinators |
