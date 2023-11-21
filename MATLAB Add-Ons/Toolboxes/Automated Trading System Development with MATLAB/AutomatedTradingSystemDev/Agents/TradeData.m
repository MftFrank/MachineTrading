classdef (ConstructOnLoad) TradeData < event.EventData
    % Trade event data handling
    
    
    % Copyright 2015 The MathWorks, Inc.
    
    properties
        Data;
    end
    methods
        function eventData = TradeData(newdata)
            eventData.Data = newdata;
        end
    end
end

