function L = Cholesky(X)
    % Cholesky–Banachiewicz algorithm decomposes a Hermitian matrix into a product of a lower triangular matrix and its conjugate transpose.
    % Arguemnts:
    %    X = n x n matrix representing a Hermitian matrix that the user wants to decompose
    % Returns:
    %    n x n lower triangular matrix such that the matrix product between it and its conjugate transpose returns X
    % 
    % More info on: https://en.wikipedia.org/wiki/Cholesky_decomposition#The_Cholesky.E2.80.93Banachiewicz_and_Cholesky.E2.80.93Crout_algorithms
    %
    % Example of use
    % X = [4, 12, -16; 12, 37,-43; -16, -43, 98];
    % Cholesky(X)
    % ans =
    %     2     0     0
    %     6     1     0
    %    -8     5     3

    n = size(X, 1);
    L = zeros(n, n);
    
    for i = 1:n
        for j = 1:i
            sum = 0;
            for k = 1: j
                sum = sum + L(i, k)*L(j, k);
            end
            if (i==j)
                L(i, j) = sqrt(X(i, i)-sum);
            else
                L(i, j) = 1/L(j, j) * (X(i, j)-sum);
            end
        end
    end
end % Cholesky(X)


