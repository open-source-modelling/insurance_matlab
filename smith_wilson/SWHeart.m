function H = SWHeart(u, v, alpha)
% SWHEART Calculate the heart of the Wilson function.
% H = SWHeart(u, v, alpha) calculates the matrix H (Heart of the Wilson
% function) for maturities specified by vectors u and v. The formula is
% taken from the EIOPA technical specifications paragraph 132.
% Input description: 
%    u =     n_1 x 1 vector of maturities. Ex. u = [1; 3]
%    v =     n_2 x 1 vector of maturities. Ex. v = [1; 2; 3; 5]
%    alpha = 1 x 1 floating number representing the convergence speed parameter alpha. Ex. alpha = 0.05
%
% Output description:
%    H = n_1 x n_2 matrix H representing the Heart of the Wilson function for selected maturities and parameter alpha. H is calculated as in the paragraph 132 of the EIOPA documentation. 
%
% For more information see https://www.eiopa.europa.eu/sites/default/files/risk_free_interest_rate/12092019-technical_documentation.pdf

    H = 0.5 * (alpha *(u+v') + exp(-alpha*(u+v')) - alpha*abs(u-v') - exp(-alpha* abs(u-v'))); % Heart of the Wilson function from paragraph 132
end
