#!/bin/bash
# Set up a Gaia service to join the Cosmos Hub public testnet.

# Configuration
# You should only have to modify the values in this block
# ***
NODE_HOME=~/.gaia
NODE_MONIKER=gameday01
SERVICE_NAME=gaiad
GAIA_VERSION=v13.0.2
CHAIN_BINARY_URL=https://github.com/cosmos/gaia/releases/download/$GAIA_VERSION/gaiad-$GAIA_VERSION-linux-amd64
GENESIS_URL=https://github.com/cosmos/testnets/raw/master/game-days/gameday01/genesis.json
GAS_PRICE=0.005uatom
# ***

CHAIN_BINARY='gaiad'
CHAIN_ID=gameday01
SEEDS="1518a1e5168b2fd73926c83d092b945d13ddcc98@gameday01.rs-testnet.polypore.xyz:26656"

# Install wget and jq
sudo apt-get install curl jq wget -y

# Install go 1.20
echo "Installing go..."
rm go*linux-amd64.tar.gz
wget https://go.dev/dl/go1.20.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.20.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

# Install Gaia binary
echo "Installing Gaia..."
mkdir -p $HOME/go/bin

# Download Linux amd64,
wget $CHAIN_BINARY_URL -O $HOME/go/bin/$CHAIN_BINARY
chmod +x $HOME/go/bin/$CHAIN_BINARY

# or build from source
# echo "Installing build-essential..."
# sudo apt install build-essential -y
# echo "Installing Gaia..."
# rm -rf gaia
# git clone https://github.com/cosmos/gaia.git
# cd gaia
# git checkout $GAIA_VERSION
# make install

export PATH=$PATH:$HOME/go/bin

# Initialize home directory
echo "Initializing $NODE_HOME..."
rm -rf $NODE_HOME
$CHAIN_BINARY config chain-id $CHAIN_ID --home $NODE_HOME
$CHAIN_BINARY config keyring-backend test --home $NODE_HOME
$CHAIN_BINARY init $NODE_MONIKER --chain-id $CHAIN_ID --home $NODE_HOME
sed -i -e "/minimum-gas-prices =/ s^= .*^= \"$GAS_PRICE\"^" $NODE_HOME/config/app.toml

# Replace genesis file
echo "Downloading genesis file..."
wget $GENESIS_URL
cp genesis.json $NODE_HOME/config/genesis.json

sudo rm /etc/systemd/system/$SERVICE_NAME.service
sudo touch /etc/systemd/system/$SERVICE_NAME.service

echo "[Unit]"                               | sudo tee /etc/systemd/system/$SERVICE_NAME.service
echo "Description=Game day 01 node"             | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "After=network-online.target"          | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo ""                                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "[Service]"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "User=$USER"                           | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "ExecStart=$HOME/go/bin/$CHAIN_BINARY start --x-crisis-skip-assert-invariants --home $NODE_HOME --p2p.seeds $SEEDS" | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Restart=no"                           | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "LimitNOFILE=4096"                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo ""                                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "[Install]"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "WantedBy=multi-user.target"           | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a

# Start service
echo "Starting $SERVICE_NAME.service..."
sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME.service
sudo systemctl start $SERVICE_NAME.service
sudo systemctl restart systemd-journald

# Add go and gaiad to the path
echo "Setting up paths for go and gaiad bin..."
echo "export PATH=$PATH:/usr/local/go/bin" >> .profile

echo "***********************"
echo "To see the Gaia log enter:"
echo "journalctl -fu $SERVICE_NAME.service"
echo "***********************"
