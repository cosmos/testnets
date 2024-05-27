# test-valsetcap-1

## Chain information

* Chain ID: `test-valsetcap-1`
* Opt-in
* Denom: `uset`
* Minimum gas prices: `0uset`
* Bech32 prefix: `consumer`
* Binary
  * [`interchain-security-cd`](/isle/binaries/interchain-security-cd-linux-v4.0.0)
    * SHASUM: `f6fdb7f98c15915779d0493eb102ce44bdccda2a68f2abd262c4c88ce23e38b3`
    * Verify with `shasum -a 256 interchain-security-cd-linux-v4.0.0`
  * Repo: [interchain-security](https://github.com/cosmos/interchain-security/)
  * Version: [`v4.0.0`](https://github.com/cosmos/interchain-security/releases/tag/v4.0.0)
  * Built with Go 1.21.6
* Spawn time: `2024-05-29T14:30:00Z`
* Genesis file: **this file will be posted after the spawn time**
  * [`valsetcap-genesis.json`](./valsetcap-genesis.json)
  * SHASUM: `TBD` (verify with `shasum -a 256 valsetcap-genesis.json`)

### Pre-spawn genesis file

This file is only posted for verifying the hash from the consumer-addition proposal.
* [`valsetcap-genesis-pre-spawn.json`](./valsetcap-genesis-pre-spawn.json)
  * SHASUM: `5a46f864ad4303e2e7b48137f64eddc354471ac443f0128748746ce42d97c930` (verify with `shasum -a 256 valsetcap-genesis-pre-spawn.json`)

## Endpoints

### Persistent peers

* `00240731a27641851d649f6cdf4b8f0c1361147e@valsetcap-apple.ics-testnet.polypore.xyz:26656`
* `e13b79bcb0dc4695ca392d78126de2fd0352f6e7@valsetcap-banana.ics-testnet.polypore.xyz:26656`
* `e1fe5b766408026cc53b5e29184edf45c52be716@valsetcap-node.ics-testnet.polypore.xyz:26656`

## Preparing for Launch

### Node Setup

The `setup-valsetcap.sh` script provided in this repo will install the chain binary.
* It must be run either as root or from a sudoer account.
* The script will build the `interchain-security-cd` binary using Go 1.21.6.

### Opt in Before Launch

* You can submit your opt-in transaction before the spawn time is reached to start signing blocks as soon as the chain starts.
  ```
  gaiad tx provider opt-in test-valsetcap-1 <consumer node public key>
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
gaiad q provider consumer-genesis test-valsetcap-1 -o json --node https://rpc.provider-sentry-01.ics-testnet.polypore.xyz:443 > ccv.json
jq '.params.reward_denoms |= ["uset"]' ccv.json > ccv-denom.json
jq '.params.provider_reward_denoms |= ["uatom"]' ccv-denom.json > ccv-provider-denom.json
jq -s '.[0].app_state.ccvconsumer = .[1] | .[0]' valsetcap-genesis-pre-spawn.json ccv-provider-denom.json > valsetcap-genesis.json
```

### Joining the Consumer Chain Validator Set After Launch

* You can submit an opt-in transaction after the consumer chain has launched.
  ```
  gaiad tx provider opt-in test-valsetcap-1 <consumer node public key>
  ```
