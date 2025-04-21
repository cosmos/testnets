# Configure metrics collection

We'll be collecting metrics to analyze validator node performance. Follow these steps to set up the metrics exporter on your existing `test-locust-1` chain validator:

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
   * Set `CHAIN_ID` to `test-locust-1`
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

1. Go check out your metrics at `http://159.203.3.222:3000/d/UJyurCTWz/cosmos-dashboard?var-DS=eKzyRJ57k&var-chain_id=test-locust-1`. You should be able to use the `instance` dropdown to filter to your validator.
   Please wait a few minutes for the metrics to start flowing in.

## No metrics?

1. You may have to configure your firewall to allow the dockerized prometheus to fetch from your validator node.
   You do this by allowing containers within the `metrics-exporter_o11y-network` network to access anything at port 26660.
   If you're running ufw, you can use the following one-liner to do this:

```bash
sudo ufw allow from "$(docker inspect metrics-exporter_o11y-network | jq '.[0].IPAM.Config[0].Subnet')" to any port 26660
```

1. If you still see no metrics, note down the gateway address for your network: `docker inspect metrics-exporter_o11y-network | jq '.[0].IPAM.Config[0].Gateway'`
   then plug it into line 81 of the docker compose file, instead of `host-gateway`:

```yaml
extra_hosts:
    - "host.docker.internal:172.18.0.1" # Or some other IP.
```

1. If you still see no metrics, we shipped a host mode exporter that sacrifices network isolation to get metrics in. Do:

```bash
docker-compose down
cp .env host-networking/.env
cd host-networking
docker-compose up -d
```

1. If you **still** see no metrics, ponder how Docker became a ubiquitous solution without ever documenting their networking internals or, God forbid, writing an open spec,
   then pop into `#interchain-security-testnet` and we'll do our best to assist you.
