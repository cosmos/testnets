#!/bin/bash
# Set up a service to join the ethera_9000-1 chain.

# How to use:
# join_aether priv_validator_key.json node_key.json

# Configuration
# You should only have to modify the values in this block
# * Keys
#    The private validator key and node key operations must match those used in the provider-1 chain if you want to run a validator.
# ***
PRIV_VALIDATOR_KEY_FILE=${1:-"$HOME/priv_validator_key.json"}
NODE_KEY_FILE=${2:-"$HOME/node_key.json"}
NODE_HOME=~/.aetherd
NODE_MONIKER=ethera_9000-1
SERVICE_NAME=cosmosvisor-aetherd
# ***

CHAIN_BINARY='aetherd'
CHAIN_ID=ethera_9000-1
# Seeds available after chain spawn time
SEEDS="e6830209e30448357e64a77279c5784b0d0232ee@p2p1.ethera.aetherevm.com:26656,88266f83878399bffd8c3d627a1f401cc389b81f@p2p2.ethera.aetherevm.com:26656"

# The genesis file that includes the CCV state will not be published until after the spawn time has been reached.
GENESIS_URL=https://github.com/cosmos/testnets/raw/master/interchain-security/ethera_9000-1/ethera_9000-1-genesis.json
BINARY_URL=https://github.com/cosmos/testnets/raw/master/interchain-security/ethera_9000-1/aetherd-linux-amd64

# Install wget and jq
sudo apt-get install jq wget -y

# Install Aetherd binary
mkdir -p $HOME/go/bin
sudo wget $BINARY_URL -O $HOME/go/bin/$CHAIN_BINARY
sudo chmod +x $HOME/go/bin/$CHAIN_BINARY
export PATH=$PATH:$HOME/go/bin

# Initialize home directory
echo "Initializing $NODE_HOME..."
rm -rf $NODE_HOME
$CHAIN_BINARY config chain-id $CHAIN_ID --home $NODE_HOME
$CHAIN_BINARY config keyring-backend test --home $NODE_HOME
$CHAIN_BINARY config broadcast-mode block --home $NODE_HOME
$CHAIN_BINARY init $NODE_MONIKER --chain-id $CHAIN_ID --home $NODE_HOME
sed -i -e "/seeds =/ s^= .*^= \"$SEEDS\"^" $NODE_HOME/config/config.toml

# Replace keys
echo "Replacing keys..."
cp $PRIV_VALIDATOR_KEY_FILE $NODE_HOME/config/priv_validator_key.json
cp $NODE_KEY_FILE $NODE_HOME/config/node_key.json

# Replace genesis file: only after the spawn time is reached
echo "Replacing genesis file..."
wget $GENESIS_URL -O genesis.json
mv genesis.json $NODE_HOME/config/genesis.json

# Set up cosmovisor
echo "Installing go..."
rm go*linux-amd64.tar.gz
wget https://go.dev/dl/go1.20.12.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.20.12.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

echo "Setting up cosmovisor..."
mkdir -p $NODE_HOME/cosmovisor/genesis/bin
mkdir -p $NODE_HOME/cosmovisor/upgrades
cp $(which $CHAIN_BINARY) $NODE_HOME/cosmovisor/genesis/bin

echo "Installing cosmovisor..."
export BINARY=$NODE_HOME/cosmovisor/genesis/bin/$CHAIN_BINARY
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0

# Create the service
echo "Creating $SERVICE_NAME.service..."
sudo rm /etc/systemd/system/$SERVICE_NAME.service
sudo touch /etc/systemd/system/$SERVICE_NAME.service

echo "[Unit]"                                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service
echo "Description=Cosmovisor and Aetherd service"        | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "After=network-online.target"                       | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo ""                                                  | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "[Service]"                                         | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "User=$USER"                                        | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "ExecStart=$HOME/go/bin/cosmovisor run start --x-crisis-skip-assert-invariants --home $NODE_HOME --chain-id $CHAIN_ID" | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Restart=always"                                    | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "RestartSec=3"                                      | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "LimitNOFILE=50000"                                 | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Environment='DAEMON_NAME=$CHAIN_BINARY'"           | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Environment='DAEMON_HOME=$NODE_HOME'"              | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Environment='DAEMON_ALLOW_DOWNLOAD_BINARIES=true'" | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Environment='DAEMON_RESTART_AFTER_UPGRADE=true'"   | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Environment='DAEMON_LOG_BUFFER_SIZE=512'"          | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo ""                                                  | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "[Install]"                                         | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "WantedBy=multi-user.target"                        | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a

# Start service
sudo systemctl daemon-reload

# Enable and start the service after the genesis that includes the CCV state is in place
sudo systemctl enable $SERVICE_NAME.service
sudo systemctl start $SERVICE_NAME.service
sudo systemctl restart systemd-journald

# Add Aetherd to the path
echo "Setting up paths for go and aetherd bin..."
echo "export PATH=$PATH:$HOME/go/bin:/usr/local/go/bin" >> .profile

echo "***********************"
echo "To see the service log enter:"
echo "journalctl -fu $SERVICE_NAME.service"
echo "***********************"