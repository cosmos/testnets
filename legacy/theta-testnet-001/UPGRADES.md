# Scheduled Upgrades 🗓️ 

## v22.0.0-rc0

### Schedule

| Date       | Testnet plan                                                                                  |
| ---------- | --------------------------------------------------------------------------------------------- |
| 2024-12-11 | Gaia v22.0.0-rc0 is live on the testnet                                                     |
| 2024-12-10 | Submit and pass upgrade proposal |

* **Version before upgrade**: `v21.0.1`
* **Version after upgrade**: `v22.0.0-rc0`

### Upgrade details

* Proposal ID: TBD
* **Upgrade height: `TBD`**
  * Mintscan countdown: https://www.mintscan.io/cosmos-testnet/block/TBD
  * Estimated upgrade time: `TBD`
* Release page: https://github.com/cosmos/gaia/releases/tag/v22.0.0-rc0

## v21.0.1

### Schedule

| Date       | Testnet plan                        |
| ---------- | ----------------------------------- |
| 2024-11-21 | Gaia v21.0.1 is live on the testnet |

* **Version before upgrade**: `v21.0.0-rc1`
* **Version after upgrade**: `v21.0.1`

### Upgrade details

* Patch upgrade
* Not consensus-breaking
* No upgrade height or halt-height required
* Replace the binary at your earliest convenience

## v21.0.0-rc1

### Schedule

| Date       | Testnet plan                            |
| ---------- | --------------------------------------- |
| 2024-10-23 | Gaia v21.0.0-rc1 is live on the testnet |

* **Version before upgrade**: `v21.0.0-rc0`
* **Version after upgrade**: `v21.0.0-rc1`

### Upgrade details

* **Upgrade height: `24171100`**
  * Mintscan countdown: https://www.mintscan.io/cosmos-testnet/block/24171100
  * Estimated upgrade time: `2024-10-24 ~13:30 UTC`
* Release page: https://github.com/cosmos/gaia/releases/tag/v21.0.0-rc1
* ⚠️ This is **not** a governance-gated upgrade. You must do one of the following ahead of time:
  * Set the upgrade height in your node(s) `app.toml` and restart the node(s).
    ```
    halt-height = 24171100
    ```
  * Restart your node(s) with the `--halt-height 24171100` flag.

## v21.0.0-rc0

### Schedule

| Date       | Testnet plan                                                                                  |
| ---------- | --------------------------------------------------------------------------------------------- |
| 2024-10-16 | ✅ Gaia v21.0.0-rc0 is live on the testnet                                                     |
| 2024-10-15 | ✅ Submit and pass [upgrade proposal](https://explorer.polypore.xyz/theta-testnet-001/gov/324) |

* **Version before upgrade**: `v20.0.0`
* **Version after upgrade**: `v21.0.0-rc0`

### Upgrade details

* Proposal ID: [324](https://explorer.polypore.xyz/theta-testnet-001/gov/324)
* **Upgrade height: `24061350`**
  * Mintscan countdown: https://www.mintscan.io/cosmos-testnet/block/24061350
  * Estimated upgrade time: `2024-10-16 ~13:00 UTC`
* Release page: https://github.com/cosmos/gaia/releases/tag/v21.0.0-rc0

## v20.0.0

### Schedule

| Date       | Testnet plan                        |
| ---------- | ----------------------------------- |
| 2024-10-09 | Gaia v20.0.0 is live on the testnet |
| 2024-10-08 | Set upgrade halt height             |

* **Version before upgrade**: `v20.0.0-rc0`
* **Version after upgrade**: `v20.0.0`

### Upgrade details

* Estimated upgrade time: `2024-10-09 ~13:30 UTC`
* **Upgrade height: `23952300`**
  * Mintscan countdown: https://www.mintscan.io/cosmos-testnet/block/23952300
* Release page: https://github.com/cosmos/gaia/releases/tag/v20.0.0
* ⚠️ This is **not** a governance-gated upgrade. You must do one of the following ahead of time:
  * Set the upgrade height in your node(s) `app.toml` and restart the node(s).
    ```
    halt-height = TBD
    ```
  * Restart your node(s) with the `--halt-height TBD` flag.
* After the halt height is reached and your node is stopped:
  * Replace the `gaiad` binary with the new one and restart the node after reverting to `halt-height = 0` in `app.toml` (or restart the node without the `--halt-height` flag).

## v20.0.0-rc0

### Schedule

| Date       | Testnet plan                                                                                  |
| ---------- | --------------------------------------------------------------------------------------------- |
| 2024-09-18 | ✅ Gaia v20.0.0-rc0 is live on the testnet                                                     |
| 2024-09-17 | ✅ Submit and pass [upgrade proposal](https://explorer.polypore.xyz/theta-testnet-001/gov/323) |

* **Version before upgrade**: `v19.2.0`
* **Version after upgrade**: `v20.0.0-rc0`

### Upgrade details

* Proposal ID: [323](https://explorer.polypore.xyz/theta-testnet-001/gov/323)
* **Upgrade height: `23626900`**
  * Mintscan countdown: https://www.mintscan.io/cosmos-testnet/block/23626900
  * Estimated upgrade time: `2024-09-18 ~13:30 UTC`
* Release page: https://github.com/cosmos/gaia/releases/tag/v20.0.0-rc0

## v19.1.0

### Schedule

| Date       | Testnet plan                          |
| ---------- | ------------------------------------- |
| 2024-08-22 | ✅ Gaia v19.1.0 is live on the testnet |
| 2024-08-21 | ✅ Set upgrade halt height             |

* **Version before upgrade**: `v19.0.0-rc4`
* **Version after upgrade**: `v19.1.0`

### Upgrade details

* Estimated upgrade time: `2024-08-22 ~14:30 UTC`
* **Upgrade height: `23209000`**
  * Mintscan countdown: https://www.mintscan.io/cosmos-testnet/block/23209000
* Release page: https://github.com/cosmos/gaia/releases/tag/v19.1.0
* ⚠️ This is **not** a governance-gated upgrade. You must do one of the following ahead of time:
  * Set the upgrade height in your node(s) `app.toml` and restart the node(s).
    ```
    halt-height = 23209000
    ```
  * Restart your node(s) with the `--halt-height 23209000` flag.
* After the halt height is reached and your node is stopped:
  * Replace the `gaiad` binary with the new one and restart the node after reverting to `halt-height = 0` in `app.toml` (or restart the node without the `--halt-height` flag).

## v19.0.0-rc4

### Schedule

| Date       | Testnet plan                            |
| ---------- | --------------------------------------- |
| 2024-08-07 | Gaia v19.0.0-rc4 is live on the testnet |
| 2024-08-06 | ✅ Set upgrade halt height               |

* **Version before upgrade**: `v19.0.0-rc3`
* **Version after upgrade**: `v19.0.0-rc4`

### Upgrade details

* Estimated upgrade time: `2024-08-07 ~13:30 UTC`
* **Upgrade height: `22977700`**
  * Mintscan countdown: https://www.mintscan.io/cosmoshub-testnet/block/22977700
* Release page: https://github.com/cosmos/gaia/releases/tag/v19.0.0-rc4
* ⚠️ This is **not** a governance-gated upgrade. You must do one of the following ahead of time:
  * Set the upgrade height in your node(s) `app.toml` and restart the node(s).
    ```
    halt-height = 22977700
    ```
  * Restart your node(s) with the `--halt-height 22977700` flag.
* After the halt height is reached and your node is stopped:
  * Replace the `gaiad` binary with the new one and restart the node after reverting to `halt-height = 0` in `app.toml` (or restart the node without the `--halt-height` flag).

## v19.0.0-rc3

### Schedule

| Date       | Testnet plan                              |
| ---------- | ----------------------------------------- |
| 2024-07-24 | ✅ Gaia v19.0.0-rc3 is live on the testnet |
| 2024-07-23 | ✅ Set upgrade halt height                 |

* **Version before upgrade**: `v19.0.0-rc0`
* **Version after upgrade**: `v19.0.0-rc3`

### Upgrade details

* Estimated upgrade time: `2024-07-31 ~13:30 UTC`
* **Upgrade height: `22869650`**
  * Mintscan countdown: https://www.mintscan.io/cosmoshub-testnet/block/22869650
* Release page: https://github.com/cosmos/gaia/releases/tag/v19.0.0-rc3
* ⚠️ This is **not** a governance-gated upgrade. You must do one of the following ahead of time:
  * Set the upgrade height in your node(s) `app.toml` and restart the node(s).
    ```
    halt-height = 22869650
    ```
  * Restart your node(s) with the `--halt-height 22869650` flag.
* After the halt height is reached and your node is stopped:
  * Replace the `gaiad` binary with the new one and restart the node after reverting to `halt-height = 0` in `app.toml` (or restart the node without the `--halt-height` flag).

## v19.0.0-rc0

### Schedule

| Date       | Testnet plan                                                                                  |
| ---------- | --------------------------------------------------------------------------------------------- |
| 2024-07-24 | ✅ Gaia v19.0.0-rc0 is live on the testnet                                                     |
| 2024-07-23 | ✅ Submit and pass [upgrade proposal](https://explorer.polypore.xyz/theta-testnet-001/gov/301) |

* **Version before upgrade**: `v18.1.0`
* **Version after upgrade**: `v19.0.0-rc0`

### Upgrade details

* Estimated upgrade time: `2024-07-24 ~13:30 UTC`
* **Upgrade height: `22760800`**
  * Mintscan countdown: https://www.mintscan.io/cosmoshub-testnet/block/22760800
* Release page: https://github.com/cosmos/gaia/releases/tag/v19.0.0-rc0

## v18.1.0

### Schedule

| Date         | Testnet plan                              |
| ------------ | ----------------------------------------- |
| July 10 2024 | ✅ Gaia v18.1.0-rc3 is live on the testnet |
| July 09 2024 | ✅ Set upgrade halt height                 |

* **Version before upgrade**: `v18.0.0-rc3`
* **Version after upgrade**: `v18.1.0`

### Upgrade details

* **Upgrade height: `22545200`**
* Estimated upgrade time: `2024-07-10 ~14:00 UTC`
  * [Mintscan countdown](https://www.mintscan.io/cosmoshub-testnet/block/22545200)
* Release page: https://github.com/cosmos/gaia/releases/tag/v18.1.0
* ⚠️ This is **not** a governance-gated upgrade. You must do one of the following ahead of time:
  * Set the upgrade height in your node(s) `app.toml` and restart the node(s).
    ```
    halt-height = 22545200
    ```
  * Restart your node(s) with the `--halt-height 22545200` flag.
* After the halt height is reached and your node is stopped:
  * Replace the `gaiad` binary with the new one and restart the node after reverting to `halt-height = 0` in `app.toml` (or restart the node without the `--halt-height` flag).

## v18.0.0-rc3

### Schedule

| Date         | Testnet plan                              |
| ------------ | ----------------------------------------- |
| June 26 2024 | ✅ Gaia v18.0.0-rc3 is live on the testnet |
| June 25 2024 | ✅ Set upgrade halt height                 |

* **Version before upgrade**: `v17.2.0`
* **Version after upgrade**: `v18.0.0-rc3`

### Upgrade details

* **Upgrade height: `22329350`**
* Estimated upgrade time: `2024-06-26 ~13:00 UTC`
  * [Mintscan countdown](https://www.mintscan.io/cosmoshub-testnet/block/22329350)
* Release page: https://github.com/cosmos/gaia/releases/tag/v18.0.0-rc3

## v17.2.0

### Schedule

| Date         | Testnet plan                          |
| ------------ | ------------------------------------- |
| June 12 2024 | ✅ Gaia v17.2.0 is live on the testnet |
| June 11 2024 | ✅ Set upgrade halt height             |

* **Version before upgrade**: `v17.0.0-rc0`
* **Version after upgrade**: `v17.2.0`

### Upgrade details

* **Upgrade height: `22113300`**
* Estimated upgrade time: `2024-06-12 ~13:00 UTC`
* Release page: https://github.com/cosmos/gaia/releases/tag/v17.2.0
* ⚠️ This is **not** a governance-gated upgrade. You must do one of the following ahead of time:
  * Set the upgrade height in your node(s) `app.toml` and restart the node(s).
    ```
    halt-height = 22113300
    ```
  * Restart your node(s) with the `--halt-height 22113300` flag.
* After the halt height is reached and your node is stopped:
  * Replace the `gaiad` binary with the new one and restart the node after reverting to `halt-height = 0` in `app.toml` (or restart the node without the `--halt-height` flag).

## v17.0.0-rc0

### Schedule

| Date       | Testnet plan                                                                                               |
| ---------- | ---------------------------------------------------------------------------------------------------------- |
| May 8 2024 | ✅ Gaia `v17.0.0-rc0` is live on the testnet                                                                |
| May 7 2024 | ✅ Submit and pass v17 software upgrade [proposal](https://explorer.polypore.xyz/theta-testnet-001/gov/249) |

* **Version before upgrade**: `v16.0.0`
* **Version after upgrade**: `v17.0.0-rc0`

### Upgrade details

* **Upgrade height: `21,572,600`**
* Estimated upgrade time: `2024-05-08 13:30 UTC`
  * [Mintscan countdown](https://www.mintscan.io/cosmoshub-testnet/block/21572600)

## v16.0.0-rc2

### Schedule

| Date          | Testnet plan                                                                                               |
| ------------- | ---------------------------------------------------------------------------------------------------------- |
| April 24 2024 | ✅ Gaia `v16.0.0-rc2` is live on the testnet                                                                |
| April 23 2024 | ✅ Submit and pass v16 software upgrade [proposal](https://explorer.polypore.xyz/theta-testnet-001/gov/246) |

* **Version before upgrade**: `v15.2.0`
* **Version after upgrade**: `v16.0.0-rc2`

### Upgrade details

* **Upgrade height: `21356800`**
* Estimated upgrade time: `2024-04-24 13:30 UTC`

## v15.2.0-rc0

### Schedule

| Date         | Testnet plan                              |
| ------------ | ----------------------------------------- |
| April 3 2024 | ✅ Gaia v15.2.0-rc0 is live on the testnet |
| April 2 2024 | ✅ Set upgrade halt height: `21040550`     |

* **Version before upgrade**: `v15.1.0`
* **Version after upgrade**: `v15.2.0-rc0`

### Upgrade details

* **Upgrade height: `21040550`**
* Estimated upgrade time: `2024-04-03 ~13:30 UTC`
* Release page: https://github.com/cosmos/gaia/releases/tag/v15.2.0-rc0
* ⚠️ This is **not** a governance-gated upgrade. You must do one of the following ahead of time:
  * Set the upgrade height in your node(s) `app.toml` and restart the node(s).
    ```
    halt-height = 21040550
    ```
  * Restart your node(s) with the `--halt-height 21040550` flag.
* After the halt height is reached and your node is stopped:
  * Replace the `gaiad` binary with the new one and restart the node after reverting to `halt-height = 0` in `app.toml` (or restart the node without the `--halt-height` flag).

## v15.1.0

### Schedule

| Date          | Testnet plan                          |
| ------------- | ------------------------------------- |
| March 27 2024 | ✅ Gaia v15.1.0 is live on the testnet |
| March 26 2024 | ✅ Set upgrade halt height: `20933250` |

* **Version before upgrade**: `v15.0.0-rc3`
* **Version after upgrade**: `v15.1.0`

### Upgrade details

* **Upgrade height: `20933250`**
* Estimated upgrade time: `2024-03-27 ~13:30 UTC`
* ⚠️ This is **not** a governance-gated upgrade. You must do one of the following ahead of time:
  * Set the upgrade height in your node(s) `app.toml` and restart the node(s).
    ```
    halt-height = 20933250
    ```
  * Restart your node(s) with the `--halt-height 20933250` flag.
* After the halt height is reached and your node is stopped:
  * Replace the `gaiad` binary with the new one and restart the node after reverting to `halt-height = 0` in `app.toml` (or restart the node without the `--halt-height` flag).

## v15.0.0-rc3

### Schedule

| Date             | Testnet plan                              |
| ---------------- | ----------------------------------------- |
| February 29 2024 | ✅ Gaia v15.0.0-rc3 is live on the testnet |
| February 28 2024 | ✅ Set upgrade halt height: `20519000`     |

* **Version before upgrade**: `v15.0.0-rc1`
* **Version after upgrade**: `v15.0.0-rc3`

### Upgrade details

* **Upgrade height: `20519000`**
* Estimated upgrade time: `2024-02-29 ~14:30 UTC`
* ⚠️ This is **not** a governance-gated upgrade, you must set the upgrade height in your node(s) `app.toml` ahead of time:
  ```
  halt-height = 20519000
  ```
  * After the halt height is reached and your node is stopped, replace the `gaiad` binary with the new one before starting the node again.

## v15.0.0-rc1

### Schedule

| Date             | Testnet plan                              |
| ---------------- | ----------------------------------------- |
| February 20 2024 | ✅ Gaia v15.0.0-rc1 is live on the testnet |
| February 19 2024 | ✅ Set upgrade halt height: `20378500`     |

* **Version before upgrade**: `v15.0.0-rc0`
* **Version after upgrade**: `v15.0.0-rc1`

### Upgrade details

* **Upgrade height: `20378500`**
* Estimated upgrade time: `2024-02-20 ~15:00 UTC`
* ⚠️ This is **not** a governance-gated upgrade, you must set the upgrade height in your node(s) `app.toml` ahead of time:
  ```
  halt-height = 20378500
  ```
  * After the halt height is reached and your node is stopped, replace the `gaiad` binary with the new one before starting the node again.

## v15.0.0-rc0

### Schedule

| Date             | Testnet plan                                                                                                 |
| ---------------- | ------------------------------------------------------------------------------------------------------------ |
| February 13 2024 | ✅ Gaia v15.0.0-rc0 is live on the testnet                                                                    |
| February 12 2024 | ✅ Submit and pass v15 software upgrade [proposal](https://explorer.theta-testnet.polypore.xyz/proposals/216) |

* **Version before upgrade**: `v14.1.0`
* **Version after upgrade**: `v15.0.0-rc0`

### Upgrade details

* **Upgrade height: `20269900`**
* Upgrade time: `2024-02-13 15:09:28 UTC`
  * The upgrade took 55 minutes, and block `20269902` was indexed at `16:04:19 UTC`

## v14.1.0-rc0

### Schedule

| Date             | Testnet plan                              |
| ---------------- | ----------------------------------------- |
| November 22 2023 | ✅ Gaia v14.1.0-rc0 is live on the testnet |
| November 21 2023 | ✅ Set upgrade halt height: `18986400`     |

* **Version before upgrade**: `v14.0.0-rc1`
* **Version after upgrade**: `v14.1.0-rc0`

### Upgrade details

* **Upgrade height: `18986400`**
* Estimated upgrade time: `2023-11-22 ~14:30 UTC`
* ⚠️ This is **not** a governance-gated upgrade, you must set the upgrade height in your node(s) `app.toml` ahead of time:
  ```
  halt-height = "18986400"
  ```
  * After the halt height is reached and your node is stopped, replace the `gaiad` binary with the new one, set `halt-height = "0"`, and start the node again.
  * If you are using a service file, set `Restart=No` to keep the node from restarting before you have replaced the binary.


## v14.0.0-rc1

### Schedule

| Date             | Testnet plan                              |
| ---------------- | ----------------------------------------- |
| November 15 2023 | ✅ Gaia v14.0.0-rc1 is live on the testnet |
| November 14 2023 | ✅Set upgrade halt height: `18876500`      |

* **Version before upgrade**: `v14.0.0-rc0`
* **Version after upgrade**: `v14.0.0-rc1`

### Upgrade details

* **Upgrade height: `18876500`**
* Estimated upgrade time: `2023-11-15 ~14:30 UTC`
* ⚠️ This is **not** a governance-gated upgrade, you must set the upgrade height in your node(s) `app.toml` ahead of time:
  ```
  halt-height = 18876500
  ```
  * After the halt height is reached and your node is stopped, replace the `gaiad` binary with the new one before starting the node again.

## v14

### Schedule

| Date              | Testnet plan                                                                                                 |
| ----------------- | ------------------------------------------------------------------------------------------------------------ |
| ✅ November 8 2023 | ✅ Gaia v14.0.0-rc0 is live on the testnet                                                                    |
| ✅ November 7 2023 | ✅ Submit and pass v14 software upgrade [proposal](https://explorer.theta-testnet.polypore.xyz/proposals/187) |

* **Version before upgrade**: `v13.0.1`
* **Version after upgrade**: `v14.0.0-rc0`

### Upgrade details

* **Upgrade height: `18766800`**
* Estimated upgrade time: `2023-11-08 ~14:30 UTC`

## v13

### Schedule

| Date                | Testnet plan                                    |
| ------------------- | ----------------------------------------------- |
| ✅ September 20 2023 | ✅ Gaia v13.0.0-rc0 is live on the testnet       |
| ✅ September 18 2023 | ✅ Submit and pass v13 software upgrade proposal |

* **Version before upgrade**: `v12.0.0`
* **Version after upgrade**: `v13.0.0-rc0`

### Upgrade details

* **Upgrade height: `17996550`**
* Upgrade time: `2023-09-20 13:42:06 UTC`
  * The upgrade took one minute, and block `17996552` was indexed at `13:42:59 UTC`
  
## v12

### Schedule

| Date           | Testnet plan                                                                                                 |
| -------------- | ------------------------------------------------------------------------------------------------------------ |
| August 23 2023 | ✅ [Gaia v12.0.0-rc0](https://github.com/cosmos/gaia/releases/tag/v12.0.0-rc0) is live on the testnet         |
| August 21 2023 | ✅ Submit and pass v12 software upgrade [proposal](https://explorer.theta-testnet.polypore.xyz/proposals/176) |

* **Version before upgrade**: `v11.0.0`
* **Version after upgrade**: `v12.0.0-rc0`

### Upgrade details

* **Upgrade height: `17550150`**
* Upgrade time: `2023-08-23 13:41:37 UTC`
  * The upgrade took six minutes, and block `17550152` was indexed at `13:47:33 UTC`

## v11

### Schedule

| Date         | Testnet plan                                                                                                 |
| ------------ | ------------------------------------------------------------------------------------------------------------ |
| July 26 2023 | ✅ [Gaia v11.0.0-rc0](https://github.com/cosmos/gaia/releases/tag/v11.0.0-rc0) is live on the testnet         |
| July 25 2023 | ✅ Submit and pass v11 software upgrade [proposal](https://explorer.theta-testnet.polypore.xyz/proposals/169) |

* **Version before upgrade**: `v10.0.2`
* **Version after upgrade**: `v11.0.0-rc0`

### Upgrade details

* **Upgrade height: `17107825`**
* Upgrade time: `2023-07-26 13:30:40 UTC`
  * The upgrade took two minutes, and block `17107827` was indexed at `13:32:58 UTC`

## v10

### Schedule

| Date        | Testnet plan                                                                                                 |
| ----------- | ------------------------------------------------------------------------------------------------------------ |
| May 24 2023 | ✅ [Gaia v10.0.0-rc0](https://github.com/cosmos/gaia/releases/tag/v10.0.0-rc0) is live on the testnet         |
| May 24 2023 | ✅ Submit and pass v10 software upgrade [proposal](https://explorer.theta-testnet.polypore.xyz/proposals/167) |

* **Version before upgrade**: `v9.0.3`
* **Version after upgrade**: `v10.0.0-rc0`

### Upgrade details

* Upgrade height: `16117530` 
* Upgrade time: `2023-05-24 13:59:49 UTC`
  * The upgrade took three minutes, and block `16117532` was indexed at `14:03:19 UTC`

## v9-Lambda

### Schedule

| Date             | Testnet plan                                                                                                           |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------- |
| February 08 2023 | ✅ v9-Lambda upgrade ([Gaia v9.0.0-rc3](https://github.com/cosmos/gaia/releases/tag/v9.0.0-rc3)) is live on the testnet |
| February 07 2023 | ✅ Submit and pass v9-Lambda software upgrade [proposal](https://explorer.theta-testnet.polypore.xyz/proposals/115)     |

* **Version before upgrade**: `v8.0.0`
* **Version after upgrade**: `v9.0.0-rc3`

### Upgrade height and binaries

* Upgrade height: `14476206` 
* Upgrade time: `2023-02-08 15:15:00 UTC`
  * The upgrade took under a minute, and block `14476207` was indexed at `15:35:54 UTC`.
* Unsigned proposal:

```json=
{"body":{"messages":[{"@type":"/cosmos.gov.v1beta1.MsgSubmitProposal","content":{"@type":"/cosmos.upgrade.v1beta1.SoftwareUpgradeProposal","title":"v9-Lambda","description":"# v9-Lambda Software Upgrade\r\n\r\n## Summary\r\nThis on-chain upgrade governance proposal is to adopt Gaia `v9.0.0-rc3`.By voting YES to this proposal, you approve of adding these updates to the Cosmos Hub Public Testnet.\r\n\r\n## Details\r\n\r\nThis is the fourth release candidate in preparation of the Lambda upgrade. This release candidate is for use in the simulated upgrade testnet. This is the first release of the Hub with [Replicated Security](https://github.com/cosmos/interchain-security). See the [v9  upgrade proposal post on the forum](https://forum.cosmos.network/t/proposal-draft-v9-lambda-upgrade-with-replicated-security/8766/1) for more information and further discussion.\r\n\r\nThis release contains the following changes:\r\n* (feat) Add [Interchain-Security](https://github.com/cosmos/interchain-security) [v1.0.0-rc5](https://github.com/cosmos/interchain-security/releases/tag/v1.0.0-rc5) provider module. See the [ICS Spec](https://github.com/cosmos/ibc/blob/main/spec/app/ics-028-cross-chain-validation/README.md) for more details.\r\n* (gaia) bump [cosmos-sdk](https://github.com/cosmos/cosmos-sdk) to [v0.45.12-ics](https://github.com/cosmos/cosmos-sdk/releases/tag/v0.45.12-ics). See [CHANGELOG.md](https://github.com/cosmos/cosmos-sdk/releases/tag/v0.45.12) for details.\r\n* (gaia) Bump [ibc-go](https://github.com/cosmos/ibc-go) to [v4.2.0](https://github.com/cosmos/ibc-go/blob/release/v4.2.x/CHANGELOG.md). See [v4.2 Release Notes](https://github.com/cosmos/ibc-go/releases/tag/v4.2.0) for details.\r\n* (gaia) Bump [packet-forwarding-middleware](https://github.com/strangelove-ventures/packet-forward-middleware) to [v4.0.3](https://github.com/strangelove-ventures/packet-forward-middleware/releases/tag/v4.0.3).\r\n* (tests) Add [E2E ccv tests](https://github.com/cosmos/gaia/blob/main/tests/e2e/e2e_gov_test.go#L138). Tests covering new functionality introduced by the provider module to add and remove a consumer chain via governance proposal.\r\n* (tests) Add [integration ccv tests](https://github.com/cosmos/gaia/blob/main/tests/ics/interchain_security_test.go). Imports Interchain-Security's `TestCCVTestSuite` and implements Gaia as the provider chain.\r\n\r\n## On-Chain Upgrade Process\r\n\r\nWhen the network reaches the upgrade height, the state machine program will be halted. One method for upgrading requires all validators and node operators to manually substitute the existing state machine binary with the new binary. Alternatively, Cosmovisor has the ability to download the binaries automatically before swapping them.\r\n\r\nTo test a simulated local upgrade please see the local testnet documentation. Because it is an onchain upgrade process, the blockchain will be continued with all the accumulated history with continuous block height.\r\n","plan":{"name":"v9-Lambda","time":"0001-01-01T00:00:00Z","height":"14476206","info":"{\"binaries\":{\"linux/amd64\":\"https://github.com/cosmos/gaia/releases/download/v9.0.0-rc3/gaiad-v9.0.0-rc3-linux-amd64?checksum=sha256:b54e122e6d4cb996c9f2b736436bde569d22535e8006b132e0575968667be5ca\",\"linux/arm64\":\"https://github.com/cosmos/gaia/releases/download/v9.0.0-rc3/gaiad-v9.0.0-rc3-linux-arm64?checksum=sha256:1c91c96740dbce946786878ce7ac90f5b51b5dd72bb7ea0d20ba789664af8b9d\",\"darwin/amd64\":\"https://github.com/cosmos/gaia/releases/download/v9.0.0-rc3/gaiad-v9.0.0-rc3-darwin-amd64?checksum=sha256:9713b917ac7d2c428ae6e2c57d45fb0b7074e9aa3d57a98915f32887bc8817fa\",\"windows/amd64\":\"https://github.com/cosmos/gaia/releases/download/v9.0.0-rc3/gaiad-v9.0.0-rc3-windows-amd64.exe?checksum=sha256:2e4b352793091e3855e27e7c1e4a80c1d6f22b4bb45ee5f6630a0456008d2ace\"}}","upgraded_client_state":null}},"initial_deposit":[{"denom":"uatom","amount":"1"}],"proposer":"cosmos10v6wvdenee8r9l6wlsphcgur2ltl8ztkvhc8fw"}],"memo":"","timeout_height":"0","extension_options":[],"non_critical_extension_options":[]},"auth_info":{"signer_infos":[],"fee":{"amount":[{"denom":"uatom","amount":"5000"}],"gas_limit":"1000000","payer":"","granter":""}},"signatures":[]}
```

## v8-Rho

### Schedule

| Date            | Testnet plan                                                                                                        |
| --------------- | ------------------------------------------------------------------------------------------------------------------- |
| January 20 2023 | ✅ v8-Rho upgrade ([Gaia v8.0.0-rc3](https://github.com/cosmos/gaia/releases/tag/v8.0.0-rc3)) is live on the testnet |
| January 18 2023 | ✅ Submit and pass v8-Rho software upgrade [proposal](https://explorer.theta-testnet.polypore.xyz/proposals/112)     |

* **Version before upgrade**: `v7.1.0`
* **Version after upgrade**: `v8.0.0-rc3`

### Upgrade height and binaries

* Upgrade height: `14175595` 
* Upgrade time: `2023-01-20 14:36:02 UTC`
  * The upgrade took under a minute, and block `14175596` was indexed at `14:36:53 UTC`.
* Unsigned proposal:

```json=
{"body":{"messages":[{"@type":"/cosmos.gov.v1beta1.MsgSubmitProposal","content":{"@type":"/cosmos.upgrade.v1beta1.SoftwareUpgradeProposal","title":"v8-Rho","description":"# v8-Rho Software Upgrade\r\n\r\n## Summary\r\n\r\nThis on-chain upgrade governance proposal is to adopt Gaia `v8.0.0-rc3`.By voting YES to this proposal, you approve of adding these updates to the Cosmos Hub Public Testnet.\r\n\r\n## Details\r\n\r\nSince the last v7-Theta upgrade at height 9283650, there have been a number of updates, fixes and new modules added to Gaia.\r\n\r\nThis is a proposal to adopt release candidate 3 for the Gaia v8-Rho upgrade on the public testnet. It contains the following changes:\r\n\r\n* (gaia) Bump [ibc-go](https://github.com/cosmos/ibc-go) to [v3.4.0](https://github.com/cosmos/ibc-go/releases/tag/v3.4.0) to fix a vulnerability in ICA. See [CHANGELOG.md](https://github.com/cosmos/ibc-go/blob/v3.4.0/CHANGELOG.md) for details.\r\n* (gaia) Bump [cosmos-sdk](https://github.com/cosmos/cosmos-sdk) to [v0.45.11](https://github.com/cosmos/cosmos-sdk/releases/tag/v0.45.11). See [CHANGELOG.md](https://github.com/cosmos/cosmos-sdk/blob/release/v0.45.x/CHANGELOG.md) for details.\r\n* (gaia) Bump [tendermint](https://github.com/tendermint/tendermint) to [0.34.24](https://github.com/tendermint/tendermint/tree/v0.34.24). See [CHANGELOG.md](https://github.com/tendermint/tendermint/blob/v0.34.24/CHANGELOG.md) for details.\r\n* (gaia) Bump [liquidity](https://github.com/Gravity-Devs/liquidity) to [v1.5.3](https://github.com/Gravity-Devs/liquidity/releases/tag/v1.5.3).\r\n* (gaia) Bump [packet-forwarding-middleware](https://github.com/strangelove-ventures/packet-forward-middleware) to [v3.1.1](https://github.com/strangelove-ventures/packet-forward-middleware/releases/tag/v3.1.1).\r\n* (feat) Add [globalfee](https://github.com/cosmos/gaia/tree/main/x/globalfee) module. See [globalfee docs](https://github.com/cosmos/gaia/blob/main/docs/modules/globalfee.md) for more details.\r\n* (feat) [#1845](https://github.com/cosmos/gaia/pull/1845) Add bech32-convert command to gaiad.\r\n* (fix) [Add new fee decorator](https://github.com/cosmos/gaia/pull/1961) to change MaxBypassMinFeeMsgGasUsage so importers of x/globalfee can change MaxGas.\r\n* (fix) [#1870](https://github.com/cosmos/gaia/issues/1870) Fix bank denom metadata in migration. See #1892 for more details.\r\n* (fix) [#1976](https://github.com/cosmos/gaia/pull/1976) Fix Quicksilver ICA exploit in migration. See the bug fix forum post for more details.\r\n* (tests) Add [E2E](https://github.com/cosmos/gaia/tree/main/tests/e2e) tests. The tests cover transactions/queries tests of different modules, including Bank, Distribution, Encode, Evidence, FeeGrant, Global Fee, Gov, IBC, packet forwarding middleware, Slashing, Staking, and Vesting module.\r\n* (tests) [#1941](https://github.com/cosmos/gaia/pull/1941) Fix packet forward configuration for e2e tests.\r\n* (tests) Use gaiad to swap out [Ignite](https://github.com/ignite/cli) in [liveness tests](https://github.com/cosmos/gaia/blob/main/.github/workflows/test.yml).\r\n\r\n## On-Chain Upgrade Process\r\n\r\nWhen the network reaches the upgrade height, the state machine program will be halted. One method for upgrading requires all validators and node operators to manually substitute the existing state machine binary with the new binary. Alternatively, Cosmovisor has the ability to download the binaries automatically before swapping them.\r\n\r\nTo test a simulated local upgrade please see the local testnet documentation. Because it is an on-chain upgrade process, the blockchain will be continued with all the accumulated history with continuous block height.","plan":{"name":"v8-Rho","time":"0001-01-01T00:00:00Z","height":"14175595","info":"{\"binaries\":{\"linux/amd64\":\"https://github.com/cosmos/gaia/releases/download/v8.0.0-rc3/gaiad-v8.0.0-rc3-linux-amd64?checksum=sha256:52236137b101de47dc392ce831c7d379d7a0dca35cdde997f6de61241d6cc71e\",\"linux/arm64\":\"https://github.com/cosmos/gaia/releases/download/v8.0.0-rc3/gaiad-v8.0.0-rc3-linux-arm64?checksum=sha256:1d118a0f8911c5039e07e1f90cd4bcc85ac1d22c2686e6c838c9157aa6d89031\",\"darwin/amd64\":\"https://github.com/cosmos/gaia/releases/download/v8.0.0-rc3/gaiad-v8.0.0-rc3-darwin-amd64?checksum=sha256:77c6b73b43ad583484b5d0373c5176583654f32477e9b47db2370ac30e34875a\",\"darwin/arm64\":\"https://github.com/cosmos/gaia/releases/download/v8.0.0-rc3/gaiad-v8.0.0-rc3-darwin-arm64?checksum=sha256:c32c36fc49a05f38916863c7a429decaab534552449c36657e58bd80917770ff\",\"windows/amd64\":\"https://github.com/cosmos/gaia/releases/download/v8.0.0-rc3/gaiad-v8.0.0-rc3-windows-amd64.exe?checksum=sha256:ca1b0ded75093862850a1beaffd8fd15c96bea701701130077926724228c27f9\"}}","upgraded_client_state":null}},"initial_deposit":[{"denom":"uatom","amount":"1"}],"proposer":"cosmos10v6wvdenee8r9l6wlsphcgur2ltl8ztkvhc8fw"}],"memo":"","timeout_height":"0","extension_options":[],"non_critical_extension_options":[]},"auth_info":{"signer_infos":[],"fee":{"amount":[{"denom":"uatom","amount":"5000"}],"gas_limit":"1000000","payer":"","granter":""}},"signatures":[]}
```

## v7-Theta

### Schedule

| Date          | Testnet plan                                                                                                        |
| ------------- | ------------------------------------------------------------------------------------------------------------------- |
| March 17 2022 | ✅  Theta upgrade ([Gaia v7.0.0-rc0](https://github.com/cosmos/gaia/releases/tag/v7.0.0-rc0)) is live on the testnet |
| March 16 2022 | ✅  Voting ends                                                                                                      |
| March 16 2022 | ✅  Submit v7-Theta software [upgrade proposal](https://testnet.cosmos.bigdipper.live/proposals/66)                  |
| March 10 2022 | ✅  Launch testnet chain with Gaia v6.0.0 (previous version)                                                         |


* **Version before upgrade**: `v6.0.x`
* **Version after upgrade**: `v7.0.0-rc0`

The v7-Theta upgrade was successfully completed on **March 17th, 2022 at 16:14 UTC (12:14 PM ET)**. The upgrade halt height was `9283650`, and blocks were being produced 7 minutes later.

Relevant log lines:
```
Mar 17 12:07:40 earth cosmovisor[822]: 12:07PM ERR UPGRADE "v7-Theta" NEEDED at height: 9283650
Mar 17 12:14:42 earth cosmovisor[13563]: 12:14PM INF finalizing commit of block hash=D83798E929BA7FB1F740C7E583EC2918EC40EDD3249B14BC72876130053BD0EE height=9283651 module=consensus num_txs=0 root=17F5C1754B53350A543A6BB29DE5E35A9DB9874AF89117220117213E53E38344
```

### Validators participating in upgrade testing

* 0base.vc
* 20MB Lab
* Cosmic Validator - Testnet
* Everstake
* Itachi
* KalpaTech
* P2P.ORG Validator
* Provalidator
* StakeWithUs
* Stakely.io
* WeStaking

Thank you to all participating validators! These validators received `THETA` tokens to their self-delegation addresses as part of our [collectables program](https://interchain-io.medium.com/cosmos-hub-theta-testnet-token-collectables-d08967ba2875)!

### Upgrade height and binaries

* Upgrade height: `9283650` 
* Estimated update time: 16:00 UTC
* On-chain proposal:

```bash=
gaiad tx gov submit-proposal software-upgrade v7-Theta \
--title v7-Theta \
--deposit 500000uatom \
--upgrade-height 9283650 \
--upgrade-info '{"binaries": {"linux/amd64": "https://github.com/cosmos/gaia/releases/download/v7.0.0-rc0/gaiad-v7.0.0-rc0-linux-amd64?checksum=sha256:4e95eaca51d6e0ab61b7a759aafc4b4674c270b8ffa764cb953d3808a1f9e264","linux/arm64": "https://github.com/cosmos/gaia/releases/download/v7.0.0-rc0/gaiad-v7.0.0-rc0-linux-arm64?checksum=sha256:574916076c6e0960fa980522ed9a404967a6f4c306448d09649a11e5626cd991","darwin/amd64": "https://github.com/cosmos/gaia/releases/download/v7.0.0-rc0/gaiad-v7.0.0-rc0-darwin-amd64?checksum=sha256:547182dd4456e8d71ff5256484458f0690a865d5c9f2185286dd9ab71dd11b10","windows/amd64": "https://github.com/cosmos/gaia/releases/download/v7.0.0-rc0/gaiad-v7.0.0-rc0-windows-amd64.exe?checksum=sha256:4eea1a32af3ed79632cfc8cca7088a10b3d89f767310e3c24fe31ad99492f6c8"}}' \
--description "This on-chain upgrade governance proposal is to adopt gaia v7.0.0 which includes a number of updates, fixes and new modules. By voting YES to this proposal, you approve of adding these updates to the Cosmos Hub.\n\n# Background\n\nSince the last v6-Vega upgrade at height 86950000 there have been a number of updates, fixes and new modules added to the Cosmos SDK, IBC and Tendermint.\n\nThis is a proposal to adopt the first release candidate for the [v7-Theta](https://github.com/cosmos/gaia/blob/main/docs/roadmap/cosmos-hub-roadmap-2.0.md#v7-theta-upgrade-expected-q1-2022) upgrade on the public testnet.\n\nIt contains the following changes:\n\n* (gaia) bump [cosmos-sdk](https://github.com/cosmos/cosmos-sdk) to [v0.45.1](https://github.com/cosmos/cosmos-sdk/releases/tag/v0.45.1). See [CHANGELOG.md](https://github.com/cosmos/cosmos-sdk/blob/v0.45.1/CHANGELOG.md#v0451---2022-02-03) for details.\n* (gaia) bump [ibc-go](https://github.com/cosmos/ibc-go) module to [v3.0.0](https://github.com/cosmos/ibc-go/releases/tag/v3.0.0). See [CHANGELOG.md](https://github.com/cosmos/ibc-go/blob/v3.0.0/CHANGELOG.md#v300---2022-03-15) for details.\n* (gaia) add [interchain account](https://github.com/cosmos/ibc-go/tree/main/modules/apps/27-interchain-accounts) module (interchain-account module is part of ibc-go module).\n* (gaia) bump [liquidity](https://github.com/gravity-devs/liquidity/x/liquidity) module to [v1.5.0](https://github.com/Gravity-Devs/liquidity/releases/tag/v1.5.0). See [CHANGELOG.md](https://github.com/Gravity-Devs/liquidity/blob/v1.5.0/CHANGELOG.md#v150---20220223) for details.\n* (gaia) bump [packet-forward-middleware](https://github.com/strangelove-ventures/packet-forward-middleware) module to [v2.1.1](https://github.com/strangelove-ventures/packet-forward-middleware/releases/tag/v2.1.1).\n* (gaia) add migration logs for upgrade process.\n\n# On-Chain Upgrade Process\nWhen the network reaches the halt height, the state machine program of the Cosmos Hub will be halted. The classic method for upgrading requires all validators and node operators to manually substitute the existing state machine binary with the new binary. There is also a newer method that relies on Cosmovisor to swap the binaries automatically. Cosmovisor also includes the ability to download the binaries automatically before swapping them. To test a simulated local upgrade please see the local testnet documentation. Because it is an onchain upgrade process, the blockchain will be continued with all the accumulated history with continuous block height." \
--fees 1500uatom \
--gas auto \
--from <key_name> \
--chain-id theta-testnet-001 \
--node tcp://localhost:26657 \
--yes
```
