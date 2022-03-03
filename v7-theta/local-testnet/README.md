# Local testnet upgrade instructions

TODO

## Genesis Modifications

Full list of modifications are as follows:

* Swapping chain id to theta-localnet
* Increasing balance of cosmos1wvvhhfm387xvfnqshmdaunnpujjrdxznr5d5x9 by 175000000000000 uatom
* Increasing supply of uatom by 175000000000000
* Increasing balance of cosmos1wvvhhfm387xvfnqshmdaunnpujjrdxznr5d5x9 by 1000 theta
* Increasing supply of theta by 1000
* Creating new coin theta valued at 1000
* Increasing balance of cosmos1wvvhhfm387xvfnqshmdaunnpujjrdxznr5d5x9 by 1000 rho
* Increasing supply of rho by 1000
* Creating new coin rho valued at 1000
* Increasing balance of cosmos1wvvhhfm387xvfnqshmdaunnpujjrdxznr5d5x9 by 1000 lambda
* Increasing supply of lambda by 1000
* Creating new coin lambda valued at 1000
* Increasing balance of cosmos1wvvhhfm387xvfnqshmdaunnpujjrdxznr5d5x9 by 1000 epsilon
* Increasing supply of epsilon by 1000
* Creating new coin epsilon valued at 1000
* Increasing balance of cosmos1fl48vsnmsdzcv85q5d2q4z5ajdha8yu34mf0eh by 550000000000000 uatom
* Increasing supply of uatom by 550000000000000
* Increasing delegator stake of cosmos1wvvhhfm387xvfnqshmdaunnpujjrdxznr5d5x9 by 550000000000000
* Increasing validator stake of cosmosvaloper1wvvhhfm387xvfnqshmdaunnpujjrdxznxqep2k by 550000000000000
* Increasing validator power of D5AB5E458FD9F9964EF50A80451B6F3922E6A4AA by 550000000
* Swapping min governance deposit amount to 1uatom
* Swapping tally parameter quorum to 0.000000000000000001
* Swapping tally parameter threshold to 0.000000000000000001
* Swapping governance voting period to 60s
* Swapping staking unbonding_time to 1s

Please note that you'll need to set `fast-sync` to false in your `config.toml` file and wait for approximately 10mins for a single node testnet to start. This is due to an [issue](https://github.com/osmosis-labs/osmosis/issues/735) with state export based testnets that can't get to consensus without multiple peered nodes.