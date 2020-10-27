function filename = helperSaveTextFile(bulletSignalData, leftRightRange, tdmsFilename, textFilePath, extractName, iChannel, iRound, nthRounds)

if isempty(nthRounds)
    filename = sprintf('%s_%s_ch%d_rnd%d.txt', lower(tdmsFilename), lower(extractName), iChannel, iRound);
    fullFileName = fullfile(textFilePath, filename);
    % Write spike samples into TEXT files to fullFileName
    mex_WriteMatrix(fullFileName, bulletSignalData(round(leftRightRange(iRound, 1)):round(leftRightRange(iRound, 2))), '%0.10f', '\n', 'w+');
else
    filename = sprintf('%s_%s_ch%d_rnd%d.txt', lower(tdmsFilename), lower(extractName), iChannel, nthRounds(iRound));
    fullFileName = fullfile(textFilePath, filename);
    % Write spike samples into TEXT files to fullFileName
    mex_WriteMatrix(fullFileName, bulletSignalData(round(leftRightRange(iRound, 1)):round(leftRightRange(iRound, 2))), '%0.10f', '\n', 'w+');
end