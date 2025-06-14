#!/bin/bash
# Set up a Cosmovisor service to join the test-locust-2 chain.

# Configuration
# You should only have to modify the values in this block
# * Binary
#     The binary for the linux-amd64 architecture is set by default.
#     If you are using a different architecture, visit the gaia releases page for an adequate link.
#     If you want to build from source, uncomment the "Build from source" section
# ***
NODE_HOME=~/.gaia
NODE_MONIKER=locust-node
SERVICE_NAME=cosmovisor
GAIA_VERSION=v24.0.99-alpha0
CHAIN_BINARY_URL=https://github.com/hyphacoop/gaia/releases/download/$GAIA_VERSION/gaiad-$GAIA_VERSION-linux-amd64
GO_VERSION=1.23.4
STATE_SYNC=true
GAS_PRICE=0.001ulcst
# ***

CHAIN_BINARY='gaiad'
CHAIN_ID=test-locust-2
GENESIS_URL=https://github.com/cosmos/testnets/raw/master/interchain-security/test-locust-2/genesis.json
PEERS="25960d16ce876eb6a5d7cbbc728bad58c57ec6a2@locust-sentry-1.ics-testnet.polypore.xyz:26656,5e45ae91ca5d2551aeaee41b1ed5d302c9771fe5@locust-sentry-2.ics-testnet.polypore.xyz:26656,0479695c665a55f0deac3912c2d5faafd681cf75@locust-sentry-3.ics-testnet.polypore.xyz:26656,4828cebecd894bec1124177440065e8c537bfbda@locust-sentry-4.ics-testnet.polypore.xyz:26656"

SYNC_RPC_1=https://rpc.locust-sentry-1.ics-testnet.polypore.xyz:443
SYNC_RPC_2=https://rpc.locust-sentry-2.ics-testnet.polypore.xyz:443
SYNC_RPC_SERVERS="$SYNC_RPC_1,$SYNC_RPC_2"

# Install wget and jq
sudo apt-get install curl jq wget -y
mkdir -p $HOME/go/bin
export PATH=$PATH:$HOME/go/bin

# Install go
echo "Installing go..."
rm go*linux-amd64.tar.gz
wget https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

# Install Gaia binary
echo "Installing Gaia..."

# Build from source,
#echo "Installing build-essential..."
#sudo apt install build-essential -y
#echo "Installing Gaia..."
#cd $HOME
#rm -rf gaia
#git clone https://github.com/cosmos/gaia.git
#cd gaia
#git checkout $GAIA_VERSION
#make install

# or download Linux amd64 (unsupported),\
wget $CHAIN_BINARY_URL -O $HOME/go/bin/$CHAIN_BINARY
chmod +x $HOME/go/bin/$CHAIN_BINARY

# Initialize home directory
echo "Initializing $NODE_HOME..."
rm -rf $NODE_HOME
$CHAIN_BINARY config set client chain-id $CHAIN_ID --home $NODE_HOME
$CHAIN_BINARY config set client keyring-backend test --home $NODE_HOME
$CHAIN_BINARY init $NODE_MONIKER --chain-id $CHAIN_ID --home $NODE_HOME
sed -i -e "/minimum-gas-prices =/ s^= .*^= \"$GAS_PRICE\"^" $NODE_HOME/config/app.toml
sed -i -e "s/persistent_peers = \"\"/persistent_peers = \"$PEERS\"/" $NODE_HOME/config/config.toml
sed -i -e "s/^size = .*/size = 10000/" $NODE_HOME/config/config.toml
sed -i -e "s/^max_txs_bytes = .*/max_txs_bytes = 1073741824/" $NODE_HOME/config/config.toml
sed -i -e "s/^cache_size = .*/cache_size = 100000/" $NODE_HOME/config/config.toml
sed -i -e "s/^keep-invalid-txs-in-cache = .*/keep-invalid-txs-in-cache = false/" $NODE_HOME/config/config.toml
sed -i -e "s/^max_tx_bytes = .*/max_tx_bytes = 10485760/" $NODE_HOME/config/config.toml
sed -i -e "s/^timeout_commit = .*/timeout_commit = \"2s\"/" $NODE_HOME/config/config.toml
sed -i -e "s/^namespace = .*/namespace = \"tendermint\"/" $NODE_HOME/config/config.toml

if [ $STATE_SYNC == "true" ]; then
    echo "Configuring state sync..."
    CURRENT_BLOCK=$(curl -s $SYNC_RPC_1/block | jq -r '.result.block.header.height')
    TRUST_HEIGHT=$[$CURRENT_BLOCK-5000]
    TRUST_BLOCK=$(curl -s $SYNC_RPC_1/block\?height\=$TRUST_HEIGHT)
    TRUST_HASH=$(echo $TRUST_BLOCK | jq -r '.result.block_id.hash')
    sed -i -e '/enable =/ s/= .*/= true/' $NODE_HOME/config/config.toml
    sed -i -e '/trust_period =/ s/= .*/= "8h0m0s"/' $NODE_HOME/config/config.toml
    sed -i -e "/trust_height =/ s/= .*/= $TRUST_HEIGHT/" $NODE_HOME/config/config.toml
    sed -i -e "/trust_hash =/ s/= .*/= \"$TRUST_HASH\"/" $NODE_HOME/config/config.toml
    sed -i -e "/rpc_servers =/ s^= .*^= \"$SYNC_RPC_SERVERS\"^" $NODE_HOME/config/config.toml
else
    echo "Skipping state sync..."
fi

# Replace genesis file
wget $GENESIS_URL -O genesis.json
mv genesis.json $NODE_HOME/config/genesis.json

# Set up cosmovisor
echo "Setting up cosmovisor..."
mkdir -p $NODE_HOME/cosmovisor/genesis/bin
cp $(which $CHAIN_BINARY) $NODE_HOME/cosmovisor/genesis/bin

echo "Installing cosmovisor..."
export BINARY=$NODE_HOME/cosmovisor/genesis/bin/$CHAIN_BINARY
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.7.0

sudo systemctl disable $SERVICE_NAME.service --now
sudo rm /etc/systemd/system/$SERVICE_NAME.service
sudo touch /etc/systemd/system/$SERVICE_NAME.service

echo "[Unit]"                               | sudo tee /etc/systemd/system/$SERVICE_NAME.service
echo "Description=Cosmovisor service"       | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "After=network-online.target"          | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo ""                                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "[Service]"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "User=$USER"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "ExecStart=$HOME/go/bin/cosmovisor run start --home $NODE_HOME" | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Restart=no"                       | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "LimitNOFILE=4096"                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Environment='DAEMON_NAME=$CHAIN_BINARY'"      | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Environment='DAEMON_HOME=$NODE_HOME'" | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Environment='DAEMON_ALLOW_DOWNLOAD_BINARIES=false'" | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Environment='DAEMON_RESTART_AFTER_UPGRADE=true'" | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Environment='DAEMON_LOG_BUFFER_SIZE=512'" | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
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
echo "export PATH=$PATH:/usr/local/go/bin:$NODE_HOME/cosmovisor/current/bin" >> .profile

echo "***********************"
echo "To see the Cosmovisor log enter:"
echo "journalctl -fu $SERVICE_NAME.service"
echo "***********************"
