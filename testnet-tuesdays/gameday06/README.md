# Testnet Game Day # 6: Upgrade Drill 2025-Mar-11

* Start time: `13:00 UTC`
* End time: `14:30 UTC`

We will use this game day to review our upgrade processes through governance-gated and non-governance-gated upgrades.

## Summary

We have launched a chain, `test-upgrade-1`, running Gaia v21.0.1. We will upgrade it twice in a row.

The validator tasks will be to:
1. Set up a validator in `test-upgrade-1`
1. Vote on a proposal to upgrade to v22
2. Upgrade to v22.0.0
3. Upgrade to v22.1.0


### Testnet Incentives Program (TIP) Eligibility

This event will be part of the March 2025 TIP period and will be worth up to **four points**.
* (1 point) Task 1: Sign at least one block on `test-upgrade-1`
* (1 point) Task 2: Vote on the v22 software upgrade proposal
* (1 point) Task 3: Sign at least one block after the v22.0.0 upgrade height and before the v22.1.0 halt height
* (1 point) Task 4: Sign at least one of the 5 blocks following a consensus-breaking tx


### Timeline (times in UTC)

|    Time    | Event                                            | Available tasks |
| :--------: | :----------------------------------------------- | :-------------: |
| March 7-11 | Validators are set up                            |        1        |
| March 11:  |                                                  |                 |
|   13:00    | v22.0.0 upgrade proposal goes into voting period |       1,2       |
|   13:30    | v22.0.0 upgrade proposal passes                  |        1        |
|   ~13:40   | v22.0.0 upgrade height is reached                |       1,3       |
|   ~13:45   | v22.1.0 halt height is announced                 |       1,3       |
|   ~14:00   | v22.1.0 upgrade height is reached                |        1        |
|   ~14:05   | Consensus-breaking tx is submitted               |       1,4       |


## 1. Set up a validator in `test-upgrade-1`

* Join the `test-upgrade-chain` using the details in the chain [README](/interchain-security/test-upgrade-1/README.md).
* We encourage validators to use Cosmovisor `v1.7.0` to collect data on upgrade-related bugs.

### Send funds from `provider` to `test-upgrade-1`

* All validators have been sent `udrl` tokens in the `provider` chain.
  * The IBC-wrapped denom is `ibc/25F1EB6956137FB10323746935A2F9CDDCAD2F01A2C89C4A54AE78F2E74D0988`.
  * If you need tokens, please tag a Hypha member in Discord.
* You must create a new self-delegation wallet in the `test-upgrade-1` chain and send it `udrl` tokens  to create a validator with.
* In the provider chain:
```
gaiad tx ibc-transfer transfer transfer channel-345 <wallet in test-upgrade-1> 15000000ibc/25F1EB6956137FB10323746935A2F9CDDCAD2F01A2C89C4A54AE78F2E74D0988 --from <provider validator wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```

### Create validator in `test-upgrade-1`

* ⚠️ You **must** create the validator with the wallet that received the funds from your  `provider` validator: this is how we will link your `provider` validator to the `test-upgrade-1` one.
* Obtain the pubkey from your `test-upgrade-1` node:
```bash
PUBKEY=$(gaiad comet show-validator)
```
* Set up a validator JSON
```json
{
  "pubkey": $PUBKEY,
  "amount": "10000000udrl",
  "moniker": "your-moniker",
  "identity": null,
  "website": null,
  "security": null,
  "details": null,
  "commission-rate": "0.1",
  "commission-max-rate": "0.2",
  "commission-max-change-rate": "0.01"
}
```
* Submit create-validator transaction
```bash
gaiad tx staking create-validator validator.json --from <upgrade chain validator> --gas auto --gas-adjustment 3 --gas-prices 0.005udrl -y
```

* Check that your validator is in the `test-upgrade-1` validator set:
```bash
gaiad q staking validators
```

## 2. Vote on software upgrade proposal

* We will submit a proposal to upgrade `test-upgrade-1` to Gaia v22.0.0 and publish the proposal ID in Discord.
* The voting period is set to **30 minutes**.
* You must vote YES on this proposal:
```
gaiad tx gov vote <prop ID> yes --from <wallet in test-upgrade-1> --gas auto --gas-adjustment 3 --gas-prices 0.005udrl -y
```

## 3. Upgrade to Gaia v22.0.0

* You must set up the v22.0.0 binary ahead of the upgrade height.
* Using Cosmovisor, download the binary and set it up as follows (Cosmosvisor must have auto-download disabled):
```bash
wget https://github.com/cosmos/gaia/releases/download/v22.0.0/gaiad-v22.0.0-linux-amd64 -O gaiad-v22.0.0
chmod +x gaiad-v22.0.0
export DAEMON_NAME=gaiad
export DAEMON_HOME=<path to .gaia folder>
cosmovisor add-upgrade v22 gaiad-v22.0.0
```

## 4. Upgrade to Gaia v22.1.0

* You must set up the v22.1.0 binary ahead of the halt height.
* Using Cosmovisor, download the binary and set it up with the halt height as follows (Cosmosvisor must have auto-download disabled):
```bash
wget https://github.com/cosmos/gaia/releases/download/v22.1.0/gaiad-v22.1.0-linux-amd64 -O gaiad-v22.1.0
chmod +x gaiad-v22.1.0
export DAEMON_NAME=gaiad
export DAEMON_HOME=<path to .gaia folder>
cosmovisor add-upgrade v22.1.0 gaiad-v22.1.0 --upgrade-height <published halt height> --force
```


