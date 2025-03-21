# Testnet Game Day # 7: Upgrade Drill 2

* 2025-Mar-25
* Start time: `13:00 UTC`
* End time: `15:00 UTC`

We will use this game day to review the rollback command to recover from a chain halt.

## Summary

We have launched a chain, `test-halt-1`, running Gaia `v22.0.0`. On game day:
1. Half of the validators will upgrade to a new Gaia version at a specified halt height.
2. We will experience a chain halt
3. The validators that did not upgrade will roll back one block and re-join consensus.

Participants will be divided into two groups on game day:
* Group A: Upgrade to Gaia `v22.1.0` at the specified halt height
* Group B: Roll back and upgrade to Gaia `v22.1.0` **after** the chain halts

> We will swap the Group A and Group B roles for the next upgrade drill!

### Testnet Incentives Program (TIP) Eligibility

This event will be part of the March 2025 TIP period and will be worth up to **two points**.
* (1 point) Task 1: Sign at least one block on `test-halt-1`
* (1 point) Task 2: Bring the chain back online
  * Everyone who gets task 1 will get the one additional point if we manage to bring the chain back.


### Timeline (times in UTC)

|    Time     | Event                                               | Available tasks |
| :---------: | :-------------------------------------------------- | :-------------: |
| March 21-25 | Validators are set up                               |        1        |
|  March 25:  |                                                     |                 |
|    13:00    | v22.1.0 halt height and group members are announced |        1        |
|   ~13:30    | v22.1.0 halt height is reached                      |        1        |
|   ~13:35    | Consensus-breaking transaction is submitted         |        1        |
|   ~14:00    | Chain starts producing blocks again                 |       1,2       |

## 1. Set up a validator in `test-halt-1`

* Join the `test-halt-chain` using the details in the chain [README](/interchain-security/test-halt-1/README.md).

### Send funds from `provider` to `test-halt-1`

* All validators have been sent `uhalt` tokens in the `provider` chain.
  * The IBC-wrapped denom is `ibc/55627B1E427C5F9195350C9A9792873C3D88F124D5CC4CFA504E733B7F257E6F`.
  * If you need tokens, please tag a Hypha member in Discord.
* You must create a new self-delegation wallet in the `test-halt-1` chain and send it `uhalt` tokens to create a validator with.
* In the provider chain:
```
gaiad tx ibc-transfer transfer transfer channel-352 <wallet in test-halt-1> 11000000ibc/55627B1E427C5F9195350C9A9792873C3D88F124D5CC4CFA504E733B7F257E6F --from <provider validator wallet> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```

### Create validator in `test-halt-1`

* ⚠️ You **must** create the validator with the wallet that received the funds from your  `provider` validator: this is how we will link your `provider` validator to the `test-halt-1` one.
* Obtain the pubkey from your `test-halt-1` node:
```bash
PUBKEY=$(gaiad comet show-validator)
```
* Set up a validator JSON
```json
{
  "pubkey": $PUBKEY,
  "amount": "10000000uhalt",
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
gaiad tx staking create-validator validator.json --from <halt chain validator> --gas auto --gas-adjustment 3 --gas-prices 0.005uhalt -y
```

* Check that your validator is in the `test-halt-1` validator set:
```bash
gaiad q staking validators
```

## 2. (Group A only): Upgrade to Gaia v22.1.0
* Halt height: **TBA**
* You must set up the v22.1.0 binary ahead of the halt height.
* Using Cosmovisor, download the binary and set it up with the halt height as follows (Cosmosvisor must have auto-download disabled):
```bash
wget https://github.com/cosmos/gaia/releases/download/v22.1.0/gaiad-v22.1.0-linux-amd64 -O gaiad-v22.1.0
chmod +x gaiad-v22.1.0
export DAEMON_NAME=gaiad
export DAEMON_HOME=<path to .gaia folder>
cosmovisor add-upgrade v22.1.0 gaiad-v22.1.0 --upgrade-height TBA --force
```

## 3. Recover after consensus failure

### Group A

* You will see this message in the log when the chain halts:
```
ERR prevote step: consensus deems this block invalid; prevoting nil err="wrong Block.Header.LastResultsHash.
```
* Wait until enough validators in Group B recover their nodes.

### Group B

* You will see this message in the log when the chain halts:
```
ERR prevote step: consensus deems this block invalid; prevoting nil err="wrong Block.Header.LastResultsHash.
```
* Stop the node service and roll back your node to the previous height:
```bash
gaiad rollback --hard --home <path to .gaia folder>
```
* Install the new binary
```bash
wget https://github.com/cosmos/gaia/releases/download/v22.1.0/gaiad-v22.1.0-linux-amd64 -O gaiad-v22.1.0
chmod +x gaiad-v22.1.0
cp gaiad-v22.1.0 <path to .gaia folder>/cosmovisor/current/bin/gaiad
```
* Start the node again
* Wait until enough validators in Group B recover their nodes.

* Note that if you do not recover your node until after enough voting power has recovered and the chain starts again, you will see the following in your log (it doesn't change the rollback procedure):
   ```
   ERR CONSENSUS FAILURE!!! err="precommit step; +2/3 prevoted for an invalid block: wrong Block.Header.LastResultsHash.
   ```

