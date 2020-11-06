# Bigbang State Migration and Upgrade

We will be performing a state export of the current ```bigbang``` testnet and upgrade to **Stargate** phase of the testnet on Mon, 09 Nov 2020 1500UTC. Due to a minor bug in akash@v0.8.1, exporting state by passing the flag `--height` is not possible. It is recommended for all the validators to upgrade their nodes to [fixed](https://github.com/ovrclk/akash/tree/boz/mainnet/prevent-double-init) version of the binary with halt time specified in `app.toml`.

### Build the fixed binary:
```
cd $GOPATH/src/github.com/ovrclk/akash
git fetch -a && git checkout boz/mainnet/prevent-double-init
make install
```
This will create the fixed version of `akashd` and place it automatically in your `$GOBIN`.

To ensure all the validators stop at the right time, it's recommended for all to edit the `app.toml` file with the right halt-time.
```
nano ~/.akashd/config/app.toml
```
Replace the default value of `halt-time` with `1604934000`. This is time in unix for Mon, 09 Nov 2020 1500UTC. Restart the node with the fixed binary with and `app.toml` modifications.
```
sudo systemctl restart akashd
```

### Migration steps

The node will stop automatically on Mon, 09 Nov 2020 1500UTC if the above steps are performed. Stop your current `akashd` process:
```
sudo systemctl stop akashd
```
State export of the current chain will be taken using this command:
**Note**: Please execute the follwing command only when the node stops on the pre-determined time. 
```
akashd export --for-zero-height --height <last-commit-height> > bigbang_genesis_export.json
```
Please co-ordinate on **#bigbang-testnet** channel to get the right `<last-commit-height>`.

The `export` command will generate the file `bigbang_genesis_export.json` with the state export. Verify the sha256 sum of the file
```
jq -S -c -M '' bigbang_genesis_export.json | shasum -a 256
```
Hash of the file: **TBA**

#### Build the bigbang binary
```
cd $GOPATH/src/github.com/ovrclk/akash
git fetch -a && git checkout bigbang
make all
```
This will create `akashd` binary built on stargate release. Copy the binary to your `$GOBIN`.
```
cp akashd $GOBIN
```

With the stargate release binary of `akashd`, migrate the genesis to `v0.40`.
```
akashd migrate v0.40 bigbang_genesis_export.json > new_v40_genesis.json
```
Verify the sha256 sum of the new genesis file

```
jq -S -c -M '' new_v40_genesis.json | shasum -a 256
```
Hash of the file: **TBA**

Replace the original genesis with the new v40 genesis:

```
cp new_v40_genesis.json ~/.akasd/config/genesis.json
```

New genesis file will be pushed to this repo for validators after being generated.

#### Reset the state and restart:

**Note**: It is recommended to take a backup of the data before wiping the state in case of a rollback.
```
akashd unsafe-reset-all
```

Start `akashd` process with the new genesis file:
```
sudo systemctl start akashd
```
