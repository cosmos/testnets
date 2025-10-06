# Testnet Demo Day # 21: 2025-Oct-7

In this demo day, we will review the capabilities of the IBC rate limit module.

* Start time: `2025-10-07 13:30 UTC`
* End time: `2025-10-07 15:00 UTC`

## Schedule (approximate times in UTC)

| Time  | Event                                                    | Tasks Available |
| :---: | :------------------------------------------------------- | :-------------: |
| 13:30 | Expedited proposal to set rate limit is in voting period |        1        |
| 13:45 | Expedited proposal to set rate limit passes              |        -        |
| 13:45 | Demo day IBC token is distributed                        |        2        |
| 14:15 | Rate limit threshold is reached                          |        -        |
| 15:00 | Testnet Tuesday ends                                     |        -        |


### Testnet Incentives Program (TIP) Eligibility

* You must complete the tasks listed below to earn points for the October 2025 TIP period.
* Available points: 2

#### Tasks

* (1 point) Task 1: Vote YES on proposal 279 to put a rate limit in place.
  * Vote from your self-delegation address.
* (1 point) Task 2: Send IBC-wrapped uatom from `provider` to `gaia-devnet`.
  * Send the tokens from your self-delegation address.

> Please note that all the transactions listed in this page are sent from the `provider` chain.

## 1. Rate Limit

The `ratelimit` module prevents massive inflows or outflows of IBC tokens in a short time frame. We will submit a [proposal](proposal-ratelimit.json) to add a rate limit to the `provider` chain. After it passes, it will block IBC transfers out of the chain for a specific denom once a threshold (a percentage of the denom supply) is reached within a one-hour window.

Transfers of the IBC-wrapped Gaia devnet uatom will be blocked after 20% of the token supply has been reached in IBC transfers out of channel-513 until the one-hour window passes.

We will use the following channels between the `provider` and `gaia-devnet` chain:

| `provider`       | `gaia-devnet`  |
| ---------------- | -------------- |
| `channel-513`    | `channel-11`   |
| `connection-265` | `connection-3` |

### Task 1: Vote YES to the rate limit proposal
* Vote yes on [proposal 279](https://explorer.polypore.xyz/provider/gov/279) with your self-delegation address:
```
gaiad tx gov vote 279 yes --from <self-delegation address> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```
* The expedited voting period will be set to **15 minutes** ahead of this demo day.

## 2. IBC Transfer

We have distributed IBC-wrapped uatom from the Gaia devnet to all the validators in the `provider` chain.
* Denom: `ibc/002C7C438AF3C8D40655E1C3356E3A0680A78FE08A6CD8A6FFB8A2AC86E0DD7F`

### Task 2: Send tokens from `provider` to `gaia-devnet`
* Send 1 devnet ATOM from your validator self-delegation address to a recipient of your choosing  via `channel-513` on the provider chain.
* You can use this command as reference:
   ```
   gaiad tx ibc-transfer transfer transfer channel-513 <recipient> 1000000ibc/002C7C438AF3C8D40655E1C3356E3A0680A78FE08A6CD8A6FFB8A2AC86E0DD7F --from <self-delegation address> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
   ```

One way to check if the transfer went through is to look for a change in the recipient balance.
```
gaiad q bank balances <recipient address> --node https://rpc.gaia-devnet.polypore.xyz
```

### (Optional) Task 3: Try sending tokens from `provider` to `gaia-devnet` again

We will submit a large IBC transfer 30 minutes after the proposal passes to reach the threshold set by the rate limit. Once the threshold is reached, further attempts to send additional tokens out will be blocked!

The rate limit will only kick in after the threshold is reached, but after the one-hour window passes you will be able to continue sending these tokens out throuch `channel-513`.

> Visit the [ibc-apps repo](https://github.com/cosmos/ibc-apps/tree/main/modules/rate-limiting) for more details on the `ratelimit` module!

