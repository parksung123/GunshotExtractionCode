%% helperFindPeakLocation
% A method to call either 'xf' or 'cc' method. 
function [xLocationMatrix, roundCount, leftRightRange] = helperFindPeakLocation(bulletSignalData, isCCorXForFIX, xInitial, xFinal)
[nextSWLoc, SWTHVal, binSize, dataSize] = helperFindFirstSW(bulletSignalData);

isCC = strcmp(isCCorXForFIX, 'cc');
isXF = strcmp(isCCorXForFIX, 'xf');

if isCC
    [xLocationMatrix, roundCount, leftRightRange] = helperCrossCorrelation(bulletSignalData, dataSize, nextSWLoc, binSize, SWTHVal);
elseif isXF
    [xLocationMatrix, roundCount, leftRightRange] = helperAddxFinal(bulletSignalData, nextSWLoc, xInitial, xFinal, SWTHVal);
end
end