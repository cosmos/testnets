
# [Aether - Ethera_9000-1] Validators start guide

## TL;DR

Ethera should join ICS Testnet on `2024-01-17T14:00:00.000000000Z`. 
This is a small guide to help validators to join Ethera:
- For launching consumer chains, validators have two main responsibilities:
  - Submit an `AssignConsumerKey` transaction on the provider chain (more information on [Key Assignment](https://cosmos.github.io/interchain-security/features/key-assignment))
  - Run the consumer chain binary at the spawn time
    - **Important to note that Ethera requires the --chain-id flag to be passed on start**

## Starting Ethera (After spawn time)

Once we pass the spawn time, Ethera can be started.
The best way of starting Ethera is to use our scripts provided on [Testnets](https://github.com/cosmos/testnets):
- [join_ethera_9000-1_cv.sh](https://github.com/cosmos/testnets/blob/master/interchain-security/ethera_9000-1/join_ethera_9000-1_cv.sh)
  - Binaries are targeting Linux AMD64
  - This starts the chain with Cosmos Visor as a service
- [join_ethera_9000-1.sh](https://github.com/cosmos/testnets/blob/master/interchain-security/ethera_9000-1/join_ethera_9000-1.sh)
  - Binaries are targeting Linux AMD64
  - This starts the chain without Cosmos Visor as a service

### Starting Ethera manually

To start Ethera manually, you can run this command:
**Don't forget to pass the --chain-id flag on start**

```sh
# Download the genesis with ccv
GENESIS_URL=https://github.com/cosmos/testnets/raw/master/interchain-security/ethera_9000-1/ethera_9000-1-genesis.json
BINARY_URL=https://github.com/cosmos/testnets/raw/master/interchain-security/ethera_9000-1/aetherd-linux-amd64
SEEDS="e6830209e30448357e64a77279c5784b0d0232ee@p2p1.ethera.aetherevm.com:26656,88266f83878399bffd8c3d627a1f401cc389b81f@p2p2.ethera.aetherevm.com:26656"
NODE_HOME=~/.aetherd
NODE_MONIKER=ethera_9000-1
CHAIN_BINARY=aetherd

# Install Aetherd binary
mkdir -p $HOME/go/bin
sudo wget $BINARY_URL -O $HOME/go/bin/$CHAIN_BINARY
sudo chmod +x $HOME/go/bin/$CHAIN_BINARY
export PATH=$PATH:$HOME/go/bin

# Init aether
aetherd init $NODE_MONIKER --chain-id ethera_9000-1 --home $NODE_HOME

# Copy validator keys
cp priv_validator_key.json $NODE_HOME/config/priv_validator_key.json

# Prepare seeds
sed -i -e "/seeds =/ s^= .*^= \"$SEEDS\"^" $NODE_HOME/config/config.toml

# Download and copy genesis
wget $GENESIS_URL -O genesis.json
mv genesis.json $NODE_HOME/config/genesis.json

# Start Ethera
aetherd start --chain-id ethera_9000-1
```

### Making my node public

If you are preparing a public node, the following script can help you prepare you node to be public on the p2p network:

```sh
NODE_HOME=~/.aetherd

sed -i -e "/external_address =/ s^= .*^= \"$(curl httpbin.org/ip | jq -r .origin):26656\"^" $NODE_HOME/config/config.toml
```

## Congratulations!

After that, you should have Aether running on the Ethera network.