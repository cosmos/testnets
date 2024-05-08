# test-faroe-1

## Chain information

* Chain ID: `test-faroe-1`
* Denom: `ufaro`
* Top N: `67`
* Bech32 prefix: `consumer`
* Binary
  * [`interchain-security-cd`](/isle/binaries/interchain-security-cd-linux-v4.0.0)
    * SHASUM: `f6fdb7f98c15915779d0493eb102ce44bdccda2a68f2abd262c4c88ce23e38b3`
    * Verify with `shasum -a 256 interchain-security-cd-linux-v4.0.0`
  * Repo: [interchain-security](https://github.com/cosmos/interchain-security/)
  * Version: [`v4.0.0`](https://github.com/cosmos/interchain-security/releases/tag/v4.0.0)
  * Built with Go 1.21.6
* Spawn time: `2024-05-14T14:30:00Z`
* Genesis file: **this file will be posted after the spawn time**
  * [`faroe-genesis.json`](./faroe-genesis.json)
  * SHASUM: `TBD` (verify with `shasum -a 256 faroe-genesis.json`)

### Pre-spawn genesis file

This file is only posted for verifying the hash from the consumer-addition proposal.
* [`faroe-genesis-pre-spawn.json`](./faroe-genesis-pre-spawn.json)
  * SHASUM: `8df26a4753a7b6defa7b0e489c2b058ecde58a530764064a5a692a64207bc401` (verify with `shasum -a 256 faroe-genesis-pre-spawn.json`)

## Endpoints

### Persistent peers

* `1cb1b2c1be0765e4f87139e7a58056c5de46994e@faroe-apple.isle-testnet.polypore.xyz:26656`
* `82344dc34d2f2b63fb878e55f622b77b88c3b7b8@faroe-banana.isle-testnet.polypore.xyz:26656`
* `34056aa7a296accbd5a4ac15f3dc480d0fc4ca29@faroe-cherry.isle-testnet.polypore.xyz:26656`
* `fc78b514df730d19330fb9bd2f3bec8e72d62226@faroe-node.isle-testnet.polypore.xyz:26656`

## Preparing for Launch

### Node Setup

The `setup-faroe.sh` script provided in this repo will install the chain binary.
* It must be run either as root or from a sudoer account.
* The script will build the `interchain-security-cd` binary using Go 1.21.6.

### Assign a Consensus Key Before Launch

* You must submit your assign-consensus-key transaction before the spawn time is reached.
  ```
  gaiad tx provider assign-consensus-key test-faroe-1 <consumer node public key>
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
gaiad q provider consumer-genesis test-faroe-1 -o json --node https://rpc.provider-sentry-01.ics-testnet.polypore.xyz:443 > ccv.json
jq '.params.reward_denoms |= ["ufaro"]' ccv.json > ccv-denom.json
jq '.params.provider_reward_denoms |= ["uatom"]' ccv-denom.json > ccv-provider-denom.json
jq -s '.[0].app_state.ccvconsumer = .[1] | .[0]' faroe-genesis-pre-spawn.json ccv-provider-denom.json > faroe-genesis.json
```

### Joining the Consumer Chain Validator Set After Launch

* You can submit an opt-in transaction after the consumer chain has launched if you are not in the top N.
  ```
  gaiad tx provider opt-in test-faroe-1
  ```
  * If you did not assign a consensus key prior to opting in, you can assign it at this time.
    ```
    gaiad tx provider opt-in test-faroe-1 <consumer node public key>
    ```