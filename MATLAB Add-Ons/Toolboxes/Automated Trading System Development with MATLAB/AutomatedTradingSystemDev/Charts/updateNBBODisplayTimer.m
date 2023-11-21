function updateNBBODisplayTimer(ut,t,symbolList)
% Helper function for timer updating of bid/ask table

% Copyright 2015 The MathWorks, Inc.

persistent indx
if ~exist('indx','var') || isempty(indx)
    indx = 1;
else
    indx = indx+1;
end

quoteStr = @(q,v) [num2str(q,'%8.2f'),' x ', num2str(v,'%8.0f')];

updateDisplay = @(d) {d.DateTime{1},quoteStr(d.BidPrice,d.BidSize),...
           quoteStr(d.AskPrice,d.AskSize)};
       
loc = ismember(symbolList,t.Symbol(indx));
ut.Data(loc,:) = updateDisplay(t(indx,:));
drawnow;
