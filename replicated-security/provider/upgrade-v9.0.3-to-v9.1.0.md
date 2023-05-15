# Upgrading provider chain from Gaia v9.0.3 to v9.1.0

We will be upgrading the provider chain on Wednesday, May 17 2023. This upgrade has already been applied on mainnet as an emergency upgrade.

Key information

| Block height | 1538100 |
| Golang version | 1.18.x |

## ❗Halt height settings

As the upgrade is a non-governance upgrade, the halt height needs to be manually set. You can do this one of the following ways, see here for more information. You must:

Set the halt-height configuration parameter in your config/app.toml
Or pass the --halt-height flag to gaiad with the block height specified

App.toml example:

If you use this method, you MUST restart the node for the halt-height to be activated.

# halt and shutdown that can be used to assist upgrades and testing.
halt-height = 1538100

Gaiad start example:

gaiad start --halt-height 1538100

## ❗Avoiding double signing errors

To avoid the potential for double signing, make sure that you backup your priv_validator_state.json file and make sure that you are using the same file if moving machines etc. We recommend that you do not switch machines during this process. Instead, go down at the halt height, and come back up afterward on the same machine with the same data-dir using the new binary. 

Do NOT start multiple machines with the same priv_validator_state.json, your validator will be tombstoned and you will be slashed. 
Do NOT use unsafe-reset-all, as that will destroy your priv_validator_state.json file.

## ❗Dealing with stuck nodes

Do NOT restart your node, it might take some time to reach consensus. Monitor the `#replicated-security` channel for more information/instructions as the upgrade progresses.

Support

Please don’t hesitate to ask for help.  Key to doing this well, is for as many validators as possible to halt at the same time.  We’re on standby to help with the halt height setup. 

Before the time of the upgrade, please monitor the Interchain Security `#announcements` channel on Cosmos Discord, and be sure to be in`#replicated-security` channel where you can get support for the upgrade. 
Please reach out to the Discord admins if you’re not already in the #cosmos-hub-validators-verified channel.
