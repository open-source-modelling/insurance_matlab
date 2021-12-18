A block resampling method used for weakly-dependent stationary time-series data proposed in the 1994 paper by [Politis & Romano](https://www.researchgate.net/publication/254287565_The_Stationary_Bootstrap).

## Problem
When using non-parametric tools to generate counterfactual scenarios or empirical distributions, bootstrapping methods proved to be a powerful and easy-to-use tools. However, the bootstrap in its simplest implementation assumes a time-series in which observations are independent. In a lot of applications this is not the case.

An example of this is interest rate modelling when business cycles need to be considered. The presence of business cycles makes the time-series weakly time dependent. To account for this, block-resampling techniques are used.

## Solution

Stationary bootstrap is a block-resampling technique that relaxes the assumption of a fixed length of a sampling block. The user still needs to specify an average length, but because this is true only on average, shorter/longer blocks are also present in the final sample.
The algorithm works by randomly selecting a starting point in the time-series and at each step it either increases the block size by one or selects a new block with a new starting point. This choice happens with a fixed probability governed by the parametrisation.

### Input
 - A time-series that you want to bootstrap
 - The parameter m describing the average duration of the blocks in the sample
 - The length of the output sample
 
 ### Output
  - Vector of bootstrapped values of specified length

## Getting started

Given the time-series with observed values 1, 2, 3, 4, 5, 6, 7, 8, 9, and 10, the user is looking to bootstrap a new sample of length 9 where the average block is of size 4. 

```matlab

data = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10];
StationaryBootstrap(data, 4, 9)

>> ans = [6; 5; 6; 7; 8; 9; 9; 10; 1]
```

## Calibration of the parameter

For the calibration of the parameter, a really good source is Andrew J. Patton's implementation that can be found here: http://public.econ.duke.edu/~ap172/

## Example script
Script IRS_Example.m contains an example of bootstrapping the EURO denominated 6M interest-rate-swap rate. Data is obtained from the Italian stock exchange: https://www.teleborsa.it/Quotazioni/Tassi/Eurirs for date 12/11/2021.


