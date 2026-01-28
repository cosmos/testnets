# How to upgrade your node

There are two major kinds of upgrades:
* Governance gated
* Non-governance gated

In both cases, you can upgrade your node by replacing the binary manually or using Cosmovisor.


## Governance Gated Upgrade

A governance gated upgrade occurs when an upgrade plan goes on chain through a software upgrade proposal.
* Your node **will** stop at the height listed in the upgrade plan.

You can query the upgrade name for governance-gated upgrades with the following command:
```
gaiad q upgrade plan
plan:
  height: "15759100"
  info: '{"binaries": {"darwin/amd64": "https://github.com/cosmos/gaia/releases/download/v26.0.0-rc0/gaiad-v26.0.0-rc0-darwin-amd64?checksum=sha256:2a83c58734274cba27eac2651967a6c3f271bb66009551a2a37ec4ff8aa1c22e",
    "darwin/arm64": "https://github.com/cosmos/gaia/releases/download/v26.0.0-rc0/gaiad-v26.0.0-rc0-darwin-arm64?checksum=sha256:ebfa99daf57165a741d0fb3869dddff37990f85df3fc393cabc58fe6b572952f",
    "linux/amd64": "https://github.com/cosmos/gaia/releases/download/v26.0.0-rc0/gaiad-v26.0.0-rc0-linux-amd64?checksum=sha256:cb83ab849c61a8450bf7389a12424700e3bd416ab44ced823e25d5d426dfa243",
    "linux/arm64": "https://github.com/cosmos/gaia/releases/download/v26.0.0-rc0/gaiad-v26.0.0-rc0-linux-arm64?checksum=sha256:f67cfdebed6e0b8f9213076db0770a8db8a89b0b029719e36420a618cafd6fb0"}}'
  name: v26.0.0
  time: "0001-01-01T00:00:00Z"
```

### Manual Binary Upgrade

1. Build or download the binary for the release you are upgrading to.
2. Wait for the node to stop at the upgrade height.
   * The log will display something like this:
     ```
     ERR UPGRADE "v26.0.0" NEEDED at height: 15759100: upgrade to v26.0.0 and applying upgrade "v26.0.0" at height:15759100
     ```
  * If the node service remains active, you can stop it now.
3. Replace the binary listed in the unit file with the new release.
4. Start the node service again.

### Cosmovisor Upgrade

1. Build or download the binary for the release you are upgrading to.
2. Create a folder for the new binary in the relevant Cosmovisor directory.
   * If the upgrade name is `v26.0.0`, you would place the binary under `<node home>/cosmovisor/upgrades/v26.0.0/bin/gaiad`:
     ```
     .
     ├── current -> genesis or upgrades/<name>
     ├── genesis
     │   └── bin
     │       └── gaiad  # old: v25.3.2
     └── upgrades
         └── v26.0.0
             └── bin
                 └── gaiad  # new: v26.0.0
     ```
3. Verify that Cosmovisor will use the binary you have prepared.
   * The Cosmovisor service should have the auto-download feature disabled. A sample Cosmovisor unit file will look like this:
     ```
     [Unit]
     Description=Cosmovisor service
     After=network-online.target
     
     [Service]
     User=gaia
     ExecStart=/gaia/go/bin/cosmovisor run start --home /gaia/.gaia
     Restart=no
     LimitNOFILE=50000
     Environment='DAEMON_NAME=gaiad'
     Environment='DAEMON_HOME=/gaia/.gaia'
     Environment='DAEMON_ALLOW_DOWNLOAD_BINARIES=false'
     Environment='DAEMON_RESTART_AFTER_UPGRADE=true'
     Environment='DAEMON_LOG_BUFFER_SIZE=512'
     Environment='UNSAFE_SKIP_BACKUP=true'
     
     [Install]
     WantedBy=multi-user.target
     ```
  * If you must change the contents of the unit file, run `systemctl daemon-reload` before restarting the service.
4. Wait for the node to reach the upgrade height. Cosmovisor will restart the node using the new binary.


## Non-governance Gated Upgrade

A non-governance gated upgrade occurs when nodes upgrade their binary at an agreed-upon height.

* You **must** stop your node at the relevant height and replace the binary before starting it again.
* ⚠️ Monitor your logs when the halt height is about to be reached. If your node does not stop at the specified height using the instructions below, stop the service manually and replace the binary before starting the service again.

### Manual Binary Upgrade

1. Build or download the binary for the release you are upgrading to.
2. Stop the node service.
3. Update the app.toml file in your node's config folder to set the `halt-height` variable.
   * A sample app.toml line will look like this for an upgrade height of `11620400`:
     ```
     halt-height = 11620400
     ```
4. Restart the service.
5. Wait for the halt height. 
   * The log will display something like this when height is reached:
     ```
     ERR CONSENSUS FAILURE!!! err="failed to apply block; error halt per configuration height 11620400 time 0" 
     ```
7. Stop the node service.
8. Replace the binary listed in the unit file with the new release.
   * For Cosmovisor, this will be `<node home>/cosmovisor/current/bin/gaiad`.
9.  Update app.toml to set the `halt-height` back to 0.
10. Start the node service.

### Cosmovisor `add-upgrade`

#### ⚠️ Be aware that there are reported issues with using Cosmovisor for non-governance upgrades: the instructions below may result in unexpected behaviour, such as an immediate upgrade or failure to stop at the specified height.

1. Build or download the binary for the release you are upgrading to.
2. Run the `add-upgrade` command. This command will look as follows using the example values listed below.
   * New binary: `gaiad-v23.1.1-linux-amd64`
   * Upgrade name: `v23.1.1`
   * Halt height: `11620400`
   ```
   cosmovisor add-upgrade v23.0.0 gaiad-v23.1.1-linux-amd64 --upgrade-height 11620399 --force
   ```
3. Wait for the node to reach the upgrade height. Cosmovisor will restart the node using the new binary.
