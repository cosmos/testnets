# `stride-ics-testnet-1`

Stride's launch on the Replicated Security Testnet will be a little different from previous consumer chain launches. Previous chain launches spawned a new chain from a fresh genesis state, but Stride already exists as a sovereign chain.

### How will the sovereign -> consumer chain transition work on the Replicated Security testnet?

* Stride side: The Stride team is running their own testnet (chain-id: stride-ics-testnet-1). That testnet will perform a software upgrade and at the upgrade height (shortly after the spawn time) it will transition to the provider chain’s validator set.
* Provider side: There will be a consumer-addition proposal for the stride chain. Shortly after the spawn time, we will receive the CCV state. This CCV state will be used to patch the original stride chain’s genesis file.

### What do you need to do to participate in the launch on Wednesday?
See the table below for a breakdown of steps you'll need to follow throughout the process. 

## ⚠️  Complete STEP 1 (join Stride testnet with a full node) ASAP ⚠️
Follow along with Stride's block explorer here: https://ics-explorer.stride.zone/stride 

For step 1, you can try using Stride’s joining script here: https://github.com/Stride-Labs/mainnet/blob/ics-testnet/ics-testnet/join_ics_testnet.sh 

Otherwise you may manually join stride-ics-testnet-1 using these notes:
* Joining instructions: https://github.com/Stride-Labs/mainnet/tree/ics-testnet/ics-testnet
* Genesis file: https://raw.githubusercontent.com/Stride-Labs/mainnet/ics-testnet/ics-testnet/genesis.json
* Pre-transition stride binary commit: `3aeb075f36cb12711201a7f17e8b8d856bd99a01`
* Stride’s GitHub repository: https://github.com/stride-Labs/stride
* Building instructions for stride’s binary: `make install`
* Go version: 1.19
* Persistent Peers = `"cd34b9f506a4840d5ea69095403029056862a2e1@stride-direct.testnet-2.stridenet.co:26656"`

* Chain ID: stride-ics-testnet-1
* Post-upgrade stride binary commit (run with this binary after the upgrade): [`17fa2fd7802005a7af09e6d2d0f5126b4bf1e10f`](https://github.com/Stride-Labs/stride/commit/17fa2fd7802005a7af09e6d2d0f5126b4bf1e10f)
  * You can also build with [this Docker image](https://hub.docker.com/layers/stridelabs/ics-testnet/stride-17fa/images/sha256-22dbec2b61e6745f0c80b48bebf23a80a8bd279da5b4dd943cbfed8a8d7f5c11?context=repo)
 
<details><summary>Detailed steps for joining Stride Testnet</summary>
<br>
 
 _Courtesy of Stakecito_

```sh
git clone https://github.com/Stride-Labs/stride.git
cd stride
git checkout 3aeb075f36cb12711201a7f17e8b8d856bd99a01
make install
strided init stride-node --chain-id stride-ics-testnet-1

# Grab the genesis file
curl -L https://raw.githubusercontent.com/Stride-Labs/mainnet/ics-testnet/ics-testnet/genesis.json -o $HOME/.stride/config/genesis.json
```

add `0b3e01c43f733e85b3d3f1a012256c5e19be796c@seed.testnet-2.stridenet.co:26656` as seed in `config.toml`

* Start stride node, node should start catching up
* Node will panic at block 4899
* Stop the node

```sh
cd $HOME/stride

git checkout 17fa2fd7802005a7af09e6d2d0f5126b4bf1e10f

make install
```

replace the binary

```sh
mkdir -p $HOME/.sovereign/config

curl -L https://github.com/cosmos/testnets/raw/master/replicated-security/stride-ics-testnet-1/genesis.json -o $HOME/.sovereign/config/genesis.json
```
</details>

<details><summary>Detailed steps for transitioning Stride node from non-validator on Stride testnet to validator on consumer chain</summary>
<br>

_Thanks to Bosco from Silk Nodes_

Download v10 Binary
```sh
cd stride
git pull
git checkout 17fa2fd7802005a7af09e6d2d0f5126b4bf1e10f
make install

#Should be v10
strided version
```

Make directories in cosmovisor and copy binaries
```
mkdir -p $HOME/.stride/cosmovisor/upgrades/v10/bin/
cp $HOME/go/bin/strided $HOME/.stride/cosmovisor/upgrades/v10/bin/
```

Download new Sovereign genesis
```
mkdir -p $HOME/.sovereign/config/
wget -O $HOME/.sovereign/config/genesis.json https://cdn.discordapp.com/attachments/1064857924402413600/1116022613966336041/genesis_new.json
```

Restart the Service
```
sudo service stride restart && journalctl -u stride -f -o cat
```

</details>

# Launch Sequence

| # | When? | Provider side | Stride side |
| -- | --- | ----- | ---- |
| 1 | Now | | Join the Stride testnet `stride-ics-testnet-1` with the pre-transition binary (commit hash `3aeb075f3`) as a full node (not validator) and sync to the tip of the chain (link to instructions below). |
| 2 | Now until software upgrade proposal passes on Stride | | Build (or download) the target (post-transition) Stride binary. <br><br>If you are using Cosmovisor, place place it in Cosmovisor `/upgrades/<upgrade-name>/bin` directory.<br><br>If you are not using Cosmovisor, be ready to manually switch your binary at the upgrade halt height. |
| 3 | Now until spawn time (15:00 UTC) | Submit assign-consensus-key for stride-ics-testnet-1 with the keys on your full node (**note: make sure to do this before spawn time!)** | |
| 4 | During voting period for  consumer-addition proposal on provider | You don’t have to do anything. Optionally, you may vote for the consumer-addition proposal | |
| 5 | During voting period for software upgrade on Stride | | You don’t have to do anything. |
| 6 | After spawn time | | Place the newly generated “genesis” file (containing only the ccv state) in the ⚠️ `$HOME/.sovereign/config directory` ⚠️ Stride will provide this.<br><br>Do NOT replace the existing genesis file. |
| 7 | When the software upgrade height is reached | | At the halt height, your node will halt.<br><br>Please upgrade to the  binary and ensure your genesis file has the CCV state from the provider chain |
