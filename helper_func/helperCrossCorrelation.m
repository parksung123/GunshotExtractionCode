%% helperCrossCorrelation
% A method to extract gunshot using cross-correlation method.
function [xLocationMatrix, roundCount, leftRightRange] = helperCrossCorrelation(bulletSignalData, dataSize, nextSWLoc, binSize, SWTHVal)
% Import muzzleWave for cross-correlation
muzzleWave = importdata(fullfile(fullfile(fileparts(pwd), 'cc_sample'), 'muzzleWave.txt'));
maxBulletSignal = max(bulletSignalData);
desiredMuzzleAmp = maxBulletSignal * 0.06;
maxMuzzleSignal = max(muzzleWave);
muzzleMult = desiredMuzzleAmp / maxMuzzleSignal;
muzzleWave = muzzleWave * muzzleMult;

% cross-correlation to extract muzzleBlast positions
[ccMuzzle, ~] = xcorr(bulletSignalData, muzzleWave);

% muzzleblast threshold set as top 0.00005%
[counts, edges] = histcounts(ccMuzzle, binSize);
cdf = cumsum(counts);
cdf = cdf / cdf(end);
THIdx = find(cdf > 0.99995, 1, 'first');
MBTHVal = edges(THIdx);

nextMBLoc = find(ccMuzzle > MBTHVal, 1, 'first');
nextMBLoc = nextMBLoc - dataSize;

% Extract shockwave and muzzleblast positions 
[xLocationMatrix, roundCount] = helperFindMBandSW(bulletSignalData, ccMuzzle, nextSWLoc, nextMBLoc, dataSize, SWTHVal, MBTHVal);

xLocationMatrix = xLocationMatrix(1:roundCount, :);
xLocationMatrix = xLocationMatrix(any(xLocationMatrix, 2), :);

% Sets the padding before shockwave and after muzzleblast
MBtoSW = xLocationMatrix(2:end, 1) - xLocationMatrix(1:end-1, 2);
MBPad = min(MBtoSW);
if min(MBtoSW) > 10000
    MBPad = 10000;
end

leftRightRange = zeros(roundCount, 2);
leftRightRange(:, 1) = xLocationMatrix(1:roundCount, 1) - MBPad/2;
leftRightRange(:, 2) = xLocationMatrix(1:roundCount, 2) + MBPad;
end