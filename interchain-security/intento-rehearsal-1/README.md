# **Joining the Intento Mainnet Rehearsal (ICS)**

This is the **Intento Consumer Chain** (Consumer ID `148`) under Cosmos Hub Provider chain’s **Interchain Security (ICS)**. If you’ve run ICS consumers, this will feel familiar — but read carefully.

---

## **Before You Start**

- **Provider Requirement**: You must run a synced provider testnet node.
- **Consumer ID**: `148`
- **Chain ID**: `intento-rehearsal-1`
- **Binary**: `intentod`

---

## **1. Prepare the Consumer Node**

**Hardware Minimums:**

| CPU     | RAM   | Storage    | Network   |
| ------- | ----- | ---------- | --------- |
| 4 cores | 16 GB | 200 GB SSD | 100 Mbps+ |

**Software:**

- Linux 20.04+
- Go 1.24.6+
- wasmvm v2.2.4

**Build Binary:**

```bash
git clone https://github.com/trstlabs/intento.git
cd intento
git checkout v1.0.0-beta.1
make install
intentod version
```

**Init Consumer Config:**

```bash
intentod init [moniker] --chain-id intento-rehearsal-1
```

**Download Genesis (placeholder until spawn time passes and ccv is available):**

```bash
curl -o $HOME/.intento/config/genesis.json \
  https://github.com/cosmos/testnets/raw/master/interchain-security/intento-rehearsal-1/intento-rehearsal-1-genesis-with-ccv.json
```

**Replace Validator Key (validators only):**

```bash
mv /path/to/priv_validator_key.json \
   $HOME/.intento/config/priv_validator_key.json
```

_Do this **before** starting node to avoid double signing._

**Configure Networking:**

```bash
SEED="<seed1@ip:port,seed2@ip:port>"
PEERS="<peer1@ip:port,peer2@ip:port>"

config="$HOME/.intento/config/config.toml"
app="$HOME/.intento/config/app.toml"
client="$HOME/.intento/config/client.toml"

ATOM="ibc/C4CFF46FD6DE35CA4CF4CE031E643C8FDC9BA4B99AE598E9B0ED98FE3A2319F9"

sed -i "s|^seeds *=.*|seeds = \"$SEED\"|" $config
sed -i "s|^persistent_peers *=.*|persistent_peers = \"$PEERS\"|" $config
sed -i "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.005uinto,0.001$ATOM\"|" $app
sed -i "s|^chain-id *=.*|chain-id = \"intento-rehearsal-1\"|" $client
```

---

## **2. Opt-in on Cosmos Hub**

**Build Gaia:**

```bash
git clone https://github.com/cosmos/gaia.git
cd gaia
git checkout v25.1.0
make install
gaiad version
```

**Get Consumer Consensus Pubkey:**

```bash
intentod tendermint show-validator
```

**Opt-in (replace `[YOUR_KEY]`):**

```bash
gaiad tx provider opt-in 148 <consumer-pubkey> \
  --from [YOUR_KEY] \
  --chain-id cosmoshub-4 \

```

**Verify Opt-in:**

```bash
gaiad q provider consumer-opted-in-validators 148 \
  --chain-id cosmoshub-4 \
```

---

## **3. Start the Consumer Node**

**Direct Run:**

```bash
intentod start
```

**Systemd (recommended):**

```bash
sudo tee /etc/systemd/system/intentod.service <<EOF
[Unit]
Description=Intento Consumer Node
After=network.target

[Service]
User=$USER
ExecStart=$(which intentod) start
Restart=always
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable intentod
sudo systemctl start intentod
journalctl -u intentod -f -o cat
```

Once 2/3 Hub voting power is running, blocks will produce.

That's it! Keep an eye in the Discord. We will signal when we're ready so you can clean up your environment.

