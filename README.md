# Deploy a Testnet

## Setup

If you're running a full node validator we recommend you to comply with the necessary [technical requirements](https://github.com/cosmos/cosmos/blob/master/VALIDATORS_FAQ.md#technical-requirements). You can check more information regarding validators in our [website](https://cosmos.network/validators) or in the [validator FAQ](https://cosmos.network/resources/validator-faq).

### Install the SDK on a Cloud Server

You can set up a cloud server of your choice to run a non-validator full node.

#### Digital Ocean Droplet

Follow these commands to install the SDK on a Digital Ocean [Droplet](https://www.digitalocean.com/products/droplets/):

```
export PATH=$PATH:/usr/lib/go-1.10/bin
export PATH=$PATH:/root/go/bin
bash <(curl -s https://gist.github.com/melekes/1bd57c73646de97c8f6cbe1b780eb822/raw/2447b0fbf95775852c93a91ed3e12631c7ceb648/install.sh)
nohup ./build/gaiad start &
```

### Software Setup (Manual Installation)


#### Install [GNU Wget](https://www.gnu.org/software/wget/)

**MacOS**

```
brew install wget
```

**Linux**

```
sudo apt-get install wget
```

Note: You can check other available options for downloading `wget` [here](https://www.gnu.org/software/wget/faq.html#download).

#### Install binaries

Cosmos SDK can be installed to `$GOPATH/src/github.com/cosmos/cosmos-sdk` like a normal Go program:

```
go get github.com/cosmos/cosmos-sdk
cd $GOPATH/src/github.com/cosmos/cosmos-sdk
git fetch --all
git checkout 0f2aa6b
make get_tools // run $ make update_tools if already installed
make get_vendor_deps
make install
```

This will install `gaiad` and `gaiacli` and four example binaries: `basecoind`, `basecli`, `democoind`, and `democli`. Verify that everything is OK by running:

```
gaiad version
gaiacli version
```

You should see in both cases:

```
0.15.0-rc0-0f2aa6b
```

### Genesis Setup

Now that we have completed the basic SDK setup, we can start working on the genesis configuration for the chain we want to connect to. Initiliaze `gaiad` :

```
gaiad init
```

You can find the corresponding genesis files [here](https://github.com/cosmos/testnets). Then replace the `genesis.json` and `config.toml` files:

```
wget -O $HOME/.gaiad/config/genesis.json https://raw.githubusercontent.com/cosmos/testnet/master/gaia-4000/genesis.json

wget -O $HOME/.gaiad/config/config.toml https://raw.githubusercontent.com/cosmos/testnet/master/gaia-4000/config.toml
```

Lastly change the `moniker` string in the `config.toml` to identify your node.

```
# A custom human readable name for this node
moniker = "<your_custom_name>"
```

## Running a Full Node

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
KEYNAME=<set_a_name_for_your_new_key>
gaiacli keys add $KEYNAME
```

Next, you will have to enter a passphrase for your `$KEYNAME` key twice. Save the _seed_ _phrase_ in a safe place in case you forget the password.

Now if you check your private keys you will see the `$KEYNAME` key among them with the value of your `address`:

```
gaiacli keys show $KEYNAME
```

You can see all your other available keys by typing:

```
gaiacli keys list
```

Now get your public key by typing:

```
gaiad show_validator
```

You'll get the `value` of your `pk` in `base64` format and the `type` of it
To convert your `pk` to `hex` go to this [website](https://cryptii.com/base64-to-hex) and paste the value of the public key in the left box. On the right, select `Group By: None` to covert it.

Finally, save your address and pubkey into a variable

```
MYADDR=<your_newly_generated_address>
MYPUBKEY=<your_newly_generated_public_key>
```

**IMPORTANT:** We strongly recommend to **NOT** use the same passphrase for your different keys. The Tendermint team and the Interchain Foundation will not be responsible for the lost of funds.

### Getting coins

Go to the faucet in [http://atomexplorer.com/](http://atomexplorer.com/) and claim some coins for your testnet by typing the address of your key, as printed out above.

### Send tokens

```
gaiacli --amount=1000fermion --chain-id=<name_of_testnet_chain> --sequence=1 --name=$KEYNAME --to=<destination_address>
```

The `--amount` flag defines the corresponding amount of the coin in the format `--amount=<value|coin_name>`

The `--sequence` flag corresponds to the sequence number to sign the tx.

Now check the destination account and your own account to check the updated balances \(by default the latest block\):

```
gaiacli account <destination_address>
gaiacli account $MYADDR
```

You can also check your balance at a given block by using the `--block` flag:

```
gaiacli account $MYADDR --block=<block_height>
```

##### Custom fee \(coming soon\)

You can also define a custom fee on the transaction by adding the `--fee` flag using the same format:

```
gaiacli send --from=$MYADDR --amount=1000fermion --fee=1fermion --chain-id=<name_of_testnet_chain> --sequence=1 --name=$KEYNAME --to=<destination_address>
```

### Transfer tokens to other chain

The command to `transfer` tokens to other chain is the same as `send`, we just need to add the `--chain` flag:

```
gaiacli transfer --amount=20fermion --chain-id=<name_of_testnet_chain> --chain=<destination_chain> --sequence=1 --name=$KEYNAME --to=<sidechain_destination_address>
```

## Become a Validator

You can become a validator candidate by staking some tokens:

To check that the validator is active you can find it on the validator set list:

```
gaiacli validatorset
```

**Note:** Remember that to be in the validator set you need to have more total power than the Xnd validator, where X is the assigned size for the validator set \(by default _`X = 100`_\).

#### Delegating: Bonding and unbonding to a validator

You can delegate \(i.e. bind\) **Atoms** to a validator to obtain a part of its fee revenue in exchange \(the fee token in the Cosmos Hub are **Photons**\).

```
gaiacli bond --stake=10fermion --validator=<bonded_validator_address> --name=$KEYNAME --chain-id=<name_of_testnet_chain> --sequence=1
```

If for any reason the validator misbehaves or you just want to unbond a certain amount of the bonded tokens:

```
gaiacli unbond --name=$KEYNAME --chain-id=<name_of_testnet_chain> --sequence=1
```

You should now see the unbonded tokens reflected in your balance:

```
gaiacli account $MYADDR
```

#### Relaying

Relaying is key to enable interoperability in the Cosmos Ecosystem. It allows IBC packets of data to be sent from one chain to another.

The command to relay packets is the following:

```
gaiacli relay --from-chain-id=<name_of_testnet_chain> --to-chain-id=<destination_chain_name> --from-chain-node=<host>:<port> --to-chain-node=<host>:<port> --name=$KEYNAME --sequence=1
```
