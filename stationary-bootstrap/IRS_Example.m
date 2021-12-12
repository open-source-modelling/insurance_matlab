rng(10)
% EURO denominated 6M interest-rate-swap rate obtained from
% https://www.teleborsa.it/Quotazioni/Tassi/Eurirs for date 12/11/2021 and
% interpolated using the Smith & Wilson algorithm for missing durations.
dataRaw = [-0.00497999999999998;-0.00336999999999998;-0.00219000000000003;-0.00137999999999994;-0.000839999999999952;-0.000349999999999961;0.000140000000000029;0.000669999999999948;0.00116999999999989;0.00165999999999999;0.00208999999999993;0.00245999999999991;0.00277690952371801;0.00303541131903184;0.00323000000000007;0.00336225372994803;0.00345212702349018;0.00351682745133952;0.00356726077755898;0.00360999999999989;0.00364393467821089;0.00365001038370538;0.00360991273768496;0.00350996855727703;0.00333999999999990;0.00310968998405592;0.00288888447388769;0.00274107227669318;0.00271077735186531;0.00283000000000011];

nSample = 3; % Number of generated samples
sampleLen = numel(dataRaw)-1; % Length of the sample will be the same as the input. 
% Note that you loose 1 degree of freedom when converting from rates to 1-year-forwards 
Samples = zeros(nSample, sampleLen); % Matrix to store the final obtained samples

data = zeros(numel(dataRaw)-1,1); % Vector with the 1-year forward curve

for iTime = 1:(numel(dataRaw)-1) % Convert rates into 1-year forward curve
    data(iTime) = (1+dataRaw(iTime+1))^iTime / (1+dataRaw(iTime))^(iTime-1) -1;
end

m = 3.8299; % Calculated using the method presented in 2004 paper by Politis & White.

for iSample = 1:nSample % Generate Stationary bootstraped samples
    Samples(iSample,:) = StationaryBootstrap(data,m(1),sampleLen)';
end

% Final plot to visualy show results
plot(1:(sampleLen),Samples,"red")
line(1:(sampleLen),data)
title("Stationary bootstrap")
xlabel("Time")
ylabel("Bootstraped samples")
