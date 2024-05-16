# test-ibiza-1

## Chain information

* Chain ID: `test-ibiza-1`
* Denom: `ubiza`
* Minimum gas prices: `0ubiza`
* Opt-in
* Bech32 prefix: `elys`
* Binary
  * `elysd`
  * Repo: https://github.com/monopauli/elys
  * Version: [v0.30.0-isle](https://github.com/monopauli/elys/releases/tag/v0.30.0-isle)
* Spawn time: `2024-05-16T15:45:00Z`
* Genesis file: **this file will be posted after the spawn time**
  * [`ibiza-genesis.json`](./ibiza-genesis.json)
  * SHASUM: `TBD` (verify with `shasum -a 256 ibiza-genesis.json`)

### Pre-spawn genesis file

This file is only posted for verifying the hash from the consumer-addition proposal.
* [`ibiza-genesis-pre-spawn.json`](./ibiza-genesis-pre-spawn.json)
  * SHASUM: `8da84e910a714336cb40d1b84f4ba86b3c9071fb438fbc6c707f33c5af2ed858` (verify with `shasum -a 256 ibiza-genesis-pre-spawn.json`)

## Endpoints

### Persistent peers

* `3821b0c9793ff70258328f03f390be2dd6456af2@ibiza-apple.isle-testnet.polypore.xyz:26656`
* `b44bc2bff63ee111e3d36b0b164ef2e0bd7fab6e@ibiza-banana.isle-testnet.polypore.xyz:26656`
* `309b80dcf099e5b4a79c6f2280da5b8d942acd08@ibiza-cherry.isle-testnet.polypore.xyz:26656`
* `06d49c0dabe6604de2cc19bfac193496cd02d870@ibiza-node.isle-testnet.polypore.xyz:26656`

## Preparing for Launch

### Node Setup

The `setup-ibiza.sh` script provided in this repo will install the chain binary.
* It must be run either as root or from a sudoer account.
* The script will build the `elysd` binary using Go 1.21.6.

### Opt in Before Launch

* You must submit your opt-in transaction before the spawn time is reached.
  ```
  gaiad tx provider opt-in test-ibiza-1 <consumer node public key>
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
gaiad q provider consumer-genesis test-ibiza-1 -o json --node https://rpc.provider-sentry-01.ics-testnet.polypore.xyz:443 > ccv.json
jq '.params.reward_denoms |= ["ubiza"]' ccv.json > ccv-denom.json
jq '.params.provider_reward_denoms |= ["uatom"]' ccv-denom.json > ccv-provider-denom.json
jq -s '.[0].app_state.ccvconsumer = .[1] | .[0]' ibiza-genesis-pre-spawn.json ccv-provider-denom.json > ibiza-genesis.json
```

### Joining the Consumer Chain Validator Set After Launch

* You can submit an opt-in transaction after the consumer chain has launched.
  ```
  gaiad tx provider opt-in test-ibiza-1 <consumer node public key>
  ```
* If you have already assigned a consensus key prior to opting in, you can omit the public key argument.
  ```
  gaiad tx provider opt-in test-ibiza-1
  ```
