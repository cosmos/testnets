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
* CCV file: https://raw.githubusercontent.com/cosmos/testnets/master/replicated-security/banksy-testnet-3/ccv.json
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

#### Persistent Peers (Thanks Polkachu):
 ```
 ab6375b396b09e3648b4d12c4b2b1aefdd8f4d4a@185.252.220.89:26656,e121e8bed6710d05e45f5a2ddf88107b360281c5@142.132.156.189:26656,2c08aa7bc9e94304225ada5ddc30374f00942a90@138.201.204.5:43656,08cf0f37ca069d9f4027b0b6cb406c40c9fabb16@51.91.118.140:26656,d25ca51122f2bd7738001818eb39fd4919c8fe92@20.208.46.170:26656,a53530c5bac43d5748e730f4f3abaa7b26d31ced@37.120.245.99:26656,b7d0bd260fca7a5a19c7631b15f6068891faa60e@143.198.45.216:25001,328a00ee256b3219e018a33b6cc124bc8b44249a@89.58.32.218:26656,c299ee06a11addcccb4cbd0d600ca521ff143ff1@65.109.25.113:14956,ca5c2c15856673dc79b8985377b28a9fc86b2188@57.128.20.118:29656,30a6d997733e95a823cd826ca3b99dca3906efdb@65.21.24.47:26656,08ec17e86dac67b9da70deb20177655495a55407@147.182.145.105:26656,bedd82fdaf29120c97eb88494e481c181426f2a0@63.229.234.75:26656,328e0627172add338f6aed08600098a9308dc52d@147.182.145.103:26656,f2520026fb9086f1b2f09e132d209cbe88064ec1@146.190.161.210:25003,091c4ea2235875b6730b51cf9d76cef549eef955@34.230.12.101:26656,0c3f20cd4b42287f47cc5dc9fcb82e8806e704ef@35.210.15.38:26656,65f3b835c3253fcdace2ef5afb47718e74339f9f@136.243.0.216:26656,5a4475fe23124a5cabd13d27ce14eccedb2ba1b5@141.95.103.138:26656,29bc3833f3584eb795fc28653021cfa25d9bb9c6@85.207.33.77:30156,4ea6e56300a2f37b90e58de5ee27d1c9065cf871@146.190.252.36:26656,99ad87e4419cbea7c59b27e77442a457eda1dc21@65.21.202.61:25007,bf4c544949c4922ab31d1c65ef6d0a7fbb5af99f@38.109.200.33:26656,f5772050cc2cab7dab946f2deb5e45ae1ea71dcc@148.251.133.248:30056,50bd49d6f0dd3bd5519572fc1522946c80702262@211.219.19.69:28656,ad5c0ab231f9b0ed91ffbaee70fd082fd5e78ad4@65.109.85.225:2010,92eb45963b0ef919d7d4cfd8faff05ade90637cc@65.109.85.226:2010,070b8d6935313f66f3a55c61560802a255a4f968@43.157.44.61:26656,a2491114d865ecf0a29f46cec3c3c9c056979e83@194.163.159.174:26656,1ffedf461d86d97b10f9dd064ffd046d49301ad4@208.88.251.50:26656,b0e1a54e0be7ff8af3caf457e29d217ca1184129@46.101.195.113:26656,3e085ac1382e57a62c770e11b334fb7a9a9c5daa@65.21.84.110:26656,c340bed60f5cbabb1aff82943390d8a8f2fcdd74@202.157.148.54:14956,794fcb57bb76c50515f31dc8e0e8d6536dea859d@178.239.197.182:26656,86c9f2f5f252eee2b64cf0aec8059c86c88b8824@65.21.84.109:26656,5c8ea31510389054b2e9192a8dfaa7a0f0b3f0c5@51.81.208.63:14956,032ac421764cdf5139e64510669cc519fe1e1193@37.120.245.83:26656,e281bdf052dad68ccf40777cb7d25649a5b9fa26@207.180.219.160:36656,d1752a3dcfc9d3169c47853a82fe0d1ec79c0024@147.182.145.100:26656,8d7627c01a0f133495d123aeffef4a4db0cee254@89.250.150.241:26656,a2cfd24ca641a6d407b03d98595f4755b349df61@141.94.138.48:26676,cb14b7f5ff66b52846b21912968c1880480aea0a@74.118.136.163:26656,f74e384e48bb78d566297eb502f8059798bfe2e5@135.181.16.163:26001,d13d77428697308eacb1a6a33b42f72650bc511e@80.64.208.139:26656,cd1cd8d95132857ae14825428e55eaffea36a597@195.14.6.2:26656,49d75c6094c006b6f2758e45457c1f3d6002ce7a@167.172.155.44:25002,538d7bbc8ee2d5c6cd8bd12da935759cef006e5e@5.161.94.187:26656,abb2ddadc12f9135209d1dd03b3707f649ecbb7a@147.182.145.88:26656,5fb5d0cd61d3ffcb4246a32321ea595827be6851@203.135.141.17:26656,6483d2098cab9402c7931dc07181f42fbe3cc05f@148.251.177.108:14956,a86f0c6f503b728cbd48218462dbee10d1ebea85@3.76.85.22:31556,a46ce2df33f8de333d0dd127238cb9603110b92a@43.131.37.70:26656
```

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
|3   |The proposals passed                                 |Nothing                                                                           | The proposals passed, `spawn_time` is set. After `spawn_time` is reached, the `ccv.json` file containing `ccv` state will be provided from provider chain.
|4   |Voting period for consumer-addition proposal.     |[PROVIDER] Optional: Vote for the consumer-addition proposal.                                 |Passing the consumer-addition proposal on the provider side.|
|5   |`spawn_time` reached                                  |The `ccv.json` file will be provided in the testnets repo. Place the newly generated `ccv.json` in the `$HOME/.banksy/config` directory. <br/><br/>NOTE: Do NOT replace the existing genesis file, the chain still running with old genesis file before and after upgrade.|`ccv` state is provided from provider chain. The new `ccv.json` file with ccv data will be published in `https://github.com/cosmos/testnets/tree/master/replicated-security/banksy-testnet-3`|
|6   |Upgrade height reached     | Restart your node with the post-transition binary `v6.0.1-ics`. The upgrade handler will automatically read the existing genesis file and new `ccv.json` file. | Composable chain halts to transition to being a consumer chain.                                                                                     |
|7   |3 blocks after upgrade height                     |Celebrate! :tada: 🥂                                                |Composable blocks are now produced by the provider validator set|
