#!/bin/bash
export ACCOUNT="<TBD>"
gaiad tx gov submit-proposal consumer-addition proposal-start-duality-rehearsal-1.json \
--from=$ACCOUNT \
--keyring-backend test \
--chain-id=provider-1 \
--gas-prices 0.0025uatom --gas-adjustment 1.2 \
-y
