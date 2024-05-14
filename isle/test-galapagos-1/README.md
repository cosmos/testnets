# test-galapagos-1

## Chain information

* Chain ID: `test-galapagos-1`
* Denom: `ugala`
* Opt-in
* Bech32 prefix: `consumer`
* Binary
  * [`interchain-security-cd`](/isle/binaries/interchain-security-cd-linux-v4.0.0)
    * SHASUM: `f6fdb7f98c15915779d0493eb102ce44bdccda2a68f2abd262c4c88ce23e38b3`
    * Verify with `shasum -a 256 interchain-security-cd-linux-v4.0.0`
  * Repo: [interchain-security](https://github.com/cosmos/interchain-security/)
  * Version: [`v4.0.0`](https://github.com/cosmos/interchain-security/releases/tag/v4.0.0)
  * Built with Go 1.21.6
* Spawn time: `2024-05-14T15:30:00Z`
* Genesis file: **this file will be posted after the spawn time**
  * [`galapagos-genesis.json`](./galapagos-genesis.json)
  * SHASUM: `ab34ab311d2ef4435931bc43a8d6293bbdeeed5a643ffb52d1b4ce221ac85893` (verify with `shasum -a 256 galapagos-genesis.json`)

### Pre-spawn genesis file

This file is only posted for verifying the hash from the consumer-addition proposal.
* [`galapagos-genesis-pre-spawn.json`](./galapagos-genesis-pre-spawn.json)
  * SHASUM: `90c8b62134d360a44d208f4f30a4bda219eab6a6a4a100285eb6217a0bec8dfa` (verify with `shasum -a 256 galapagos-genesis-pre-spawn.json`)

## Endpoints

### Persistent peers

* `8ceaca491f600c96244f88dd096155ee72f43cd5@gala-apple.isle-testnet.polypore.xyz:26656`
* `c018db4a253025dca34f85f0a438edd2cfc2b671@gala-banana.isle-testnet.polypore.xyz:26656`
* `4c80daf0e07398abfda6b2617f18df324569a3e2@gala-cherry.isle-testnet.polypore.xyz:26656`
* `7747224d0c88412b45f3bd83990c17f2a7857adb@gala-node.isle-testnet.polypore.xyz:26656`

## Preparing for Launch

### Node Setup

The `setup-galapagos.sh` script provided in this repo will install the chain binary.
* It must be run either as root or from a sudoer account.
* The script will build the `interchain-security-cd` binary using Go 1.21.6.

### Opt in Before Launch

* You must submit your opt-in transaction before the spawn time is reached.
  ```
  gaiad tx provider opt-in test-galapagos-1 <consumer node public key>
  ```

## Launch Instructions

After the spawn time is reached:
  * The launch genesis file will be posted in this repo.
  * Copy this file to your consumer chain's home `/config/genesis.json`.
  * Start your node

### Preparing the genesis file

These are the commands we will use to generate the launch genesis file after the spawn time is reached:

* Obtain CCV state
* Populate reward denoms
* Populate provider reward denoms
* Patch the consumer genesis file
```
gaiad q provider consumer-genesis test-galapagos-1 -o json --node https://rpc.provider-sentry-01.ics-testnet.polypore.xyz:443 > ccv.json
jq '.params.reward_denoms |= ["ugala"]' ccv.json > ccv-denom.json
jq '.params.provider_reward_denoms |= ["uatom"]' ccv-denom.json > ccv-provider-denom.json
jq -s '.[0].app_state.ccvconsumer = .[1] | .[0]' galapagos-genesis-pre-spawn.json ccv-provider-denom.json > galapagos-genesis.json
```

### Joining the Consumer Chain Validator Set After Launch

* You can submit an opt-in transaction after the consumer chain has launched if you are not in the top N.
  ```
  gaiad tx provider opt-in test-galapagos-1
  ```
  * If you did not assign a consensus key prior to opting in, you can assign it at this time.
    ```
    gaiad tx provider opt-in test-galapagos-1 <consumer node public key>
    ```
