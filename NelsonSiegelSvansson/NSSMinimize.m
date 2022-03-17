function out = NSSMinimize(beta0, beta1, beta2, beta3, lambda0, lambda1, TimeVec, YieldVec)
    % NSSMinimize uses the built-in Matlab function "fminsearch". The Euclidian norm is used as a measure of distance between the forcasted numbers and the observed data.
    % If the optimization does not converge, the function returns an empty vector.  
    %
    % Arguments:
    %    beta0 =    1 x 1 floating number, representing the first factor of the NSS parametrisation  
    %    beta1 =    1 x 1 floating number, representing the second factor of the NSS parametrisation 
    %    beta2 =    1 x 1 floating number, representing the third factor of the NSS parametrisation
    %    beta3 =    1 x 1 floating number, representing the fourth factor of the NSS parametrisation
    %    lambda0 =  1 x 1 floating number, representing the first shape parameter lambda of the NSS parametrisation
    %    lambda1 =  1 x 1 floating number, representing the second shape parameter lambda of the NSS parametrisation 
    %    TimeVec =  n x 1 vector of maturities for which the yields in YieldVec were observed
    %    YieldVec = n x 1 vector of observed yields 
    % 
    % Returns:
    %     6 x 1 vector of parameters and factors, that best fit the observed yields (or an empty array if the optimization was not successfull).
    %
    % https://docs.scipy.org/doc/scipy/reference/optimize.minimize-neldermead.html
    % https://en.wikipedia.org/wiki/Nelder%E2%80%93Mead_method
    
    fun = @(params)sum((NelsonSiegelSvansson(TimeVec, params(1), params(2), params(3), params(4), params(5), params(6))-YieldVec).^2); 
    [opt_sol,~,isSuccess] = fminsearch(fun, [beta0; beta1; beta2; beta3; lambda0; lambda1]);
    if (isSuccess)
        out = opt_sol;
    else
        out = [];
    end
end

