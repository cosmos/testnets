#!/bin/bash
# Set up a service for the test-ibiza-1 chain.

# ***
# Configuration
# You should only have to modify the values in this block

NODE_HOME=~/.ibiza
NODE_MONIKER=ibiza
SERVICE_NAME=test-ibiza-1
SERVICE_DESCRIPTION="test-ibiza-1 node"
CHAIN_VERSION="v0.30.0-isle"
GAS_PRICE=0ubiza
# ***

CHAIN_BINARY='elysd'
CHAIN_ID=test-ibiza-1
PEERS="3821b0c9793ff70258328f03f390be2dd6456af2@ibiza-apple.isle-testnet.polypore.xyz:26656,b44bc2bff63ee111e3d36b0b164ef2e0bd7fab6e@ibiza-banana.isle-testnet.polypore.xyz:26656,309b80dcf099e5b4a79c6f2280da5b8d942acd08@ibiza-cherry.isle-testnet.polypore.xyz:26656,06d49c0dabe6604de2cc19bfac193496cd02d870@ibiza-node.isle-testnet.polypore.xyz:26656"

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
rm -rf elys
git clone https://github.com/monopauli/elys
cd elys
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
