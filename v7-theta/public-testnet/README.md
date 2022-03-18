# v7-Theta Public Testnet

* If you're syncing from genesis, you'll need to use gaiad `v6.0.x` and uprade at the upgrade heights described below
* If you do not need to keep all the state locally, you can use state sync with the current version. See the quickstart instructions below.

## Scheduled Upgrades 🗓️ 

### 2022-03-17 v7-Theta upgrade

* **Version before upgrade**: `v6.0.x`
* **Version after upgrade**: `v7.0.0-rc-0`

| Date                       | Testnet plan                |
| -------------------------- | --------------------------- |
| March 10 2022  | ✅  Launch testnet chain with Gaia v6.0.0 (previous version)  |
| March 16 2022  | ✅  Submit software [upgrade proposal](https://testnet.cosmos.bigdipper.live/proposals/66)           |
| March 16 2022  | ✅  Voting ends                 |
| March 17 2022  | ✅  Theta upgrade ([Gaia v7.0.0-rc0](https://github.com/cosmos/gaia/releases/tag/v7.0.0-rc0)) is live on the testnet |

The v7-Theta upgrade was successfully completed on **March 17th, 2022 at 16:14 UTC (12:14 PM ET)**. The upgrade halt height was `9283650`, and blocks were being produced 7 minutes later.

Relevant log lines:
```
Mar 17 12:07:40 earth cosmovisor[822]: 12:07PM ERR UPGRADE "v7-Theta" NEEDED at height: 9283650
Mar 17 12:14:42 earth cosmovisor[13563]: 12:14PM INF finalizing commit of block hash=D83798E929BA7FB1F740C7E583EC2918EC40EDD3249B14BC72876130053BD0EE height=9283651 module=consensus num_txs=0 root=17F5C1754B53350A543A6BB29DE5E35A9DB9874AF89117220117213E53E38344
```

#### Validators participating in upgrade testing

* 0base.vc
* 20MB Lab
* Cosmic Validator - Testnet
* Everstake
* Itachi
* KalpaTech
* P2P.ORG Validator
* Provalidator
* StakeWithUs
* Stakely.io
* WeStaking

Thank you to all participating validators! These validators received `THETA` tokens to their self-delegation addresses as part of our [collectables program](https://interchain-io.medium.com/cosmos-hub-theta-testnet-token-collectables-d08967ba2875)!

#### Upgrade height and binaries
* Upgrade height: `9283650` 
* Estimated update time: 16:00 UTC
* On-chain proposal:

```bash=
gaiad tx gov submit-proposal software-upgrade v7-Theta \
--title v7-Theta \
--deposit 500000uatom \
--upgrade-height 9283650 \
--upgrade-info '{"binaries": {"linux/amd64": "https://github.com/cosmos/gaia/releases/download/v7.0.0-rc0/gaiad-v7.0.0-rc0-linux-amd64?checksum=sha256:4e95eaca51d6e0ab61b7a759aafc4b4674c270b8ffa764cb953d3808a1f9e264","linux/arm64": "https://github.com/cosmos/gaia/releases/download/v7.0.0-rc0/gaiad-v7.0.0-rc0-linux-arm64?checksum=sha256:574916076c6e0960fa980522ed9a404967a6f4c306448d09649a11e5626cd991","darwin/amd64": "https://github.com/cosmos/gaia/releases/download/v7.0.0-rc0/gaiad-v7.0.0-rc0-darwin-amd64?checksum=sha256:547182dd4456e8d71ff5256484458f0690a865d5c9f2185286dd9ab71dd11b10","windows/amd64": "https://github.com/cosmos/gaia/releases/download/v7.0.0-rc0/gaiad-v7.0.0-rc0-windows-amd64.exe?checksum=sha256:4eea1a32af3ed79632cfc8cca7088a10b3d89f767310e3c24fe31ad99492f6c8"}}' \
--description "This on-chain upgrade governance proposal is to adopt gaia v7.0.0 which includes a number of updates, fixes and new modules. By voting YES to this proposal, you approve of adding these updates to the Cosmos Hub.\n\n# Background\n\nSince the last v6-Vega upgrade at height 86950000 there have been a number of updates, fixes and new modules added to the Cosmos SDK, IBC and Tendermint.\n\nThis is a proposal to adopt the first release candiate for the [v7-Theta](https://github.com/cosmos/gaia/blob/main/docs/roadmap/cosmos-hub-roadmap-2.0.md#v7-theta-upgrade-expected-q1-2022) upgrade on the public testnet.\n\nIt contains the following changes:\n\n* (gaia) bump [cosmos-sdk](https://github.com/cosmos/cosmos-sdk) to [v0.45.1](https://github.com/cosmos/cosmos-sdk/releases/tag/v0.45.1). See [CHANGELOG.md](https://github.com/cosmos/cosmos-sdk/blob/v0.45.1/CHANGELOG.md#v0451---2022-02-03) for details.\n* (gaia) bump [ibc-go](https://github.com/cosmos/ibc-go) module to [v3.0.0](https://github.com/cosmos/ibc-go/releases/tag/v3.0.0). See [CHANGELOG.md](https://github.com/cosmos/ibc-go/blob/v3.0.0/CHANGELOG.md#v300---2022-03-15) for details.\n* (gaia) add [interhcian account](https://github.com/cosmos/ibc-go/tree/main/modules/apps/27-interchain-accounts) module (interhchain-account module is part of ibc-go module).\n* (gaia) bump [liquidity](https://github.com/gravity-devs/liquidity/x/liquidity) module to [v1.5.0](https://github.com/Gravity-Devs/liquidity/releases/tag/v1.5.0). See [CHANGELOG.md](https://github.com/Gravity-Devs/liquidity/blob/v1.5.0/CHANGELOG.md#v150---20220223) for details.\n* (gaia) bump [packet-forward-middleware](https://github.com/strangelove-ventures/packet-forward-middleware) module to [v2.1.1](https://github.com/strangelove-ventures/packet-forward-middleware/releases/tag/v2.1.1).\n* (gaia) add migration logs for upgrade process.\n\n# On-Chain Upgrade Process\nWhen the network reaches the halt height, the state machine program of the Cosmos Hub will be halted. The classic method for upgrading requires all validators and node operators to manually substitute the existing state machine binary with the new binary. There is also a newer method that relies on Cosmovisor to swap the binaries automatically. Cosmovisor also includes the ability to download the binaries automatically before swapping them. To test a simulated local upgrade please see the local testnet documentation. Because it is an onchain upgrade process, the blockchain will be continued with all the accumulated history with continuous block height." \
--fees 1500uatom \
--gas auto \
--from <key_name> \
--chain-id theta-testnet-001 \
--node tcp://localhost:26657 \
--yes
```

## How to join

### Quickstart on a fresh machine (e.g., on Digital Ocean droplet)

You will have to modify the configuration below with the relevant release, trust height, and corresponding trust hash.

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

### Upgrading with autodownload vs. manually preparing your binary

If you're using Cosmovisor's **autodownload** feature, please set the environment variable `DAEMON_ALLOW_DOWNLOAD_BINARIES=true`

**IMPORTANT:** In case you're using auto-download, on Gaia v6.0.0 or v6.0.3 Cosmosvisor won't auto-download the binary unfortunately. v6.0.4 will work fine. Please refer to [this issue](https://github.com/cosmos/gaia/issues/1342) for details.

If you're **manually preparing your binary**, please download v7.0.0-rc0 and move the binary to the v7-Theta upgrade directory in your cosmovisor directory

```
.
├── current -> genesis or upgrades/<name>
├── genesis
│   └── bin
│       └── gaiad
└── upgrades
    └── v7-Theta
        ├── bin
        │   └── gaiad
        └── upgrade-info.json
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
