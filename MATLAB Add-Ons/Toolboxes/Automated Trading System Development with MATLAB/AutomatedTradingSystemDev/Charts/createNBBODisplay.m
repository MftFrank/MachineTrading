function ut = createNBBODisplay(symbolList)
% Example quote display

% Copyright 2015 The MathWorks, Inc.

f = figure;
f.Name = 'National Best Bid and Offer';
colNames = {'TimeStamp','Bid','Ask'};
ut = uitable(f,'ColumnName',colNames,'RowName',symbolList);
ut.Units = 'normalized';
ut.ColumnWidth = {150};
ut.Position(3) = ut.Extent(3);
ut.Position(4) = 0.9;
ut.Data = repmat({'NaN'},length(symbolList),3);