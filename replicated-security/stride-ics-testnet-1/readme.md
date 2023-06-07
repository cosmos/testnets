How will the sovereign -> consumer chain transition work on the Replicated Security testnet?

* Stride side: The Stride team is running their own testnet (chain-id: stride-ics-testnet-1). That testnet will perform a software upgrade and at the upgrade height (shortly after the spawn time) it will transition to the provider chain’s validator set.
* Provider side: There will be a consumer-addition proposal for the stride chain. Shortly after the spawn time, we will receive the CCV state. This CCV state will be used to patch the original stride chain’s genesis file.

What do you need to do to participate in the launch on Wednesday?
See the attached image for a breakdown of steps you'll need to follow throughout the process. 

## ⚠️  Complete STEP 1 (join Stride testnet with a full node) ASAP ⚠️
Follow along with Stride's block explorer here: https://ics-explorer.stride.zone/stride 

For step 1, you can try using Stride’s joining script here: https://github.com/Stride-Labs/mainnet/blob/ics-testnet/ics-testnet/join_ics_testnet.sh 

Otherwise you may manually join stride-ics-testnet-1 using these notes:
* Joining instructions: https://github.com/Stride-Labs/mainnet/tree/ics-testnet/ics-testnet
* Genesis file: https://raw.githubusercontent.com/Stride-Labs/mainnet/ics-testnet/ics-testnet/genesis.json
* Pre-transition stride binary commit: 3aeb075f36cb12711201a7f17e8b8d856bd99a01
* Stride’s GitHub repository: https://github.com/stride-Labs/stride
* Building instructions for stride’s binary: `make install`


* Go version: 1.19
* Chain ID: stride-ics-testnet-1
* Persistent Peers ="cd34b9f506a4840d5ea69095403029056862a2e1@stride-direct.testnet-2.stridenet.co:26656"
* Post-upgrade stride binary commit (run with this binary after the upgrade): 17fa2fd7802005a7af09e6d2d0f5126b4bf1e10f



| # | When? | Provider side | Stride side |
| -- | --- | ----- | ---- |
| 1 | Now | | Join the Stride testnet `stride-ics-testnet-1` with the pre-transition binary (commit hash `3aeb075f3`) as a full node (not validator) and sync to the tip of the chain (link to instructions below). |
| 2 | Now until software upgrade proposal passes on Stride | | Build (or download) the target (post-transition) Stride binary. <br><br>If you are using Cosmovisor, place place it in Cosmovisor `/upgrades/<upgrade-name>/bin` directory.<br><br>If you are not using Cosmovisor, be ready to manually switch your binary at the upgrade halt height. |
| 3 | Now until spawn time (15:00 UTC) | Submit assign-consensus-key for stride-ics-testnet-1 with the keys on your full node (**note: make sure to do this before spawn time!)** | |
| 4 | During voting period for  consumer-addition proposal on provider | You don’t have to do anything. Optionally, you may vote for the consumer-addition proposal | |
| 5 | During voting period for software upgrade on Stride | | You don’t have to do anything. |
| 6 | After spawn time | | Place the newly generated “genesis” file (containing only the ccv state) in the ⚠️ `$HOME/.sovereign/config directory` ⚠️ Stride will provide this.<br><br>Do NOT replace the existing genesis file. |
| 7 | When the software upgrade height is reached | | At the halt height, your node will halt.<br><br>Please upgrade to the  binary and ensure your genesis file has the CCV state from the provider chain |

