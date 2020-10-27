%% HelperZoomAndWaitForUserResponse
% A method to plot the bullet data graph for inputting gunshot numbers.
function helperZoomAndWaitForUserResponse(bulletSignalData, prevPoints, iRepeat, tdmsFilename)
figure;
hold on;
plot(bulletSignalData);
plot(prevPoints, zeros(1, length(prevPoints)), 'ro');
hold off;
title([tdmsFilename, ': ������/���� ���ϱ� ', num2str(iRepeat)]);
zoom on;
waitfor(gcf, 'CurrentCharacter', char(13))
zoom reset;
zoom off;
end