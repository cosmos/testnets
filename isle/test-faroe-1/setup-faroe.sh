#!/bin/bash
# Set up a service for the test-faroe-1 chain.

# ***
# Configuration
# You should only have to modify the values in this block

NODE_HOME=~/.faroe
NODE_MONIKER=faroe
SERVICE_NAME=test-faroe-1
SERVICE_DESCRIPTION="test-faroe-1 node"
CHAIN_VERSION="v4.0.0"
GAS_PRICE=0ufaro
# ***

CHAIN_BINARY='interchain-security-cd'
CHAIN_ID=test-faroe-1
PEERS="1cb1b2c1be0765e4f87139e7a58056c5de46994e@faroe-apple.isle-testnet.polypore.xyz:26656,82344dc34d2f2b63fb878e55f622b77b88c3b7b8@faroe-banana.isle-testnet.polypore.xyz:26656,34056aa7a296accbd5a4ac15f3dc480d0fc4ca29@faroe-cherry.isle-testnet.polypore.xyz:26656,fc78b514df730d19330fb9bd2f3bec8e72d62226@faroe-node.isle-testnet.polypore.xyz:26656"

# Install wget and jq
sudo apt-get install curl jq wget -y
mkdir -p $HOME/go/bin
export PATH=$PATH:$HOME/go/bin

# Install binary
echo "Installing binary..."

# Install go 1.21.6
echo "Installing go..."
rm go*linux-amd64.tar.gz
wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz
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
$CHAIN_BINARY config chain-id $CHAIN_ID --home $NODE_HOME
$CHAIN_BINARY config keyring-backend test --home $NODE_HOME
$CHAIN_BINARY init $NODE_MONIKER --chain-id $CHAIN_ID --home $NODE_HOME
sed -i -e "/minimum-gas-prices =/ s^= .*^= \"$GAS_PRICE\"^" $NODE_HOME/config/app.toml
sed -i -e "s/persistent_peers = \"\"/persistent_peers = \"$PEERS\"/" $NODE_HOME/config/config.toml

sudo rm /etc/systemd/system/$SERVICE_NAME.service
sudo touch /etc/systemd/system/$SERVICE_NAME.service

echo "[Unit]"                               | sudo tee /etc/systemd/system/$SERVICE_NAME.service
echo "Description=$SERVICE_DESCRIPTION"      | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "After=network-online.target"          | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo ""                                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "[Service]"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "User=$USER"                           | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "ExecStart=$HOME/go/bin/$CHAIN_BINARY start --x-crisis-skip-assert-invariants --home $NODE_HOME" | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Restart=no"                           | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "LimitNOFILE=4096"                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo ""                                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "[Install]"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "WantedBy=multi-user.target"           | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a

# Start service
echo "Setting up $SERVICE_NAME.service..."
sudo systemctl daemon-reload

echo "***********************"
echo "To start the service after the launch genesis is in place enter:"
echo "sudo systemctl enable $SERVICE_NAME.service --now"
echo "To see the service log enter:"
echo "journalctl -fu $SERVICE_NAME.service"
echo "***********************"
