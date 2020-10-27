function [nextSWLoc, SWTHVal, binSize, dataSize] = helperFindFirstSW(bulletSignalData)
dataSize=length(bulletSignalData);
y = num2str(dataSize);
binSize = str2double(y(1:4));

[counts, edges] = histcounts(bulletSignalData, binSize);
cdf = cumsum(counts);
cdf = cdf / cdf(end);
THIdx = find(cdf > 0.999999, 1, 'first');
SWTHVal = edges(THIdx);
nextSWLoc = find(bulletSignalData > SWTHVal, 1, 'first');
end