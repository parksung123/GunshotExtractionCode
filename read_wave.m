function read_wave(PA, varargin)
% READ_WAVE  Saves TDMS files to Text files.
%   READ_WAVE(PA, PLOT) extracts tdms data to text files. If PLOT == 1,
%   extracted data are plotted. The default algorithm is cross-correlation.
%
%   READ_WAVE(PA, PLOT, ALG) if ALG == 'cc', then algorithm is
%   cross-correlation. If ALG == 'xf', then algorithm is adding xFinal. If
%   ALG == 'check', then it's manual. 
%
%   For ALG == 'xf', 
%   ex) 
%       READ_WAVE(PA, PLOT, 'xf', 5000, 30000)
%   For ALG == 'cc',
%   ex)  
%       READ_WAVE(PA, PLOT, 'cc')
%   For ALG == 'check',
%   1. ex) READ_WAVE(PA, PLOT, 'check', PEAK)
%   PEAK : number of peaks to manually extract
%   
%   2. ex) READ_WAVE(PA, PLOT, 'check', 1, RN)
%   PEAK : nth round to manually extract

% Include helper functions in the path
addpath(fullfile(fileparts(pwd), 'helper_func'));
%%
% Default parameters.
xInitial = 0;
xFinal = 0;
willCrossCorrelateOrXF = 'cc';
nChannels = 0;
isPlotOn = 0;
nthRounds = [];

try
    isPlotOn = varargin{1};
    willCrossCorrelateOrXF = varargin{2};
    
    isXF = strcmp(willCrossCorrelateOrXF, 'xf');
    isCC = strcmp(willCrossCorrelateOrXF, 'cc');
    isFix = strcmp(willCrossCorrelateOrXF, 'fix');
    
    if isXF
        xInitial = varargin{3};
        xFinal = varargin{4};
        nChannels = varargin{5};
    elseif isCC
        nChannels = varargin{3};
    elseif isFix
        nthRounds = varargin{3};
        nChannels = varargin{5};
    end
catch
end

% Return error message if input directory is wrong
helperCheckMainParameters(PA, willCrossCorrelateOrXF, isPlotOn, xInitial, xFinal, nChannels, nthRounds)

% Create output folders for
[textFilePath, extractName] = helperCreateOutputFolder(PA);

% helperChooseTDMSFilesToConvert: Pop-up GUI for selecting TDMS files
% Return: nFiles      : Number of TDMS files selected
%         fullFilename: Full path for TDMS files
%         filenameCell:
[nFiles, fullFilename, isPlotEnabled] = helperChooseTDMSFilesToConvert(isPlotOn);
if isempty(fullFilename)
    return;
end

% Apply algorithm to every round of every channel of every file
for iFile=1:nFiles
    [savedSignal, tdmsFilename, isEndProgram] = helperExtractAllData(fullFilename,...
        isPlotEnabled, textFilePath, extractName, xInitial, xFinal,...
        nChannels, willCrossCorrelateOrXF, nthRounds, iFile);
    if isEndProgram
        return;
    end
    
    helperSaveVariablesInMat(textFilePath, savedSignal, nthRounds, tdmsFilename);
end
end