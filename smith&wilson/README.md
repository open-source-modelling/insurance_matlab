Popular algorithm for interpolating and extrapolating various curves such as bond yields and risk-free rates. This implementation is based on the [Technical documentation of the Methodology to derive EIOPA's risk-free interest rate term structure](https://www.eiopa.europa.eu/sites/default/files/risk_free_interest_rate/12092019-technical_documentation.pdf) (Version published on 12/09/2019. See Section 7).

## Problem

When analysing market expectations of future rates, a common approach is to look at fixed income instruments such as government or corporate bonds that mature in the future. In practice, the maturities observable (and liquid) on the market rarely cover all the maturities that are needed.

## Solution

This implementation takes as input the available market information, parameters describing the long-term behaviour of the curve and the data on desired (target) maturities for which the yields are needed.

### Market information input

 - Observed yields of the zero-coupon bonds (ZCB)
 - Maturity of the observed ZCB

### SW Parameters
 - Ultimate froward rate ufr represents the rate to which the rate curve will converge as time increases.
 - Convergence speed parameter α controls the speed at which the curve converges towards the ufr parameter from the last liquid point (last data point available in the market information input)

### Desired output
 
 - List of maturities for which the SW algorithm will calculate the yields

Note that this implementation assumes that the yields were calculated on ZCB. This assumption can be easily relaxed in future releases.
The implementation is split in two parts: 

1. The available market data and the parameters are used to "calibrate" the algorithm. This returns a calibration vector that can be used to interpolate or extrapolate target maturities. This is done by calibrating the kernel functions. Look at the function `SWCalibrate()`
2. The yields for ZCB with targeted maturities are Interpolated/extrapolated. Look at the function `SWExtrapolate()`
 
 The syntax in the functions tries to be consistent with EIOPA technical specifications.
 
 ### Getting started
 
 Given the data on 6 ZCB with maturities of 1,2,4,5,6, and 7 years with observed yields 1%, 2%, 3%, 3.2%, 3.5% and 4% respectively. The user is interested in yields for ZCB at maturities 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20 years. The given calibration for the parameter alpha is 0.15 and the ultimate forward rate is 4%. 
The commands to calculate the target yields would be:

``` matlab
r_Obs = [0.01; 0.02; 0.03; 0.032; 0.035; 0.04]; % yields observed on the market
T_Obs = [1; 2; 4; 5; 6; 7]; % maturities of bonds observed on the market
T_Target = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 15; 20]; % Targeted maturities for interpolation/extrapolation 
ufr = 0.04; % ultimate forward rate
alpha = 0.15; % convergence speed parameter
b = SWCalibrate(r_Obs, T_Obs, ufr, alpha) % calibration vector calculation
r_Target = SWExtrapolate(T_Target, T_Obs, b, ufr, alpha) % calculation of target yields
r_Target % display target yields
```

