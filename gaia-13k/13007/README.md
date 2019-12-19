# GenTx Generation

1. Initialize the gaia directories and create the local genesis file with the correct
   chain-id

   ```shell
   $ gaiad init monikername --chain-id=gaia-13007
   ```

2. Create a local key pair in the Keybase

   ```shell
   $ gaiacli keys add <key-name>
   ```

3. Add your account to your local genesis file with a given amount and the key you
   just created.

   ```shell
   $ gaiad add-genesis-account $(gaiacli keys show <key-name> -a) 50000000000umuon
   ```

4. Create the gentx

   ```shell
   $ gaiad gentx --amount 50000000000umuon \
     --commission-rate=<rate> \
     --commission-max-rate=<max-rate> \
     --commission-max-change-rate=<max-change-rate-rate> \
     --pubkey $(gaiad tendermint show-validator) \
     --name=<key-name>
   ```
