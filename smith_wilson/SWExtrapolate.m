function r = SWExtrapolate(M_Target, M_Obs, b, ufr, alpha)
% SWEXTRAPOLATE Interpolate or/and extrapolate rates for targeted maturities using a Smith-Wilson algorithm.
% r = SWExtrapolate(T_Target, M_Obs, b, ufr, alpha) calculates the rates for maturities specified in M_Target using the calibration vector b.
%
% Input description: 
%    M_Target = k x 1 vector. Each element represents a bond maturity of interest. Ex. M_Target = [1; 2; 3; 5]
%    M_Obs =    n x 1 vector. Observed bond maturities used for calibrating the calibration vector b. Ex. M_Obs = [1; 3]
%    b =        n x 1 calibration vector calculated on observed bonds.
%    ufr =      1 x 1 floating number, representing the ultimate forward rate.
%       Ex. ufr = 0.042
%    alpha =    1 x 1 floating number representing the convergence speed parameter alpha. Ex. alpha = 0.05
%    rates
%
% Output description:
%    r = k x 1 vector. Represents the targeted rates for a zero-coupon bond. Each rate belongs to a targeted zero-coupon bond with a maturity from T_Target. Ex. r = [0.0024; 0.0029; 0.0034; 0.0039]
%
% For more information see https://www.eiopa.europa.eu/sites/default/files/risk_free_interest_rate/12092019-technical_documentation.pdf

    C = eye(numel(M_Obs));
    d = exp(-log(1+ufr) .* M_Obs);                                                % Calculate vector d described in paragraph 138
    Q = diag(d) * C;                                                              % Matrix Q described in paragraph 139
    H = SWHeart(M_Target, M_Obs, alpha);                                          % Heart of the Wilson function from paragraph 132
    p = exp(-log(1+ufr)* M_Target) + diag(exp(-log(1+ufr)*M_Target)) * H * Q * b; % Discount pricing function for targeted maturities from paragraph 147
    r = p.^(-1./M_Target) -1;                                                     % Convert obtained prices to rates
end