#!/bin/bash
# Set up a service for the test-galapagos-1 chain.

# ***
# Configuration
# You should only have to modify the values in this block

NODE_HOME=~/.galapagos
NODE_MONIKER=galapagos
SERVICE_NAME=test-galapagos-1
SERVICE_DESCRIPTION="test-galapagos-1 node"
CHAIN_VERSION="v4.0.0"
GAS_PRICE=0ugala
# ***

CHAIN_BINARY='interchain-security-cd'
CHAIN_ID=test-galapagos-1
PEERS="8ceaca491f600c96244f88dd096155ee72f43cd5@gala-apple.isle-testnet.polypore.xyz:26656,c018db4a253025dca34f85f0a438edd2cfc2b671@gala-banana.isle-testnet.polypore.xyz:26656,4c80daf0e07398abfda6b2617f18df324569a3e2@gala-cherry.isle-testnet.polypore.xyz:26656,7747224d0c88412b45f3bd83990c17f2a7857adb@gala-node.isle-testnet.polypore.xyz:26656"

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
