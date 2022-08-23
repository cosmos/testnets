# Cosmos Hub Testnets

This repository contains current and archived genesis files, scripts, and configurations for Cosmos Hub testnets. Key network information is present here, but please check out the tutorial in the [Cosmos Hub documentation](https://hub.cosmos.network/main/hub-tutorials/join-testnet.html) for step-by-step instructions on how to join whichever testnet is currently running. You can also find legacy network information [here](legacy/README.md).

## Cosmos Hub Testnet Plan

The goals of the Cosmos Hub testnet program are to:

-  Build confidence among validators and full node operators to test upcoming software upgrades.
-  Provide developers with a low-risk production-like environment to test integrations with Cosmos Hub.
-  Make historical hub software releases and states readily available for testing and querying.

Beyond these goals, testnets could also become a site for R&D for new development and governance approaches in a fast-moving and live context.

Up until the `Vega` testnet, our approach was to deploy a testnet for each Gaia upgrade.

**Starting with `Theta`, we have moved to a persistent testnet model, which means the `Theta` testnet will stay online and remain the primary Cosmos Hub testnet after the `v7-Theta` upgrade and beyond.**

### Theta

* [Public](theta/public-testnet/README.md)
* [Local](theta/local-testnet/README.md)
* [Developer](theta/devnet/README.md)

Based on our experience with `Vega`, we have configured `Theta` so that:
* Testnet coordinators will operate 4+ validators with combined voting power exceeding 75% total power.
* These validators will require an addition of ~550M bonded test ATOM (current bonded ATOM are ~180M) and a corresponding increase in total supply.
* Tesnet coordinators control a faucet with >175M liquid tokens.
* Testnet coordinators can reward validators with limited edition secondary tokens that are named after their release (`Theta`, `Rho`, `Epsilon`, `Lambda`). The testnets will have a fixed supply of 1000 each of such tokens.

### Vega (deprecated)

* [Public](vega/public-testnet/README.md)
* [Local](vega/local-testnet/README.md)



