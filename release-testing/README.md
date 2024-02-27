# Release Testing

This section provides:

* A summary of the process used by Hypha to qualify upcoming Gaia versions as mainnet-ready.
* A record of testing results for major Gaia upgrades.

## Release Testing Process

The release testing process can be split into three phases for each major release.

1. Planning
   * A set of test requirements is tailored for each upcoming release.
2. Development
   * Automated testing using nightly builds.
3. Release verification
   * Automated testing using release candidate builds.
   * Testnet upgrades

### Automated testing

GitHub Actions workflows are used to run baseline and version-specific tests for each major upgrade. Upgrade workflows use starting points: fresh and stateful genesis.

* **Pass criteria:** All test workflows for a given version run successfully.
* **Output:** Test report and logs.

#### Fresh genesis

A genesis file is initialized with three validators and the chain starts at height 1.

#### Stateful genesis

A genesis file is periodically exported from a Cosmos Hub node and modified to provide a single validator with a majority voting power so it can start producing blocks after rebuilding a stateful database.

### Testnet upgrades

Testnet upgrades are scheduled once a release candidate has passed all tests and is identified as having a 90% chance of reaching the Cosmos Hub as-is by the Gaia integration team.

The Release testnet (`theta-testnet-001`) is upgraded to the release candidate, and after it is confirmed as successful, the Replicated Security testnet (`provider`) is upgraded next.

Testnet upgrades are done through governance proposals.

Validators participating in the testnets will be given advance notice that a software upgrade is happening via Discord, at least three days in advance, so they can prepare their nodes accordingly.

This testnets repo will be updated with the relevant information so anyone willing to participate in the upgrade can join the testnet ahead of time.

* **Pass criteria:** Blocks are produced with new version after the upgrade height is reached with no indication of unexpected behaviour.
  * Depending on the features included in a specific version, additional checks may be run on the testnet after the upgrade takes place to qualify the release candidate as ready for mainnet.
* **Output:** Upgrade summary.
