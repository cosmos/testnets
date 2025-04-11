# Testnet Tuesday: Build Environment Census

* 2025-Apr-8
* Start time: `13:30 UTC`
* End time: `20:00 UTC`

We will use this Testnet Tuesday to run a census on the environments that validators use to build their Gaia binaries via on-chain transactions.

## Instructions

* Please provide the following information through the `note` field in a bank send to address `cosmos1fs07c7rnus4ze5w39xwachpq0xuqvxfyv07a88` in the `provider` chain.
    * CPU (`Model name` field from `lscpu`)
    * CPU Flags (`Flags` field from `lscpu`)
    * OS + distribution
    * Go version
    * Gaia version
    * Release/Build
      * "Release" if you used the binary from the releases page, or "Build" if you built the binary from source
    * Any build flags you used
    * Linker version (from `ld --version`)
    * Any build errors or warnings you found in this environment
    * Any runtime errors you found in this environment
* Send the transaction from your self-delegation wallet so we can assign points for participation.
* You can use the following commands as reference:
```
gaiad tx bank send <your self-delegation wallet> \
cosmos1fs07c7rnus4ze5w39xwachpq0xuqvxfyv07a88 1uatom --note \
'
CPU: Intel(R) Xeon(R) CPU X5667 @ 3.07GHz
CPU flags:
fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq vmx ssse3 cx16 pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes hypervisor lahf_lm cpuid_fault pti ssbd ibrs ibpb stibp tpr_shadow flexpriority ept vpid tsc_adjust arat vnmi umip flush_l1d arch_capabilities
OS/distribution: Ubuntu 24.04.2 LTS 6.8.0-57-generic
Go version: v1.23.6
Gaia version: v23.0.1
Release/build: Build
Build flags:
CGO_CFLAGS="-O -D__BLST_PORTABLE__"
CGO_CFLAGS_ALLOW="-O -D__BLST_PORTABLE__"
ld version: (Ubuntu GLIBC 2.39-0ubuntu8.4) 2.39
Build errors: None
Runtime errors: None
' \
--gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
```
```
gaiad tx bank send <your self-delegation wallet> \
cosmos1fs07c7rnus4ze5w39xwachpq0xuqvxfyv07a88 1uatom --note \
'
CPU: Intel(R) Xeon(R) CPU X5667 @ 3.07GHz
CPU flags:
fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq vmx ssse3 cx16 pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes hypervisor lahf_lm cpuid_fault pti ssbd ibrs ibpb stibp tpr_shadow flexpriority ept vpid tsc_adjust arat vnmi umip flush_l1d arch_capabilities
OS/distribution: Ubuntu 24.04.2 LTS 6.8.0-57-generic
Go version: v1.23.6
Gaia version: v23.0.1
Release/build: Build
Build flags: None
ld version: (Ubuntu GLIBC 2.39-0ubuntu8.4) 2.39
Build errors: None
Runtime errors: 
gaiad version
Caught SIGILL in blst_cgo_init, consult <blst>/bindings/go/README.md.
' \
--gas auto --gas-adjustment 3 --gas-prices 0.005uatom -y
````


### Testnet Incentives Program (TIP) Eligibility

This event will be part of the April 2025 TIP period and will be worth **one point**.
* (**1 point**) Task 1: Send your build specs to `cosmos1fs07c7rnus4ze5w39xwachpq0xuqvxfyv07a88`.
