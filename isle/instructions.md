# ISLE Task Instructions

The following is a cheat sheet for all the CLI commands you will need to submit at one point during ISLE.

## Vote on a proposal

Vote YES transaction
```
gaiad tx gov vote <proposal ID> yes
```

To verify you have voted:
```
gaiad q gov votes <proposal id> --height <height within voting period> -o json | jq '.votes[] | select(.voter=="<cosmos address>").options'
```

## Assign a consensus key for a consumer chain

Assign consensus key transaction
```
gaiad tx provider assign-consensus-key <consumer chain id> <consumer public key>
```
* The public key can be obtained by running the following in the consumer node
  ```
  interchain-security-cd tendermint show-validator --home <chain home folder>
  ```

To verify the key has been assigned, query the consensus address:
```
gaiad q provider validator-consumer-key <consumer chain id> <provider cosmosvalcons address>
consumer_address: <consumer cosmosvalcons address>
```
The hex address must match the validator's `priv_validator_key.json` in the consumer node:
```
interchain-security-pd keys parse <consumer cosmosvalcons address>
```

## Opt-in to a consumer chain

Opt-in transaction when a consensus key has been assigned already
```
gaiad tx provider opt-in <consumer-chain-id>
```

Opt-in transaction when a consensus key has not been assigned yet
```
gaiad tx provider opt-in <consumer-chain-id> <consumer public key>
```
* The public key can be obtained by running the following in the consumer node
  ```
  interchain-security-cd tendermint show-validator --home <chain home folder>
  ```

To verify the validator has opted-in, use the `has-to-validate` query:
```
gaiad q provider has-to-validate <provider cosmosvalcons address>
consumer_chain_ids:
...
```

## Opt-out from a consumer chain

Opt-out transaction
```
gaiad tx provider opt-out <consumer-chain-id>
```

To verify the validator has opted-out, use the `has-to-validate` query:
```
gaiad q provider has-to-validate <provider cosmosvalcons address>
consumer_chain_ids:
...
```

## Set a commission rate in a consumer chain

Set consumer commission rate transaction
```
gaiad tx provider set-consumer-commission-rate <consumer chain id>  <commission rate>
```

To verify the rate has been set:
```
gaiad q provider validator-consumer-commission-rate <consumer chain id> <provider cosmosvalcons address>
rate: "<consumer rate>"
```
