#  Steps

## Software Setup

**Get Source Code**

```
go get github.com/cosmos/cosmos-sdk
```

Now we can fetch the correct versions of each dependency by running:

```
cd $GOPATH/src/github.com/cosmos/cosmos-sdk
git fetch --all
git checkout 0f2aa6b
make get_tools
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

Initiliase Gaiad:

```
gaiad init
````

Replace the genesis.json and config.toml files:

```
rm $HOME/.gaiad/config/genesis.json $HOME/.gaiad/config/config.toml $HOME/.gaiad/config/addrbook.json

wget -O $HOME/.gaiad/config/genesis.json https://raw.githubusercontent.com/tendermint/testnets/master/gaia-4000/genesis.json

wget -O $HOME/.gaiad/config/config.toml https://raw.githubusercontent.com/tendermint/testnets/master/gaia-4000/config.toml
```

Lastly change the moniker string in the `config.toml` to identify your node.


## Starting Gaiad

```
gaiad start
```


## Getting Coins

Generate a key pair:

```
gaiacli keys add default
```

Join the Riot chat: https://riot.im/app/#/room/#cosmos:matrix.org

Ask @adrian:matrix.org (me) for coins or go to https://faucet.adrianbrink.com .

Tell me or use the address of your key, as printed out above.


## Becoming a Validator

One your node from above is running and secure.

Get your public key:

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
