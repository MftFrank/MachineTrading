function updateNBBODisplay(ut,t,symbolList)
% Helper function NBBODisplay

% Copyright 2015 The MathWorks, Inc.

quoteStr = @(q,v) [num2str(q,'%8.2f'),' x ', num2str(v,'%8.0f')];

updateDisplay = @(d) {d.DateTime,quoteStr(d.BidPrice,d.BidSize),...
           quoteStr(d.AskPrice,d.AskSize)};
       
loc = ismember(symbolList,t.Symbol);
ut.Data(loc,:) = updateDisplay(t);
drawnow;
