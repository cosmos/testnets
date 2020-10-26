# The Stargate Upgrade

Stargate upgrade is to test the upgrade path from `cosmos-sdk@0.39.x` to `stargate` release. The current `bigbang-1` testnet 
is using `cosmos-sdk@0.39.1` and the upgrade will change the software to which uses `cosmos-sdk@v0.40.0-rc1`.

## `stargate` - Software upgrade proposal
**Proposal ID:** 1

**Title:** Stargate Upgrade Proposal

**Description:** Stargate upgrade proposal is to upgrade the current Bigbang testnet to use stargate version of the software. 
Stargate compatible version is available on *bigbang* branch of the Akash Network repo (https://github.com/ovrclk/akash/tree/bigbang). 
This upgrade focuses on testing the upgrade path from 0.39 to stargate release candidate (i.e.cosmos-sdk@v0.40.0-rc1). In case of any upgrade issues, 
network with continue with old binary (akash@v0.8.1) using `akashd skip-upgrade <height>` option. Here height will be the height of 
the network before upgrade + 1.

**Upgrade Time:** 30th Oct 2020, 1500UTC

**Explorer Links:** https://bigbang.aneka.io/proposals/1 https://bigbang.bigdipper.live/proposals/1

**Voting Period Start Time:** 26th Oct 2020, 1500UTC 

**Voting Period End Time:** 28th Oct 2020, 1500UTC 

## How to Vote for the proposal

```sh
akashctl tx gov vote 1 yes --from <your_key>
```
Note: Though there are different options for voting, it is adviced to vote "yes" as this proposal is about testing the upgrade path itself.
 
## How to upgrade 
[TBD]

## What if the upgrade fails?

If the scheduled upgrade fails, the network will resume with old software (akash@0.8.1). The validators would need to `skip` the upgrade in-order to 
make the old binary work. Following commad will skip the upgrade and start the validator node with old binary.

```sh
akashd start --skip-upgrade <height>
```
`height` here will be the next block height of the network (i.e., halt-height + 1).
