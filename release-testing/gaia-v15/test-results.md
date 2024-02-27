# Gaia v15 Upgrade Test Results

* **Target version:** `v15.0.0-rc2`
* **Starting version:** `v14.1.0`
* **Minimum hardware requirements for stateful upgrade**
  * 8 cores
  * 64GB memory + 64GB swap
* **Recommended hardware requirements for stateful upgrade**
  * 8 cores
  * 128GB memory
  * NVME storage

## Test Summary

Upgrade workflows use two starting points: fresh and stateful genesis.

* Fresh genesis: A genesis file is initialized with three validators and the chain starts at height 1.
* Stafeul genesis: A genesis file is periodically exported from a Cosmos Hub node and modified to provide a single validator with a majority voting power so it can start producing blocks on its own.

### Baseline

| Test                      | Fresh | Stateful |
| ------------------------- | ----- | -------- |
| Transactions              | PASS  | PASS     |
| API endpoints             | PASS  | PASS     |
| RPC endpoints             | PASS  | PASS     |
| globalfee                 | PASS  | N/A      |
| Consumer chain launches   | PASS  | N/A      |
| packet-forward-middleware | PASS  | N/A      |
| Liquid Staking Module     | PASS  | N/A      |
| Mainnet consumer chains   | PASS  | N/A      |

### v15-specific

| Test                    | Fresh | Stateful |
| ----------------------- | ----- | -------- |
| Minimum commission      | PASS  | N/A      |
| Minimum deposit         | PASS  | N/A      |
| Voting requirements     | PASS  | N/A      |
| Unvested funds transfer | PASS  | PASS     |

## Baseline test details

* Transactions
   * tx bank send
   * tx staking delegate
   * tx distribution withdraw-all-rewards
   * tx staking unbond
 * API endpoints
 * RPC endpoints
 * globalfee
   * Check tx result under different gas prices combinations
     * node > globalfee > tx: FAIL
     * node > tx > globalfee: FAIL
     * tx > node > globalfee: PASS
     * globalfee > node > tx: FAIL
     * globalfee > tx > node: FAIL
     * tx > globalfee > node: PASS
* Consumer chain launches
   * Verify CCV channel is established
   * Test IBC transfers
   * Test soft opt-out
   * ICS versions:
     * v3.1.0
     * v3.2.0
     * v3.3.0
     * v4.0.0
* packet-forward-middleware
   * Test two-way IBC transfers:
     * A>B>C>D: **Test chain** -> pfm1 chain -> pfm2 chain -> pfm3 chain
     * D>C>B>A: pfm3 chain -> pfm2 chain -> pfm1 chain -> **test chain**
* Liquid Staking Module
   * Bond
   * Tokenize
   * Transfer ownership of liquid tokens
   * ICA delegation

### v15-specific test details

1. Minimum commission set to 5%
   * `min_commission_rate` staking parameter must be set to `0.05`
   * Validators with <5% prior to the upgrade must have 5% afterwards
2. Minimum deposit
   * `min_deposit_ratio` gov parameter must be set to `0.01`
   * Deposits with <1% of the `min_deposit` parameter amount must not be accepted
3. Voting requirements
   * Voting transactions must not be accepted if the voter has less than 1ATOM staked
4. Unvested funds transfer
   * Vesting account: cosmos145hytrc49m0hn6fphp8d5h4xspwkawcuzmx498
     * Account must be a BaseAccount type
     * Community pool balance must increase by at least the unvested amount of the vesting account

## Relayer version

* Hermes v1.8.0

## Cosmovisor versions

Cosmovisor-based upgrades are tested with the auto-download feature both turned on and off.

* v1.5.0
* v1.4.0
* v1.3.0
