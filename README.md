# Cosmos Hub Testnets

This repository contains current and archived genesis files, scripts, and configurations for Cosmos Hub testnets. You can also find legacy network information [here](legacy/).

## Cosmos Hub Testnet Plan

The goals of the Cosmos Hub testnet program are to:

-  Build confidence among validators and full node operators in operating Gaia in daily operations and during upgrades.
-  Educate validators, full node operators, and consumer chain developers about Gaia features and best practices.
-  Provide developers with a low-risk production-like environment to test integrations with Cosmos Hub.

These goals are supported by a persistent testnet using similar, if not identical, parameters to the Cosmos Hub.

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

A local testnet can be set up to experiment in a single-validator environment.
