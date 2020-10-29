We will be using `cosmovisor` to perform an automatic software upgrade from `bigbang-1` to a stargate release candidate. 

**Note**: Building the `bigbang` binary requires GO version 1.15+

#### Installing cosmovisor

```
mkdir -p $GOPATH/src/github.com/cosmos
cd $GOPATH/src/github.com/cosmos
git clone https://github.com/cosmos/cosmos-sdk.git && cd cosmos-sdk/cosmovisor
make cosmovisor
cp cosmovisor $GOBIN/cosmovisor
```

#### Setting up directories

```
mkdir -p ~/.akashd/cosmovisor
mkdir -p ~/.akashd/cosmovisor/genesis/bin
mkdir -p ~/.akashd/cosmovisor/upgrades/stargate/bin
cp $GOBIN/akashd ~/.akashd/cosmovisor/genesis/bin
```

#### Building the stargate release 

```
cd $GOPATH/src/github.com/ovrclk/akash
git fetch -a && git checkout bigbang
make all
```

This will create `akashd` binary built on stargate release. This binary has to be placed in the upgrades folder.
```
cp akashd ~/.akashd/cosmovisor/upgrades/stargate/bin
```

#### Modifying or setting up service file

**Note**: Using cosmovisor for automatic upgrade requires it to be set up as a service file.
Create a systemd file:
`sudo nano /lib/systemd/system/akashd.service`
Copy-Paste in the following and update `<your_username>` and `<go_workspace>` as required:

```
[Unit]
Description=Akash daemon
After=network-online.target

[Service]
Environment="DAEMON_NAME=akashd"
Environment="DAEMON_HOME=/home/<your_username>/.akashd"
Environment="DAEMON_RESTART_AFTER_UPGRADE=on"
User=<your_username>
ExecStart=/home/<your_username>/<go_workspace>/bin/cosmovisor start
Restart=always
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```

#### Restart the process
```
sudo systemctl stop akashd
sudo systemctl daemon-reload
sudo systemctl start akashd
```
