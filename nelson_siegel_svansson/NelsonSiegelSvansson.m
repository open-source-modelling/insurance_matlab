function out = NelsonSiegelSvansson(T, beta0, beta1, beta2, beta3, lambda0, lambda1)
    % NelsonSiegelSvansson calculates the interpolated/extrapolated curve at points in the array "T" using the Nelson-Siegel-Svannson algorithm,
    % parameterized with parameters beta0, beta1, beta2, beta3, lambda0, and lambda1. It returns a vector of points.
    % 
    % Arguments:
    %    T =       n x 1 vector of maturities for which the user wants to calculate the coresponding rate
    %    beta0 =   1 x 1 floating number, representing the first factor of the NSS parametrisation  
    %    beta1 =   1 x 1 floating number, representing the second factor of the NSS parametrisation 
    %    beta2 =   1 x 1 floating number, representing the third factor of the NSS parametrisation
    %    beta3 =   1 x 1 floating number, representing the fourth factor of the NSS parametrisation
    %    lambda0 = 1 x 1 floating number, representing the first shape parameter lambda of the NSS parametrisation
    %    lambda1 = 1 x 1 floating number, representing the second shape parameter lambda of the NSS parametrisation 
    % 
    % Returns:
    %     n x 1 vector of interpolated/extrapolarted points coresponding to maturities inside T. Where n is the length of the vector T.
    % 
    % https://www.bis.org/publ/bppdf/bispap25l.pdf
    
    alpha1 = (1 - exp(-T ./ lambda0)) ./ (T ./ lambda0);
    alpha2 = alpha1 - exp(-T ./ lambda0);
    alpha3 = (1 - exp(-T ./ lambda1)) ./ (T ./ lambda1) - exp(-T ./ lambda1);

    out = beta0 + beta1*alpha1 + beta2*alpha2 + beta3*alpha3;
end
