# Validator Launch Process

This guide is intended for validators that are looking to join the Replicated Security testnet.

## Joining the Provider Chain

To join the Replicated Security testnet as a validator, you will have to run a binary for the provider chain as well as all live consumer chains.

1. [Join the provider chain](https://github.com/cosmos/testnets/tree/master/replicated-security/provider#how-to-join).
1. Request funds from the provider chain [faucet](https://faucet.rs-testnet.polypore.xyz).
1. Join all the live consumer chains currently listed in the [status section](https://github.com/hyphacoop/testnets/tree/split-out-validator-docs/replicated-security#status) contains up-to-date information on live consumer chains and their slashing parameters.

Once you have some tokens in your self-delegation account, you can submit the `create-validator` transaction.

## Creating a Validator on the Provider Chain


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

You can verify the validator was created in the block explorer, or in the command line:
```
gaiad q staking validators -o json | jq '.validators[].description.moniker'
```

## Running a Consumer Chain

Follow the instructions contained in the consumer chain's directory in this repository. You can choose to run the consumer chain on a different machine, or on the same machine as your provider
node, granted that the recommended hardware requirements are met. In some cases, if running on the same machine, you may have to override default port configurations to prevent port clashing.

Port configuration settings can typically be found in the consumer chain's system configuration files, at `~/.<consumer>/config/app.toml` and `~/.<consumer>/config/config.toml`, which are
initialized as part of installation.

## Associating the Consumer Chain with your Provider Chain's Validator

You may notice that some consumer chains do not implement the `staking` module, which means there is no way to set up a validator in the conventional way on the consumer chain.

On the consumer chain, a validator's activity is identified by the private validator key used to sign blocks. There are two mutually exclusive methods for connecting activity on a consumer chain back to a provider.

#### Option One: Reuse your private validator key

Within the machine running the provider node, this key is found at `~/.gaia/config/priv_validator_key.json`.

Copy the contents of this file into a new file on the machine hosting the consumer chain, at `~/.<consumer>/config/priv_validator_key.json`. Upon start, the consumer chain should begin signing blocks with the same validator key as present on the provider.

You can verify that consumer blocks are correctly associated to your validator key by running:

```sh
<consumer binary> query tendermint-validator-set | grep "$(<consumer binary> tendermint show-address)"
```

#### Option Two: Use key delegation

If you do not wish to reuse the private validator key from your provider chain, an alternative method is to use multiple keys managed by the Key Assignment feature.

Read up on how to use [Key Assignment](https://github.com/cosmos/interchain-security/blob/main/docs/docs/features/key-assignment.md).
