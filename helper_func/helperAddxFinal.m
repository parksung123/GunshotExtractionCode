%% helperAddxFinal
% A method to extract shockwave positions using the 'xf' method.
function [xLocationMatrix, roundCount, leftRightRange] = helperAddxFinal(bulletSignalData, nextSWLoc, xInitial, xFinal, SWTHVal)
xLocationMatrix = zeros(1000, 1);
roundCount = 0;

% Repeatedly retrieve shockwave positions
while ~isempty(nextSWLoc)
    roundCount = roundCount + 1;
    xLocationMatrix(roundCount) = nextSWLoc;
    
    nextSWScan = nextSWLoc + xFinal;
    nextSWLoc = find(bulletSignalData(nextSWScan:end) > SWTHVal, 1, 'first');
    nextSWLoc = nextSWLoc + nextSWScan;
end
xLocationMatrix = xLocationMatrix(1:roundCount);

leftRightRange = zeros(roundCount, 2);
leftRightRange(:, 1) = xLocationMatrix - xInitial;
leftRightRange(:, 2) = xLocationMatrix + xFinal;
end