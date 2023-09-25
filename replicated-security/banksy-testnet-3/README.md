# banksy-testnet-3 ICS Testnet

### How will the sovereign -> consumer chain transition work on the Replicated Security testnet?

* Composable side: The Composable team is running their own testnet (chain-id: `banksy-testnet-3`). That testnet will perform a software upgrade and at the upgrade height (shortly after the spawn time) it will transition to the provider chain’s validator set.

* Provider side: There will be a consumer-addition proposal for the Composable chain. Shortly after the spawn time, we will receive the CCV state. This CCV state will be used to patch the original Composable chain’s genesis file.

# Information and Joining instructions
Follow along with Composable's block explorer here: https://explorer.nodexcapital.com/banksy-testnet

Otherwise you may manually join `banksy-testnet-3` using these notes:
* Joining instructions: https://github.com/notional-labs/Composable-ICS-tesnet
* Spawn time: `Available soon`
* Genesis file (without CCV): https://raw.githubusercontent.com/notional-labs/Composable-ICS-tesnet/main/genesis.json
* CCV file: `Available soon`
* Pre-transition Composable binary: 
   * Version: [v5.0.0](https://github.com/notional-labs/Composable-ICS-tesnet/raw/main/binaries/v5.0.0/centaurid)
   * SHA256: `ef92568fed75492cee9b634ba368ed17e7c82737433e6918bc96f20e51a2b089`
* Composable’s GitHub repository: https://github.com/notional-labs/composable-centauri
* Go version: `1.19`
* Persistent Peers = `c0f197bdf6c4a4a16eb9db112d1ec9545336fd43@168.119.91.22:2250`
* Chain ID: `banksy-testnet-3`
* Post-upgrade Composable binary commit (run with this binary after the upgrade):
   * Version: [v6.0.1-ics](https://github.com/notional-labs/composable-centauri/releases/tag/v6.0.1-ics)
   * SHA256: `1b85b1423ec2af8a43c7a74f9d0a32209b6f023189cbfb9338180e3a0f9bd889`
- Public Notional endpoints: 
    - RPC: `https://rpc-banksy.notional.ventures:443`
    - API: `https://api-banksy.notional.ventures:443`
    - gRPC: `https://grpc-banksy.notional.ventures:443`
- Block Explorer: `https://explorer.nodexcapital.com/banksy-testnet`

### IBC data
| | banksy-testnet-3|provider|
|-------------|---------------------|-----------------|
|Client |`Available soon`| `Available soon`|
|Connections | `Available soon` | `Available soon` |
|Channels | `transfer`: `Available soon` <br/><br/> `consumer`: `Available soon` | `transfer`: `Available soon` <br/><br/> `consumer`: `Available soon` |

### Joining before transition
All provider validators must join `banksy-testnet-3` before the upgrade and `spawn_time`, using released binary:

```bash
export PATH=$PATH:$HOME/go/bin
wget https://github.com/notional-labs/composable-centauri/releases/download/v5.0.0/centaurid -O $HOME/go/bin.centaurid
chmod +x $HOME/go/bin.centaurid
sudo wget -P /usr/lib https://github.com/CosmWasm/wasmvm/raw/main/internal/api/libwasmvm.x86_64.so
centaurid version # v5.0.0
centaurid init <moniker> --chain-id banksy-testnet-3

# Genesis file without ccv module
wget https://raw.githubusercontent.com/notional-labs/Composable-ICS-tesnet/main/genesis.json -O $HOME/.banksy/config/genesis.json

# run node
centaurid start --p2p.seeds c0f197bdf6c4a4a16eb9db112d1ec9545336fd43@168.119.91.22:2250
```
Or building binary from source:
```bash
export PATH=$PATH:$HOME/go/bin
cd $HOME
git clone https://github.com/notional-labs/composable-centauri
cd composable-centauri
git checkout v5.0.0 # Using v5.0.0
make install
centaurid version # v5.0.0
```

### Upgrade and apply new genesis file
The node will start running until the upgrade height, at which the node will halt. Detail about timeline and instruction can be seen at **Launch Stages** section. To download new ccv file at `spawn_time`, and apply new version after upgrade height, see following commands:
```bash
# Download new genesis-ccv at `spawn_time`
wget -O $HOME/.banksy/config/ccv.json https://raw.githubusercontent.com/cosmos/testnets/master/replicated-security/banksy-testnet-3/ccv.json
```

```bash
# Installing centaurid v6.0.1-ics
export PATH=$PATH:$HOME/go/bin
cd $HOME
git clone https://github.com/notional-labs/composable-centauri
cd composable-centauri
git checkout v6.0.1-ics # Using v6.0.1-ics
make install
centaurid version # v6.0.1-ics

# run node
centaurid start --p2p.seeds c0f197bdf6c4a4a16eb9db112d1ec9545336fd43@168.119.91.22:2250
```

# Launch Stages
|Step|When?|What do you need to do?|What is happening?|
|----|--------------------------------------------------|----------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
|1   |ASAP                                              |Join the Composable testnet `banksy-testnet-3` with the pre-transition binary as a full node (not validator) and sync to the tip of the chain.|Validator machines getting caught up on existing Composable chain's history                                                                         |
|2   |Upgrade in Composable testnet and Consumer Addition on provider chain proposals voting period time | [PROVIDER] Optional: Vote for the consumer-addition proposal.  | The proposals that provide new binary for the transition, and passing Composable testnet from sovereign to consumer chain.                                 |
|3   |The proposals passed                                 |Nothing                                                                           | The proposals passed, `spawn_time` is set. After `spawn_time` is reached, the `genesis.json` file containing `ccv` state will be provided from provider chain.
|4   |Voting period for consumer-addition proposal.     |[PROVIDER] Optional: Vote for the consumer-addition proposal.                                 |Passing the consumer-addition proposal on the provider side.|
|5   |`spawn_time` reached                                  |The `ccv.json` file will be provided in the testnets repo. Place the newly generated `ccv.json` in the `$HOME/.banksy/config` directory. <br/><br/>NOTE: Do NOT replace the existing genesis file, the chain still running with old genesis file before and after upgrade.|`ccv` state is provided from provider chain. The new `ccv.json` file with ccv data will be published in `https://github.com/cosmos/testnets/tree/master/replicated-security/banksy-testnet-3`|
|6   |Upgrade height reached     | Restart your node with the post-transition binary `v6.0.1-ics`. The upgrade handler will automatically read the existing genesis file and new `ccv.json` file. | Composable chain halts to transition to being a consumer chain.                                                                                     |
|7   |3 blocks after upgrade height                     |Celebrate! :tada: 🥂                                                |Composable blocks are now produced by the provider validator set|
