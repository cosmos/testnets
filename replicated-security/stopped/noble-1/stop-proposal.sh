#!/bin/bash
export ACCOUNT="cosmos1cymmn6xh0nns7uwlwwl2jtemn3haa7w5l4kjdg"
gaiad tx gov submit-proposal consumer-removal proposal-noble-1.json \
--from=$ACCOUNT \
--keyring-backend test \
--chain-id=provider-1 \
--gas-prices 0.0025uatom --gas-adjustment 1.2 \
-y
