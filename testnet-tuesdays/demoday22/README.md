# Testnet Demo Day # 22: 2025-December-16

We will use this demo day to test different settings in the `feemarket` module and explore how the gas prices may adjust to high volume scenarios.

We will submit a series of transactions and several governance proposals throughout the event to demonstrate the effect of the `feemarket` module parameters.

We will post announcements in the `testnet-announcements` channel in Discord to coordinate activities during the event.

* Start time: `2025-12-16 14:30 UTC`
* End time: `2025-12-16 16:00 UTC`

## Schedule (approximate times in UTC)

| Time  | Event                                                                     | Tasks Available |
| :---: | :------------------------------------------------------------------------ | :-------------: |
| 15:30 | Transactions with high gas use start being sent to the `provider` network |                 |
| 15:40 | Governance proposals start being submitted for voting                     |        1        |
| 17:00 | Transactions with high gas fees stop being sent                           |                 |

## Testnet Incentives Program (TIP) Eligibility

* You must complete the tasks listed below by the time the event ends to earn points for the December 2025 TIP period.
* Available points: 1


## Tasks

* Task 1: Vote YES on at least one feemarket param change proposal.

## Transactions and Gas Prices

We will submit several high-gas (`>60_000_000`) transactions for each combination of feemarket module parameters: one transaction per block, paying the current gas price.

For each scenario, we will collect:
- Max gas prices
- Total fees paid in gas

## Feemarket

### Terms

* **Window**: The number of blocks that are used to calculate gas usage.
* **Target**: The target for the feemarket module is set to half of the max block utilization.
* **Net Utilization**: How much gas is used beyond the target utilization
  * `net_utilization = sum(window) - (target × window_size)`
* **Learning rate**: A multiplier that scales how aggressively the fee market responds to network utilization deviations from the target.
* **Price change**: The amount by which the gas price changes based on utilization.
  *  `price_change = delta × learning_rate × net_utilization`

### Parameters

* **Alpha**: This amount is added to the learning rate when utilization is outside the target threshold.
* **Beta**: The learning rate is multiplied by this amount to set the new learning rate when utilization is within the target threshold.
* **Delta**: Controls the magnitude of base fee adjustments based on network utilization.
* **Gamma**: Defines the threshold band around the target where the utilization is considered "acceptable".
* **Min/max learning rate**: Learning rate limites.
* **Max block utilization**: The target threshold for the feemarket module is set to half of the max block utilization.

