# test-java-1

## Chain information

* Chain ID: `test-java-1`
* Opt-in
* Denom: `ujava`
* Minimum gas prices: `0ujava`
* Bech32 prefix: `consumer`
* Binary
  * [`interchain-security-cd`](/isle/binaries/interchain-security-cd-linux-v4.0.0)
    * SHASUM: `f6fdb7f98c15915779d0493eb102ce44bdccda2a68f2abd262c4c88ce23e38b3`
    * Verify with `shasum -a 256 interchain-security-cd-linux-v4.0.0`
  * Repo: [interchain-security](https://github.com/cosmos/interchain-security/)
  * Version: [`v4.0.0`](https://github.com/cosmos/interchain-security/releases/tag/v4.0.0)
  * Built with Go 1.21.6
* Spawn time: `2024-05-17T14:30:00Z`
* Genesis file: **this file will be posted after the spawn time**
  * [`java-genesis.json`](./java-genesis.json)
  * SHASUM: `` (verify with `shasum -a 256 java-genesis.json`)

### Pre-spawn genesis file

This file is only posted for verifying the hash from the consumer-addition proposal.
* [`java-genesis-pre-spawn.json`](./java-genesis-pre-spawn.json)
  * SHASUM: `fa3103910f46fbf1bf57f64e1bbb7c2ae969fb97770dc457599a6126bacf81bb` (verify with `shasum -a 256 java-genesis-pre-spawn.json`)

## Endpoints

### Persistent peers

* `a1e212b0a31f6a32b1dcf4517c58256f90341681@java-node.isle-testnet.polypore.xyz:26656`

## Preparing for Launch

### Node Setup

The `setup-java.sh` script provided in this repo will install the chain binary.
* It must be run either as root or from a sudoer account.
* The script will build the `interchain-security-cd` binary using Go 1.21.6.

### Opt in Before Launch

* You must submit your opt-in transaction before the spawn time is reached.
  ```
  gaiad tx provider opt-in test-java-1 <consumer node public key>
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
gaiad q provider consumer-genesis test-java-1 -o json --node https://rpc.provider-sentry-01.ics-testnet.polypore.xyz:443 > ccv.json
jq '.params.reward_denoms |= ["ujava"]' ccv.json > ccv-denom.json
jq '.params.provider_reward_denoms |= ["uatom"]' ccv-denom.json > ccv-provider-denom.json
jq -s '.[0].app_state.ccvconsumer = .[1] | .[0]' java-genesis-pre-spawn.json ccv-provider-denom.json > java-genesis.json
```

### Joining the Consumer Chain Validator Set After Launch

* You can submit an opt-in transaction after the consumer chain has launched if you are not in the top N.
  ```
  gaiad tx provider opt-in test-java-1
  ```
  * If you did not assign a consensus key prior to opting in, you can assign it at this time.
    ```
    gaiad tx provider opt-in test-java-1 <consumer node public key>
    ```
