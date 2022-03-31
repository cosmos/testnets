# Cosmos Hub Testnets

This repository contains current and archived genesis files, scripts, and configurations for Cosmos Hub testnets. Key network information is present here, but please check out the tutorial in the [Cosmos Hub documentation](https://hub.cosmos.network/main/hub-tutorials/join-testnet.html) for step-by-step instructions on how to join whichever testnet is currently running. You can also find legacy network information [here](legacy/README.md).

## v7-Theta

* [Public](v7-theta/public-testnet/README.md)
* [Local](v7-theta/local-testnet/README.md)
* [Developer](v7-theta/devnet/README.md)

## v6-Vega (deprecated)

* [Public](v6-Vega/public-testnet/README.md)
* [Local](v6-Vega/local-testnet/README.md)


## Cosmos Hub Testnet Plan

The goals of the Cosmos Hub testnet program are to:

-  Build confidence among validators and full node operators to test upcoming software upgrades.
-  Provide developers with a low-risk production-like environment to test integrations with Cosmos Hub.
-  Make historical hub software releases and states readily available for testing and querying.
  
Beyond these goals, testnets could also become a site for R&D for new development and governance approaches in a fast-moving and live context.

We are expecting the roll out as follows:

### 1. Rolling testnets for each gaia upgrade.

These testnets aim to help validators set up robust automation around upgrades using Cosmovisor. This phase includes working directly with validators to understand current pain points and develop tools and processes to support their workflows. The `v6-vega` testnet was in Q4 2021 and we are currently working on `v7-Theta` testnet for Q1 2022.

Based on learnings from vega, we will configure `v7-Theta` so that:
* Testnet coordinators will operate 4+ validators with combined voting power exceeding 75% total power
* These validators will require an addition of ~550M bonded test ATOM (current bonded ATOM are ~180M) and a corresponding increase in total supply.
* Tesnet coordinators control a faucet with >175M liquid tokens
* Testnet coordinators can reward validators with limited edition secondary tokens that are named after their release (`Theta`, `Rho`, `Epsilon`, `Lambda`). The testnets will have a fixed supply of 1000 each of such tokens.

### 2. Persistent testnet.

After the `v7-Theta` testnet we will assess whether we can continue using the same testnets on a persistent basis for future upgrades.
