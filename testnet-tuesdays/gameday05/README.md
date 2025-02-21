# Testnet Game ~~Day~~ _Week_: Block Party 2025-Feb-24

* Start time: `2025-02-24 14:00 UTC`
* End time: `2025-02-28 23:00 UTC`

We will use this game day to ensure everyone's validator nodes are synced properly and
able to propose blocks. This will prepare us for more complex games involving stake
redistribution! 

You will have **the whole week** to complete this game day's tasks.

### Testnet Incentives Program (TIP) Eligibility

This event will be part of the Feb 2025 TIP period and will be worth up to **two points**.
* (1 point) Task 1: Propose at least one block on `provider`
* (1 point) Task 2: Propose at least one block on `pion-1`

## Block (Proposal) Party

### Dashboard

We have deployed a dashboard to track block proposals, you can view it [here](http://cvms.ics-testnet.polypore.xyz:3000/d/bedk3wkhshgxsd/blocks-since-last-proposed?orgId=1&from=now-3h&to=now&timezone=browser&var-query0=&var-chain_id=provider).
* Use the dropdown to switch between `provider` and `pion-1`.
* Note how rows in red are validators that have not proposed a block in the last 20k blocks. You can use this as a yardstick to figure out if you're proposing blocks correctly.
* We will assign points to all validators marked in green by the end of the week. If you find a block that your validator proposed and was not detected, please tag a Hypha member in Discord with the chain and block height.

### Stake Distribution

We will rotate stake delegations periodically so that five validators will have ~1 % voting power each at any given time.
* Ideally, your validator will propose at least one of every 100 blocks at some point during the week.

### 🔧 Troubleshooting

If you are not proposing blocks:
* You will have to re-sync. Make sure you **back your keys up**, then do a `gaiad comet unsafe-reset-all` or `neutrond comet unsafe-reset-all` and sync again.
* Please sync using the snapshots or state sync endpoints listed in the [provider](../../interchain-security/provider/README.md) and [pion-1](../../interchain-security/pion-1/README.md) readmes in this testnets repo: we cannot verify other snapshots are synced properly.
* One way to find out if your validator cannot propose blocks if by checking a validator's proposer priority in your node's `validators` RPC endpoint. If this number does not match the result from the nodes listed below, you **must** re-sync.
  * provider
    * `curl -s https://rpc.provider-sentry-01.ics-testnet.polypore.xyz/validators\?height\=<recent block height> | jq '.result.validators[0].proposer_priority'`
  * pion-1
    * `curl -s https://rpc.pion.ics-testnet.polypore.xyz/validators\?height\=<recent block height> | jq '.result.validators[0].proposer_priority'`

## `provider` Sync Sources

### State Sync

1. `https://provider-state-sync-01.ics-testnet.polypore.xyz:443`
2. `https://provider-state-sync-02.ics-testnet.polypore.xyz:443`

### Snapshot

* https://snapshots.polypore.xyz/ics-testnet/provider/
* https://snapshots-2.polypore.xyz/ics-testnet/provider/

## `pion-1` Sync Sources

### State sync

1. `https://rpc.pion.ics-testnet.polypore.xyz:443`
2. `https://rpc.pion-2.ics-testnet.polypore.xyz:443`

### Snapshot
* https://snapshots.polypore.xyz/ics-testnet/pion-1/
* https://snapshots-2.polypore.xyz/ics-testnet/pion-1/

## Re-syncing Reference for `provider`

⚠️ Be careful when working with your validator keys.

* Stop your node, back up your keys, and replace them with non-validator ones before clearing the state.

```bash
sudo systemctl stop cv-provider.service
cp ~/.gaia/config/priv_validator_key.json ~/.gaia/priv_validator_key.json.bak
cp ~/.gaia/config/node_key.json ~/.gaia/node_key.json.bak
gaiad init dummy-home --home .non-validator
cp ~/.non-validator/config/priv_validator_key.json ~/.gaia/config/priv_validator_key.json
cp ~/.non-validator/config/node_key.json ~/.gaia/config/key.json
rm -r .non-validator
gaiad comet unsafe-reset-all --home ~/.gaia --keep-addr-book
rm -r ~/.gaia/wasm
```

* Pick state sync or snapshot next:

### State Sync

* Obtain a recent block height and save the height and tx hash.
```bash
RPC="https://rpc.provider-state-sync-01.ics-testnet.polypore.xyz:443"
TRUST_HEIGHT=$[$(curl -s $RPC/block | jq -r '.result.block.header.height')-2000]
TRUST_HASH=$((curl -s $RPC/block\?height\=$TRUST_HEIGHT) | jq -r '.result.block_id.hash')
echo "Set trust_height = $TRUST_HEIGHT in config.toml"
echo "Set trust_hash = $TRUST_HASH in config.toml"
```
* Update the `.gaia/config/config.toml` file with the following values:
```toml
[statesync]
enable = true
rpc_servers = "https://rpc.provider-state-sync-01.ics-testnet.polypore.xyz:443,https://rpc.provider-state-sync-02.ics-testnet.polypore.xyz:443"
trust_height = <value from $TRUST_HEIGHT>
trust_hash = <value from $TRUST_HASH>
trust_period = "8h0m0s"
```
* Start the service.
```bash
sudo systemctl start cv-provider.service
```
* After the node has synced, you can replace the dummy keys with the back-up validator ones.
```bash
sudo systemctl stop cv-provider.service
cp ~/.gaia/priv_validator_key.json.bak ~/.gaia/config/priv_validator_key.json
cp ~/.gaia/node_key.json.bak ~/.gaia/config/node_key.json
sudo systemctl start cv-provider.service
```

### Snapshot

* Download and extract snapshot. 

```bash
curl -LO https://snapshots.polypore.xyz/ics-testnet/provider/latest.tar.gz
tar -xvf latest.tar.gz -C ~/.gaia
```

* Start the service.
```
sudo systemctl start cv-provider.service
```
* After the node has synced, you can replace the dummy keys with the back-up validator ones.
```bash
sudo systemctl stop cv-provider.service
cp ~/.gaia/priv_validator_key.json.bak ~/.gaia/config/priv_validator_key.json
cp ~/.gaia/node_key.json.bak ~/.gaia/config/node_key.json
sudo systemctl start cv-provider.service
```

## Re-Syncing Reference for `pion-1`

⚠️ Be careful when working with your validator keys.

* Stop your node, back up your keys, and replace them with non-validator ones before clearing the state.

```bash
sudo systemctl stop cv-neutron.service
cp ~/.neutrond/config/priv_validator_key.json ~/.neutrond/priv_validator_key.json.bak
cp ~/.neutrond/config/node_key.json ~/.neutrond/node_key.json.bak
neutrond init dummy-home --home .non-validator
cp ~/.non-validator/config/priv_validator_key.json ~/.neutrond/config/priv_validator_key.json
cp ~/.non-validator/config/node_key.json ~/.neutrond/config/key.json
rm -r .non-validator
neutrond comet unsafe-reset-all --home ~/.neutrond --keep-addr-book
rm -r ~/.neutrond/wasm
```

* Pick state sync or snapshot next:

### State Sync

* Obtain a recent block height and save the height and tx hash.
```bash
RPC="https://rpc.pion.ics-testnet.polypore.xyz:443"
TRUST_HEIGHT=$[$(curl -s $RPC/block | jq -r '.result.block.header.height')-20000]
TRUST_HASH=$((curl -s $RPC/block\?height\=$TRUST_HEIGHT) | jq -r '.result.block_id.hash')
echo "Set trust_height = $TRUST_HEIGHT in config.toml"
echo "Set trust_hash = $TRUST_HASH in config.toml"
```
* Update the `.neutrond/config/config.toml` file with the following values:
```toml
[statesync]
enable = true
rpc_servers = "https://rpc.pion.ics-testnet.polypore.xyz:443,https://rpc.pion-2.ics-testnet.polypore.xyz:443"
trust_height = <value from $TRUST_HEIGHT>
trust_hash = <value from $TRUST_HASH>
```
* Start the service.
```bash
sudo systemctl start cv-neutron.service
```
* After the node has synced, you can replace the dummy keys with the back-up validator ones.
```bash
sudo systemctl stop cv-neutron.service
cp ~/.neutrond/priv_validator_key.json.bak ~/.neutrond/config/priv_validator_key.json
cp ~/.neutrond/node_key.json.bak ~/.neutrond/config/node_key.json
sudo systemctl start cv-neutron.service
```

### Snapshot

* Download and extract snapshot.

```bash
curl -LO https://snapshots.polypore.xyz/ics-testnet/pion-1/latest.tar.gz
tar -xvf latest.tar.gz -C ~/.neutrond
```
* Start the service.
```bash
sudo systemctl start cv-neutron.service
```
* After the node has synced, you can replace the dummy keys with the back-up validator ones.
```bash
sudo systemctl stop cv-neutron.service
cp ~/.neutrond/priv_validator_key.json.bak ~/.neutrond/config/priv_validator_key.json
cp ~/.neutrond/node_key.json.bak ~/.neutrond/config/node_key.json
sudo systemctl start cv-neutron.service
```

