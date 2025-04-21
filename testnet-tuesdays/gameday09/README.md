# Testnet Game Day #9: Load Test

* 2025-Apr-15
* Start time: `13:30 UTC`
* End time: `16:30 UTC`

## Summary

During this game day, we will launch a new chain and conduct performance load tests with Gaia v23.1.1. The event will help us establish baseline performance metrics for future comparisons.

### Testnet Incentives Program (TIP) Eligibility

This event will be worth **one point** for the current TIP period:

* (1 point) Successfully set up metrics collection for a validator on `test-locust-1` (metrics appear in our Prometheus throughout the load test)

If you're unable to run the observability stack, please fill out a form (link to be added) and prove that you're signing blocks on the new chain. Proving that there's a validator with your moniker that's signing blocks is acceptable.

## Timeline (times in UTC)

| Time | Event |
|------|-------|
| 13:30 | Chain launch and validator setup (1 hour) |
| 14:30 | Load testing begins (multiple tests) |
| 16:30 | Results analysis and wrap-up |

## 1. Set up a validator

* Join the chain `test-locust-1` using the details in the chain's [README](../../interchain-security/test-locust-1/README.md).
* **Important**: Configure your node's consensus and mempool as per the specs in that README!

## 2. Configure metrics collection

For metrics collection setup instructions, please refer to [the observability guide](observability.md).

## 3. Load testing

* Ensure your node is running Gaia v23.1.1
* We will conduct multiple load tests to establish baseline performance metrics
* No action is required from validators during this phase. Hypha will report on load tests as they happen.

## Results

After the load tests are complete, we will analyze the performance data and share the results with all participants.

## Support

If you encounter any issues during the game day, please reach out in the #interchain-security-testnet Discord channel.
