function Y = CorBrownian(mu,E, sampleSize)
    % Algorithm generates samples of increments from a correlated Brownian motion with a given mean and Variance-Covariance matrix (E). 
    % The algorithm uses the fact that if you have n independent brownian motions, the samples given by "mu+ C*Z" are distributed as N(mu,E), where mu is the vector of means and C is the square root of the Variance-Covariance matrix.
    % For calculating the square root of the VarCovar matrix, the Cholesky decomposition is implemented.
    % Arguments:
    %    mu         = vector with n elements containing the mean of each BM  
    %    E          = n x n Variance-Covariance matrix 
    %    sampleSize = integer representing the number of samples
    % 
    % Returns:
    %     sampleSize x n matrix containing sampled increments for the correlated Brownian motion
    %      
    % Note: 
    %  The algorithm is not optimized for speed and no testing of inputs is implemented. If this would be usefull to you, let us know and we can extend the code.
    %
    % Example of use:
    % mu = [1; 0];
    % VarCovar = [1.5,0.8; 0.8,2];
    % sampleSize = 5;
    % CorBrownian(mu, VarCovar, sampleSize)
    % ans =
    %     0.8406   -1.4282
    %     2.5647   -1.9239
    %     1.1557    2.9384
    %    -0.6874   -0.8918
    %     0.2343    1.6925

    dim = size(E,1);                    % Guess the number of Brownian motions (dimension) from the size of the Var-Covar matrix
    Z = normrnd(0,1,[dim, sampleSize]); % Generate independent increments of a simpleSize dimensional Brownian motion
    Y = zeros(sampleSize, dim);         % Predefine the final output
    L = Cholesky(E);                    % Calculate the square root of the Var-Covar matrix

    for iSample = 1: sampleSize % For each sample, calculate mu + L*Z
        Y(iSample,:) = mu +  L * Z(:,iSample);     
    end
end % function