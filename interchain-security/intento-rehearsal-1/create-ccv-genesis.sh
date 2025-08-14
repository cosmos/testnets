#!/bin/bash

gaiad --node https://rpc.provider-sentry-01.rs-testnet.polypore.xyz:443 query provider consumer-genesis IDDDDDDD -o json > ccv.json
jq -s '.[0].app_state.ccvconsumer = .[1] | .[0]' intento-rehearsal-1-genesis-without-ccv.json ccv.json > intento-rehearsal-1-genesis-with-ccv.json
rm ccv.json
sha256sum intento-rehearsal-1-genesis-with-ccv.json
