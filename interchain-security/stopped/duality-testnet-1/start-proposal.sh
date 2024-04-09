#!/bin/bash
export ACCOUNT="<TBD>"
gaiad tx gov submit-proposal consumer-addition proposal-start-duality-testnet-1.json \
--from=$ACCOUNT \
--keyring-backend test \
--chain-id=provider \
--gas-prices 0.0025uatom --gas-adjustment 1.2 \
-y
