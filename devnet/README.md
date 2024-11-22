
# Devnet Details

## ⏸️ The devnet is offline until a mainnet fork can be run with its own chain ID.

The Cosmos Hub devnet is used to test the next major upgrade before a release candidate is tagged.
* The devnet state represents a recent for of the Cosmos Hub (`cosmoshub-4`).
* The provided snapshot will start by applying an upgrade.

* **Chain-ID**: `cosmoshub-4`
* **denom**: `uatom`
* **Gaia Version**: Refer to https://files.polypore.xyz/gaia-devnet/ for the current version.
  * The `abci_info` endpoint also provides the current version:
    ```
    curl -s https://rpc.gaia-devnet.polypore.xyz/abci_info | jq -r '.result.response.version'
    ```
* **Genesis File:**  [genesis.cosmoshub-4.json.gz](https://github.com/cosmos/mainnet/raw/master/genesis/genesis.cosmoshub-4.json.gz)
   * Verify with `sha256sum genesis.cosmoshub-4.json.gz`
   * Genesis sha256sum: `7fe946e6bb3c378da546767f4d078585c38f256c8ec17888d71aeee3b7edd5c7`

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

## Snapshot

* https://files.polypore.xyz/gaia-devnet/

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

#### Sync from snapshot

1. Build, install, and configure the matching running version of gaiad
2. Download the snapshot https://files.polypore.xyz/gaia-devnet/
3. Remove existing `data` and `wasm` directories in the ~/.gaia directory
4. Extract the snapshot in the ~/.gaia directory
5. Start the `gaiad` binary normally with `gaiad start`
