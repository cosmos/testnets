## Feemarket module demo results

The following tables list the parameters and results for all parameter change rounds from demo day 22.
* 30 high-gas transactions were submitted per round.

### Parameters

| Parameter          | Baseline | Round 1   | Round 2           | Round 3           | Round 4 | Round 5   | Round 6           | Round 7           |
| ------------------ | -------- | --------- | ----------------- | ----------------- | ------- | --------- | ----------------- | ----------------- |
| alpha              | 0.0      | **0.005** | 0.0               | **0.005**         | 0.0     | **0.005** | 0.0               | **0.005**         |
| beta               | 1.0      | 1.0       | 1.0               | 1.0               | 1.0     | 1.0       | 1.0               | 1.0               |
| gamma              | 0.0      | 0.0       | 0.0               | 0.0               | 0.0     | 0.0       | 0.0               | 0.0               |
| delta              | 0.0      | 0.0       | **0.00000000001** | **0.00000000001** | 0.0     | 0.0       | **0.00000000001** | **0.00000000001** |
| min_base_gas_price | 0.005    | 0.005     | 0.005             | 0.005             | 0.005   | 0.005     | 0.005             | 0.005             |
| min_learning_rate  | 0.125    | 0.125     | 0.125             | 0.125             | 0.125   | 0.125     | 0.125             | 0.125             |
| max_learning_rate  | 0.125    | **0.25**  | 0.125             | **0.25**          | 0.125   | **0.25**  | 0.125             | **0.25**          |
| window             | 1        | 1         | 1                 | 1                 | **5**   | **5**     | **5**             | **5**             |

### Results

| Round    | Highest gas price (uatom) | Total gas fees paid (ATOM) |
| -------- | ------------------------- | -------------------------- |
| Baseline | 0.070118                  | 55.251                     |
| Round 1  | 0.007913                  | 13.914897                  |
| Round 2  | 0.005736                  | 11.510418                  |
| Round 3  | 1.030843                  | 416.868343                 |
| Round 4  | 0.070119                  | 55.252198                  |
| Round 5  | 0.077569                  | 59.048812                  |
| Round 6  | 0.005539                  | 11.365428                  |
| Round 7  | 0.305739                  | 176.392147                 |
