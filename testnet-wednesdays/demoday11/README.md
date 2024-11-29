# Testnet Demo Day # 11: 2024-Dec-4

In this demo day, we will demonstrate how a sovereign chain can become an opt-in consumer chain through a software upgrade.
We will post announcements in the `testnet-announcements` channel in Discord to coordinate activities during the event.

* Start time: `2024-12-04 15:30 UTC`
* End time: `2024-12-04 17:00 UTC`

## Testnet Incentives Program (TIP) Eligibility

* You must complete the tasks listed below by the time the event ends to earn one point for TIP period 10.

### Tasks

* Task 1: Opt in to the `test-butterfly-1` consumer chain with a public key that differs from the `provider` chain one.
  * You may opt in from the moment the consumer chain is created up until it is removed.
```
gaiad tx provider opt-in <consumer ID> <consumer chain public key> --from <self-delegation wallet> --gas auto --gas-adjustment 2 --gas-prices 0.005uatom -y
```

## Changeover Plan

The changeover demo is divided into three phases:
1. Sovereign Chain Start
2. Consumer Chain Creation
3. Consumer Chain Launch

### 2024-11-29: Sovereign Chain Start

The chain is started using a reference binary from the `interchain-security` repo.

#### Sovereign chain details

* Chain ID: `test-butterfly-1`
* Denom: `ubttr`
* Binary: `interchain-security-sd` v6.2.0
  * Build instructions
    * Several binaries (`-sd`, `-cd`, `-cdd`, and `-pd`) will be placed in `~/go/bin`
    ```
    git clone https://github.com/cosmos/interchain-security.git
    git checkout v6.2.0
    make install
    ```
* Peers
  ```
  "3c53448db7746810cc31c6fd6d69d998ee3aa13b@butterfly-tomato.ics-testnet.polypore.xyz:26656,4bfaa6aab539ec51b89343ee56ea7274e12cdf36@butterfly-cherry.ics-testnet.polypore.xyz:26656,019463585337a6c254733a2f2f402ab2fe7c8b09@butterfly-node.ics-testnet.polypore.xyz:26656"
  ```
* Genesis file: [butterfly-genesis.json](./butterfly-genesis.json)
* Use [this script](./join-butterfly-sovereign.sh) as reference for settting up a node.
* If you wish to create a validator in the sovereign chain, please request `test-butterfly-1` tokens in the `interchain-security-testnet` Discord channel.

### 2024-12-02: Consumer Chain Creation

* The consumer chain is created in the `provider` chain with a spawn time set to `null`.
* Validators can opt-in from this point up until the chain is stopped with a `remove-consumer` transaction.
* If you have set up a node in the `test-butterfly-1` network, you can obtain the pubkey to use in the opt-in transaction with `interchain-security-sd tendermint show-validator`.
* The slash window will be set to 100,000 blocks (roughly one week at 6s per block), but the chain will be stopped on the same day the consumer chain launches.
* **Validators who opt-in but do not sign blocks will be in no danger of being jailed for downtime in this consumer chain.**

### 2024-12-04: Consumer Chain Launch

#### Consumer chain details

* Binary: `interchain-security-cdd` v6.2.0
  * Build instructions
    * `interchain-security-cdd` should already be in `~/go/bin` if you ran `make install` in the same machine when setting up the sovereign binary.
    ```
    git clone https://github.com/cosmos/interchain-security.git
    git checkout v6.2.0
    make install
    ```
* Consumer genesis file: TBD
* Consumer ID: TBD

#### Launch Day Schedule (approximate times in UTC)

| Time  | Event                                                                   | Responsibility       |
| :---: | :---------------------------------------------------------------------- | :------------------- |
| 15:30 | A software upgrade proposal is submitted to the sovereign chain         | Testnet coordinators |
| 15:35 | The software upgrade proposal passes                                    | -                    |
| 16:00 | The upgrade height is reached and `test-butterfly-1` stops              | -                    |
| 16:05 | The consumer chain is updated with a spawn time set to the current time | Testnet coordinators |
| 16:10 | The consumer genesis file is posted in this repo                        | Testnet coordinators |
| 16:15 | (See below) The consumer chain nodes start using the new binary.        | Validators           |
| 16:20 | The CCV channel is established                                          | Testnet coordinators |
| 16:30 | The consumer chain is confirmed to be Interchain-secured                | Testnet coordinators |
| 17:00 | The consumer chain is stopped with a `remove-consumer` transaction      | Testnet coordinators |

#### Consumer Chain Start Post-Upgrade

1. After the upgrade height is reached in the sovereign chain, stop the service.
2. Copy the consumer genesis file to the location specified below.
  * The consumer genesis file posted in this repo will be created as follows:
    ```
    gaiad q provider consumer-genesis <consumer ID> -o json --node https://rpc.provider-sentry-01.ics-testnet.polypore.xyz:443 > ccv.json
    jq '.params.reward_denoms |= ["ubttr"]' ccv.json > ccv-denom.json
    jq '.params.provider_reward_denoms |= ["uatom"]' ccv-denom.json > ccv-provider-denom.json
    jq -s '.[0].app_state.ccvconsumer = .[1] | .[0]' butterfly-genesis-sovereign.json ccv-provider-denom.json > consumer-genesis.json
    ```
  * The resulting `consumer-genesis.json` includes the Cross-Chain Validation (CCV) state and must be copied to a specific location in the consumer chain node:
    ```
    mkdir -p ~/.sovereign/config
    cp consumer-genesis.json ~/.sovereign/config/genesis.json
    ```
  * The `.sovereign` home directory is hard-coded in the post-changeover binary. It is fine if your actual chain home folder is something else, but the genesis file with the CCV state **must** be placed in this directory.
3. Update the service or rename the binary so the consumer chain binary (`interchain-security-cdd`) is used instead of the sovereign one (`interchain-security-sd`).
4. Restart the sovereign chain service.
