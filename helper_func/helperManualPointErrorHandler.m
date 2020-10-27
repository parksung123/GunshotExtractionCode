function [leftRightCoord, prevPoints, iRepeat] = helperManualPointErrorHandler(leftRightCoord, iRepeat, prevPoints)
try
    [coord, ~] = ginput(2);
    leftRightCoord(iRepeat, 1) = coord(1);
    leftRightCoord(iRepeat, 2) = coord(2);
catch
end

close;

% Checks if the points user selected are valid
areInvalidCoords = coord(1) > coord(2);
if areInvalidCoords
    disp('�������� �������� Ů�ϴ�. �ٽ� �õ��Ͻÿ�.');
else
    prevPoints = [prevPoints coord(1) coord(2)];
    iRepeat = iRepeat + 1;
end
end