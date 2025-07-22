# Testnet Demo Day # 19: 2025-Jul-22

In this demo day, we will demonstrate how you can generate and submit different kinds of transactions using the `gaiad` CLI.

* Start time: `2025-07-22 13:30 UTC`
* End time: `2025-07-22 14:30 UTC`

The generate-sign-broadcast workflow is standard to Cosmos chains, so you can try it out on different networks.

## Single-command transactions

The simplest workflow we can use with the CLI is using a tx command to generate, sign, and submit a transaction. Here are two sample transactions:
* `bank send`: Send tokens to one recipient
  * Format
    ```
    gaiad tx bank send <sender> <recipient> <amount> --from <sender> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
    ```
  * Example ([on-chain data](https://explorer.polypore.xyz/provider/tx/31FDA9D266C79D23C0EEDFB9F353FC00C1C22A8BE17CEDE739FDD107262C3BB1))
    ```
    gaiad tx bank send cosmos1j7qzunvzx4cdqya80wvnrsmzyt9069d3gwhu5p cosmos1arjwkww79m65csulawqngr7ngs4uqu5hx9ak2a 1000000uatom --from cosmos1j7qzunvzx4cdqya80wvnrsmzyt9069d3gwhu5p --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
    ```

* `staking delegate`: Delegate stake to one validator
  * Format
    ```
    gaiad tx staking delegate <validator> <amount> --from <delegator> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
    ```
  * Example ([on-chain data](https://explorer.polypore.xyz/provider/tx/0265E7FBB508C1E2E2B215D377D2525FDAC88FD95E7F5AF0202C0DD7EDFCBD51))
    ```
    gaiad tx staking delegate cosmosvaloper1arjwkww79m65csulawqngr7ngs4uqu5hr3frxw 1000000uatom --from cosmos1j7qzunvzx4cdqya80wvnrsmzyt9069d3gwhu5p --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
    ```

### Multi-send

Some modules will allow you to submit more complex transactions. For instance, the `bank` module offers a multisend subcommand to send the same amount of funds to multiple recipients. The `amount` will be multiplied by the number of recipients specified, and that is how much will be withdrawn from the sender balance (plus gas fees). This is our go-to tool for TIP payouts!
* `bank multisend`: Send the same amount to multiple recipients
  * Format
    ```
    gaiad tx bank multisend <sender> <recipient 1> <recipient 2> <recipient 3> <amount> --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
    ```
  * Example ([on-chain data](https://explorer.polypore.xyz/provider/tx/D8D9CA3F3C1AB29D39D54C3E7FE37E22A80312E6D3F0582A5DA0F40F779F733F))
    ```
    gaiad tx bank multi-send cosmos1j7qzunvzx4cdqya80wvnrsmzyt9069d3gwhu5p cosmos1arjwkww79m65csulawqngr7ngs4uqu5hx9ak2a cosmos1apac0g5s88pfjvlgjqjnr0kdpkpmhx8pkdp0r5 cosmos1e5yfpc8l6g4808fclmlyd38tjgxuwshn7xzkvf 1000000uatom --from cosmos1j7qzunvzx4cdqya80wvnrsmzyt9069d3gwhu5p --gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
    ```

## Generate-sign-broadcast workflow

There are times when you must generate a transaction before signing it. We will cover a couple of scenarios in increasing levels of complexity.

### Single-message transactions

1. Generate a JSON file for an unsigned bank send transaction
  * Format
    ```
    gaiad tx bank send <sender> <recipient> <amount> --from <sender> --gas-prices 0.005uatom --generate-only > send-unsigned.json
    ```
  * Example
    ```
    gaiad tx bank send cosmos1j7qzunvzx4cdqya80wvnrsmzyt9069d3gwhu5p cosmos1arjwkww79m65csulawqngr7ngs4uqu5hx9ak2a 1000000uatom --gas-prices 0.005uatom --generate-only > send-unsigned.json
    ```
2. Sign the unsigned file
   ```
   gaiad tx sign send-unsigned.json --from <sender> --output-document send-signed.json
   ```

3. Broadcast the signed file
   ```
   gaiad tx broadcast send-signed.json
   ```

### Multi-message transactions

You can assemble an unsigned transaction with several messages to sign it and broadcast it as a single transaction. As an example, you can use this method to delegate stake to multiple validators at once (there is no such thing as a multi-delegate subcommand).

1. Generate an unsigned delegate transaction for two different validators
  * Format
    ```
    gaiad tx staking delegate <validator 1> 1000000uatom --from <delegator> --gas 600000 --gas-prices 0.005uatom --generate-only > delegate-unsigned-1.json
    gaiad tx staking delegate <validator 2> 1000000uatom --from <delegator> --gas 600000 --gas-prices 0.005uatom --generate-only > delegate-unsigned-2.json
    ```
  * Example
    ```
    gaiad tx staking delegate cosmosvaloper1arjwkww79m65csulawqngr7ngs4uqu5hr3frxw 1000000uatom --from cosmos1j7qzunvzx4cdqya80wvnrsmzyt9069d3gwhu5p --gas 600000 --gas-prices 0.005uatom --generate-only > delegate-unsigned-1.json
    gaiad tx staking delegate cosmosvaloper1apac0g5s88pfjvlgjqjnr0kdpkpmhx8pne4608 1000000uatom --from cosmos1j7qzunvzx4cdqya80wvnrsmzyt9069d3gwhu5p --gas 600000 --gas-prices 0.005uatom --generate-only > delegate-unsigned-2.json
    ```

  > Note that the gas limit must be adjusted to accommodate the additional messages.

2. Compile messages into a single transaction
  The following commands will create an unsigned transaction by collecting the message from `delegate-unsigned-2.json` and inserting it into the body of `delegate-unsigned-1.json`.
    ```
    message2=$(jq '.body.messages' delegate-unsigned-2.json)
    jq --argjson message $message2 '.body.messages += $message' delegate-unsigned-1.json > delegate-unsigned.json
    ```
3. Sign the unsigned transaction
   ```
   gaiad tx sign delegate-unsigned.json --from <delegator> --output-document delegate-signed.json
   ```
4. Broadcast transaction ([example on-chain data](https://explorer.polypore.xyz/provider/tx/F215B5B23B3D866B7F0044C086138357663611C228410D37871334A5CA8B29AB))
   ```
   gaiad tx broadcast delegate-signed.json
   ```

## Quiz time

Can you merge messages to accomplish the following in the same transaction?
1. Delegate to and tokenize shares from a validator (combine `staking` and `liquid` module messages)
2. Fund an account and grant it a delegation authorization with authz (combine `bank` and `authz` module messages)

### Question 1 transaction

1. Generate a staking delegate transaction
   ```
   gaiad tx staking delegate <cosmosvaloper> <amount> --from <delegator> --gas 1000000 --gas-prices 0.005uatom --generate-only | jq '.' > delegate-unsigned.json
   ```
3. Generate a liquid tokenize-share transaction
   ```
   gaiad tx liquid tokenize-share <cosmosvaloper> <amount> <owner address> --from <delegator> --gas 1000000 --gas-prices 0.005uatom --generate-only | jq '.' > tokenize-unsigned.json
   ```
4. Merge messages
   ```
   message2=$(jq '.body.messages' tokenize-unsigned.json)
   jq --argjson message $message2 '.body.messages += $message' delegate-unsigned.json > delegate-tokenize-unsigned.json
   ```
5. Sign transaction
   ```
   gaiad tx sign delegate-tokenize-unsigned.json --from <delegator> --output-document delegate-tokenize-signed.json
   ```
6. Broadcast transaction
   ```
   gaiad tx broadcast delegate-tokenize-signed.json
   ```

### Question 2 transaction

1. Generate a bank send transaction
   ```
   gaiad tx bank send <sender> <recipient> <amount> --from <sender> --gas 1000000 --gas-prices 0.005uatom --generate-only | jq '.' > fund-unsigned.json
   ```
2. Create authz grantee account (optional)
   ```
   gaiad keys add grantee
   ```
3. Generate an authz grant transaction
   ```
   gaiad tx authz grant <grantee> delegate --from <sender> --allowed-validators <comma-separated-validators-list> --gas 1000000 --gas-prices 0.005uatom --generate-only | jq '.' > grant-unsigned.json
   ```
4. Merge messages
   ```
   message2=$(jq '.body.messages' grant-unsigned.json)
   jq --argjson message $message2 '.body.messages += $message' fund-unsigned.json > fund-grant-unsigned.json
   ```
5. Sign transaction
   ```
   gaiad tx sign fund-grant-unsigned.json --from <sender> --output-document fund-grant-signed.json
   ```
6. Broadcast transaction
   ```
   gaiad tx broadcast fund-grant-signed.json