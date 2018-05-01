# Connect to a Testnet

This document explains how to connect to the Testnet of a [Cosmos-SDK](https://github.com/cosmos/cosmos-sdk/) based blockchain. It can be used to connect to the latest Testnet for the Cosmos Hub.

## Software Setup (Manual Installation)

Follow these instructions to install the Cosmos-SDK and connect to the latest Testnet. This instructions work for both a local machine and a VM in a cloud server.

If you want to run a non-validator full-node, installing the SDK on a Cloud server is a good option. However, if you are want to become a validator for the Hub's `mainnet` you should look at more complex setups, including [Sentry Node Architecture](https://github.com/cosmos/cosmos/blob/master/VALIDATORS_FAQ.md#how-can-validators-protect-themselves-from-denial-of-service-attacks), to protect your node from DDOS and ensure high-availability (see the [technical requirements](https://github.com/cosmos/cosmos/blob/master/VALIDATORS_FAQ.md#technical-requirements)). You can find more information on validators in our [website](https://cosmos.network/validators), in the [Validator FAQ](https://cosmos.network/resources/validator-faq) and in the [Validator Chat](https://riot.im/app/#/room/#cosmos_validators:matrix.org).

### Install [Go](https://golang.org/)

Install `go` following the [instructions](https://golang.org/doc/install) in the official golang website.
You will require **Go 1.9+** for this tutorial.

#### Set GOPATH

First, you will need to set up your `GOPATH`. Make sure that the location `$HOME` is something like `/Users/<username>`, you can corroborate it by typing `echo $HOME` in your terminal.

Go to `$HOME` with the command `cd $HOME` and open the the hidden file `.barshrc` with a code editor and paste the following lines \(or `.bash_profile` if your're using OS X\).

```
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
```

Save and restart the terminal.

_Note_: If you can't see the hidden file, use the shortcut `Command + Shift + .` in Finder.

#### Update Packages

To update all packages in your `GOPATH` run:

```
go get -u all
```

If you want to update a specific package run:

```
go get -u <package_name>
```

### Install [Glide](https://glide.sh/)

Glide is a package manager for Go used in most of Tendermint's and Cosmos' codebases.

To install it copy and paste the following command in your Terminal:

```
curl https://glide.sh/get | sh
```

Or install it with [Homebrew](https://brew.sh/) if you have MacOS \(OSX\):

```
brew install glide
```

### Install [GNU Wget](https://www.gnu.org/software/wget/)

**MacOS**

```
brew install wget
```

**Linux**

```
sudo apt-get install wget
```

Note: You can check other available options for downloading `wget` [here](https://www.gnu.org/software/wget/faq.html#download).

### Install binaries

Cosmos SDK can be installed to `$GOPATH/src/github.com/cosmos/cosmos-sdk` like a normal Go program:

```
go get github.com/cosmos/cosmos-sdk
cd $GOPATH/src/github.com/cosmos/cosmos-sdk
git fetch --all
git checkout d613c2b9
make get_tools // run $ make update_tools if already installed
make get_vendor_deps
make install
```

This will install the `gaiad` and `gaiacli` binaries. Verify that everything is OK by running:

```
gaiad version
gaiacli version
```

You should see in both cases:

```
0.15.0-rc0-d613c2b9
```

### Genesis Setup

Now that we have completed the basic SDK setup, we can start working on the genesis configuration for the chain we want to connect to.

Initiliaze `gaiad` :

```
gaiad init
```

You can find the corresponding genesis files [here](https://github.com/cosmos/testnets). Then replace the `genesis.json` and `config.toml` files:

```
wget -O $HOME/.gaiad/config/genesis.json https://raw.githubusercontent.com/cosmos/testnet/master/gaia-5000/genesis.json

wget -O $HOME/.gaiad/config/config.toml https://raw.githubusercontent.com/cosmos/testnet/master/gaia-5000/config.toml
```

Lastly change the `moniker` string in the `config.toml` to identify your node.

```
# A custom human readable name for this node
moniker = "<your_custom_name>"
```

## Run a Full Node

Start the full node:

```
gaiad start
```

Check the everything is running smoothly:

```
gaiacli status
```

### Generate keys

You'll need a private and public key pair \(a.k.a. `sk, pk` respectively\) to be able to receive funds, send txs, bond tx, etc.

To generate your a new key \(default _ed25519_ elliptic curve\):

```
gaiacli keys add <your_key_name>
```

Next, you will have to enter a passphrase for your key twice. Save the _seed_ _phrase_ in a safe place in case you forget the password.

Now if you check your private keys you will see the `<your_key_name>` key among them:

```
gaiacli keys show <your_key_name>
```

You can see all your other available keys by typing:

```
gaiacli keys list
```

The validator pubkey from your node should be the same as the one printed with the command:

```
gaiad show_validator
```

Finally, save your address and pubkey into a variable to use them afterwards.

```
MYADDR=<your_newly_generated_address>
MYPUBKEY=<your_newly_generated_public_key>
```

**IMPORTANT:** We strongly recommend to **NOT** use the same passphrase for your different keys. The Tendermint team and the Interchain Foundation will not be responsible for the lost of funds.

### Get coins

Go to the faucet in [http://atomexplorer.com/](http://atomexplorer.com/) and claim some coins for your testnet by typing the address of your key, as printed out above.

### Send tokens

```
gaiacli send --amount=1000fermion --chain-id=<name_of_testnet_chain> --sequence=1 --name=<key_name> --to=<destination_address>
```

The `--amount` flag defines the corresponding amount of the coin in the format `--amount=<value|coin_name>`

The `--sequence` flag corresponds to the sequence number to sign the tx.

Now check the destination account and your own account to check the updated balances \(by default the latest block\):

```
gaiacli account <destination_address>
gaiacli account <your_address>
```

You can also check your balance at a given block by using the `--block` flag:

```
gaiacli account <your_address> --block=<block_height>
```

## Run a Validator Node

[Validators](https://cosmos.network/validators) are actors from the network that are responsible from commiting new blocks to the blockchain by submitting their votes. This section covers the instructions necessary to stake tokens to become a testnet validator candidate.

Your `pubkey` can be used to create a new validator candidate by staking some tokens:

```
gaiacli declare-candidacy --amount=500fermions --pubkey=<your_pubkey> --address-candidate=<your_address> --moniker=satoshi --chain-id=<name_of_the_testnet_chain> --sequence=1 --name=<key_name>
```

You can add more information of the validator candidate such as`--website`, `--keybase-sig `or additional `--details`. If you want to edit the candidate info:

```
gaiacli edit-candidacy --details="To the cosmos !" --website="https://cosmos.network"
```

Finally, you can check all the candidate information by typing:

```
gaiacli candidate --address-candidate=<your_address> --chain-id=<name_of_the_testnet_chain>
```

To check that the validator is active you can find it on the validator set list:

```
gaiacli validatorset
```

**Note:** Remember that to be in the validator set you need to have more total power than the Xnd validator, where X is the assigned size for the validator set \(by default _`X = 100`_\).

## Delegate your tokens

You can delegate \(_i.e._ bind\) **Atoms** to a validator to become a [delegator](https://cosmos.network/resources/delegators) and obtain a part of its fee revenue in **Photons**. For more information about the Cosmos Token Model, refer to our [whitepaper](https://github.com/cosmos/cosmos/raw/master/Cosmos_Token_Model.pdf).

### Bond to a validator

Bond your tokens to a validator candidate with the following command:

```
gaiacli delegate --amount=10fermion --address-delegator=<your_address> --address-candidate=<bonded_validator_address> --name=<key_name> --chain-id=<name_of_testnet_chain> --sequence=1
```

### Unbond

If for any reason the validator misbehaves or you just want to unbond a certain amount of the bonded tokens:

```
gaiacli unbond --address-delegator=<your_address> --address-candidate=<bonded_validator_address> --shares=MAX --name=<key_name> --chain-id=<name_of_testnet_chain> --sequence=1
```

You can unbond a specific amount of`shares`\(eg:`12.1`\) or all of them \(`MAX`\).

You should now see the unbonded tokens reflected in your balance and in your delegator bond:

```
gaiacli account <your_address>
gaiacli delegator-bond --address-delegator=<your_address> --address-candidate=<bonded_validator_address> --chain-id=<name_of_testnet_chain>
```
