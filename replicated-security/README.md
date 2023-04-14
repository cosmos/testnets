# Replicated Security Persistent Testnet

The Replicated Security (RS) persistent testnet will be used to test Interchain Security features.

This testnet includes the following:
* A provider chain
* Consumer chains
* Relayers
* Block explorers
* Faucets

## Status

> Note that there will be three directories for different Neutron rehearsal chains:
> * `neutron-rehearsal-1` (stopped)
> * [`neutron-rehearsal-fix-1`](/replicated-security/neutron-rehearsal-fix-1/) (live)
> * `neutron-rehearsal-final-1` (scheduled, chain ID subject to change)

### Live Chains

* Provider: [`provider`](/replicated-security/provider/README.md)
* Consumer: [`baryon-1`](/replicated-security/baryon-1/README.md)
* Consumer: [`neutron-rehearsal-fix-1`](/replicated-security/neutron-rehearsal-fix-1/README.md)

### Stopped Chains

* Consumer: [`timeout-1`](/replicated-security/timeout-1/README.md)
* Consumer: [`timeout-2`](/replicated-security/timeout-2/README.md)
* Consumer: [`timeout-3`](/replicated-security/timeout-3/README.md)
* Consumer: [`consumer-1`](/replicated-security/consumer-1/README.md)
* Consumer: [`slasher`](/replicated-security/slasher/README.md)
* Consumer: [`noble-1`](/replicated-security/noble-1/README.md)
* Consumer: [`removeme`](/replicated-security/removeme/README.md)
* Consumer: [`neutron-rehearsal-1`](/replicated-security/neutron-rehearsal-1/README.md)

## Upcoming Events

See the [RS testnet schedule](SCHEDULE.md) for consumer chain launches and other planned events.

## How to Join

To join the Replicated Security testnet, you can run the reference bash script for each of the chains that are currently live.

If you want to run a validator, you will need to run a binary for the provider as well as all live consumer chains. One way to do this is as follows:

1. Join the [provider chain](https://github.com/cosmos/testnets/tree/master/replicated-security/provider#how-to-join).
2. Join all the consumer chains currently online using the same key files as your provider chain node:
   * [baryon-1](https://github.com/cosmos/testnets/tree/master/replicated-security/baryon-1#how-to-join)
   * [neutron-rehearsal-fix-1](https://github.com/cosmos/testnets/tree/master/replicated-security/neutron-rehearsal-fix-1#how-to-join)
3. Request funds from the provider chain [faucet](https://faucet.rs-testnet.polypore.xyz).
4. Create a [validator](https://github.com/cosmos/testnets/tree/master/replicated-security/provider#creating-a-validator).
