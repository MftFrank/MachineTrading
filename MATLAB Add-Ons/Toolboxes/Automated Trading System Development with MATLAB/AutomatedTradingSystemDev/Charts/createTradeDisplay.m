function ut = createTradeDisplay()
% Example trading log

% Copyright 2015 The MathWorks, Inc.

f = figure;
f.Name = 'Trade Records';
colNames = {'TimeStamp','Trader','Symbol','Action','Price','Quantity'};
ut = uitable(f,'ColumnName',colNames);
ut.Units = 'normalized';
ut.ColumnWidth = {100};
ut.Position(3) = ut.Extent(3);
ut.Position(4) = 0.9;