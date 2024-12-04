#!/bin/bash
# Set up a service for the test-butterfly-1 chain.

# ***
# Configuration
# You should only have to modify the values in this block

NODE_HOME=~/.butterfly
NODE_MONIKER=butterfly-test
SERVICE_NAME=test-butterfly-1
SERVICE_DESCRIPTION="test-butterfly-1 node"
CHAIN_VERSION="v6.2.0"
GAS_PRICE=0ubttr
# ***

CHAIN_BINARY='interchain-security-cdd'
CHAIN_ID=test-butterfly-1
PEERS="3c53448db7746810cc31c6fd6d69d998ee3aa13b@butterfly-tomato.ics-testnet.polypore.xyz:26656,4bfaa6aab539ec51b89343ee56ea7274e12cdf36@butterfly-cherry.ics-testnet.polypore.xyz:26656,019463585337a6c254733a2f2f402ab2fe7c8b09@butterfly-node.ics-testnet.polypore.xyz:26656"
GENESIS_URL="https://github.com/cosmos/testnets/raw/refs/heads/master/testnet-wednesdays/demoday11/butterfly-genesis.json"
CONSUMER_GENESIS_URL="https://github.com/cosmos/testnets/raw/refs/heads/master/testnet-wednesdays/demoday11/consumer-genesis.json"
SNAPSHOT_URL=https://files.polypore.xyz/snapshots/test-butterfly-1/butterfly-89602.tar.gz

# Install wget and jq
sudo apt-get install curl jq wget -y
mkdir -p $HOME/go/bin
export PATH=$PATH:$HOME/go/bin

# Install binary
echo "Installing binary..."

# Install go 1.21.6
echo "Installing go..."
rm go*linux-amd64.tar.gz
wget https://go.dev/dl/go1.23.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.2.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo "Installing build-essential..."
sudo apt install build-essential -y
echo "Installing binary..."
cd $HOME
rm -rf interchain-security
git clone https://github.com/cosmos/interchain-security.git
cd interchain-security
git checkout $CHAIN_VERSION
make install

# Initialize home directory
echo "Initializing $NODE_HOME..."
rm -rf $NODE_HOME
$CHAIN_BINARY config set client chain-id $CHAIN_ID --home $NODE_HOME
$CHAIN_BINARY config set client keyring-backend test --home $NODE_HOME
$CHAIN_BINARY init $NODE_MONIKER --chain-id $CHAIN_ID --home $NODE_HOME
sed -i -e "/minimum-gas-prices =/ s^= .*^= \"$GAS_PRICE\"^" $NODE_HOME/config/app.toml
sed -i -e "s/persistent_peers = \"\"/persistent_peers = \"$PEERS\"/" $NODE_HOME/config/config.toml

# Replace genesis file
wget $GENESIS_URL -O genesis.json
mv genesis.json $NODE_HOME/config/genesis.json

# Set up consumer genesis file
wget $CONSUMER_GENESIS_URL -o genesis.json
mkdir -p ~/.sovereign/config
mv genesis.json ~/.sovereign/config/

# Download snapshot for height 89602
wget $SNAPSHOT_URL -O snapshot.tar.gz
tar -xzvf snapshot.tar.gz
rm -rf $NODE_HOME/data
cp -r .butterfly-snapshot/data $NODE_HOME/data

sudo rm /etc/systemd/system/$SERVICE_NAME.service
sudo touch /etc/systemd/system/$SERVICE_NAME.service

echo "[Unit]"                               | sudo tee /etc/systemd/system/$SERVICE_NAME.service
echo "Description=$SERVICE_DESCRIPTION"      | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "After=network-online.target"          | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo ""                                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "[Service]"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "User=$USER"                           | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "ExecStart=$HOME/go/bin/$CHAIN_BINARY start --home $NODE_HOME" | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Restart=no"                           | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "LimitNOFILE=4096"                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo ""                                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "[Install]"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "WantedBy=multi-user.target"           | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a

# Start service
echo "Setting up $SERVICE_NAME.service..."
sudo systemctl daemon-reload
# sudo systemctl enable $SERVICE_NAME.service --now

echo "***********************"
echo "To see the service log enter:"
echo "journalctl -fu $SERVICE_NAME.service"
echo "***********************"