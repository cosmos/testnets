# Testnet Demo Day # 24: 2026-Mar-31

In this demo day, we will explore the gas surcharge for multi-send transactions introduced in Gaia v27.0.0.

* End time: `2026-03-31 14:30 UTC`

## Testnet Participation Eligibility

* You must complete the task listed below by the time the event ends to earn points for the March 2026 period.
* Available points: 1

### Tasks

* (1 point) Task 1: Send a multi-send transaction that lists at least 10 recipients.
    ```
    gaiad tx bank multi-send <self-delegation wallet> <recipient 1> <recipient 2>...<recipient n> <amount> --from <self delegation wallet> --gas auto --gas-adjustment 1.2 --gas-prices 0.005uatom --chain-id provider -y
    ```

## The `multi-send` Gas Surcharge

Gaia v27.0.0 introduced a gas surcharge and a cap on the number of recipients to the `multi-send` message.

The surcharge calculation is as follows:
```
gas_surcharge = 300 * <recipients>^2
```

* For a message with 10 recipients, the nominal surcharge is `30_000`.
* For a message with 100 recipients, the nominal surcharge is `3_000_000`.
* For a message with 200 recipients, the nominal surcharge is `12_000_000`.

The number of recipients is capped to 500, but the gas limit per block (currently set to `75_000_000`) means the actual limit is less than that.

