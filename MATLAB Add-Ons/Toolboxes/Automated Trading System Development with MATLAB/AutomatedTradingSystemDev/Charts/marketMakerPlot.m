function marketMakerPlot(PAsk,PBid,Pmid,pos,pnl,ind)
% Helper function to show market maker performance

% Copyright 2015 The MathWorks, Inc.

if isempty(findobj('Tag','MarketMaker'))
    figure('Tag','MarketMaker')
    subplot(3,1,1)
    plot(PAsk,'Tag','PAsk')
    hold on
    plot(PBid,'Tag','PBid')
    plot(Pmid,'Tag','Pmid')
    hold off
    legend('PAsk','PBid','Pmid')
    
    subplot(3,1,2)
    plot(pos,'Tag','pos')
    legend('Position')
    
    subplot(3,1,3)
    plot(pnl,'Tag','pnl');
    legend('PnL')
else
    % update the data
    h = findobj('Tag','PAsk');
    h.YData(ind) = PAsk;
    h = findobj('Tag','PBid');
    h.YData(ind) = PBid;
    h = findobj('Tag','Pmid');
    h.YData(ind) = Pmid;
    h = findobj('Tag','pos');
    h.YData(ind) = pos;
    h = findobj('Tag','pnl');
    h.YData(ind) = pnl;
end
%drawnow;
