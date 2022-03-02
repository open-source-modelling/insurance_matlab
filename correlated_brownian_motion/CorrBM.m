%E = [4,12,-16; 12,37,-43;-16,-43,98];
%Cholesky(E)
mu = [1;0];
VarCovar = [1.5,0.8; 0.8,2];
sampleSize = 5;
CorBrownian(mu, VarCovar, sampleSize)

%VarCovar = np.matrix('1.5, 0.8; 0.8, 2')
