function sample = StationaryBootstrap(data, m, sampleLength)
% STATIONARY BOOTSTRAP Returns a bootstraped sample of the time-series
% "data" of length "sampleLength. The algorithm used is stationary bootstrap
% from 1994 Politis & Romano.
%    sample = StationaryBootstrap(data, m, sampleLength)
%
%% Input: 
%    data =         n x 1 vector containing the time-series that will be
%                       bootstrapped.
%    m =            1 x 1 parameter m of the stationary bootstrap algorithm indicating the
%                        average length of blocks in the final sample.
%    sampleLength = 1 x 1 integer setting the lenght of the output sample. 
%
%% Output:
%    sample =       sampleLength x 1 vector containing the bootstraped sample 
%
%% Example:
%    >> data = [1;2;3;4;5;6;7;8;9;10]
%    >> StationaryBootstrap(data,4,9)
%    ans = [9; 10; 1; 2; 5; 6; 5; 6; 7]
%
%% Original source:
%     Dimitris N. Politis & Joseph P. Romano (1994) The Stationary Bootstrap, Journal of the American Statistical 
%     Association, 89:428, 1303-1313, DOI: 10.1080/01621459.1994.10476870
%
% Implemented by Gregor Fabjan from Qnity Consultants on 12/11/2021.

    accept = 1/m;
    pd1 = makedist('Uniform');   
    lenData = size(data, 1);
    sampleIndex = randperm(lenData, 1);
    sample = zeros(sampleLength, 1);
    for iSample = 1:sampleLength
        if random(pd1)>=accept % Block continues because step is accepted
            sampleIndex = sampleIndex+1;
            if sampleIndex > lenData % The block has arrived at the end of the data and needs to loop around
                sampleIndex = 1;
            end
        else % Step is rejected, therefore a new block is started 
            sampleIndex = randperm(lenData, 1);
        end
        sample(iSample) = data(sampleIndex); % Add the selected datapoint to the sample
    end
end
