# Testnet Game Day # 1: 2024-Jan-24

For our first-ever game day, we will experiment with how we respond to changes during software upgrades.
We will post announcements in the `testnet-announcements` channel in Discord to coordinate activities during the event.

* Start time: `2023-01-24 14:30 UTC`
* Estimated end time: `2023-01-24 15:30 UTC`

## Testnet Incentives Program (TIP) Eligibility

* Once your `gameday01` validator is running, send a tx from your provider wallet to `cosmos15vnglkkrgwp454rsjka6gtlnh9kp50dxgmdw34` in the `provider` chain with the `gameday01` cosmovaloper address in the memo. This is **required** for tracking TIP eligibility.


## Testnet Details

- **Chain-ID**: `gameday01`
- **Launch date**: 2024-01-22
- **Current Gaia Version:** `v13.0.2`
- **Genesis File:**  [genesis.json](https://github.com/cosmos/testnets/raw/master/game-days/gameday01/genesis.json)
- **Genesis sha256sum**: Verify with `shasum -a 256 genesis.json`: `110d827d493bc9bac6b103806b1c1e51ac8c98560596afd3571557d0dd94f173`


### Endpoints

RPC endpoints

- https://rpc.gameday01.rs-testnet.polypore.xyz:443

Seeds

- 1518a1e5168b2fd73926c83d092b945d13ddcc98@gameday01.rs-testnet.polypore.xyz:26656

### Block Explorers

- https://explorer.rs-testnet.polypore.xyz/gameday01


### Faucet

- https://gameday01-faucet.rs-testnet.polypore.xyz

## How to Join

* ⚠️ Do NOT use your `provider` chain keys. Never reuse keys!

### Bash Script

Run either one of the scripts provided in this repo to join the provider chain:
* `join-gameday01.sh` will create a `gaiad` service.
* `join-gameday01-cv.sh` will create a `cosmovisor` service.
* Both scripts must be run either as root or from a sudoer account.
* Both scripts will attempt to download the amd64 binary from the Gaia [releases](https://github.com/cosmos/gaia/releases) page. You can modify the `CHAIN_BINARY_URL` to match your target architecture if needed.


### Creating a Validator

Once you have some tokens in your self-delegation account, you can submit the `create-validator` transaction.

Submit the `create-validator` transaction.

```bash
gaiad tx staking create-validator \
--amount 1000000uatom \
--pubkey "$(gaiad tendermint show-validator)" \
--moniker <your moniker> \
--chain-id gameday01 \
--commission-rate 0.10 \
--commission-max-rate 1.00 \
--commission-max-change-rate 0.1 \
--gas auto \
--gas-adjustment 1.4 \
--gas-prices 0.005uatom \
--from <self-delegation-account>
```

You can verify the validator was created in the [block explorer](https://explorer.rs-testnet.polypore.xyz/gameday01/staking), or in the command line:

```
gaiad q staking validators -o json | jq '.validators[].description.moniker'
```
