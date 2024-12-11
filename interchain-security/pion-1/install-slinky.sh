#!/bin/bash
# Set up a service to join the pion-1 chain.

# Configuration
# You should only have to modify the values in this block or you can pass the values as arguments to the script.
# * Keys
#    The private validator key and node key operations must match those used in the provider-1 chain if you want to run a validator.
# ***
SLINKY_HOME=~/.slinky
SERVICE_NAME=slinky
SERVICE_VERSION="1.0.13"
# ***

# Create directories
if [ ! -d $SLINKY_HOME ]
then
    mkdir $SLINKY_HOME
    chown -R $USER $SLINKY_HOME
fi

if [ ! -d $HOME/go/bin ]
then
    mkdir -p $HOME/go/bin
    chown -R $USER $SLINKY_HOME
fi

# Install slinky binary
mkdir ~/slinky-tmp
cd ~/slinky-tmp
wget https://github.com/skip-mev/connect/releases/download/v$SERVICE_VERSION/slinky-$SERVICE_VERSION-linux-amd64.tar.gz -O - | tar xvz --strip-components=1
cp slinky $HOME/go/bin/slinky
cd ~
rm -r ~/slinky-tmp
export PATH=$PATH:$HOME/go/bin

echo "Creating $SERVICE_NAME.service..."
sudo rm /etc/systemd/system/$SERVICE_NAME.service
sudo touch /etc/systemd/system/$SERVICE_NAME.service

echo "[Unit]"                               | sudo tee /etc/systemd/system/$SERVICE_NAME.service
echo "Description=Slinky service"           | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "After=network-online.target"          | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo ""                                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "[Service]"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "WorkingDirectory=$SLINKY_HOME"        | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "User=$USER"                           | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "ExecStart=$HOME/go/bin/slinky"        | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "Restart=always"                       | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "RestartSec=3"                         | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "LimitNOFILE=50000"                    | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo ""                                     | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "[Install]"                            | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a
echo "WantedBy=multi-user.target"           | sudo tee /etc/systemd/system/$SERVICE_NAME.service -a

# Start service
sudo systemctl daemon-reload

# Enable and start the service after the genesis that includes the CCV state is in place
sudo systemctl enable $SERVICE_NAME.service
sudo systemctl start $SERVICE_NAME.service
sudo systemctl restart systemd-journald

echo "***********************"
echo "To see the service log enter:"
echo "journalctl -fu $SERVICE_NAME.service"
echo "***********************"
