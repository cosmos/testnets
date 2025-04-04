# Testnet Demo Day: Observability Setup

* 2025-Apr-15
* Start time: `13:30 UTC`
* End time: `15:00 UTC`

## Summary

During this demo day, we will guide validators in setting up observability tools for their existing nodes on the `provider` chain.
This will help prepare for future performance testing and increase visibility into chain operations.

### Testnet Incentives Program (TIP) Eligibility

This event will be worth **one point** for the current TIP period:

* (1 point) Task: Successfully set up metrics collection (metrics appear in our Prometheus)

## Timeline (times in UTC)

| Time | Event |
|------|-------|
| 13:30 | Demo day introduction and setup guidance |
| 14:00 | Technical support for metrics configuration |
| 14:30 | Verification of metrics collection |
| 14:50 | Wrap-up and next steps |

## Configure metrics collection

We'll be collecting metrics to analyze validator node performance. Follow these steps to set up the metrics exporter on your existing `provider` chain validator:

1. Clone the metrics exporter repository:

```bash
git clone https://github.com/hyphacoop/cosmos-observability.git
cd cosmos-observability/metrics-exporter
```

1. Create an environment file from the template:

```bash
cp env_template .env
```

1. Edit the `.env` file with your validator information:
   * Set `VALIDATOR_MONIKER` to your validator's moniker
   * Set `CHAIN_ID` to `provider`
   * Set `REMOTE_WRITE_URL` to `http://159.203.3.222:9091/api/v1/write`
   * Set `PYROSCOPE_SERVER_ADDRESS` to `http://159.203.3.222:4040`

1. You may want to configure a gcr mirror to pull docker images, since pulling from dockerhub may result in rate limiting.
   Add the following to `/etc/docker/daemon.json`:

```json
{
  "registry-mirrors": ["https://mirror.gcr.io"]
}
```

1. Start the metrics exporter:

```bash
docker-compose up -d
```

1. Go check out your metrics at `http://159.203.3.222:3000/d/CgCw8jKZz/go-metrics`. You should be able to use the `instance` dropdown to filter to your validator.
   Please wait a few minutes for the metrics to start flowing in.

## Support

If you encounter any issues during the demo day, please reach out in the #interchain-security-testnet Discord channel.