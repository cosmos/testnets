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

#### Setting up service file

**Note**: Using cosmovisor for automatic upgrade requires it to be set up as a service file.
Create a systemd file:
`sudo nano /lib/systemd/system/cosmovisor.service`
Copy-Paste in the following and update `<your_username>` and `<go_workspace>` as required:

```
[Unit]
Description=Cosmovisor daemon
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

#### Enable the cosmovisor process
```
sudo systemctl daemon-reload
sudo systemctl enable cosmovisor.service
```

#### Stop the existing Akashd service file and start the Cosmovisor service.

```
sudo systemctl stop akashd.service
sudo systemctl start cosmovisor.service
```

You can see the logs using:
```
journalctl -u cosmovisor -f
```

### Upgrade failure contingency

Due to ongoing development of Stargate release, it is possible the `bigbang` Stargate release candidate might have issues which might prevent the network from restarting. In this case the planned upgrade will have to be cancelled and the network will continue on the `v0.8.1` binary using the `--unsafe-skip-upgrades` flag.

**Note**: The following procedure has to be undertaken only if the planned upgrade fails. Please co-ordinate on the #bigbang-testnet channel on Discord to see if this procedure is necessary or not.

#### Stop the Cosmovisor service

```
sudo systemctl stop cosmovisor.service
sudo systemctl disable cosmovisor.service
```

#### Edit the original Akashd service file to include the flag
```
sudo nano /lib/systemd/system/akashd.service
```

 Please co-ordinate on the #bigbang-testnet channel on Discord to see what `<upgrade-height>` will be.
 
 
```
[Unit]
Description=akash
After=network-online.target

[Service]
User=<your_username>
ExecStart=/home/<your_username>/<go_workspace>/bin/akashd start --unsafe-skip-upgrades <upgrade-height>
Restart=always
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```

#### Start the Akashd service 

```
sudo systemctl daemon-reload
sudo systemctl restart akash.service
```
