# test-easter-1

## Chain information

* Chain ID: `test-easter-1`
* Denom: `uestr`
* Top N: `80`
* Bech32 prefix: `consumer`
* Binary
  * [`interchain-security-cd`](/isle/binaries/interchain-security-cd-linux-v4.0.0)
    * SHASUM: `f6fdb7f98c15915779d0493eb102ce44bdccda2a68f2abd262c4c88ce23e38b3`
    * Verify with `shasum -a 256 interchain-security-cd-linux-v4.0.0`
  * Repo: [interchain-security](https://github.com/cosmos/interchain-security/)
  * Version: [`v4.0.0`](https://github.com/cosmos/interchain-security/releases/tag/v4.0.0)
  * Built with Go 1.21.6
* Spawn time: `2024-05-13T15:00:00Z`
* Genesis file: **this file will be posted after the spawn time**
  * [`easter-genesis.json`](./easter-genesis.json)
  * SHASUM: `6585f1daad5cad92b1e15a42fce2e96bd87d9ec2d426158e5d92edd8ba182288` (verify with `shasum -a 256 easter-genesis.json`)

### Pre-spawn genesis file

This file is only posted for verifying the hash from the consumer-addition proposal.
* [`easter-genesis-pre-spawn.json`](./easter-genesis-pre-spawn.json)
  * SHASUM: `11d3a3eb1dde780771f2c3ff2654bfaddcc7f1dae9da79aec57977a8dac53e49` (verify with `shasum -a 256 easter-genesis-pre-spawn.json`)

## Endpoints

### Persistent peers

* `0b5b1e0b9c76377f3f4b09584de21c138ce67f53@easter-apple.isle-testnet.polypore.xyz:26656`
* `bb5952685d8a8fa4928bf0728a64efc7693d4622@easter-banana.isle-testnet.polypore.xyz:26656`
* `09b89ade1950ea024859127649d2f126fcce8c16@easter-cherry.isle-testnet.polypore.xyz:26656`
* `9348ab71b114e506a135cda026b52c21fb90ea62@easter-node.isle-testnet.polypore.xyz:26656`

## Preparing for Launch

### Node Setup

The `setup-easter.sh` script provided in this repo will install the chain binary.
* It must be run either as root or from a sudoer account.
* The script will build the `interchain-security-cd` binary using Go 1.21.6.

### Assign a Consensus Key Before Launch

* You must submit your assign-consensus-key transaction before the spawn time is reached.
  ```
  gaiad tx provider assign-consensus-key test-easter-1 <consumer node public key>
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
gaiad q provider consumer-genesis test-easter-1 -o json --node https://rpc.provider-sentry-01.ics-testnet.polypore.xyz:443 > ccv.json
jq '.params.reward_denoms |= ["uestr"]' ccv.json > ccv-denom.json
jq '.params.provider_reward_denoms |= ["uatom"]' ccv-denom.json > ccv-provider-denom.json
jq -s '.[0].app_state.ccvconsumer = .[1] | .[0]' easter-genesis-pre-spawn.json ccv-provider-denom.json > easter-genesis.json
```

### Joining the Consumer Chain Validator Set After Launch

* You can submit an opt-in transaction after the consumer chain has launched if you are not in the top N.
  ```
  gaiad tx provider opt-in test-easter-1
  ```
  * If you did not assign a consensus key prior to opting in, you can assign it at this time.
    ```
    gaiad tx provider opt-in test-easter-1 <consumer node public key>
    ```