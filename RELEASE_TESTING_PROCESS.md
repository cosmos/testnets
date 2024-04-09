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

GitHub Actions workflows are used to run baseline and version-specific tests for each major upgrade.

* **Pass criteria:** All test workflows for a given version run successfully.
* **Output:** Test report and logs.

### Testnet upgrades

Testnet upgrades are scheduled once a release candidate has passed all tests and is identified as having a 90% chance of reaching the Cosmos Hub as-is by the Gaia integration team. Testnet upgrades are done through governance proposals.

The Release testnet (`theta-testnet-001`) is upgraded to the release candidate first; after it is confirmed as successful, the Interchain Security testnet (`provider`) is upgraded next.

Validators participating in the testnets will be given advance notice that a software upgrade is happening via Discord, at least three days in advance, so they can prepare their nodes accordingly. This repo will be updated with the relevant information so anyone willing to participate in the upgrade can join the testnet ahead of time.

* **Pass criteria:** Blocks are produced with new version after the upgrade height is reached with no indication of unexpected behaviour.
  * Depending on the features included in a specific version, additional checks may be run on the testnet after the upgrade takes place to qualify the release candidate as ready for mainnet.
* **Output:** Upgrade summary.

## Test Results

### Gaia v15

* [Automated testing report](https://github.com/hyphacoop/cosmos-release-testing/blob/main/test-results/gaia-v15/automated-tests.md)
* [Testnet upgrades](https://github.com/hyphacoop/cosmos-release-testing/blob/main/test-results/gaia-v15/testnet-upgrades.md)
