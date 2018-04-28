# Deploy a Testnet

## Software Setup \(Manual Installation\)

- Install [GNU Wget](https://www.gnu.org/software/wget/):

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
cd $GOPATH/src/github.com/cosmos/cosmos-sdk
git fetch --all
git checkout 0f2aa6b
make get_tools // run $ make update_tools if already installed
make get_vendor_deps
make install
```

The latest binaries should now be installed. Verify that everything is OK by running:

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

wget -O $HOME/.gaiad/config/genesis.json https://raw.githubusercontent.com/cosmos/testnet/master/gaia-4000/genesis.json

wget -O $HOME/.gaiad/config/config.toml https://raw.githubusercontent.com/cosmos/testnet/master/gaia-4000/config.toml
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

To generate your a new key \(default _ed25519_ elliptic curve\):

```
gaiacli keys add default
```

Next, you will have to enter a passphrase for your key twice. Save the _seed phrase_ in a safe place in case you forget the password.

Now if you check your private keys you will see the key among them:

```
gaiacli keys list
```

## Getting Coins

Go to the faucet in [http://atomexplorer.com/](http://atomexplorer.com/) and claim some coins for your testnet by typing the address of your key, as printed out above.

## Send tokens

```
gaiacli send --amount=1000fermion --chain-id=gaia-4000 --sequence=0 --name=default --to=<destination_address>
```

The `--amount` flag defines the corresponding amount of the coin in the format `--amount=<value|coin_name>`

The `--sequence` flag corresponds to the sequence number to sign the tx.

Now check the destination account and your own account to check the updated balances \(by default the latest block\):

```
gaiacli account <destination_address>
gaiacli account <your_address>
```


## Staking: Becoming a Validator

Get your public key by typing:

```
gaiad show_validator
```

Take the base64 encoded string from the value field and use [this](https://cryptii.com/base64-to-hex) to convert it to hex. 
Change `Group by` to `None`.

Send the bonding transaction:

*Remember to use your own validator address or use mine if you want to delegate to me.*

```
gaiacli bond --stake=6steak --validator=45798afe9b0cd7a05b765107b744478f91848d18a54ce7d06daace1c71a56913 --sequence=0 --chain-id=gaia-4000 --name=default
```
