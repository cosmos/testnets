#!/bin/bash
# Set up a Cosmovisor service to join the provider chain.

# Configuration
# You should only have to modify the values in this block
# * Keys
#     The private validator key and node key operations are provided in case you have a pre-existing set of keys.
#     If you want to generate these keys as part of the setup, comment out the "Replace keys" section.
# * Binary
#     The binary for the amd64 architecture is set by default.
#     If you are using a different architecture, v isit the gaia releases page for an adequate link.
#     If you want to build from source, uncomment the "or install from source" section
# ***
PRIV_VALIDATOR_KEY_FILE=~/priv_validator_key.json
NODE_KEY_FILE=~/node_key.json
NODE_HOME=~/.gaia
NODE_MONIKER=provider
SERVICE_NAME=cv-provider
GAIA_VERSION=v23.3.0
CHAIN_BINARY_URL=https://github.com/cosmos/gaia/releases/download/$GAIA_VERSION/gaiad-$GAIA_VERSION-linux-amd64
STATE_SYNC=true
GAS_PRICE=0.005uatom
# ***

CHAIN_BINARY='gaiad'
CHAIN_ID=provider
GENESIS_URL=https://github.com/cosmos/testnets/raw/master/interchain-security/provider/provider-genesis.json
SEEDS="08ec17e86dac67b9da70deb20177655495a55407@provider-seed-01.ics-testnet.polypore.xyz:26656,4ea6e56300a2f37b90e58de5ee27d1c9065cf871@provider-seed-02.ics-testnet.polypore.xyz:26656"
SYNC_RPC_1=https://rpc.provider-state-sync-01.ics-testnet.polypore.xyz:443
SYNC_RPC_2=https://rpc.provider-state-sync-02.ics-testnet.polypore.xyz:443
SYNC_RPC_SERVERS="$SYNC_RPC_1,$SYNC_RPC_2"
SNAPSHOT_URL=https://snapshots.polypore.xyz/ics-testnet/provider/latest.tar.gz
SNAPSHOT=false

for i in "$@"; do
    case $i in
        -s|--snapshot)
            SNAPSHOT=true
            STATE_SYNC=false
        ;;
    esac
done

# Install wget and jq
sudo apt-get install curl jq wget -y
mkdir -p $HOME/go/bin
export PATH=$PATH:$HOME/go/bin

# Install go 1.23.6
echo "Installing go..."
rm go*linux-amd64.tar.gz
wget https://go.dev/dl/go1.23.6.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.6.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

# Install Gaia binary
echo "Installing Gaia..."

# Build from source,
echo "Installing build-essential..."
sudo apt install build-essential -y
echo "Installing Gaia..."
cd $HOME
rm -rf gaia
git clone https://github.com/cosmos/gaia.git
cd gaia
git checkout $GAIA_VERSION
make install

# or download Linux amd64 (unsupported),\
# wget $CHAIN_BINARY_URL -O $HOME/go/bin/$CHAIN_BINARY
# chmod +x $HOME/go/bin/$CHAIN_BINARY

# Initialize home directory
echo "Initializing $NODE_HOME..."
rm -rf $NODE_HOME
$CHAIN_BINARY config set client chain-id $CHAIN_ID --home $NODE_HOME
$CHAIN_BINARY config set client keyring-backend test --home $NODE_HOME
$CHAIN_BINARY init $NODE_MONIKER --chain-id $CHAIN_ID --home $NODE_HOME
sed -i -e "/minimum-gas-prices =/ s^= .*^= \"$GAS_PRICE\"^" $NODE_HOME/config/app.toml
sed -i -e "/seeds =/ s^= .*^= \"$SEEDS\"^" $NODE_HOME/config/config.toml

# Replace keys
echo "Replacing keys and genesis file..."
cp $PRIV_VALIDATOR_KEY_FILE $NODE_HOME/config/priv_validator_key.json
cp $NODE_KEY_FILE $NODE_HOME/config/node_key.json

if [ $STATE_SYNC == "true" ]; then
    echo "Configuring state sync..."
    CURRENT_BLOCK=$(curl -s $SYNC_RPC_1/block | jq -r '.result.block.header.height')
    TRUST_HEIGHT=$[$CURRENT_BLOCK-1000]
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

if [ $SNAPSHOT == "true" ]; then
    echo "Downloading snapshot..."
    rm -rf $NODE_HOME/wasm $NODE_HOME/data
    curl $SNAPSHOT_URL
    curl -o - -L $SNAPSHOT_URL | tar vxz -C $NODE_HOME
else
    echo "Skipping download snapshot..."
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
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.7.1

sudo rm /etc/systemd/system/$SERVICE_NAME.service
sudo touch /etc/systemd/system/$SERVICE_NAME.service

echo "[Unit]"                               | sudo tee /etc/systemd/system/$SERVICE_NAME.service
echo "Description=Cosmovisor service"       | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "After=network-online.target"          | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo ""                                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "[Service]"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "User=$USER"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "ExecStart=$HOME/go/bin/cosmovisor run start --x-crisis-skip-assert-invariants --home $NODE_HOME" | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Restart=no"                       | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "LimitNOFILE=4096"                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Environment='DAEMON_NAME=$CHAIN_BINARY'"      | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Environment='DAEMON_HOME=$NODE_HOME'" | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Environment='DAEMON_ALLOW_DOWNLOAD_BINARIES=true'" | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
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
