# test-powercap-1

## Chain information

* Chain ID: `test-powercap-1`
* Opt-in
* Power cap: 5%
* Denom: `upow`
* Minimum gas prices: `0upow`
* Bech32 prefix: `consumer`
* Binary
  * [`interchain-security-cd`](/isle/binaries/interchain-security-cd-linux-v4.0.0)
    * SHASUM: `f6fdb7f98c15915779d0493eb102ce44bdccda2a68f2abd262c4c88ce23e38b3`
    * Verify with `shasum -a 256 interchain-security-cd-linux-v4.0.0`
  * Repo: [interchain-security](https://github.com/cosmos/interchain-security/)
  * Version: [`v4.0.0`](https://github.com/cosmos/interchain-security/releases/tag/v4.0.0)
  * Built with Go 1.21.6
* Spawn time: `2024-06-19T14:45:00Z`
* Genesis file: **this file will be posted after the spawn time**
  * [`powercap-genesis.json`](./powercap-genesis.json)
  * SHASUM: `TBA` (verify with `shasum -a 256 powercap-genesis.json`)

### Pre-spawn genesis file

This file is only posted for verifying the hash from the consumer-addition proposal.
* [`powercap-genesis-pre-spawn.json`](./powercap-genesis-pre-spawn.json)
  * SHASUM: `d0708bc4bc2b046c6296be24a52aade0e6387a58dd7e80ec3f3426e8d33bc280` (verify with `shasum -a 256 powercap-genesis-pre-spawn.json`)

## Endpoints

### Persistent peers

* `5ac39e42f07d373c5544fd487639375f8f57da74@powercap-banana.ics-testnet.polypore.xyz:26656`
* `c0713cf382be88a124ccc29139f2a7aa797403a8@powercap-cherry.ics-testnet.polypore.xyz:26656`
* `7be2d3916cde2d8979fdffd123d0b38321486a95@powercap-node.ics-testnet.polypore.xyz:26656`

## Preparing for Launch

### Node Setup

The `setup-powercap.sh` script provided in this repo will install the chain binary.
* It must be run either as root or from a sudoer account.
* The script will build the `interchain-security-cd` binary using Go 1.21.6.

### Opt in Before Launch

* You can submit your opt-in transaction before the spawn time is reached to start signing blocks as soon as the chain starts.
  ```
  gaiad tx provider opt-in test-powercap-1 <consumer node public key>
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
gaiad q provider consumer-genesis test-powercap-1 -o json --node https://rpc.provider-sentry-01.ics-testnet.polypore.xyz:443 > ccv.json
jq '.params.reward_denoms |= ["upow"]' ccv.json > ccv-denom.json
jq '.params.provider_reward_denoms |= ["uatom"]' ccv-denom.json > ccv-provider-denom.json
jq -s '.[0].app_state.ccvconsumer = .[1] | .[0]' powercap-genesis-pre-spawn.json ccv-provider-denom.json > powercap-genesis.json
```

### Joining the Consumer Chain Validator Set After Launch

* You can submit an opt-in transaction after the consumer chain has launched.
  ```
  gaiad tx provider opt-in test-powercap-1 <consumer node public key>
  ```
