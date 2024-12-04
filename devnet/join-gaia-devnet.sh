#!/bin/bash
# Set up a Gaia service to join the devnet.

# Configuration
# You should only have to modify the values in this block
# * Keys
#    The private validator key and node key operations are provided in case you have a pre-existing set of keys.
#    If you want to generate these keys as part of the setup, comment out the "Replace keys" section.
# * Binary
#    The binary for the amd64 architecture is set by default.
#    If you are using a different architecture, visit the gaia releases page for an adequate link.
#    If you want to build from source, uncomment the "or install from source" section
# ***
PRIV_VALIDATOR_KEY_FILE=~/priv_validator_key.json
NODE_KEY_FILE=~/node_key.json
NODE_HOME=~/.gaia
NODE_MONIKER=gaiad-devnet
SERVICE_NAME=gaiad-devnet
GAS_PRICE=0.005uatom
# ***

CHAIN_BINARY='gaiad'
CHAIN_ID=gaia-devnet
GENESIS_URL=https://files.polypore.xyz/gaia-devnet/genesis.json
PERSISTENT_PEERS="0ef1c4cbfe5b93a3e778acbc07fe0384567283d2@gaia-devnet.polypore.xyz:26656"

# Install wget and jq
sudo apt-get install curl jq wget -y
mkdir -p $HOME/go/bin
export PATH=$PATH:$HOME/go/bin

# Get current devnet version
GAIA_VERSION=$(curl -s "https://rpc.gaia-devnet.polypore.xyz/abci_info?" | jq -r '.result.response.version')

# Install Gaia binary
echo "Installing Gaia..."

# Build from source
## Install go 1.22.6
echo "Installing go..."
rm go*linux-amd64.tar.gz
wget https://go.dev/dl/go1.22.6.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.6.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo "Installing build-essential..."
sudo apt install build-essential -y
echo "Installing Gaia..."
cd $HOME
rm -rf gaia
git clone https://github.com/cosmos/gaia.git
cd gaia
git checkout $GAIA_VERSION
make install

# Initialize home directory
echo "Initializing $NODE_HOME..."
rm -rf $NODE_HOME
$CHAIN_BINARY config set client chain-id $CHAIN_ID --home $NODE_HOME
$CHAIN_BINARY config set client keyring-backend test --home $NODE_HOME
$CHAIN_BINARY init $NODE_MONIKER --chain-id $CHAIN_ID --home $NODE_HOME
sed -i -e "/minimum-gas-prices =/ s^= .*^= \"$GAS_PRICE\"^" $NODE_HOME/config/app.toml
sed -i -e "/^persistent_peers =/ s^= .*^= \"$PERSISTENT_PEERS\"^" $NODE_HOME/config/config.toml

# Replace keys
echo "Replacing keys and genesis file..."
cp $PRIV_VALIDATOR_KEY_FILE $NODE_HOME/config/priv_validator_key.json
cp $NODE_KEY_FILE $NODE_HOME/config/node_key.json

echo "Downloading gaia-devnet archive..."
cd $NODE_HOME
curl -o - -L https://files.polypore.xyz/gaia-devnet/latest.tar.gz | tar vzx -C .
cd $HOME

# Replace genesis file
wget $GENESIS_URL -O genesis.json
mv genesis.json $NODE_HOME/config/genesis.json

sudo rm /etc/systemd/system/$SERVICE_NAME.service
sudo touch /etc/systemd/system/$SERVICE_NAME.service

echo "[Unit]"                               | sudo tee /etc/systemd/system/$SERVICE_NAME.service
echo "Description=Gaia service"             | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
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
echo "Starting $SERVICE_NAME.service..."
sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME.service
sudo systemctl start $SERVICE_NAME.service
sudo systemctl restart systemd-journald

# Add go and gaiad to the path
echo "Setting up paths for go and cosmovisor current bin..."
echo "export PATH=$PATH:/usr/local/go/bin" >> .profile

echo "***********************"
echo "To see the Gaia log enter:"
echo "journalctl -fu $SERVICE_NAME.service"
echo "***********************"
