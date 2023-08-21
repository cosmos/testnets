# v11 Local Testnet

These instructions will help you simulate the `v11` upgrade on a single validator node testnet as follows:

- Start with gaia version: `v10.0.2`
- After the upgrade: gaia release `v11.0.0`

We will use a modified genesis file during this upgrade. This modified genesis file is similar to the one we are running on the public testnet, and has been modified in part to replace an existing validator (Coinbase Custody) with a new validator account that we control. The account's mnemonic, validator key, and node key are provided in this repo.  
For a full list of modifications to the genesis file, please [see below](#genesis-modifications).

If you are interested in running v10 without going through the upgrade, you can download one of the binaries in the Gaia [releases](https://github.com/cosmos/gaia/releases) page follow the rest of the instructions up until the node is running and producing blocks.

* **Chain ID**: `local-testnet`
* **Gaia version:** `v10.0.2`
* **Modified genesis file:** [here](https://files.polypore.xyz/genesis/mainnet-genesis-tinkered/latest_v10.json.gz)
* **Original genesis file:** [here](https://files.polypore.xyz/genesis/mainnet-genesis-export/latest_v10.json.gz)
* **Validator key:** [priv_validator_key](priv_validator_key.json)
* **Node key:** [node_key](node_key.json)
* **Validator mnemonic:** [mnemonic.txt](mnemonic.txt)

## Set up with Ansible Playbook

Use the example inventory file from the [cosmos-ansible](https://github.com/hyphacoop/cosmos-ansible) repo to set up a local testnet node:

```
git clone https://github.com/hyphacoop/cosmos-ansible.git
cd cosmos-ansible
ansible-playbook node.yml -i examples/inventory-local-genesis.yml -e 'target=SERVER_IP_OR_DOMAIN'
```

The playbook will set up Cosmovisor with auto-download enabled.

For additional information, visit the [examples page](https://github.com/hyphacoop/cosmos-ansible/tree/main/examples#start-a-local-testnet-using-a-modified-genesis-file).

### Upgrade proposal requirements

Log into the target machine and switch to the `gaia` user with `su gaia`.

```
export CHAIN_ID=local-testnet
export NODE_HOME=$HOME/.gaia
export USER_MNEMONIC="abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon art"
export USER_KEY_NAME=my-validator-account
echo $USER_MNEMONIC | gaiad --home $NODE_HOME keys add $USER_KEY_NAME --recover --keyring-backend=test
```

## Manual setup

### Requirements

Follow the [installation instructions](https://hub.cosmos.network/main/getting-started/installation.html) to understand build requirements. You'll need to install Go 1.20.

```
sudo apt update
sudo apt upgrade
sudo apt install git build-essential

curl -OL https://golang.org/dl/go1.20.linux-amd64.tar.gz
sudo tar -C /usr/local -xvf go1.20.linux-amd64.tar.gz
```

### Modify your paths
```
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.profile
source ~/.profile
```

### Build gaia 

```
cd $HOME
git clone https://github.com/cosmos/gaia.git
cd gaia
git checkout v10.0.2
make install
```

### Configure the chain

First initialize your chain.

```
export CHAIN_ID=local-testnet
export NODE_MONIKER=my-local-validator # whatever you like
export BINARY=gaiad
export NODE_HOME=$HOME/.gaia

$BINARY config chain-id $CHAIN_ID --home $NODE_HOME
$BINARY config keyring-backend test --home $NODE_HOME
$BINARY config broadcast-mode block --home $NODE_HOME
$BINARY init $NODE_MONIKER --home $NODE_HOME --chain-id=$CHAIN_ID
```

Then replace the genesis file with our modified genesis file.

```
wget https://files.polypore.xyz/genesis/mainnet-genesis-tinkered/latest_v10.json.gz
gunzip latest_v10.json.gz
mv latest_v10.json $NODE_HOME/config/genesis.json
```

Replace the validator and node keys.

```
wget https://raw.githubusercontent.com/cosmos/testnets/master/local/priv_validator_key.json
mv priv_validator_key.json $NODE_HOME/config/priv_validator_key.json
wget https://raw.githubusercontent.com/cosmos/testnets/master/local/node_key.json
mv node_key.json $NODE_HOME/config/node_key.json
```

Now add your user account. This account has over 75% tokens bonded to your validator.

```
export USER_MNEMONIC="abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon art"
export USER_KEY_NAME=my-validator-account
echo $USER_MNEMONIC | $BINARY --home $NODE_HOME keys add $USER_KEY_NAME --recover --keyring-backend=test
```

Set minimum gas prices.

```
sed -i -e 's/minimum-gas-prices = ""/minimum-gas-prices = "0.0025uatom"/g' $NODE_HOME/config/app.toml
```

Set block sync to be false. This allow us to achieve liveness without additional peers. See this [issue](https://github.com/osmosis-labs/osmosis/issues/735) for details.

```
sed -i -e '/fast_sync =/ s/= .*/= false/' $NODE_HOME/config/config.toml
```

### Cosmovisor

First download Cosmovisor.

```
export GO111MODULE=on
go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v1.3.0
```

Setup the Cosmovisor directory structure. There are two methods to use Cosmovisor:

1. **Manual:** Node runners can manually build the old and new binary and put them into the `cosmovisor` folder (as shown below). Cosmovisor will then switch to the new binary upon upgrade height.

```
cosmovisor/upgrades/v11/bin/gaiad
```

1. **Auto-download:** Allowing Cosmovisor to [auto-download](https://github.com/cosmos/cosmos-sdk/tree/main/tools/cosmovisor#auto-download) the new binary at the upgrade height automatically.

**Cosmovisor directory structure**

```shell
.
├── current -> genesis or upgrades/<name>
├── genesis
│   └── bin
│       └── gaiad
└── upgrades
    └── v11
        ├── bin
        │   └── gaiad
        └── upgrade-info.json
```

For both methods, you should first start by creating the genesis directory as well as copying over the starting binary.

```
mkdir -p $NODE_HOME/cosmovisor/genesis/bin
cp $(which gaiad) $NODE_HOME/cosmovisor/genesis/bin
export BINARY=$NODE_HOME/cosmovisor/genesis/bin/gaiad
```

We recommend running Cosmovisor as a systemd service. Here's how to create the service:

```
touch /etc/systemd/system/$NODE_MONIKER.service

echo "[Unit]"                               >> /etc/systemd/system/$NODE_MONIKER.service
echo "Description=cosmovisor-$NODE_MONIKER" >> /etc/systemd/system/$NODE_MONIKER.service
echo "After=network-online.target"          >> /etc/systemd/system/$NODE_MONIKER.service
echo ""                                     >> /etc/systemd/system/$NODE_MONIKER.service
echo "[Service]"                            >> /etc/systemd/system/$NODE_MONIKER.service
echo "User=root"                        >> /etc/systemd/system/$NODE_MONIKER.service
echo "ExecStart=/root/go/bin/cosmovisor run start --x-crisis-skip-assert-invariants" >> /etc/systemd/system/$NODE_MONIKER.service
echo "Restart=no"                       >> /etc/systemd/system/$NODE_MONIKER.service
echo "LimitNOFILE=4096"                     >> /etc/systemd/system/$NODE_MONIKER.service
echo "Environment='DAEMON_NAME=gaiad'"      >> /etc/systemd/system/$NODE_MONIKER.service
echo "Environment='DAEMON_HOME=$NODE_HOME'" >> /etc/systemd/system/$NODE_MONIKER.service
echo "Environment='DAEMON_ALLOW_DOWNLOAD_BINARIES=true'" >> /etc/systemd/system/$NODE_MONIKER.service
echo "Environment='DAEMON_RESTART_AFTER_UPGRADE=true'" >> /etc/systemd/system/$NODE_MONIKER.service
echo "Environment='DAEMON_LOG_BUFFER_SIZE=512'" >> /etc/systemd/system/$NODE_MONIKER.service
echo ""                                     >> /etc/systemd/system/$NODE_MONIKER.service
echo "[Install]"                            >> /etc/systemd/system/$NODE_MONIKER.service
echo "WantedBy=multi-user.target"           >> /etc/systemd/system/$NODE_MONIKER.service
```

Set the following environment variables for the Cosmovisor service:

```
export DAEMON_NAME=gaiad
export DAEMON_HOME=$NODE_HOME
```

Before running the service, we recommend reloading the systemctl daemon and restarting the journald service.

```
sudo systemctl daemon-reload
sudo systemctl restart systemd-journald
```

### Run your node

You are now ready to start your node like this:

```
sudo systemctl enable --now $NODE_MONIKER.service
```

And view the logs like this:

```
sudo journalctl -fu $NODE_MONIKER.service
```

**Please make sure your node is running and producing blocks before you proceed further!** It can take up to 10 minutes for your node to start up. Once it's producing blocks you'll start seeing log messages like the following:

```
INF committed state app_hash=99D509C03FDDFEACAD90608008942C0B4C801151BDC1B8998EEC69A1772B22DF height=16188740 module=state num_txs=0
```

## Manually prepare the upgrade binary (if you do not have auto-download enabled on Cosmovisor)

Build the upgrade binary: v11 requires GO v1.20.
```
wget -q https://go.dev/dl/go1.20.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.20.linux-amd64.tar.gz

cd $HOME/gaia
git checkout v11.0.0
git pull
make install
```

Copy over the v11 binary into the correct directory.
```
mkdir -p $NODE_HOME/cosmovisor/upgrades/v11/bin
cp $(which gaiad) $NODE_HOME/cosmovisor/upgrades/v11/bin
export BINARY=$NODE_HOME/cosmovisor/upgrades/v11/bin/gaiad
```

## Submit and vote on a software upgrade proposal

You can submit a software upgrade proposal without specifiying a binary, but this only works for those nodes who are manually preparing the upgrade binary.

```
gaiad tx gov submit-proposal software-upgrade v11 \
--title "v11 Upgrade" \
--deposit 100uatom \
--upgrade-height TBD \
--upgrade-info '{"binaries":{"darwin/amd64":"https://github.com/cosmos/gaia/releases/download/v11.0.0/gaiad-v11.0.0-darwin-amd64?checksum=sha256:f115875122386496254905a1de0c0cb45f1b731536281586f77a41be55458505","darwin/arm64":"https://github.com/cosmos/gaia/releases/download/v11.0.0/gaiad-v11.0.0-darwin-arm64?checksum=sha256:53d0ffe4d8353e51d0be543edf764de033e24d703d4c408244a141e635b27628","linux/amd64":"https://github.com/cosmos/gaia/releases/download/v11.0.0/gaiad-v11.0.0-linux-amd64?checksum=sha256:258df2eec5b22f8baadc988e184fbfd2ae6f9f888e9f4461a110cc365fe86300","linux/arm64":"https://github.com/cosmos/gaia/releases/download/v11.0.0/gaiad-v11.0.0-linux-arm64?checksum=sha256:688e3ae4aa5ed91978f537798e012322336c7309fe5ee9169fdd607ab6c348b8","windows/amd64":"https://github.com/cosmos/gaia/releases/download/v11.0.0/gaiad-v11.0.0-windows-amd64.exe?checksum=sha256:24a1de7579673c77e1be1a7d2085a8d39a21611ed5d8329f1df0619f875e32c6","windows/arm64":"https://github.com/cosmos/gaia/releases/download/v11.0.0/gaiad-v11.0.0-windows-arm64.exe?checksum=sha256:122c25e7291158293f1b1f0a7272184e556ebe01292257a1d4b9987077d0d61a"}}' \
--description "Upgrade Gaia to v11" \
--gas auto \
--fees 1000uatom \
--from $USER_KEY_NAME \
--keyring-backend test \
--chain-id $CHAIN_ID \
--home $NODE_HOME \
--node tcp://localhost:26657 \
--yes \
-b block
```

Get the proposal ID from the TX hash
`$NODE_HOME/cosmovisor/current/bin/gaiad q tx DB297FDA1DAE700B0155388220703A4074E0C48595635C6A91BBEAF2FF266412`

Vote on it.

```
gaiad tx gov vote <proposal ID> yes \
--from $USER_KEY_NAME \
--keyring-backend test \
--chain-id $CHAIN_ID \
--home $NODE_HOME \
--gas auto \
--fees 500uatom \
--node tcp://localhost:26657 \
--yes -b block
```

After the voting period ends, you should be able to query the proposal to see if it has passed. Like this:

```
gaiad query gov proposal <proposal ID> --home $NODE_HOME
```

After `PROPOSAL_STATUS_PASSED`, wait until the upgrade height is reached Cosmovisor will now auto-download the new binary specific to your platform and apply the upgrade.

## Genesis Modifications

Full list of modifications are as follows:

* Swapping chain id to local-testnet
* Increasing balance of cosmos1r5v5srda7xfth3hn2s26txvrcrntldjumt8mhl by 175000000000000 uatom
* Increasing supply of uatom by 175000000000000
* Increasing balance of cosmos1r5v5srda7xfth3hn2s26txvrcrntldjumt8mhl by 550000000000000 uatom
* Increasing supply of uatom by 550000000000000
* Increasing delegator stake of cosmos1wvvhhfm387xvfnqshmdaunnpujjrdxznr5d5x9 by 550000000000000
* Increasing validator stake of cosmosvaloper1r5v5srda7xfth3hn2s26txvrcrntldju7lnwmv by 550000000000000
* Increasing validator power of 973C48DF8B3356C45E44494723A6E0D45DEB8131 by 550000000
* Swapping min governance deposit amount to 1uatom
* Swapping tally parameter quorum to 0.000000000000000001
* Swapping tally parameter threshold to 0.000000000000000001
* Swapping governance voting period to 60s
* Swapping staking unbonding_time to 1s

Please note that you will need to set `fast-sync` to false in your `config.toml` file and wait for approximately 10mins for a single node testnet to start. This is due to an [issue](https://github.com/osmosis-labs/osmosis/issues/735) with state export based testnets that can't get to consensus without multiple peered nodes.
