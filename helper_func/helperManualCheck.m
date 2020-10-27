%% helperManualCheck 
% A method to manually extract shockwave and muzzleblast segments. 
function [leftRightRange, numRounds, isEndProgram] = helperManualCheck(bulletSignalData, nthRounds, tdmsFilename)
numRounds = length(nthRounds);
isEndProgram = 0;

% If user doesn't specify gunshot numbers, then ask user
if numRounds == 0
    [numRounds, dlgTitle, dims, options] = helperUserRoundsInput(bulletSignalData, tdmsFilename);
    [isEndProgram, numRounds] = helperRoundInputErrorHandler(numRounds, dlgTitle, dims, options);
end

leftRightCoord = zeros(numRounds, 2);
iRepeat = 1;
prevPoints = [];

% Set starting and end points of one gunshot. 
while iRepeat <= numRounds
    helperZoomAndWaitForUserResponse(bulletSignalData, prevPoints, iRepeat, tdmsFilename);
    [leftRightCoord, prevPoints, iRepeat] = helperManualPointErrorHandler(leftRightCoord, iRepeat, prevPoints);
end

leftRightRange = fix(leftRightCoord);
end