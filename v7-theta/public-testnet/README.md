## How to join

### Quickstart on a fresh machine (e.g., on Digital Ocean droplet)

```
#!/bin/bash -i

##### CONFIGURATION ###

export GAIA_BRANCH=release/v6.0.0
export GENESIS_ZIPPED_URL=https://github.com/hyphacoop/testnets/raw/add-theta-testnet/v7-theta/public-testnet/genesis.json.gz
export NODE_HOME=$HOME/.gaia
export CHAIN_ID=theta-testnet-001
export NODE_MONIKER=my-node # only really need to change this one
export BINARY=gaiad
export PERSISTENT_PEERS="5c9850dc5ec603b0c97ffd8d67bde3221b877acf@p2p.sentry-01.theta-testnet.polypore.xyz:26656,208683ee734ba3cec1cfc0c8bcbc326969641952@p2p.sentry-02.theta-testnet.polypore.xyz:26656,58e9d022962a3875fa22d7146949d0dc34e51ba6@p2p.state-sync-01.theta-testnet.polypore.xyz:26656,6954e0479cd71fa01aeed15e1a3b87c06433d827@p2p.state-sync-02.theta-testnet.polypore.xyz:26656"

##### OPTIONAL STATE SYNC CONFIGURATION ###

export STATE_SYNC=true # if you set this to true, please have TRUST HEIGHT and TRUST HASH and RPC configured
export TRUST_HEIGHT=9057300
export TRUST_HASH="35628D6804C6340CC19BBB49E7ED1AAAA4CF1628B4CBDA903EE142BC0D3B7D0A"
export SYNC_RPC="rpc.sentry-01.theta-testnet.polypore.xyz:26657,rpc.sentry-02.theta-testnet.polypore.xyz:26657"

############## 

# you shouldn't need to edit anything below this

echo "Updating apt-get..."
sudo apt-get update

echo "Getting essentials..."
sudo apt-get install git build-essential

echo "Installing go..."
wget -q -O - https://git.io/vQhTU | bash -s - --version 1.17

echo "Sourcing bashrc to get go in our path..."
source $HOME/.bashrc

export GOROOT=$HOME/.go
export PATH=$GOROOT/bin:$PATH
export GOPATH=/root/go
export PATH=$GOPATH/bin:$PATH

echo "Getting gaia..."
git clone https://github.com/cosmos/gaia.git

echo "cd into gaia..."
cd gaia

echo "checkout gaia branch..."
git checkout $GAIA_BRANCH

echo "building gaia..."
make install
echo "***********************"
echo "INSTALLED GAIAD VERSION"
gaiad version
echo "***********************"

cd ..
echo "getting genesis file"
wget $GENESIS_ZIPPED_URL
gunzip genesis.json.gz 

echo "configuring chain..."
$BINARY config chain-id $CHAIN_ID --home $NODE_HOME
$BINARY config keyring-backend test --home $NODE_HOME
$BINARY config broadcast-mode block --home $NODE_HOME
$BINARY init $NODE_MONIKER --home $NODE_HOME --chain-id=$CHAIN_ID

if $STATE_SYNC; then
    echo "enabling state sync..."
    sed -i -e '/enable =/ s/= .*/= true/' $NODE_HOME/config/config.toml
    sed -i -e "/trust_height =/ s/= .*/= $TRUST_HEIGHT/" $NODE_HOME/config/config.toml
    sed -i -e "/trust_hash =/ s/= .*/= \"$TRUST_HASH\"/" $NODE_HOME/config/config.toml
    sed -i -e "/rpc_servers =/ s/= .*/= \"$SYNC_RPC\"/" $NODE_HOME/config/config.toml
else
    echo "disabling state sync..."
fi

echo "copying over genesis file..."
cp genesis.json $NODE_HOME/config/genesis.json

echo "setup cosmovisor dirs..."
mkdir -p $NODE_HOME/cosmovisor/genesis/bin

echo "copy binary over..."
cp $(which gaiad) $NODE_HOME/cosmovisor/genesis/bin

echo "re-export binary"
export BINARY=$NODE_HOME/cosmovisor/genesis/bin/gaiad

echo "install cosmovisor"
export GO111MODULE=on
go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v1.0.0

echo "setup systemctl"
touch /etc/systemd/system/$NODE_MONIKER.service

echo "[Unit]"                               >> /etc/systemd/system/$NODE_MONIKER.service
echo "Description=cosmovisor-$NODE_MONIKER" >> /etc/systemd/system/$NODE_MONIKER.service
echo "After=network-online.target"          >> /etc/systemd/system/$NODE_MONIKER.service
echo ""                                     >> /etc/systemd/system/$NODE_MONIKER.service
echo "[Service]"                            >> /etc/systemd/system/$NODE_MONIKER.service
echo "User=root"                        >> /etc/systemd/system/$NODE_MONIKER.service
echo "ExecStart=/root/go/bin/cosmovisor start --x-crisis-skip-assert-invariants --home \$DAEMON_HOME --p2p.persistent_peers $PERSISTENT_PEERS" >> /etc/systemd/system/$NODE_MONIKER.service
echo "Restart=always"                       >> /etc/systemd/system/$NODE_MONIKER.service
echo "RestartSec=3"                         >> /etc/systemd/system/$NODE_MONIKER.service
echo "LimitNOFILE=4096"                     >> /etc/systemd/system/$NODE_MONIKER.service
echo "Environment='DAEMON_NAME=gaiad'"      >> /etc/systemd/system/$NODE_MONIKER.service
echo "Environment='DAEMON_HOME=$NODE_HOME'" >> /etc/systemd/system/$NODE_MONIKER.service
echo "Environment='DAEMON_ALLOW_DOWNLOAD_BINARIES=true'" >> /etc/systemd/system/$NODE_MONIKER.service
echo "Environment='DAEMON_RESTART_AFTER_UPGRADE=true'" >> /etc/systemd/system/$NODE_MONIKER.service
echo "Environment='DAEMON_LOG_BUFFER_SIZE=512'" >> /etc/systemd/system/$NODE_MONIKER.service
echo ""                                     >> /etc/systemd/system/$NODE_MONIKER.service
echo "[Install]"                            >> /etc/systemd/system/$NODE_MONIKER.service
echo "WantedBy=multi-user.target"           >> /etc/systemd/system/$NODE_MONIKER.service

echo "reload systemd..."
sudo systemctl daemon-reload

echo "starting the daemon..."
sudo systemctl start $NODE_MONIKER.service

sudo systemctl restart systemd-journald

echo "***********************"
echo "find logs like this:"
echo "sudo journalctl -fu $NODE_MONIKER.service"
echo "***********************"
```

## Public testnet modifications

The following modifications were made using the [cosmos-genesis-tinker script](https://github.com/hyphacoop/cosmos-genesis-tinkerer/blob/public-genesis/genesis_theta.py):

1. Autoloading ./exported_genesis.json.preprocessed.json
2. Loading genesis from file ./exported_genesis.json.preprocessed.json
3. Swapping chain id to theta-testnet-001
4. Increasing balance of cosmos10v6wvdenee8r9l6wlsphcgur2ltl8ztkvhc8fw by 175000000000000 uatom
5. Increasing supply of uatom by 175000000000000
6. Increasing balance of cosmos10v6wvdenee8r9l6wlsphcgur2ltl8ztkvhc8fw by 1000 theta
7. Increasing supply of theta by 1000
8. Creating new coin theta valued at 1000
9. Increasing balance of cosmos10v6wvdenee8r9l6wlsphcgur2ltl8ztkvhc8fw by 1000 rho
10. Increasing supply of rho by 1000
11. Creating new coin rho valued at 1000
12. Increasing balance of cosmos10v6wvdenee8r9l6wlsphcgur2ltl8ztkvhc8fw by 1000 lambda
13. Increasing supply of lambda by 1000
14. Creating new coin lambda valued at 1000
15. Increasing balance of cosmos10v6wvdenee8r9l6wlsphcgur2ltl8ztkvhc8fw by 1000 epsilon
16. Increasing supply of epsilon by 1000
17. Creating new coin epsilon valued at 1000
18. Increasing balance of cosmos1fl48vsnmsdzcv85q5d2q4z5ajdha8yu34mf0eh by 550000000000000 uatom
19. Increasing supply of uatom by 550000000000000
20. Increasing delegator stake of cosmos10v6wvdenee8r9l6wlsphcgur2ltl8ztkvhc8fw by 550000000000000
21. Increasing validator stake of cosmosvaloper10v6wvdenee8r9l6wlsphcgur2ltl8ztkfrvj9a by 550000000000000
22. Increasing validator power of A8A7A64D1F8FFAF2A5332177F777A5816036D65A by 550000000
23. Increasing delegations of cosmos10v6wvdenee8r9l6wlsphcgur2ltl8ztkvhc8fw with cosmosvaloper10v6wvdenee8r9l6wlsphcgur2ltl8ztkfrvj9a by 550000000000000.0
24. Swapping min governance deposit amount to 1uatom
25. Swapping tally parameter quorum to 0.000000000000000001
26. Swapping tally parameter threshold to 0.000000000000000001
27. Swapping governance voting period to 60s
28. Swapping staking unbonding_time to 1s

SHA256SUM: `522d7e5227ca35ec9bbee5ab3fe9d43b61752c6bdbb9e7996b38307d7362bb7e`
