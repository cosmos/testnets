# `banksy-testnet-3`



### How will the sovereign -> consumer chain transition work on the Replicated Security testnet?

* Composable side: The Composable team is running their own testnet (chain-id: `banksy-testnet-3`). That testnet will perform a software upgrade and at the upgrade height (shortly after the spawn time) it will transition to the provider chain’s validator set.
* Provider side: There will be a consumer-addition proposal for the Composable chain. Shortly after the spawn time, we will receive the CCV state. This CCV state will be used to patch the original Composable chain’s genesis file.

### What do you need to do to participate in the launch on Wednesday?
See the table below for a breakdown of steps you'll need to follow throughout the process. 

## ⚠️  Complete STEP 1 (join Composable testnet with a full node) ASAP ⚠️
Follow along with Composable's block explorer here: https://ics-explorer.Composable.zone/Composable 

For step 1, you can try using Composable’s joining script here: https://github.com/Composable-Labs/mainnet/blob/ics-testnet/ics-testnet/join_ics_testnet.sh 

Otherwise you may manually join `banksy-testnet-3` using these notes:
* Joining instructions: https://github.com/Composable-Labs/mainnet/tree/ics-testnet/ics-testnet
* Genesis file: https://raw.githubusercontent.com/Composable-Labs/mainnet/ics-testnet/ics-testnet/genesis.json
* Pre-transition Composable binary commit: `a3eff2dc`
* Composable’s GitHub repository: https://github.com/Composable-Labs/Composable
* Building instructions for Composable’s binary: `make install`
* Go version: 1.19
* Persistent Peers = `"d747545dbab1eb86caff7ec64fca3b7f2ace07fd@Composable-direct.testnet-2.Composablenet.co:26656"`
* Chain ID: `banksy-testnet-3`
* Post-upgrade Composable binary commit (run with this binary after the upgrade): [`ed3fcf9512ee136a03b58a7cd1d21b0e002de06f`](https://github.com/Composable-Labs/Composable/commit/ed3fcf9512ee136a03b58a7cd1d21b0e002de06f)
  * You can use [this](https://storage.googleapis.com/Composabled-binaries/Composabled) pre-build linux binary. E.g. `wget -O Composabled 'https://storage.googleapis.com/Composabled-binaries/Composabled'`
 
<details><summary>Detailed steps for manually joining Composable Testnet</summary>
<br>
 
 _Courtesy of Stakecito_

```sh
git clone https://github.com/Composable-Labs/Composable.git
cd Composable
git checkout a3eff2dc
make install
Composabled init Composable-node --chain-id Composable-ics-testnet-two-1

# Grab the genesis file
curl -L https://raw.githubusercontent.com/Composable-Labs/mainnet/ics-testnet/ics-testnet/genesis.json -o $HOME/.Composable/config/genesis.json
```

* Start Composable node, node should start catching up
* Node will panic at UPGRADE_HEIGHT_TBD
* Stop the node

</details>

<details><summary>Detailed steps for transitioning Composable node from Composable testnet to validator on consumer chain</summary>
<br>

_Thanks to Bosco from Silk Nodes_

Download v11 Binary
```sh
cd Composable
git pull
git checkout ed3fcf9512ee136a03b58a7cd1d21b0e002de06f
make install

#Should be v11
Composabled version
```

Make directories in cosmovisor and copy binaries
```
mkdir -p $HOME/.Composable/cosmovisor/upgrades/v11/bin/
cp $HOME/go/bin/Composabled $HOME/.Composable/cosmovisor/upgrades/v11/bin/
```

Download new Sovereign genesis
```
mkdir -p $NODE_HOME/config/
wget -O $NODE_HOME/config/ccv.json URL_TBD_PENDING_SPAWN_TIME
```

Restart the Service
```
sudo service Composable restart && journalctl -u Composable -f -o cat
```

</details>

# Launch Sequence
|Step|When?                                             |What do you need to do?                                                                       |What is happening?                                                                                                                              |
|----|--------------------------------------------------|----------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
|1   |ASAP                                              |Join the Composable testnet `Composable-ics-testnet-two-1` with the pre-transition binary as a full node (not validator) and sync to the tip of the chain.|Validator machines getting caught up on existing Composable chain's history                                                                         |
|2   |Before software upgrade proposal passes on Composable |Build (or download) the target (post-transition) Composable binary. If you are using Cosmovisor, place place it in Cosmovisor `/upgrades/v11/bin` directory. If you are not using Cosmovisor, be ready to manually switch your binary at the upgrade halt height.|Setup for machines to switch from being a full node to a validator when the chain transitions.                                                  |
|3   |Before spawn time                                 |[PROVIDER] If using key assignment, submit assign-consensus-key for `Composable-ics-testnet-two-1` with the keys on your full node. You can also just run with the same consensus key as your provider node.|Key assignment (optional) to link provider and consumer validators.                                                                             |
|4   |Voting period for consumer-addition proposal.     |[PROVIDER] Optional: Vote for the consumer-addition proposal.                                 |Passing the consumer-addition proposal on the provider side.                                                                                    |
|5   |Voting period for software upgrade                |Nothing                                                                                       |Passing the software upgrade proposal on the Composable side.                                                                                       |
|6   |Spawn time                                        |Nothing                                                                                       |ccv state becomes available                                                                                                                     |
|7   |After spawn time                                  |The `ccv.json` file will be provided in the testnets repo. Place the newly generated `ccv.json` in the `$NODE_HOME/config` directory.   Do NOT replace the existing genesis file.|Adding the ccv state to the genesis file for the new consumer chain.                                                                            |
|8   |Upgrade height                                    |Restart your node with the post-transition binary. The upgrade handler will automatically read the existing genesis file and the new `ccv.json` file if they are correctly placed.|Composable chain halts to transition to being a consumer chain.                                                                                     |
|9   |3 blocks after upgrade height                     |Celebrate! :tada: 🥂                                                |Composable blocks are now produced by the provider validator set                                                                                    |
