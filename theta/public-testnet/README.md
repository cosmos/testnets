# Theta Public Testnet

This testnet helps validators participate in simulated upgrades to the next Gaia release candidate before the mainnet upgrade. It mirrors the state of mainnet, aside from a few modifications to the exported genesis file. These adjustments help provide liveness and streamlined governance-permissioned software upgrades.

Visit the [Scheduled Upgrades](UPGRADES.md) page for details on current and upcoming versions. 

## Testnet Details

- **Chain-ID**: `theta-testnet-001`
- **Launch date**: 2022-03-10
- **Current Gaia Version:** `v7.0.0-rc0` upgraded at height `9283650`
- **Launch Gaia Version:** `release/v6.0.0`
- **Genesis File:**  Zipped and included [in this repository](public-testnet/genesis.json.gz), unzip and verify with `shasum -a 256 genesis.json`
- **Genesis sha256sum**: `522d7e5227ca35ec9bbee5ab3fe9d43b61752c6bdbb9e7996b38307d7362bb7e`

### Endpoints

Endpoints are exposed as subdomains for the sentry and snapshot nodes (described below) as follows:

* `rpc.<node-name>.theta-testnet.polypore.xyz`
* `rest.<node-name>.theta-testnet.polypore.xyz`
* `grpc.<node-name>.theta-testnet.polypore.xyz`
* `p2p.<node-name>.theta-testnet.polypore.xyz`

Sentries:

1. `https://sentry-01.theta-testnet.polypore.xyz`
2. `https://sentry-02.theta-testnet.polypore.xyz`

Seed nodes:

1. `https://seed-01.theta-testnet.polypore.xyz`
2. `https://seed-02.theta-testnet.polypore.xyz`

The following state sync nodes serve snapshots every 1000 blocks:

1. `https://state-sync-01.theta-testnet.polypore.xyz`
2. `https://state-sync-02.theta-testnet.polypore.xyz`


### Seeds

You can add these in your seeds list.

```
639d50339d7045436c756a042906b9a69970913f@seed-01.theta-testnet.polypore.xyz:26656
3e506472683ceb7ed75c1578d092c79785c27857@seed-02.theta-testnet.polypore.xyz:26656
```

### Block Explorers

  - https://explorer.theta-testnet.polypore.xyz
  - https://cosmoshub-testnet.mintscan.io/cosmoshub-testnet
  - https://testnet.cosmos.bigdipper.live/

### Faucet

Visit the [🚰・testnet-faucet](https://discord.com/channels/669268347736686612/953697793476821092) channel in the Cosmos Developers Discord.


## Add to Keplr

Use this [jsfiddle](https://jsfiddle.net/kht96uvo/1/).

## How to Join

Both of the methods shown below will install Gaia and set up a Cosmovisor service with the auto-download feature enabled on your machine.

You can choose to (not) use state sync both ways. Your node will sync much faster if you use state sync, but it will not keep all the state locally.

### Ansible Playbook

Use the example inventory file from the [cosmos-ansible](https://github.com/hyphacoop/cosmos-ansible) repo to set up a node using state sync:

```
git clone https://github.com/hyphacoop/cosmos-ansible.git
cd cosmos-ansible
git checkout v0.1.0
ansible-playbook gaia.yml -i examples/inventory-theta.yml -e 'target=SERVER_IP_OR_DOMAIN'
```

The video below provides an overview of how the playbook sets up the node.

[![Join the Cosmos Theta Testnet](https://img.youtube.com/vi/SYt0EC5pcY0/0.jpg)](https://www.youtube.com/watch?v=SYt0EC5pcY0)

If you want to sync from genesis, set the following variables in the inventory file:
* `gaiad_version: v6.0.4`
* `statesync_enabled: false`

For additional information, visit the [examples page](https://github.com/hyphacoop/cosmos-ansible/tree/main/examples#join-the-theta-testnet).

### Bash Script

Modify the script with the Gaia [release branch](https://github.com/cosmos/gaia/branches/all?query=release) you want to test and an appropriate state sync configuration.

* To use state sync:
  * Set the trust height to (roughly) the current block height minus 1000 and the corresponding trust hash. Visit a [block explorer](#block-explorers) to find a block's hash and the current block height. 

* If you are syncing from genesis:
  * Disable state sync: `STATE_SYNC=false`.
  * Use gaia branch `v6.0.4` and upgrade at the block heights described in the [Scheduled Upgrades](UPGRADES.md) page.

```
#!/bin/bash -i

##### CONFIGURATION ###

export GAIA_BRANCH=v7.0.0
export GENESIS_ZIPPED_URL=https://github.com/cosmos/testnets/tree/master/theta/public-testnet/genesis.json.gz
export NODE_HOME=$HOME/.gaia
export CHAIN_ID=theta-testnet-001
export NODE_MONIKER=my-node # only really need to change this one
export BINARY=gaiad
export SEEDS="639d50339d7045436c756a042906b9a69970913f@seed-01.theta-testnet.polypore.xyz:26656,3e506472683ceb7ed75c1578d092c79785c27857@seed-02.theta-testnet.polypore.xyz:26656"

##### OPTIONAL STATE SYNC CONFIGURATION ###

export STATE_SYNC=true # if you set this to true, please have TRUST HEIGHT and TRUST HASH and RPC configured
export TRUST_HEIGHT=9500000
export TRUST_HASH="92ABB312DFFA04D3439C5A0F74A07F46843ADC4EB391A723EAE00855ADECF5A4"
export SYNC_RPC="rpc.sentry-01.theta-testnet.polypore.xyz:26657,rpc.sentry-02.theta-testnet.polypore.xyz:26657"

############## 

# you shouldn't need to edit anything below this

echo "Updating apt-get..."
sudo apt-get update

echo "Getting essentials..."
sudo apt-get install git build-essential ntp

echo "Installing go..."
wget -q -O - https://git.io/vQhTU | bash -s - --version 1.18

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
echo "ExecStart=/root/go/bin/cosmovisor start --x-crisis-skip-assert-invariants --home \$DAEMON_HOME --p2p.seeds $SEEDS" >> /etc/systemd/system/$NODE_MONIKER.service
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

### Cosmovisor: upgrading with autodownload vs. manually preparing your binary

If you want to use Cosmovisor's **auto-download** feature, please set the environment variable `DAEMON_ALLOW_DOWNLOAD_BINARIES=true`

If you are **manually preparing your binary**, please download a copy of the v8.0.0-rc0 binary to the v8-Rho upgrade directory in your cosmovisor directory (`upgrades/v8-Rho/bin/gaiad`).

```
.
├── current -> genesis or upgrades/<name>
├── genesis
│   └── bin
│       └── gaiad
└── upgrades
    └── v8-Rho
        ├── bin
        │   └── gaiad
        └── upgrade-info.json
```

## Public testnet modifications

The following modifications were made using the [cosmos-genesis-tinker script](https://github.com/hyphacoop/cosmos-genesis-tinkerer/blob/main/example_stateful_genesis.py):

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
