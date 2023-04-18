# Replicated Security Persistent Testnet

The Replicated Security (RS) persistent testnet will be used to test Interchain Security features.

This testnet includes the following:
* A provider chain
* Consumer chains
* Relayers
* Block explorers
* Faucets

## Status

#### Next consumer chain launch: Neutron

> Note that there will be three directories for different Neutron rehearsal chains:
> * `neutron-rehearsal-1` (stopped)
> * [`neutron-rehearsal-fix-1`](/replicated-security/neutron-rehearsal-fix-1/) (live)
> * [`pion-1`](/replicated-security/pion-1) (live)
>   * This is Neutron's final rehearsal chain which will replace baryon-1 as new persistent chain.

### Live Chains

* Provider: [`provider`](/replicated-security/provider/README.md)
* Consumer: [`neutron-rehearsal-fix-1`](/replicated-security/neutron-rehearsal-fix-1/README.md)
* Consumer: [`pion-1`](/replicated-security/pion-1/README.md)

### Stopped Chains

* Consumer: [`timeout-1`](/replicated-security/timeout-1/README.md)
* Consumer: [`timeout-2`](/replicated-security/timeout-2/README.md)
* Consumer: [`timeout-3`](/replicated-security/timeout-3/README.md)
* Consumer: [`consumer-1`](/replicated-security/consumer-1/README.md)
* Consumer: [`slasher`](/replicated-security/slasher/README.md)
* Consumer: [`noble-1`](/replicated-security/noble-1/README.md)
* Consumer: [`removeme`](/replicated-security/removeme/README.md)
* Consumer: [`neutron-rehearsal-1`](/replicated-security/neutron-rehearsal-1/README.md)
* Consumer: [`baryon-1`](/replicated-security/baryon-1/README.md)

## Upcoming Events

See the [RS testnet schedule](SCHEDULE.md) for consumer chain launches and other planned events.

## How to Join

See linked documentation to join:

* As a [validator](https://github.com/cosmos/testnets/tree/master/replicated-security/VALIDATOR_JOINING_GUIDE.md)
* As a [new consumer chain](https://github.com/cosmos/testnets/tree/master/replicated-security/CONSUMER_LAUNCH_GUIDE.md)
