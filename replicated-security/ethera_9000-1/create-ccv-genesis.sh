#!/bin/bash

gaiad --node https://rpc.provider-sentry-01.rs-testnet.polypore.xyz:443 query provider consumer-genesis ethera_9000-1 -o json > ccv.json
jq -s '.[0].app_state.ccvconsumer = .[1] | .[0]' ethera_9000-1-genesis-without-ccv.json ccv.json > ethera_9000-1-genesis.json
rm ccv.json
sha256sum ethera_9000-1-genesis.json
