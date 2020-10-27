%% helperExtractAllData 
% A method to apply extraction algorithms for every channel and every
% gunshot of each channel.
function [savedSignal, tdmsFilename, isEndProgram] = helperExtractAllData(fullFilename, isPlotEnabled, textFilePath, extractName, xInitial, xFinal, nChannels, isCCorXForFIX, nthRounds, iFile)
% Convert all selected TDMS files into MAT.
% helperCheckMATFile: Returns path for MAT file.
% Return: matFullFile     : Path for MAT file.
%         charFullFilename:
[matFullFile, tdmsFilename] = helperCheckMATFile(iFile, fullFilename);

% If MAT file path exists, skip conversion. If it doesn't, convert.
hasMATConverted = exist(matFullFile, 'file');

if hasMATConverted
    allMat = load(matFullFile);
    allMat = allMat.ConvertedData;
else
    allMat = convertTDMS(true, fullFilename(iFile));
end

dataLength = 0;
nProperty = numel(allMat.Data.Root.Property);
% Check size of data
for iProperty=1:nProperty
    hasDataSizeField = strcmp(allMat.Data.Root.Property(iProperty).Name, 'samples prepared for viewing');
    
    if hasDataSizeField
        dataLength = allMat.Data.Root.Property(iProperty).Value;
        break;
    end
end

if ~hasDataSizeField
    dataLength = length(allMat.Data.MeasuredData(3).Data);
end

nData = numel(allMat.Data.MeasuredData);
channel_no_check = zeros(nData, 1);

% Check number of channels
hasChannelNum = nChannels;

if ~hasChannelNum
    for iData=1:nData
        channel_no_check(iData) = allMat.Data.MeasuredData(iData).Total_Samples == dataLength;
    end
    nChannels = sum(channel_no_check);
end

matPath = fullfile(textFilePath, sprintf(tdmsFilename,'output.mat'));
if exist(matPath, 'dir')
    savedSignal = load(matPath);
end

hasManualCheckRun = 0;
hasFoundPeak = 0;
problemMic = 0;
isEndProgram = 0 ;
% For each channel, extract peaks and save them into TEXT files.
for iChannel = 1:nChannels
    bulletSignalData = allMat.Data.MeasuredData(iChannel + 2).Data;
    
    % If channel data doesn't catch any sound, then display warning
    if ~any(bulletSignalData > 0.1)
        disp(['채널 ', num2str(iChannel), '번 고장?']);
        problemMic = iChannel;
    end
    
    isFix = strcmp(isCCorXForFIX, 'fix');
    isXF = strcmp(isCCorXForFIX, 'xf');
    isCC = strcmp(isCCorXForFIX, 'cc');
    isValidChannel = iChannel ~= problemMic;
    isExtractManually = isFix && isValidChannel;
    isExtractAll = (isFix && isempty(nthRounds)) || isXF || isCC;
    
    % Manually extract gunshot(s)
    if isExtractManually && ~hasManualCheckRun
        [leftRightRange, numRounds, isEndProgram] = helperManualCheck(bulletSignalData, nthRounds, tdmsFilename);
        hasManualCheckRun = 1;
        
        if isEndProgram
            savedSignal = struct([]);
            return;
        end
    end
    
    % Extract SW+MB positions using either 'cc' or 'xf'
    if isValidChannel && ~hasFoundPeak && ~isFix
        % helperFindPeakLocation: Finds number of rounds and peak
        % locations.
        % Return: roundCount: Number of rounds in the data.
        [~, roundCount, leftRightRange] = helperFindPeakLocation(bulletSignalData, isCCorXForFIX, xInitial, xFinal);
        hasFoundPeak = 1;
        % Set number of rounds and clean peak matrix
        numRounds = roundCount;
        
        % If data did not catch any spikes, set random left padding.
        isPeakExist = leftRightRange;
        if ~isPeakExist
            leftRightRange = xInitial+1;
        end
    end
    
    % Save each spike samples into TEXT files
    for iRound = 1:numRounds
        % Set TEXT file names
        if isExtractAll
            filename = helperSaveTextFile(bulletSignalData, leftRightRange, tdmsFilename, textFilePath, extractName, iChannel, iRound, nthRounds);
            disp(['채널 ', num2str(iChannel), ' 총탄 ', num2str(iRound), ' 파일 저장중...']);
        else
            filename = helperSaveTextFile(bulletSignalData, leftRightRange, tdmsFilename, textFilePath, extractName, iChannel, iRound, nthRounds);
            disp(['채널 ', num2str(iChannel), ' 총탄 ', num2str(nthRounds(iRound)), ' 파일 저장중...']);
        end
        
        extIdx = find(filename == '.', 1, 'last');
        filenameNoExt = regexprep(filename(1:extIdx-1), '[^a-zA-Z0-9_]', '');
        savedSignal.(filenameNoExt) = bulletSignalData(round(leftRightRange(iRound, 1)):round(leftRightRange(iRound, 2)));
    end
    disp(' ');
    helperPlotExtractedData(isPlotEnabled, numRounds, bulletSignalData, iChannel, leftRightRange);
end
end