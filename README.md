# Deploy a Testnet

## Install Cosmos-SDK on a Digital Ocean Droplet \(Recomended\)

```
export PATH=$PATH:/usr/lib/go-1.10/bin
export PATH=$PATH:/root/go/bin
bash <(curl -s https://gist.github.com/melekes/1bd57c73646de97c8f6cbe1b780eb822/raw/2447b0fbf95775852c93a91ed3e12631c7ceb648/install.sh)
nohup ./build/gaiad start &
```

## Software Setup

**Install **[**GNU Wget**](https://www.gnu.org/software/wget/)**: **

**MacOS**

```
brew install wget
```

**Linux**

```
sudo apt-get install wget
```

Note: You can check other available options for downloading `wget` [here](https://www.gnu.org/software/wget/faq.html#download).

**Get Source Code**

```
go get github.com/cosmos/cosmos-sdk
```

Now we can fetch the correct versions of each dependency by running:

```
git fetch --all
git checkout develop
make get_tools // run $ make update_tools if already installed
make get_vendor_deps
make install
make install_examples
```

The latest cosmos-sdk should now be installed. Verify that everything is OK by running:

```
gaiad version
```

You should see:

```
0.15.0-rc0-0f2aa6b
```

And also:

```
gaiacli version
```

You should see:

```
0.15.0-rc0-0f2aa6b
```

## Genesis Setup

Initiliaze `gaiad` :

```
gaiad init
```

You can find the corresponding genesis files [here](https://github.com/tendermint/testnets). Then replace the `genesis.json`and `config.toml` files:

```
rm $HOME/.gaiad/config/genesis.json $HOME/.gaiad/config/config.toml $HOME/.gaiad/config/addrbook.json

wget -O $HOME/.gaiad/config/genesis.json https://raw.githubusercontent.com/tendermint/testnets/master/gaia-4000/gaia/genesis.json

wget -O $HOME/.gaiad/config/config.toml https://raw.githubusercontent.com/tendermint/testnets/master/gaia-4000/gaia/config.toml
```

Lastly change the `moniker` string in the`config.toml`to identify your node.

```
# A custom human readable name for this node
moniker = "<your_custom_name>"
```


## Starting Gaiad

Start the full node:

```
gaiad start
```

Check the everything is running smoothly:

```
gaiacli status
```

## Generate keys

You'll need a private and public key pair \(a.k.a. `sk, pk` respectively\) to be able to receive funds, send txs, bond tx, etc.

To generate your a new key \(default _ed25519 _elliptic curve\):

```
KEYNAME=<set_a_name_for_your_new_key>
gaiacli keys add $KEYNAME
```

Next, you will have to enter a passphrase for your`$KEYNAME`key twice. Save the _seed phrase _in a safe place in case you forget the password.

Now if you check your private keys you will see the `$KEYNAME `key among them:

```
gaiacli keys show $KEYNAME
```

You can see your other available keys by typing:

```
gaiacli keys list
```

Save your address and pubkey into a variable

```
MYADDR=<your_newly_generated_address>
MYPUBKEY=<your_newly_generated_public_key>
```

_IMPORTANT: We strongly recommend to **NOT** use the same passphrase for your different keys. The Tendermint team and the Interchain Foundation will not be responsible for the lost of funds._

## Getting Coins

Go to the faucet in [http://atomexplorer.com/](http://atomexplorer.com/) and claim some coins for your testnet by typing the address of your key, as printed out above.

## Send tokens

```
gaiacli send --from=$MYADDR --amount=1000fermion --chain-id=<name_of_testnet_chain> --sequence=1 --name=$KEYNAME --to=<destination_address>
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

The command to`transfer`tokens to other chain is the same as`send`, we just need to add the`--chain`flag:

```
gaiacli transfer --from=$MYADDR --amount=20fermion --chain-id=<name_of_testnet_chain> --chain=<destination_chain> --sequence=1 --name=$KEYNAME --to=<sidechain_destination_address>
```

## Staking: Add a Validator

Get your public key by typing:

```
gaiad show_validator
```

The returned value is your validator address in hex. This can be used to create a new validator candidate by staking some tokens:

```
gaiacli declare-candidacy --amount=500fermions --pubkey=$PUBKEY --address-candidate=$MYADDR --moniker=satoshi --chain-id=<name_of_the_testnet_chain> --sequence=1 --name=$KEYNAME
```

You can add more information of the validator candidate such as`--website`, `--keybase-sig `or additional`--details`. If you want to edit the candidate info:

```
gaiacli edit-candidacy --details="To the cosmos !" --website="https://cosmos.network"
```

Finally, you can check all the candidate information by typing:

```
gaiacli candidate --address-candidate=$MYADDR --chain-id=<name_of_the_testnet_chain>
```

To check that the validator is active you can find it on the validator set list:

```
gaiacli validatorset
```

\*_Note: Remember that to be in the validator set you need to have more total power than the Xnd validator, where X is the assigned size for the validator set \(by default _`X = 100`_\). _

#### Delegating: Bonding and unbonding to a validator

You can delegate \(i.e. bind\) **Atoms** to a validator to obtain a part of its fee revenue in exchange \(the fee token in the Cosmos Hub are **Photons**\).

```
gaiacli delegate --amount=10fermion --address-delegator=$MYADDR --address-candidate=<bonded_validator_address> --shares=MAX --name=$KEYNAME --chain-id=<name_of_testnet_chain> --sequence=1
```

If for any reason the validator misbehaves or you just want to unbond a certain amount of the bonded tokens:

```
gaiacli unbond --address-delegator=$MYADDR --address-candidate=<bonded_validator_address> --shares=MAX --name=$KEYNAME --chain-id=<name_of_testnet_chain> --sequence=1
```

You can unbond a specific amount of`shares`\(eg:`12.1`\) or all of them \(`MAX`\).

You should now see the unbonded tokens reflected in your balance and in your delegator bond :

```
gaiacli account $MYADDR
gaiacli delegator-bond --address-delegator=$MYADDR --address-candidate=<bonded_validator_address> --chain-id=<name_of_testnet_chain>
```

#### Relaying

Relaying is key to enable interoperability in the Cosmos Ecosystem. It allows IBC packets of data to be sent from one chain to another.

The command to relay packets is the following:

```
gaiacli relay --from-chain-id=<name_of_testnet_chain> --to-chain-id=<destination_chain_name> --from-chain-node=<host>:<port> --to-chain-node=<host>:<port> --name=$KEYNAME --sequence=1
```
