# Frequently Asked Questions

* Can I assign a consensus keys while a consumer-addition proposal is in voting period?
  * Yes.
* Can I assign a consensus key during the voting period for a consumer-addition proposal if I am not in the top N?
  * Yes.
* Can I opt in to an Opt-in chain after its consumer-addition proposal voting period is over but before the spawn time?
  * Yes.
* Can I opt in to an Opt-in chain after the spawn time if nobody else opted in?
  * No, the consumer chain will not be added if nobody opted in by the spawn time. At least one validator, regardless of its voting power, must opt in before the spawn time arrives so the chain can start.
* Can all validators opt out of an Opt-in chain?
  * Yes, the consumer chain will halt with an `ERR CONSENSUS FAILURE` error after the opt-out message for the last validator is received.
* Can I set a commission rate for a chain I have not opted in to?
  * Yes.
