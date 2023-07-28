# Validator Joining Process

This guide is intended for validators that are looking to join the Replicated Security testnet.

## Joining the Provider Chain

To join the Replicated Security testnet as a validator, you will have to run a binary for the provider chain as well as all live consumer chains.

1. [Join the provider chain](https://github.com/cosmos/testnets/tree/master/replicated-security/provider#how-to-join).
1. Request funds from the provider chain [faucet](https://faucet.rs-testnet.polypore.xyz).
1. Join all the live consumer chains currently listed in the [status section](https://github.com/cosmos/testnets/tree/master/replicated-security#status).

## Creating a Validator on the Provider Chain

Once you have some tokens in your self-delegation account, you can submit the `create-validator` transaction.

Submit the `create-validator` transaction.

```bash
gaiad tx staking create-validator \
--amount 1000000uatom \
--pubkey "$(gaiad tendermint show-validator)" \
--moniker <your moniker> \
--chain-id provider \
--commission-rate 0.10 \
--commission-max-rate 1.00 \
--commission-max-change-rate 0.1 \
--min-self-delegation 1000000 \
--gas auto \
--from <self-delegation-account>
```

You can verify the validator was created in the [block explorer](https://explorer.rs-testnet.polypore.xyz/provider/staking), or in the command line:

```
gaiad q staking validators -o json | jq '.validators[].description.moniker'
```

## Running a Consumer Chain

Follow the instructions contained in the consumer chain's directory in this repository. You can choose to run the consumer chain on a different machine, or on the same machine as your provider
node, granted that the recommended hardware requirements are met. In some cases, if running on the same machine, you may have to override default port configurations to prevent port clashing.

Port configuration settings can typically be found in the consumer chain's system configuration files, at `~/.$CONSUMER_BINARY/config/app.toml` and `~/.$CONSUMER_BINARY/config/config.toml`, which are
initialized as part of installation.

⚠️ Before starting the consumer chain binary, download the updated genesis file from the consumer chain's directory (ex. neutron-rehearsal-fix-1/neutron-rehearsal-fix-1-genesis.json) and overwrite the genesis file in the consumer binary home directory at `~/.$CONSUMER_BINARY/config/genesis.json`. Ensure you have the genesis file with CCV state, which will be uploaded by the consumer chain team after spawn time.

## Associate the Consumer Chain with your Provider Chain's Validator

You may notice that some consumer chains do not implement the `x/staking` module, which means there is no way to set up a validator in the conventional way on the consumer chain.

On the consumer chain, a validator's activity is identified by the private validator key used to sign blocks. There are two mutually exclusive methods for connecting activity on a consumer chain back to a provider.

### Option One: Reuse your private validator key

Within the machine running the provider node, this key is found at `~/.gaia/config/priv_validator_key.json`.

Copy the contents of this file into a new file on the machine hosting the consumer chain, at `~/.$CONSUMER_BINARY/config/priv_validator_key.json`. Upon start, the consumer chain should begin signing blocks with the same validator key as present on the provider.

Your validator is ready to sign blocks when you can see it returned in:

```sh
$CONSUMER_BINARY query tendermint-validator-set | grep "$($CONSUMER_BINARY tendermint show-address)"
```

### Option Two: Use key delegation

If you do not wish to reuse the private validator key from your provider chain, an alternative method is to use multiple keys managed by the Key Assignment feature.

Read up on how to use [Key Assignment](https://cosmos.github.io/interchain-security/features/key-assignment).

⚠️ The `AssignConsumerKey` transaction **must be sent to the provider chain before the consumer chain's spawn time** if you want to start signing blocks as soon as the chain starts. This ensures that the key to be used by that consumer chain is recorded as part of the state in the genesis file. If the consumer chain ID is known prior to the on-chain proposal, this transaction can be sent before the proposal goes on-chain.

⚠️ If the `AssignConsumerKey` transaction is sent after spawn time, it will not take effect until the consumer chain is interchain secured (after the chain starts and the relayer sets up a Cross-Chain Validation channel).

⚠️ Ensure that the `priv_validator_key.json` on the consumer node is different from the key that exists on the provider node.

#### Verify that your `AssignConsumerKey` transaction was successful

Get your provider consensus key:

```sh
gaiad tendermint show-address

# cosmosvalcons12m5td...ph2g
```

Using that consensus key, query the provider for the presence of a validator-consumer-key:
 
```sh
gaiad q provider validator-consumer-key $CONSUMER_CHAIN_ID cosmosvalcons12m5td...ph2g

# consumer_address: cosmosvalcons12hu27j7hd2...9t6q
```

If you see a blank string for the `consumer_address`, doublecheck that you can find your transaction on-chain. You may need to supply a `--node` param.

```sh
gaiad q provider validator-consumer-key stride-1 --node https://cosmos-rpc.w3coins.io:443/ cosmosvalcons1e3wwysvd4pw834lcnlk24vydmn33fsxvwnffjp

# consumer_address: cosmosvalcons1a94z3qz7zn7mjrdrtp54fe895ncwq83l0mxjxv
```

#### If you are using a key management system

Sharded keys from systems like Horcrux require a different sequence of steps.

##### Horcrux

_Thanks to DanB from Strangelove_

Fetch your hex address:

```sh
horcrux cosigner address stride

{"HexAddress":"8A1D35CB0226E9FEF579ED28F8DD36A21DD94817","PubKey":"{\"@type\":\"/cosmos.crypto.ed25519.PubKey\",\"key\":\"ivVf1G+TMRX/5W/rORFw5H236y35xceQjidaPfV7pU8=\"}","ValConsAddress":"stridevalcons13gwntjczym5laatea5503hfk5gwajjqhp46v5v","ValConsPubAddress":"stridevalconspub1zcjduepq3t64l4r0jvc3tll9dl4njytsu37m06edl8zu0yywyadrmatm548sppd66t"}
```

Assign the key:

```sh
gaiad tx provider assign-consensus-key stride-1 '{"@type":"/cosmos.crypto.ed25519.PubKey","key":"ivVf1G+TMRX/5W/rORFw5H236y35xceQjidaPfV7pU8="}' --from cosmos130mdu9a0etmeuw52qfxk73pn0ga6gawkryh2z6
```

Confirm it matches the address in Horcrux:

```sh
gaiad query provider validator-consumer-key stride-1 cosmosvalcons164q2kq3q3psj436t9p7swmdlh39rw73wpy6qx6 | jq -r .consumer_address | bech32 stridevalcons
```

If you are using another key management system and don't see instructions here, please talk to us (or send a PR!)

## Verify that your validator is signing blocks in the consumer chain

You can compare the signatures on a recently-produced block with your validator's signature to confirm you are signing blocks with the assigned key

Parse your signature:

```sh
$CONSUMER_BINARY keys parse $($neutrond tendermint show-address)
```

Example output:
```sh
human: neutronvalcons
bytes: AE84D29EC8E3BBCF123B48C702DAA982EEC2830B
```

In the [block explorer](https://explorer.rs-testnet.polypore.xyz/provider/staking), you can compare the signatures on a recently-produced block with your validator's signature.

To grab only the byte string:

```sh
$CONSUMER_BINARY keys parse $($CONSUMER_BINARY tendermint show-address) --output json | jq '.bytes'
```

Query the latest block for your signature:

```sh
$CONSUMER_BINARY q block | jq '.block.last_commit.signatures' | grep <your byte string>
```
