function helperPlotExtractedData(isPlotOEnabled, nRounds, bulletSignalData, iChannel, leftRightRange)

if isPlotOEnabled
    figure;
    for iRound=1:nRounds
        subplot(2, nRounds, 1:nRounds);
        plot(bulletSignalData)
        title(['Original Bullet Data: ', num2str(iChannel), ' Channel']);
        
        subplot(2, nRounds, iRound+nRounds);
        plot(bulletSignalData(round(leftRightRange(iRound, 1)):round(leftRightRange(iRound, 2))));
        title(iRound);
    end
end
end