classdef SimpleStreamer < Streaming
    % A really simple example of a streaming data source
    
    
    % Copyright 2015 The MathWorks, Inc.
    
    properties
        Price = 0;
    end
    events
        HaveNewData
        PriceIsGoingUp
        PriceIsGoingDown
    end
    
    methods
        function obj = SimpleStreamer(period)
            obj = obj@Streaming(period);
        end
        
        function step(obj)
            p = rand*100;
            disp(['Price is ',num2str(p)]);
            notify(obj,'HaveNewData');
            if p > obj.Price
                notify(obj,'PriceIsGoingUp');
            else
                notify(obj,'PriceIsGoingDown')
            end
            obj.Price = p;
        end
    end
end