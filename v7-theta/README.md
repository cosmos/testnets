# v7-theta Testnets

As per the Cosmos Hub [roadmap](https://github.com/cosmos/gaia/blob/main/docs/roadmap/cosmos-hub-roadmap-2.0.md) Gaia v7-theta (v7.0.x) is planned to be released in Q1 2022 and contains the following:
- Cosmos SDK v0.45
- Gravity DEX: Liquidity v1.4.5
- IBC 3.0.0
- Interchain Account Module

The chain-id will remain `cosmoshub-4` during the upgrade.

We have a number of ways you can test out the coming release, through local, developer, and public testnets.

## Theta Developer testnet

Integrators such as exchanges and wallets who want to test againt theta endpoints early may do so using:

RPC endpoint: 159.223.187.74:26657
REST endpoint: 159.223.187.74:1317

**NOTE:** We'll be re-running these devnets regularly with fresh state. If you'd like us to add you to our genesis accounts each time, please make a PR with a cosmos address.

## Theta Local testnets

We use an [exported genesis file](exported_genesis.json.tar.gz) and made [modifications](local-testnet/modified_genesis.json.tar.gz).

These modifications replace an existing validator (Coinbase Custory) with a new validator accounts that we control. User account [mnemonic](local-testnet/mnemonic.txt) and the [private validator key](local-testnet/priv_validator_key.json) are provided in this repo.

Full list of modifications are as follows:

* Swapping chain id to theta-localnet
* Increasing balance of cosmos1wvvhhfm387xvfnqshmdaunnpujjrdxznr5d5x9 by 175000000000000 uatom
* Increasing supply of uatom by 175000000000000
* Increasing balance of cosmos1wvvhhfm387xvfnqshmdaunnpujjrdxznr5d5x9 by 1000 theta
* Increasing supply of theta by 1000
* Creating new coin theta valued at 1000
* Increasing balance of cosmos1wvvhhfm387xvfnqshmdaunnpujjrdxznr5d5x9 by 1000 rho
* Increasing supply of rho by 1000
* Creating new coin rho valued at 1000
* Increasing balance of cosmos1wvvhhfm387xvfnqshmdaunnpujjrdxznr5d5x9 by 1000 lambda
* Increasing supply of lambda by 1000
* Creating new coin lambda valued at 1000
* Increasing balance of cosmos1wvvhhfm387xvfnqshmdaunnpujjrdxznr5d5x9 by 1000 epsilon
* Increasing supply of epsilon by 1000
* Creating new coin epsilon valued at 1000
* Increasing balance of cosmos1fl48vsnmsdzcv85q5d2q4z5ajdha8yu34mf0eh by 550000000000000 uatom
* Increasing supply of uatom by 550000000000000
* Increasing delegator stake of cosmos1wvvhhfm387xvfnqshmdaunnpujjrdxznr5d5x9 by 550000000000000
* Increasing validator stake of cosmosvaloper1wvvhhfm387xvfnqshmdaunnpujjrdxznxqep2k by 550000000000000
* Increasing validator power of D5AB5E458FD9F9964EF50A80451B6F3922E6A4AA by 550000000
* Swapping min governance deposit amount to 1uatom
* Swapping tally parameter quorum to 0.000000000000000001
* Swapping tally parameter threshold to 0.000000000000000001
* Swapping governance voting period to 60s
* Swapping staking unbonding_time to 1s

Please note that you'll need to set `fast-sync` to false in your `config.toml` file and wait for approximately 10mins for a single node testnet to start. This is due to an [issue](https://github.com/osmosis-labs/osmosis/issues/735) with state export based testnets that can't get to consensus without multiple peered nodes.