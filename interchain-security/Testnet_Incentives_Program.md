# Testnet Incentive Program (TIP)

Since November 2023, Hypha has worked with AADAO to give testnet validators the opportunity to earn ATOM for participating on the ICS testnet. This Testnets Incentives Program is meant to incentivize high quality validator performance on the ICS testnet on a per-month basis.

The ICS testnet is **public**, meaning that anyone can join, run a validator, and learn about gaia node operations and new features on the Cosmos Hub. 

**However** – only active mainnet validators who run all Top N consumer chains are eligible for payments from TIP. 


## Quick links
* Join the ICS testnet by following the instructions [here](VALIDATOR_JOINING_GUIDE.md)
* Register using the Google form [here](https://docs.google.com/forms/d/e/1FAIpQLSeXlXu89uyAgsfck0wpjtUVqaXWRzyJQwLMM-9dlJk9WIH3Zg/viewform)
  * Resubmit this form if either your `provider` or `cosmoshub-4` keys change
* Stay tuned for Testnet Tuesday events by following our schedule [here](SCHEDULE.md) (and in Discord)
* Track validator participation using the Google sheet [here](https://docs.google.com/spreadsheets/d/1CR-gtLgHUXvP2Ww8KFqnOej7ma_GwDjNt8IhdTXbGGw/edit?gid=1605434271#gid=1605434271)


## How do I register?

You can register by filling out our [Google form](https://forms.gle/G6VB3uc1KUa54ht39). You only need to register once (unless either your mainnet or testnet validator address change).

In order for us to track your participation, we need to have an on-chain way to confirm that your mainnet validator and testnet validator are associated with one another (otherwise, some random person could claim to be a mainnet validator and claim the incentives)!

We accept two ways of proving this:

1. Memo: Using your **mainnet** validator wallet, send a trivial amount of ATOM to our multisig address (`cosmos1078gmgntta9qguve7c52dhxrs45xumjvcwrutd`). In the memo field, put the cosmovaloper address of your **testnet** validator. Do NOT put the address of your mainnet validator.
2. Email: Using the email in your mainnet validator’s security contact, email [project.cosmos@hypha.coop](mailto:project.cosmos@hypha.coop) and tell us the cosmovaloper address of your **testnet** validator . Reminder -- you can edit your security contact using the following command: `gaiad tx staking edit-validator --security-contact <contact info> --from <self-delegation address>`

⚠️ If either your mainnet or testnet address changes (due to tombstoning, for example), you **must** notify us to remain eligible. Your key is your identity – we can’t process changes in identity without hearing from you!


## What are the criteria for getting paid?
Each period, we evaluate the following three criteria:
* **Criteria 1:** Be an active mainnet validator. Submit proof via our Google form
* **Criteria 2.1:** Validate all available Top N consumer chains secured by the Cosmos Hub (Neutron and Stride) with > 50% uptime.
* **Criteria 2.2:** Use *assigned consumer keys* for all available Top N consumer chains (i.e., do not reuse your Hub key).
* **Criteria 3:** Run a testnet infrastructure setup that closely mimics mainnet. 

If you meet these three criteria (most testnet validators do), you can participate in testnet events and earn points. At the end of each period, we'll translate those points into USDC and pay you for your testnet work! There are even bonus points for completing all events perfectly and remaining unjailed.

Validators can typically track all criteria except for **participation** using their own monitoring and awareness of their options. We publish results for **participation** in this public [Google Sheet](https://docs.google.com/spreadsheets/d/1CR-gtLgHUXvP2Ww8KFqnOej7ma_GwDjNt8IhdTXbGGw/edit?gid=1605434271#gid=1605434271) throughout the period and erase it at the end of a period after payments have been made. 


## Do you ever make exceptions?

We occasionally make exceptions for an entire event for **jailing** and ** perfect participation** depending on how the testnet is behaving. 
* Exceptions for **participation** mean we will remove an event and not count it at all. This sometimes happens if we give incorrect instructions or fail to announce an event with enough lead time.
* Exceptions for **jailing** occur when there’s a widespread event that impacts many validators. For example, if a bug is discovered during an upgrade and it leads to many validators being jailed, we might make an exception and not count that jailing incident for the period. 

We also sometimes make exceptions for:
* **Intentional experimentation communicated in advance.** For example: trying to double sign and getting tombstoned for it, trying a new cosmovisor setting and missing a 5 block signing window because it doesn’t work.
* **Quick diagnosis and resolution of issues**, possibly involving submitting logs for debugging. For example, being jailed due to a faulty snapshot, informing the snapshot provider, unjailing, and emailing [project.cosmos@hypha.coop](mailto:project.cosmos@hypha.coop) within 24 hours (~15,000 blocks) of being jailed to explain the situation.

‼️ In order to process an exception, you **must** contact us in advance or within 24 hours. ‼️

Once a period is completed and payments have been made, there will be no changes made retroactively.
