%% helperUserRoundsInput
% A method that requests user input for number of gunshots
function [numRounds, dlgTitle, dims, options] = helperUserRoundsInput(bulletSignalData, tdmsFilename)
figure;
plot(bulletSignalData);
title([tdmsFilename, ': ��ź���� Ȯ��']);
options.WindowStyle = 'normal';

dlgTitle = '��ź����';
dims = [1 35];

msg = '��ź�� ��Դϱ�?';
numRounds = inputdlg(msg, dlgTitle, dims, {''}, options);
end