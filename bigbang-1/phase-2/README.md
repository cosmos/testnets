# Phase-2 : Instructions

## Software Requirements:
- Go version v1.15.+

## Useful Links
### Explorers: [Aneka](https://bigbang.aneka.io) [BigDipper](https://bigbang.bigdipper.live)
### Faucet: https://faucet.bigbang.vitwit.com


### Install Akash
```
$ mkdir -p $GOPATH/src/github.com/ovrclk
$ cd $GOPATH/src/github.com/ovrclk
$ git clone https://github.com/ovrclk/akash && cd akash
$ git checkout v0.10.0-rc3
$ make install
```

To verify if the installation was successful, execute the following command:
```
$ akash version --long
```
It will display the version of akashd currently installed:
```
name: akash
server_name: akash
version: 0.10.0
commit: af43b89e47e50bfeedcc35c7ee77229bd258ed0d
build_tags: netgo,ledger
go: go version go1.15.5 linux/amd64
build_deps:
- github.com/99designs/keyring@v1.1.6
- github.com/ChainSafe/go-schnorrkel@v0.0.0-20200405005733-88cbf1b4c40d
- github.com/Workiva/go-datastructures@v1.0.52
...
```


### Start your validator node
Follow the instructions below to start your validator node.

#### Init Chain 
   ```shell
   $ akash init <moniker-name> --chain-id=bigbang-4
   ```
#### Genesis & Seeds
Fetch `genesis.json` into `akashd`'s `config` directory.
```
$ curl https://raw.githubusercontent.com/cosmos/testnets/master/bigbang-1/phase-2/genesis.json > $HOME/.akash/config/genesis.json
```

Add seed nodes in `config.toml`.

  
```
$ nano $HOME/.akash/config/config.toml
```
Find the following section and add the seed nodes.
```
# Comma separated list of seed nodes to connect to
seeds = "31e5882c810f56b553a714bab79bf725a9bcd5e4@104.131.69.13:26656"
```
```
# Comma separated list of persistent peers to connect to
persistent_peers = "14789c286805f4d9883439d8c39c6846cdae4d4d@157.230.185.206:26656" // Witval peer
```

#### Start Your Node

Create a systemd service

```shell
echo "[Unit]
Description=Akash Node
After=network-online.target
[Service]
User=${USER}
ExecStart=$(which akash) start
Restart=always
RestartSec=3
LimitNOFILE=4096
[Install]
WantedBy=multi-user.target
" >akash.service
```

```
$ sudo mv akash.service /lib/systemd/system/
$ sudo systemctl daemon-reload
$ sudo systemctl enable akash.service
$ sudo systemctl start akash.service
```
```
$ sudo systemctl enable akash
$ sudo systemctl start akash
```
Check node status
```
$ systemctl status akash 
```
Check logs
```
$ sudo journalctl -u akash -f
```

## Create Testnet Validator

1. Create a local key pair in the Keyring

   ```shell
   $ akash keys add <key-name>
   $ akash keys show <key-name> -a
   ```

3. Request tokens from faucet: https://faucet.bigbang.vitwit.com

4. Create validator

   ```shell
   $ akash tx staking create-validator \
   --amount 900000000uakt \
   --commission-max-change-rate "0.1" \
   --commission-max-rate "0.20" \
   --commission-rate "0.1" \
   --min-self-delegation "1" \
   --details "Some details about yourvalidator" \
   --pubkey=$(akashd tendermint show-validator) \
   --moniker <your_moniker> \
   --chain-id bigbang-4 \
   --from <key-name> 
   ```


