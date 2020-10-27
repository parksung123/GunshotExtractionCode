%% helperCheckMainParameters 
% A method to check validity of inputs for read_wave. 
function helperCheckMainParameters(PA, isCCorXForFIX, isPlotOn, xInitial, xFinal, nChannels, nthRounds)
% Return error message if input directory is wrong

% Check xInitial and xFinal. If they are not numerical or are 
% negative numbers, return error.
if ~isnumeric(xInitial) || ~isnumeric(xFinal)
    error('''%s'' �Ǵ� ''%s'' �߸���. �Է°����� ���� �ʿ�.', xInitial, xFinal);
else
    if xFinal < 0 || xInitial < 0
        error('''%s'' �� ''%s'' ����� �ʿ�.', num2str(xInitial), num2str(xFinal));
    end
end

% Check channel number. If it is not numerical or is a negative number,
% then return error.
if ~isnumeric(nChannels)
    error('''%s'' �߸���. �Է°����� ���� �ʿ�.', nChannels);
else
    if nChannels < 0
        error('''%s'' �� ''%s'' ����� �ʿ�', num2str(nChannels));
    end
end

% Check nthRounds. If nthRounds is not numerical or is a negative number,
% then return error.
if ~isnumeric(nthRounds)
    error('''%s'' �߸���. �Է°����� ���� �ʿ�.', nthRounds);
else
    if any(nthRounds < 0)
        error('''%s'' �� ''%s'' ����� �ʿ�', num2str(nthRounds));
    end
end

% Check directory. If directory is not a vector nor a string, or not an
% existing directory, return error.
if ~isvector(PA) && isstring(PA)
    error('''%s'' �߸���. �Է°����� ���� �Ǵ� ��Ʈ�� �ʿ�.', PA);
else
    isDirectory = exist(PA, 'dir');
    if ~isDirectory
        error('''%s'' ���丮�� �������� ����.', PA);
    end
end

% Check plot toggle. If isPlotOn is not a number or if is not zero or one,
% then return error.
if ~isnumeric(isPlotOn)
    error('''%s'' �߸���. �Է°����� ���� �ʿ�.', isPlotOn);
else
    if isPlotOn ~= 0 && isPlotOn ~= 1
        error('''%s'' �� 0 �Ǵ� 1�̿�����.', num2str(isPlotOn));
    end
end

% Check algorithm. If the algorithm is not a vector nor a string, or is not
% 'xf', 'cc', nor 'fix', then return error.
if ~isvector(isCCorXForFIX) && isstring(isCCorXForFIX)
    error('''%s'' �߸���. �Է°����� ���� �Ǵ� ��Ʈ�� �ʿ�.', isCCorXForFIX);
else
    isValidAlgorithm = strcmp(isCCorXForFIX, 'xf') | strcmp(isCCorXForFIX, 'cc') | strcmp(isCCorXForFIX, 'fix');
    if ~isValidAlgorithm
        error('''%s'' �߸���. ''xf'', ''cc'', �Ǵ� ''fix'' �ʿ�.');
    end
end