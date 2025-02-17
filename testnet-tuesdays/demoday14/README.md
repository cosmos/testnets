# Testnet Demo Day # 14: 2025-Feb-18

In this demo day, we will demonstrate how to recover an expired IBC client.


## Testnet Incentives Program (TIP) Eligibility

* You must complete the task listed below by the time the event ends to earn points for the 2025 Feb TIP period.
* Available points: 1

### Tasks

* (1 point) Task 1: Vote YES on the IBC client recovery proposal. The proposal ID will be announced during the event.


## IBC Client Recovery

The starting status of the IBC client in the `provider` chain is `Expired`: 
```
gaiad q ibc client status 07-tendermint-234
status: Expired
```

### Step 1: Create a new client

```
hermes create client --host-chain provider --reference-chain test-ibcrecovery-1
```

### Step 2: Pass an IBC Client Recovery Proposal

```json
{
 "messages": [
  {
   "@type": "/ibc.core.client.v1.MsgRecoverClient",
   "subject_client_id": "07-tendermint-234",
   "substitute_client_id": "07-tendermint-TBD",
   "signer": "cosmos10d07y265gmmuvt4z0w9aw880jnsr700j6zn9kn"
  }
 ],
 "metadata": "ipfs://CID",
 "deposit": "1500000000uatom",
 "title": "Recover 07-tendermint-234",
 "summary": "Replace 07-tendermint-234 with 07-tendermint-TBD",
 "expedited": false
}
```

### Step 3: Confirm the client is active again 

```
gaiad q ibc client status 07-tendermint-234
```
