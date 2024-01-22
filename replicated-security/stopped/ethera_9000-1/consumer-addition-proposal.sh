#!/bin/bash

export ACCOUNT="cosmos14wlynjafz3sx48ga0prrwp8e43gugeunurfrc5"
gaiad tx gov submit-proposal consumer-addition ./proposal-ethera_9000-1.json \
    --node https://rpc.provider-sentry-01.rs-testnet.polypore.xyz:443 \
    --from=$ACCOUNT \
    --chain-id=provider \
    --gas-prices 0.005uatom --gas auto --gas-adjustment 1.5 \
    -y
