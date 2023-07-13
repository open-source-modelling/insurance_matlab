function b = SWCalibrate(r, M, ufr, alpha)
% SWCALIBRATE Calculate the calibration vector using a Smith-Wilson algorithm
% b = SWCalibrate(r, T, ufr, alpha) calculates the vector b used for
% interpolation and extrapolation of rates.
%
% Input description: 
%    r =     n x 1 vector of rates, on which you wish to calibrate the algorithm. Each rate belongs to an observable zero coupon bond with a known maturity. Ex. r = [0.0024; 0.0034]
%    M =     n x 1 vector of maturities of bonds, that have rates provided in input (r). Ex. u=[1; 3]
%    ufr =   1 x 1 floating number, representing the ultimate forward rate. Ex. ufr = 0.042
%    alpha = 1 x 1 floating number representing the convergence speed parameter alpha. Ex. alpha = 0.05
%
% Output description:
%    b = n x 1 calibration vector needed to interpolate and extrapolate
%    rates
% For more information see https://www.eiopa.europa.eu/sites/default/files/risk_free_interest_rate/12092019-technical_documentation.pdf

    C = eye(numel(M));
    p = (1+r).^(-M);              % Transform rates to implied market prices of a ZCB bond
    d = exp(-log(1+ufr) .* M);    % Calculate vector d described in paragraph 138
    Q = diag(d) * C;                  % Matrix Q described in paragraph 139
    q = C'*d;                         % Vector q described in paragraph 139
    H = SWHeart(M, M, alpha); % Heart of the Wilson function from paragraph 132
    b = (Q' * H * Q)\(p-q);           % Calibration vector b from paragraph 149
end