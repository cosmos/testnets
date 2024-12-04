
# Devnet Details

## ⏸️ The devnet is offline until a mainnet fork can be run with its own chain ID.

The Cosmos Hub devnet is used to test the next major upgrade before a release candidate is tagged.
* The devnet state represents a recent for of the Cosmos Hub (`gaia-devnet`).
* The provided snapshot will start by applying an upgrade.

* **Chain-ID**: `gaia-devnet`
* **denom**: `uatom`
* **Gaia Version**: Refer to https://files.polypore.xyz/gaia-devnet/ for the current version.
  * The `abci_info` endpoint also provides the current version:
    ```
    curl -s https://rpc.gaia-devnet.polypore.xyz/abci_info | jq -r '.result.response.version'
    ```
* **Genesis File:**  [genesis.json](https://files.polypore.xyz/gaia-devnet/genesis.json)

## Endpoints

### RPC

* `https://rpc.gaia-devnet.polypore.xyz`

### API

* `https://rest.gaia-devnet.polypore.xyz`

### gRPC

* `https://grpc.gaia-devnet.polypore.xyz`

### Persistent Peer

* `0ef1c4cbfe5b93a3e778acbc07fe0384567283d2@gaia-devnet.polypore.xyz:26656`

## Block Explorers

* https://explorer.polypore.xyz/gaia-devnet

## Faucet

* Visit `faucet-2.polypore.xyz` to request tokens and check your address balance.

## How to Join

The scripts provided in this repo will install Gaia and optionally set up a Cosmovisor service with the auto-download feature disabled on your machine.

### Bash Script

Run either one of the scripts provided in this repo to join the provider chain:
* `join-gaia-devnet.sh` will create a `gaiad` service.
* `join-gaia-devnet-cv.sh` will create a `cosmovisor` service.
* Both scripts must be run either as root or from a sudoer account.
* Both scripts will build the current running version from the [Gaia repo](https://github.com/cosmos/gaia/).
