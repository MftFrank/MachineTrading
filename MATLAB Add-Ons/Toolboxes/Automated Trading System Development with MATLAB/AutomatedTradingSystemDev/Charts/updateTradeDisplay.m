function updateTradeDisplay(ut,t)  
% Helper function for trading table display

% Copyright 2015 The MathWorks, Inc.

vars = {'TimeStamp','TraderID','Symbol','Action','FillPrice','FillQty'};
ut.Data = table2cell(t(:,vars));
drawnow;