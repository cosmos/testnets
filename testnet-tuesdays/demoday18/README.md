# Testnet Demo Day # 18: 2025-Jul-15

In this demo day, we will explore ways to inspect on-chain transaction data using `gaiad` CLI queries.

* Start time: `2025-07-15 13:30 UTC`
* End time: `2025-07-15 14:30 UTC`

> Note that the endpoint your node is querying must have the relevant data available: if you are querying blocks too far back in the past, they might have been pruned already.

## Module queries

The `gaiad query` command allows us to query data from the specified module at the current block height.

### Height-specific module queries

You can use the `---height` flag to set a height to query the module. For instance, a wallet balance may be queried this way:

```
gaiad q bank balances cosmos1vltc78wwge9222kpyvge8hkkdp3yhm57g9pqps --height 12762998 # no balance
gaiad q bank balances cosmos1vltc78wwge9222kpyvge8hkkdp3yhm57g9pqps --height 12762999 # 3 ATOM
```

You may also query a validator's delegations at different points in time this way:
```
gaiad q staking delegations-to cosmosvaloper1arjwkww79m65csulawqngr7ngs4uqu5hr3frxw --height 12763474 -o json | jq -r '.delegation_responses | length' # 42 delegations
gaiad q staking delegations-to cosmosvaloper1arjwkww79m65csulawqngr7ngs4uqu5hr3frxw --height 12763475 -o json | jq -r '.delegation_responses | length' # 43 delegations
```

## Transaction queries

Gaia provides a `query txs --query` command to search transactions using block events.

### Query all transactions in a block

```
gaiad q txs --query "tx.height=26530699"
```

### Query all transactions in a block range

```
gaiad q txs --query "tx.height>26530698 AND tx.height<26530702"
```

If you were interested in getting the transaction type only, you could use `jq` to select it:
```
gaiad q txs --query "tx.height>26530699 AND tx.height<26530702" -o json | jq '.txs[].tx.body.messages[]."@type"'
```

### Query all transactions of a given type

You can use a block event's key/value pair to construct a transaction query. A sample event looks like this:
```
gaiad q block-results 12762999 -o json | jq '.txs_results[0].events[6]'
{
  "type": "message",
  "attributes": [
    {
      "key": "action",
      "value": "/cosmos.bank.v1beta1.MsgSend",
      "index": true
    },
    {
      "key": "sender",
      "value": "cosmos19mkwu6ne284ufqgdqnv4k6cp0qqy9x0742p3d2",
      "index": true
    },
    {
      "key": "module",
      "value": "bank",
      "index": true
    },
    {
      "key": "msg_index",
      "value": "0",
      "index": true
    }
  ]
}
```
The `action` attribute lists the message type: `/cosmos.bank.v1beta1.MsgSend`.

Querying a transaction of a given type may return a massive amount of data, so you can filter the search by setting a lower limit on the block height:
```
gaiad q txs --query "message.action='/cosmos.bank.v1beta1.MsgSend' AND tx.height>12762000" -o json | jq '.txs[0].tx.body.messages[0]."@type"'
```

For bank send transactions, you can also filter using the sender address:
```
gaiad q txs --query "message.action='/cosmos.bank.v1beta1.MsgSend' AND message.sender='cosmos1vltc78wwge9222kpyvge8hkkdp3yhm57g9pqps'"
```

### Query heights on param change proposals

If you were interested in finding when a proposal to modify the slashing module was submitted, you could use the following:
```
gaiad q txs --query "tx.height>12236300 AND message.action='/cosmos.gov.v1.MsgSubmitProposal'" -o json | jq '.txs[] |  select(.tx.body.messages[].messages[]."@type"=="/cosmos.slashing.v1beta1.MsgUpdateParams").height'
```
Note that you must know the relevant update params message to do this.

## Quiz Time!

1. The message type for a `staking delegate` transaction is `/cosmos.staking.v1beta1.MsgDelegate`. How would you find the last time your validator received a delegation?
2. The message type for a governance proposal vote is `/cosmos.gov.v1.MsgVote`. How would you find out if `cosmos1arjwkww79m65csulawqngr7ngs4uqu5hx9ak2a` voted on proposal 274?
3. How would you find the last time a validator was unjailed?