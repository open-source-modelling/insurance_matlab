<h1 align="center" style="border-botom: none">
  <b>📚 Sampled increments from two or more correlated Brownian motions (BM)📚
  </b>
</h1>

</br>

Popular algorithm for generating a matrix of increments from a multidimensional Brownian motion (BM) with a given vector of means and a Variance-Covariance matrix.

## Problem

Often when using multifactor models, the model requires correlated sources of noise. A popular choice is to use a multidimensional Brownian motion.

## Solution

The proposed algorithm uses two properties of BM:
-  Increments of a BM are normally distributed.
-  assuming n independent BM's whose increments are generated from a standard normal distribution (denoted N(0,1)), a derived process 
Y = μ + L\*z has its increments distributed as N(μ, E) where μ is the vector of means and L is the square root of the Variance-Covariance matrix (denoted E in the code).

### Inputs

- Vector of means for each BM `mu`.
- Variance-Covariance matrix whose diagonal elements describe the volatility of each BM and the off-diagonal elements describe the covariance `E`.
- Number of samples needed `sampleSize`.

### Output

- Matrix of samples where each column represents a BM and each row a new increment

## Getting started

The user is interested in generating samples from 2 Brownian motions with a correlation of 0.8. Additionally, the first BM has a mean of 1 and a variance of 1.5. The second BM has a mean of 0 and a variance of 2. The user is interested in 480 samples.

```matlab

mu = [1; 0];
E = [1.5, 0.8; 0.8, 2];
sampleSize = 480;
CorBrownian(mu, E, sampleSize)
```
