%% helperCheckMainParameters 
% A method to check validity of inputs for read_wave. 
function helperCheckMainParameters(PA, isCCorXForFIX, isPlotOn, xInitial, xFinal, nChannels, nthRounds)
% Return error message if input directory is wrong

% Check xInitial and xFinal. If they are not numerical or are 
% negative numbers, return error.
if ~isnumeric(xInitial) || ~isnumeric(xFinal)
    error('''%s'' 또는 ''%s'' 잘못됨. 입력값으로 숫자 필요.', xInitial, xFinal);
else
    if xFinal < 0 || xInitial < 0
        error('''%s'' 와 ''%s'' 양수값 필요.', num2str(xInitial), num2str(xFinal));
    end
end

% Check channel number. If it is not numerical or is a negative number,
% then return error.
if ~isnumeric(nChannels)
    error('''%s'' 잘못됨. 입력값으로 숫자 필요.', nChannels);
else
    if nChannels < 0
        error('''%s'' 와 ''%s'' 양수값 필요', num2str(nChannels));
    end
end

% Check nthRounds. If nthRounds is not numerical or is a negative number,
% then return error.
if ~isnumeric(nthRounds)
    error('''%s'' 잘못됨. 입력값으로 숫자 필요.', nthRounds);
else
    if any(nthRounds < 0)
        error('''%s'' 와 ''%s'' 양수값 필요', num2str(nthRounds));
    end
end

% Check directory. If directory is not a vector nor a string, or not an
% existing directory, return error.
if ~isvector(PA) && isstring(PA)
    error('''%s'' 잘못됨. 입력값으로 백터 또는 스트링 필요.', PA);
else
    isDirectory = exist(PA, 'dir');
    if ~isDirectory
        error('''%s'' 디렉토리가 존재하지 않음.', PA);
    end
end

% Check plot toggle. If isPlotOn is not a number or if is not zero or one,
% then return error.
if ~isnumeric(isPlotOn)
    error('''%s'' 잘못됨. 입력값으로 숫자 필요.', isPlotOn);
else
    if isPlotOn ~= 0 && isPlotOn ~= 1
        error('''%s'' 가 0 또는 1이여야함.', num2str(isPlotOn));
    end
end

% Check algorithm. If the algorithm is not a vector nor a string, or is not
% 'xf', 'cc', nor 'fix', then return error.
if ~isvector(isCCorXForFIX) && isstring(isCCorXForFIX)
    error('''%s'' 잘못됨. 입력값으로 백터 또는 스트링 필요.', isCCorXForFIX);
else
    isValidAlgorithm = strcmp(isCCorXForFIX, 'xf') | strcmp(isCCorXForFIX, 'cc') | strcmp(isCCorXForFIX, 'fix');
    if ~isValidAlgorithm
        error('''%s'' 잘못됨. ''xf'', ''cc'', 또는 ''fix'' 필요.');
    end
end