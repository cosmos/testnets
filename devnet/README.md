# Rho Developer Testnet

Integrators such as exchanges and wallets who want to test against Rho endpoints early may do so using the Rho devnet.

**NOTE:** This devnet is restarted regularly with a fresh state. If you would like us to add you to our genesis accounts each time, please make a PR with a cosmos address and stating that you would like to be automatically included in future devnets.

## Testnet Details

This devnet is made up of 2 chains and a relayer.

- **Chain ID**: `rho-chain-1` and `rho-chain-2`
- **Launch date:** 2022-09-15
- **Gaia version:** `main-ddfcd1c2f3cd8069f759601320fe53cd38cd66a8` (main branch)
- **Genesis file:** [rho-devnet-genesis.json.gz](rho-devnet-genesis.json.gz)

### Endpoints
rho-chain-1:
* `http://rpc.sentry.chain-1.rho-devnet.polypore.xyz:26657`
* `http://rest.sentry.chain-1.rho-devnet.polypore.xyz:1317`
* `http://grpc.sentry.chain-1.rho-devnet.polypore.xyz:9090`
* `tcp://p2p.sentry.chain-1.rho-devnet.polypore.xyz:26656`

rho-chain-2:
* `http://rpc.sentry.chain-2.rho-devnet.polypore.xyz:26657`
* `http://rest.sentry.chain-2.rho-devnet.polypore.xyz:1317`
* `http://grpc.sentry.chain-2.rho-devnet.polypore.xyz:9090`
* `tcp://p2p.sentry.chain-2.rho-devnet.polypore.xyz:26656`

### Faucets
The faucet REST API are listed below:

rho-chain-1: http://sentry.chain-1.rho-devnet.polypore.xyz:8000
 - To request tokens: `http://sentry.chain-1.rho-devnet.polypore.xyz:8000/request?chain=rho-chain-2&address=<cosmos address>`
 - Get balance: `http://sentry.chain-1.rho-devnet.polypore.xyz:8000/balance?chain=rho-chain-2&address=<cosmos address>`

rho-chain-2: http://sentry.chain-2.rho-devnet.polypore.xyz:8000
 - To request tokens: `http://sentry.chain-2.rho-devnet.polypore.xyz:8000/request?chain=rho-chain-2&address=<cosmos address>`
 - Get balance: `http://sentry.chain-2.rho-devnet.polypore.xyz:8000/balance?chain=rho-chain-2&address=<cosmos address>`
