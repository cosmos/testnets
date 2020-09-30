# Phase-1 : Instructions

## Software Requirements:
- Go version v1.14.+
- Gaia version : [TBD]()
- Cosmos SDK version: [v0.39.1](https://github.com/cosmos/cosmos-sdk/releases/tag/v0.39.1)


### Install Gaia
```
$ mkdir -p $GOPATH/src/github.com/cosmos
$ cd $GOPATH/src/github.com/cosmos
$ git clone https://github.com/cosmos/gaia && cd gaia
$ git checkout <0.39.branch>
$ make install
```

To verify if the installation was successful, execute the following command:
```
$ gaiad version --long
```
It will display the version of xrnd currently installed:
```
name: gaia
server_name: gaia
client_name: gaiacli
version: ...
commit: ...
build_tags: netgo,ledger
go: go version go1.14.3 linux/amd64
```

## Activity-1: Start your validator node
If you are looking to join the testnet post genesis time (i.e, _14-Oct-2020 1600UTC_), skip to [Create Testnet Validator](#create-testnet-validator)

Below are the instructions to generate & submit your `GenTx`
### Generate GenTx
1. Initialize the gaia directories and create the local genesis file with the correct
   chain-id

   ```shell
   $ gaiad init <moniker-name> --chain-id=bigbang-1
   ```

2. Create a local key pair in the Keybase

   ```shell
   $ gaiacli keys add <key-name>
   ```

3. Add your account to your local genesis file with a given amount and the key you
   just created. Use only `1000000000stake`, other amounts will be ignored.

   ```shell
   $ gaiad add-genesis-account $(gaiacli keys show <key-name> -a) 1000000000stake
   ```

4. Create the gentx

   ```shell
   $ gaiad gentx --amount 900000000stake --name=<key-name>
   ```

   If all goes well, you will see a message similar to the following:
    ```shell
    Genesis transaction written to "/home/user/.gaiad/config/gentx/gentx-******.json"
    ```

### Submit Gentx
Submit your gentx in a PR [here](https://github.com/cosmos/testnets)

- Fork the testnets repo into your github account 

- Clone your repo using

    ```sh
    $ git clone https://github.com/<your-github-username>/testnets
    ```

- Copy the generated gentx json file to `<repo_path>/bigbang-1/phase-1/gentx/`

    ```sh
    $ cd $GOPATH/src/github.com/cosmos/testnets
    $ cp ~/.gaiad/config/gentx/gentx*.json ./bigbang-1/phase-1/gentx/
    ```

- Commit and push to your repo
- Create a PR onto https://github.com/cosmos/testnets


### Start your validator node
Once after the genesis is released (i.e., _13-Oct-2020 1600UTC_), follow the instructions below to start your validator node.

#### Genesis & Seeds
Fetch `genesis.json` into `gaiad`'s `config` directory.
```
$ curl https://raw.githubusercontent.com/cosmos/testnets/master/bigbang-1/genesis.json > $HOME/.gaiad/config/genesis.json
```

Add seed nodes in `config.toml`.
```
$ nano $HOME/.gaiad/config/config.toml
```
Find the following section and add the seed nodes.
```
# Comma separated list of seed nodes to connect to
seeds = ""
```
```
# Comma separated list of persistent peers to connect to
persistent_peers = ""
```

#### Start Your Node

Create a systemd service

```
$ sudo nano /lib/systemd/system/gaiad.service
```
Copy-Paste in the following and update `<your_username>` and `<go_workspace>` as required:

    ```
    [Unit]
    Description=Gaiad
    After=network-online.target

    [Service]
    User=<your_username>
    ExecStart=/home/<your_username>/<go_workspace>/bin/gaiad start
    Restart=always
    RestartSec=3
    LimitNOFILE=4096

    [Install]
    WantedBy=multi-user.target
    ```

**This tutorial assumes `$HOME/go_workspace` to be your Go workspace. Your actual workspace directory may vary.**

```
$ sudo systemctl enable gaiad
$ sudo systemctl start gaiad
```
Check node status
```
$ gaiad status
```
Check logs
```
$ sudo journalctl -u gaiad -f
```

## Create Testnet Validator
This section applies to those who are looking to join the testnet post genesis.

1. Init Chain and start your node
   ```shell
   $ gaiad init <moniker-name> --chain-id=bigbang-1
   ```

   After that, please follow all the instructions from [Start your validator node](#start-your-validator-node)


2. Create a local key pair in the Keybase

   ```shell
   $ gaiacli keys add <key-name>
   $ gaiacli keys show <key-name> -a
   ```

3. Request tokens from faucet: https://faucet.stargate.vitwit.com

4. Create validator

   ```shell
   $ gaiacli tx staking create-validator \
   --amount 900000000stake \
   --commission-max-change-rate "0.1" \
   --commission-max-rate "0.20" \
   --commission-rate "0.1" \
   --min-self-delegation "1" \
   --details "Some details about yourvalidator" \
   --pubkey=$(gaiad tendermint show-validator) \
   --moniker <your_moniker> \
   --chain-id bigbang-1 \
   --from <key-name> 
   ```
