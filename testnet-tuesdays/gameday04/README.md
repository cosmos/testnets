# Testnet Game Day # 4: 2024-Nov-13

For our fourth game day, we're gonna do a scavenger hunt to find limited
edition ibc tokens from the soon-to-be-sunset `theta` chain. We'll post
announcements in the `testnet-announcements` channel in Discord activities
during the event.

* Start time: `2024-11-13 15:30 UTC`
* It will end when someone claims the tokens!

## Scavenger hunt

One of each `theta`, `rho`, `epsilon`, and `lambda` ibc tokens from the `theta`
testnet has been transferred to account
`cosmos1er3gr2yvsgqzk66ctvj9kaz9cl37ffn6rranyt` in the `provider` chain.

We've split the account's mnemonic into four shards, and hid them around the
chain. If you find them and reconstruct the mnemonic, you win. Your clues:

1. One validator description contains the word "treasure."
2. The last word of every sentence of a certain signalling proposal is part of the mnemonic.
3. There is a consumer chain with an allowlisted reward denom that contains mnemonic words.
4. There's a transaction of type `/cosmos.feegrant.v1beta1.MsgGrantAllowance` that contains the word "treasure" in its memo field.

The 4 shards are not in order (1-4), so you'll have to reconstruct the original order.

### Testnet Incentives Program (TIP) Eligibility

**This is NOT a TIP event.**
