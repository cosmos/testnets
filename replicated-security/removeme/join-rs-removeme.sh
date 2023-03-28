#!/bin/bash
# Set up a service to join the removeme chain.

# Configuration
# You should only have to modify the values in this block
# * Keys
#    The private validator key and node key operations must match those used in the provider chain if you want to run a validator.
# ***
PRIV_VALIDATOR_KEY_FILE=~/priv_validator_key.json
NODE_KEY_FILE=~/node_key.json
NODE_HOME=~/.removeme
NODE_MONIKER=removeme
SERVICE_NAME=removeme
# ***

CHAIN_BINARY='interchain-security-cd'
CHAIN_ID=removeme
PERSISTENT_PEERS="b7d0bd260fca7a5a19c7631b15f6068891faa60e@removeme-apple.rs-testnet.polypore.xyz:26656,49d75c6094c006b6f2758e45457c1f3d6002ce7a@removeme-banana.rs-testnet.polypore.xyz:26656,f2520026fb9086f1b2f09e132d209cbe88064ec1@removeme-cherry.rs-testnet.polypore.xyz:26656"

# The genesis file that includes the CCV state will not be published until after the spawn time has been reached.
# GENESIS_URL=https://github.com/cosmos/testnets/raw/master/replicated-security/removeme/removeme-genesis.json

# Install wget and jq
sudo apt-get install curl jq wget -y

# Install go 1.18.5
echo "Installing go..."
rm go*linux-amd64.tar.gz
wget https://go.dev/dl/go1.18.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.18.5.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

# Install interchain-security-cd binary
echo "Installing build-essential..."
sudo apt install build-essential -y
echo "Installing interchain-security-cd..."
cd $HOME
mkdir -p $HOME/go/bin
rm -rf interchain-security
git clone https://github.com/cosmos/interchain-security.git
cd interchain-security
git checkout v1.1.0
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
# echo "Replacing genesis file..."
# wget $GENESIS_URL -O genesis.json
# mv genesis.json $NODE_HOME/config/genesis.json

echo "Creating $SERVICE_NAME.service..."
sudo rm /etc/systemd/system/$SERVICE_NAME.service
sudo touch /etc/systemd/system/$SERVICE_NAME.service

echo "[Unit]"                               | sudo tee /etc/systemd/system/$SERVICE_NAME.service
echo "Description=removeme service"       | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
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
# sudo systemctl enable $SERVICE_NAME.service
# sudo systemctl start $SERVICE_NAME.service
# sudo systemctl restart systemd-journald

# Add go and gaiad to the path
echo "Setting up paths for go and interchain-security-cd bin..."
echo "export PATH=$PATH:/usr/local/go/bin" >> .profile

echo "***********************"
echo "To see the service log enter:"
echo "journalctl -fu $SERVICE_NAME.service"
echo "***********************"
