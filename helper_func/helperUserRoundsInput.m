%% helperUserRoundsInput
% A method that requests user input for number of gunshots
function [numRounds, dlgTitle, dims, options] = helperUserRoundsInput(bulletSignalData, tdmsFilename)
figure;
plot(bulletSignalData);
title([tdmsFilename, ': ÃÑÅº°³¼ö È®ÀÎ']);
options.WindowStyle = 'normal';

dlgTitle = 'ÃÑÅº°³¼ö';
dims = [1 35];

msg = 'ÃÑÅºÀÌ ¸î°³ÀÔ´Ï±î?';
numRounds = inputdlg(msg, dlgTitle, dims, {''}, options);
end