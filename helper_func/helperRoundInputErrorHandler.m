%% helperRoundInputErrorHandler
% A method to handle errors from user input
function [isEndProgram, numRounds] = helperRoundInputErrorHandler(numRounds, dlgTitle, dims, options)
isEndProgram = 0;
% Handles error when user exits pop-up

if isempty(numRounds) 
    isEndProgram = 1;
    numRounds = 0;
    close;
    return;
end

numRounds = fix(str2double(numRounds{1}));

% Ask user until the input is valid
while isnan(numRounds) || numRounds <= 0
    msg = '총탄이 몇개입니까? (양수값)';
    numRounds = inputdlg(msg, dlgTitle, dims, {''}, options);
    numRounds = fix(str2double(numRounds{1}));
end
close;
end