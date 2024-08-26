#!/bin/bash

set -ex

# Set up a service to join the slasher chain.

# Configuration
# You should only have to modify the values in this block
# * Keys
#    The private validator key and node key operations must match those used in the provider chain if you want to run a validator.
# ***
PRIV_VALIDATOR_KEY_FILE=~/priv_validator_key.json
NODE_KEY_FILE=~/node_key.json
NODE_HOME=~/.dungeonchain
NODE_MONIKER=dungeonchain
SERVICE_NAME=dungeonchain
# ***

CHAIN_BINARY='dungeond'
CHAIN_ID=dungeon-1
PERSISTENT_PEERS="" # TODO:

# The genesis file that includes the CCV state will not be published until after the spawn time has been reached.
GENESIS_URL=https://github.com/cosmos/testnets/raw/master/interchain-security/dungeon-1/dungeon-genesis.json.tar.gz

# Install wget and jq
sudo apt-get install curl jq wget -y

# Install go 1.22.3
echo "Installing go..."
rm go*linux-amd64.tar.gz
wget https://go.dev/dl/go1.22.3.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.3.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

# Install binary
echo "Installing build-essential..."
sudo apt install build-essential -y
echo "Installing dungeond..."
cd $HOME
mkdir -p $HOME/go/bin
rm -rf dungeonchain
git clone https://github.com/Crypto-Dungeon/dungeonchain.git
cd dungeonchain
git checkout f2325ed0e0d341f4280992ac3cbc61b9a967d578
make install
export PATH=$PATH:$HOME/go/bin

# Initialize home directory
echo "Initializing $NODE_HOME..."
rm -rf $NODE_HOME
$CHAIN_BINARY config chain-id $CHAIN_ID --home $NODE_HOME
$CHAIN_BINARY config keyring-backend test --home $NODE_HOME
$CHAIN_BINARY config broadcast-mode block --home $NODE_HOME
$CHAIN_BINARY init $NODE_MONIKER --chain-id $CHAIN_ID --home $NODE_HOME
sed -i -e "/persistent_peers =/ s^= .*^= \"$PERSISTENT_PEERS\"^" $NODE_HOME/config/config.toml

# Replace keys
echo "Replacing keys..."
cp $PRIV_VALIDATOR_KEY_FILE $NODE_HOME/config/priv_validator_key.json
cp $NODE_KEY_FILE $NODE_HOME/config/node_key.json

# Replace genesis file: only after the spawn time is reached
echo "Replacing genesis file..."
wget $GENESIS_URL -O genesis.json.tar.gz
tar -xvzf genesis.json.tar.gz "./network/dungeon-1/genesis.json" --one-top-level=genesis.json --strip-components 4
mv genesis.json $NODE_HOME/config/genesis.json

echo "Creating $SERVICE_NAME.service..."
sudo rm /etc/systemd/system/$SERVICE_NAME.service
sudo touch /etc/systemd/system/$SERVICE_NAME.service

echo "[Unit]"                               | sudo tee /etc/systemd/system/$SERVICE_NAME.service
echo "Description=slasher service"       | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "After=network-online.target"          | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo ""                                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "[Service]"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "User=$USER"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "ExecStart=$HOME/go/bin/$CHAIN_BINARY start --x-crisis-skip-assert-invariants --home $NODE_HOME" | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Restart=always"                       | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "RestartSec=3"                         | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "LimitNOFILE=4096"                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo ""                                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "[Install]"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "WantedBy=multi-user.target"           | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a

# Start service
sudo systemctl daemon-reload

# Enable and start the service after the genesis that includes the CCV state is in place
sudo systemctl enable $SERVICE_NAME.service
sudo systemctl start $SERVICE_NAME.service
sudo systemctl restart systemd-journald

# Add go and gaiad to the path
echo "Setting up paths for go and interchain-security-cd bin..."
echo "export PATH=$PATH:/usr/local/go/bin" >> .profile

echo "***********************"
echo "To see the service log enter:"
echo "journalctl -fu $SERVICE_NAME.service"
echo "***********************"
