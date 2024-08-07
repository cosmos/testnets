# test-conmod-1

## Chain information

* Chain ID: `test-conmod-1`
* Opt-in
* Allowlist: `cosmosvalcons146zd98kguwau7y3mfrrs9k4fsthv9qct9mdnx0`,`cosmosvalcons15yprks04304h8wg0x2fef53g50x9w2qa3c0hcd`,`cosmosvalcons12m5td27rwwy95drgk53w9pfhlxqqguqmlfph2g`
* Denom: `umod`
* Minimum gas prices: `0umod`
* Bech32 prefix: `consumer`
* Binary
  * [`interchain-security-cd`](https://github.com/hyphacoop/cosmos-builds/releases/download/ics-v5.1.1/interchain-security-cd-linux)
    * SHASUM: `3a10025f73204a313e75b5fd121f9ff5f9cc2c23a89d9692264f8eec108a90f0`
    * Verify with `shasum -a 256 interchain-security-cd-linux-v5.1.1`
  * Repo: [interchain-security](https://github.com/cosmos/interchain-security/)
  * Version: [`v5.1.1`](https://github.com/cosmos/interchain-security/releases/tag/v5.1.1)
  * Built with Go 1.22.4
* Spawn time: `2024-08-06T19:00:00Z`
* Genesis file:
  * [`conmod-genesis.json`](./conmod-genesis.json)
  * SHASUM: `471aad0e290242566e65b1a1ab9881782afc76e2050c7730d1304c1e7428f28d` (verify with `shasum -a 256 conmod-genesis.json`)

## Endpoints

### Persistent peers

* `ab4a6db38c2c4932ed3933db40e31c9bb2eb697b@conmod-banana.ics-testnet.polypore.xyz:26656`
* `02618e00d1a8957736ce9b0c8ae77a5298d86a32@conmod-cherry.ics-testnet.polypore.xyz:26656`
* `84e2bb712ab5013a36cd9b8e08c882ea5a445109@conmod-node.ics-testnet.polypore.xyz:26656`

## Preparing for Launch

### Node Setup

The `setup-conmod.sh` script provided in this repo will install the chain binary.
* It must be run either as root or from a sudoer account.
* The script will build the `interchain-security-cd` binary using Go 1.21.6.

### Opt in Before Launch

* You can submit your opt-in transaction before the spawn time is reached to start signing blocks as soon as the chain starts.
  ```
  gaiad tx provider opt-in test-conmod-1 <consumer node public key>
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
gaiad q provider consumer-genesis test-conmod-1 -o json --node https://rpc.provider-sentry-01.ics-testnet.polypore.xyz:443 > ccv.json
jq '.params.reward_denoms |= ["upow"]' ccv.json > ccv-denom.json
jq '.params.provider_reward_denoms |= ["uatom"]' ccv-denom.json > ccv-provider-denom.json
jq -s '.[0].app_state.ccvconsumer = .[1] | .[0]' conmod-genesis-pre-spawn.json ccv-provider-denom.json > conmod-genesis.json
```

### Joining the Consumer Chain Validator Set After Launch

* You can submit an opt-in transaction after the consumer chain has launched.
  ```
  gaiad tx provider opt-in test-conmod-1 <consumer node public key>
  ```
