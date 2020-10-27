function [textFilePath, extractName] = helperCreateOutputFolder(textPath)

% Get directory for output folders
currentFolder= pwd;
extractLast = find(currentFolder == '\', 1, 'last');
extractName = currentFolder(extractLast+1:end);
extractName = extractName(~isspace(extractName));
textFilePath = fullfile(textPath, extractName);
textFilePath = sprintf('%sOutput', textFilePath);

isDirectory = exist(textFilePath, 'dir');

if ~isDirectory
    mkdir(textFilePath);
end
end
