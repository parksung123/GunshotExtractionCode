%% helperChooseTDMSFilesToConvert: Opens GUI for user to select a single or 
% multiple tdms/mat files
function [nFiles, fullFilename, isPlotEnabled] = helperChooseTDMSFilesToConvert(isPlot)

isTDMS = ~isempty(dir('*.tdms'));
isMAT = ~isempty(dir('*.mat'));
isConvertFile = isTDMS || isMAT;

if isConvertFile
    [filename, pathname] = uigetfile({'*.tdms' 'Text file'; '*.mat' 'Word document'}, 'MultiSelect', 'on');
    
    if ischar(filename)
        nFiles = 1;
        filenameCell = cell(1);
        filenameCell(1) = cellstr(filename);
        fullFilename = cell(1);
    elseif isnumeric(filename)
        nFiles = 0;
        fullFilename = cell(0);
        isPlotEnabled = 0;
        return;
    else
        nFiles = length(filename);
        filenameCell = filename;
        fullFilename = cell(length(filename), 1);
    end
    
    for iFile = 1:nFiles
        fullFilename(iFile) = fullfile(pathname, filenameCell(iFile));
    end
else
    msg = sprintf('Files with extension .tdms or .mat don''t exist.');
    opts = struct('WindowStyle', 'modal', 'Interpreter', 'tex');
    warndlg(msg, 'No File', opts);
end

isPlotEnabled = isPlot & nFiles == 1;
if isPlot & nFiles > 1
    warning('Plotting is only available with 1 file.');
end
end