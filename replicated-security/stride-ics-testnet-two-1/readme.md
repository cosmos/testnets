# `stride-ics-testnet-two-1`

Stride's launch on the Replicated Security Testnet will be a little different from previous consumer chain launches. Previous chain launches spawned a new chain from a fresh genesis state, but Stride already exists as a sovereign chain.

### How will the sovereign -> consumer chain transition work on the Replicated Security testnet?

* Stride side: The Stride team is running their own testnet (chain-id: stride-ics-testnet-two-1). That testnet will perform a software upgrade and at the upgrade height (shortly after the spawn time) it will transition to the provider chain’s validator set.
* Provider side: There will be a consumer-addition proposal for the stride chain. Shortly after the spawn time, we will receive the CCV state. This CCV state will be used to patch the original stride chain’s genesis file.

### What do you need to do to participate in the launch on Wednesday?
See the table below for a breakdown of steps you'll need to follow throughout the process. 

## ⚠️  Complete STEP 1 (join Stride testnet with a full node) ASAP ⚠️
Follow along with Stride's block explorer here: https://ics-explorer.stride.zone/stride 

For step 1, you can try using Stride’s joining script here: https://github.com/Stride-Labs/mainnet/blob/ics-testnet/ics-testnet/join_ics_testnet.sh 

Otherwise you may manually join stride-ics-testnet-two-1 using these notes:
* Joining instructions: https://github.com/Stride-Labs/mainnet/tree/ics-testnet/ics-testnet
* Genesis file: https://raw.githubusercontent.com/Stride-Labs/mainnet/ics-testnet/ics-testnet/genesis.json
* Pre-transition stride binary commit: `a3eff2dc`
* Stride’s GitHub repository: https://github.com/stride-Labs/stride
* Building instructions for stride’s binary: `make install`
* Go version: 1.19
* Persistent Peers = `"d747545dbab1eb86caff7ec64fca3b7f2ace07fd@stride-direct.testnet-2.stridenet.co:26656"`

* Chain ID: stride-ics-testnet-two-1
* Post-upgrade stride binary commit (run with this binary after the upgrade): [`e7a01bcdb0f192cb028638ccd25f02f9f8b73ad4`](https://github.com/Stride-Labs/stride/commit/e7a01bcdb0f192cb028638ccd25f02f9f8b73ad4)
  * You can also build with [this Docker image](https://hub.docker.com/layers/stridelabs/ics-testnet/stride/images/sha256-3268198b39fa9e3b6107f352f49d28c5c78939e1147370b166f848dbd112186e?context=repo)
 
<details><summary>Detailed steps for joining Stride Testnet</summary>
<br>
 
 _Courtesy of Stakecito_

```sh
git clone https://github.com/Stride-Labs/stride.git
cd stride
git checkout a3eff2dc
make install
strided init stride-node --chain-id stride-ics-testnet-two-1

# Grab the genesis file
curl -L https://raw.githubusercontent.com/Stride-Labs/mainnet/ics-testnet/ics-testnet/genesis.json -o $HOME/.stride/config/genesis.json
```

* Start stride node, node should start catching up
* Node will panic at UPGRADE_HEIGHT_TBD
* Stop the node

```sh
cd $HOME/stride

git checkout e7a01bcdb0f192cb028638ccd25f02f9f8b73ad4

make install
```

replace the binary

```sh
mkdir -p $HOME/.sovereign/config

curl -L https://github.com/cosmos/testnets/raw/master/replicated-security/stride-ics-testnet-two-1/genesis.json -o $HOME/.sovereign/config/genesis.json
```
</details>

<details><summary>Detailed steps for transitioning Stride node from non-validator on Stride testnet to validator on consumer chain</summary>
<br>

_Thanks to Bosco from Silk Nodes_

Download v11 Binary
```sh
cd stride
git pull
git checkout e7a01bcdb0f192cb028638ccd25f02f9f8b73ad4
make install

#Should be v11
strided version
```

Make directories in cosmovisor and copy binaries
```
mkdir -p $HOME/.stride/cosmovisor/upgrades/v11/bin/
cp $HOME/go/bin/strided $HOME/.stride/cosmovisor/upgrades/v11/bin/
```

Download new Sovereign genesis
```
mkdir -p $NODE_HOME/config/
wget -O $NODE_HOME/config/ccv.json URL_TBD_PENDING_SPAWN_TIME
```

Restart the Service
```
sudo service stride restart && journalctl -u stride -f -o cat
```

</details>

# Launch Sequence

| # | When? | Provider side | Stride side |
| -- | --- | ----- | ---- |
| 1 | Now | | Join the Stride testnet `stride-ics-testnet-two-1` with the pre-transition binary (commit hash `a3eff2dc`) as a full node (not validator) and sync to the tip of the chain (link to instructions below). |
| 2 | Now until software upgrade proposal passes on Stride | | Build (or download) the target (post-transition) Stride binary. <br><br>If you are using Cosmovisor, place place it in Cosmovisor `/upgrades/<upgrade-name>/bin` directory.<br><br>If you are not using Cosmovisor, be ready to manually switch your binary at the upgrade halt height. |
| 3 | Now until spawn time (15:00 UTC) | Submit assign-consensus-key for stride-ics-testnet-two-1 with the keys on your full node (**note: make sure to do this before spawn time!)** | |
| 4 | During voting period for  consumer-addition proposal on provider | You don’t have to do anything. Optionally, you may vote for the consumer-addition proposal | |
| 5 | During voting period for software upgrade on Stride | | You don’t have to do anything. |
| 6 | After spawn time | | Place the newly generated “genesis” file (containing only the ccv state) in the ⚠️ `$NODE_HOME/config directory` ⚠️ Stride will provide this.<br><br>Do NOT replace the existing genesis file. |
| 7 | When the software upgrade height is reached | | At the halt height, your node will halt.<br><br>Please upgrade to the  binary and ensure your genesis file has the CCV state from the provider chain |
