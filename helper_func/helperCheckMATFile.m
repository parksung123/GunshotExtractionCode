%% helperCheckMATFile: This function returns the path of the MAT file to 
% determine if convertTDMS can be skipped
function [matFullFile, tdmsFilename] = helperCheckMATFile(iFile, fullFilename)

charFullFilename = char(fullFilename(iFile));
positionOfLastSlash = find(charFullFilename == '\', 1, 'last');
positionOfLastPeriod = find(charFullFilename == '.', 1, 'last');
matFilePath = charFullFilename(1:positionOfLastSlash-1);
tdmsFilename = charFullFilename(positionOfLastSlash+1:positionOfLastPeriod-1);
matFullFile = fullfile(matFilePath, strcat(tdmsFilename, '.mat'));

end
