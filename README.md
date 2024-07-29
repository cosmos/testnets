# Cosmos Hub Testnets

This repository contains current and archived genesis files, scripts, and configurations for Cosmos Hub testnets. Key network information is present here, but please check out the tutorial in the [Cosmos Hub documentation](https://hub.cosmos.network/main/hub-tutorials/join-testnet.html) for step-by-step instructions on how to join whichever testnet is currently running. You can also find legacy network information [here](legacy/).

## Cosmos Hub Testnet Plan

The goals of the Cosmos Hub testnet program are to:

-  Build confidence among validators and full node operators in operating Gaia in daily operations and during upgrades.
-  Educate validators, full node operators, and consumer chain developers about Gaia features and best practices.
-  Provide developers with a low-risk production-like environment to test integrations with Cosmos Hub.

These goals are supported by two persistent testnets which model the Cosmos Hub.

### [Release Testnet](release/) (colloquially referred to as 'Theta')
The release testnet is the first public testnet upgraded with new Gaia releases, followed by the ICS testnet and then Cosmos Hub mainnet. It targets validators who want to participate in a simulated mainnet environment for a single chain (i.e., no consumer chains). It is also used as an IBC connection point for other testnets, such as Osmosis.

We have configured the release testnet so that:
* Testnet coordinators will operate 4+ validators with combined voting power exceeding 75% total power.
* These validators will require an addition of ~550M bonded test ATOM (current bonded ATOM are ~180M) and a corresponding increase in total supply.
* Testnet coordinators control a faucet with >100M liquid tokens, which is accessible via the Cosmos Hub Discord.

### [Interchain Security Persistent Testnet](interchain-security/)

The Interchain Security testnet provides a public platform to explore:
- Launching and stopping consumer chains
- Interchain Security features
- Relayer operations
- Integrations (block explorers, monitors, etc.)

We have configured this testnet so that:
* Testnet coordinators operate 3+ validators with a combined voting power exceeding 66% total power.
* Testnet coordinators control a faucet with >100M liquid tokens.


### [Local Testnet](local/)

A local testnet can be set up to experiment in a local single-validator environment.
