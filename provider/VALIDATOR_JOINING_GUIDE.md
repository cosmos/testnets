# Validator Joining Process

This guide is intended for validators that are looking to join the Cosmos Hub (`provider`) testnet.

## Joining the `provider` Chain

To join the Cosmos Hub testnet as a validator, you will have to run a binary for the provider chain as well as all live consumer chains.

1. [Join the provider chain](README.md#how-to-join)
2. Request funds from the provider chain [faucet](https://faucet.polypore.xyz).

## Creating a Validator on the `provider` Chain

Once you have some tokens in your self-delegation account, you can follow these steps to submit the `create-validator` transaction.

1. Obtain your public key
```
gaiad tendermint show-validator
{"@type":"/cosmos.crypto.ed25519.PubKey","key":"BShP2dtw02I/1SnLp/D/RBHoeEaG3NqlMkwWYZOqcug="}
```

2. Create the validator JSON (`validator.json`) file replacing the `pubkey` value from the `show-validator` command above and edit the other values for your needs.
```
{
  "pubkey": {"@type":"/cosmos.crypto.ed25519.PubKey","key":"BShP2dtw02I/1SnLp/D/RBHoeEaG3NqlMkwWYZOqcug="},
  "amount": "1000000uatom",
  "moniker": "your-validator-moniker-1",
  "identity": null,
  "website": null,
  "security": null,
  "details": null,
  "commission-rate": "0.1",
  "commission-max-rate": "0.2",
  "commission-max-change-rate": "0.01",
  "min-self-delegation": "1"
}
```

3. Submit the `create-validator` transaction.

```bash
gaiad tx staking create-validator \
validator.json \
--from <self-delegation-account> \
--gas auto \
--gas-adjustment 3 \
--gas-prices 0.005uatom
```

1. You can verify the validator was created in the [block explorer](https://explorer.polypore.xyz/provider/staking), or in the command line:

```
gaiad q staking validators -o json | jq '.validators[].description.moniker'
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
