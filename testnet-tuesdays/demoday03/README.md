# Testnet Demo Day # 3: 2024-Mar-13

In this demo day, we will demonstrate operations related to validator set-up.
We will post announcements in the `testnet-announcements` channel in Discord to coordinate activities during the event.

* Start time: `2023-03-13 14:00 UTC`
* End time: `2023-03-13 16:00 UTC`

## Testnet Incentives Program (TIP) Eligibility

* You must complete the tasks listed below by the time the event ends to remain eligible for TIP period 4.

## Tasks

* Task 1: Assign a consensus key in `pion-1` that differs from the `provider` chain.
* Task 2: Set a `security_contact` in the validator description.

### Assign a consensus key

We set up a validator that started off by using the same keys in the `provider` chain and the `pion-1` chain.

We followed the steps below to make the validator use an assigned key in `pion-1`. For this example, we are running both `provider` and `pion-1` nodes in the same machine.
* The provider home is in `~/.gaia`
* The pion-1 home is is in `~/.neutrond`


#### 1. Collect the starting consensus keys.

* provider
```
jq '.address' ~/.gaia/config/priv_validator_key.json 
"924F15DA7C71921D1DE379DD0BA4493D47A094E9"
```

* pion-1
```
jq '.address' ~/.neutrond/config/priv_validator_key.json 
"924F15DA7C71921D1DE379DD0BA4493D47A094E9"
```

#### 2. Generate a new consensus key.


One way we can generate a new set of keys is by running neutrond init in a separate home folder:
```
neutrond init new-keys --home ~/.keys-home
```

```
jq '.address' ~/.keys-home/config/priv_validator_key.json 
"B2931DD76A1C080A43E977593F73ADF8C39CC7D9"
```

Next we obtain the public key we will use in the `assign-consensus-key` transaction:
```
key=$(neutrond tendermint show-validator --home ~/.keys-home)
echo $key
{"@type":"/cosmos.crypto.ed25519.PubKey","key":"eRvfzBl8gYpci8vCMZE0QK+BcHJe+1VGANhOzzYB+qA="}
```

#### 3. Assign the consensus key

```
gaiad tx provider assign-consensus-key pion-1 $key --from validator --home ~/.gaia --gas auto --gas-adjustment 1.6 --gas-prices 0.005uatom -y
```

Confirm the key has been assigned
```
gaiad q provider validator-consumer-key pion-1 cosmosvalcons1jf83tknuwxfp680r08wshfzf84r6p98f5jq48m
consumer_address: cosmosvalcons1k2f3m4m2rsyq5slfwavn7uadlrpee37e7funrn
```

Obtain the address in hex format: **`B2931DD76A1C080A43E977593F73ADF8C39CC7D9`**.
```
gaiad keys parse cosmosvalcons1k2f3m4m2rsyq5slfwavn7uadlrpee37e7funrn
bytes: B2931DD76A1C080A43E977593F73ADF8C39CC7D9
human: cosmosvalcons
```

#### 4. Replace key in pion-1 home folder.

Stop the neutron service, and copy the new `priv_validator_key.json` file to the validator home folder.
```
systemctl stop neutrond.service
cp ~/.keys-home/config/priv_validator_key.json ~/.neutrond/config/priv_validator_key.json
```

Confirm the address matches the one from the assigned key: **`B2931DD76A1C080A43E977593F73ADF8C39CC7D9`**.
```
neutrond tendermint show-address --home ~/.neutrond
neutronvalcons1k2f3m4m2rsyq5slfwavn7uadlrpee37e9lcanr
```

```
neutrond keys parse neutronvalcons1k2f3m4m2rsyq5slfwavn7uadlrpee37e9lcanr
bytes: B2931DD76A1C080A43E977593F73ADF8C39CC7D9
human: neutronvalcons
```

Start the neutron service again.
```
systemctl start neutrond.service
```

The log should display the "This node is a validator" line during startup.

#### 5. Check the validator is signing blocks in pion-1

Replace the validator hex address with your own:
```
neutrond q block | jq '.block.last_commit.signatures[] | select(.validator_address == "B2931DD76A1C080A43E977593F73ADF8C39CC7D9")' 
{
  "block_id_flag": 2,
  "validator_address": "B2931DD76A1C080A43E977593F73ADF8C39CC7D9",
  "timestamp": "2024-03-12T18:39:37.5443022Z",
  "signature": "QiTuK8BDGM3W/gE5gKS1LqolOLBFgGdkJZ1Y30FGKWuuXVLtf++jYeIK9uBLlnvr0foee7oMW2KXifG346aMDQ=="
}
```
If the validator is signing blocks, you will see a non-empty `signature` value.


### Modify the `security_contact` field

To update the validator's `security_contact` field, we use the following command:

```
gaiad tx staking edit-validator --security-contact "demo day test" --from validator --gas auto --gas-adjustment 1.6 --gas-prices 0.005uatom -y
```

Where the `validator` in the `--from` flag is the key name of the validator's self-delegation address.

We can then query the validator to verify the field was updated:
```
gaiad q staking validator cosmosvaloper128kmrygt9qaguumc6gnwnlev2tj0dw3dxfs37c -o json | jq '.description.security_contact'
"demo day test"
```
