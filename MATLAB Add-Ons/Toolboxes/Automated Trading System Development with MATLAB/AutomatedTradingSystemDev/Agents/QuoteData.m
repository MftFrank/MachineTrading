classdef (ConstructOnLoad) QuoteData < event.EventData
    % Quote event data handling
    
    
    % Copyright 2015 The MathWorks, Inc.
    
    properties
        Data;
    end
    methods
        function eventData = QuoteData(newdata)
            eventData.Data = newdata;
        end
    end
end