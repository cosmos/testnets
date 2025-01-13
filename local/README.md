# Local Testnet Upgrade

The [script](./simulate_mainnet_upgrade.sh) in this folder will help you simulate a Cosmos Hub `v22` upgrade with a single-validator fork. You need to provide links to genesis and snapshot files.

- Starting Gaia version: `v21.0.1`
- Post-upgrade Gaia version: `v22.0.0-rc0`

The script uses a special build of Gaia to fork the chain with a single validator using a recent snapshot. The upgrade is performed by the one validator running the chain.
* The forked chain will contain the existing state from the chain we are simulating the upgrade on, but the voting period will be set to 20 seconds (this can be modified with further param change proposals).

If you are interested in running a forked node without going through the upgrade, you can edit the script to stop before the upgrade section.

## Cosmovisor: Manual binary setup

The script uses the auto-download feature of Cosmovisor for convenience. Node runners can manually build the new binary and put it into the relevant `upgrades` folder as shown below. Cosmovisor will switch to the new binary when the upgrade height is reached.

```
$NODE_HOME/cosmovisor/upgrades/v17/bin/gaiad
```

**Cosmovisor directory structure**

```shell
.
├── current -> genesis or upgrades/<name>
├── genesis
│   └── bin
│       └── gaiad
└── upgrades
    └── v22
        ├── bin
        │   └── gaiad
        └── upgrade-info.json
```
