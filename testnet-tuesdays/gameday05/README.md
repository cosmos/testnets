# Testnet Game Day: 2025-Feb-25

The point of this game day is to ensure that everyone's nodes are synced properly and
able to propose blocks. This will prepare us for more complex games involving stake
redistribution! You have **one week** to complete this game day. You'll receive **one TIP point**
if you propose a block on `provider` during the week, and **a second TIP point** if you
propose a block on `pion-1` during the week.

* Start time: `2025-02-25 15:30 UTC`
* End time: `2025-03-04 15:30 UTC`

## Block party

We've deployed a dashboard to track block proposals.
You can view it [here](http://cvms.ics-testnet.polypore.xyz:3000/d/bedk3wkhshgxsd/blocks-since-last-proposed?orgId=1&from=now-3h&to=now&timezone=browser&var-query0=&var-chain_id=provider&tab=queries).
Use the dropdown to switch between `provider` and `pion-1`. Note how rows in red are validators
that have not proposed a block in the last 20k blocks. You can use this as a yardstick to figure
out if you're proposing blocks correctly.

If you're not proposing blocks, you will have to re-sync. Make sure you _back your keys up_,
then do a `gaiad tendermint unsafe-reset-all` and sync from scratch. You should sync from
snapshots on the [pion-1](../../interchain-security/pion-1/README.md) and
[provider](../../interchain-security/provider/README.md) readmes, as other snapshots
may not be correctly synced.

### Provider Snapshots and State Sync

#### State sync

1. `https://provider-state-sync-01.ics-testnet.polypore.xyz:443`
2. `https://provider-state-sync-02.ics-testnet.polypore.xyz:443`

#### Snapshot

* https://snapshots.polypore.xyz/ics-testnet/provider/

### Pion-1 Snapshots and State Sync

#### State sync

1. `pion.ics-testnet.polypore.xyz:26657`

#### Snapshot
* https://snapshots.polypore.xyz/ics-testnet/pion-1/

### How to Sync

These examples assume `provider`, but you should work for `pion-1` if you change the commands accordingly.
Start by stopping your node, then back up your keys (`cp ~/.gaia/config/priv_validator_key.json ~/.gaia/priv_validator_key.json.bak`).

#### From State Sync

```bash
SNAP_RPC="https://provider-state-sync-01.ics-testnet.polypore.xyz:443"

LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 2000)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC,$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"|" $HOME/.gaia/config/config.toml
gaiad tendermint unsafe-reset-all --home $HOME/.gaia --keep-addr-book
```

You can now start your node again, and it should state sync.

#### From Snapshot

```bash
cp ~/.gaia/data/priv_validator_state.json ~/.gaia/priv_validator_state.json.bak
curl -LO https://snapshots.polypore.xyz/ics-testnet/provider/latest.tar.gz
gaiad tendermint unsafe-reset-all --home $HOME/.gaia --keep-addr-book
rm -r ~/.gaia/wasm
tar -xvf latest.tar.gz -C ~/.gaia
cp ~/.gaia/priv_validator_state.json.bak ~/.gaia/data/priv_validator_state.json
```

You can now start your node again, and it should sync from the snapshot.

### Testnet Incentives Program (TIP) Eligibility

* You'll receive one point if you propose a block on `provider` during the week.
* You'll receive one point if you propose a block on `pion-1` during the week.