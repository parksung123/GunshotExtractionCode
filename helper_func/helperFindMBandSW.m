%% helperFindMBandSW
% A method that extracts MB and SW
function [xLocationMatrix, roundCount] = helperFindMBandSW(bulletSignalData, ccMuzzle, nextSWLoc, nextMBLoc, dataSize, SWTHVal, MBTHVal)
xLocationMatrix = zeros(1000, 2);
roundCount = 0;

while ~isempty(nextSWLoc)
    % SW and MB must be at least 3000 apart 
    if (nextMBLoc - nextSWLoc) >= 3000
        roundCount = roundCount + 1;
        xLocationMatrix(roundCount, 1) = nextSWLoc;
        xLocationMatrix(roundCount, 2) = nextMBLoc;
    end
    
    nextSWScan = nextMBLoc;
    nextSWLoc = find(bulletSignalData(nextSWScan:end) > SWTHVal, 1, 'first');
    nextSWLoc = nextSWLoc + nextSWScan;
    
    nextMBScan = nextSWLoc + dataSize;
    
    while any(abs(ccMuzzle(nextMBScan-300:nextMBScan+300)> (max(ccMuzzle)/3)))
        nextMBScan = nextMBScan + 600;
    end
    
    nextMBLoc = find(ccMuzzle(nextMBScan:end) > MBTHVal, 1, 'first');
    nextMBLoc = nextMBLoc + nextMBScan - dataSize;
end
end