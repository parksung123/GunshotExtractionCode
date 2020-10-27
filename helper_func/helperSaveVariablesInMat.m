function helperSaveVariablesInMat(textFilePath, savedSignal, roundFix, tdmsFilename)
matPath = fullfile(textFilePath, sprintf(tdmsFilename, 'output.mat'));
if ~exist(matPath, 'file')
    save(matPath);
end

if ~roundFix 
    outputS = whos('-file', matPath);
    names = {outputS.name};
    outputMat = load(matPath);
    clearedSignal = rmfield(outputMat, names);
    save(matPath, '-struct', 'clearedSignal');
end
save(matPath, '-struct', 'savedSignal');
end