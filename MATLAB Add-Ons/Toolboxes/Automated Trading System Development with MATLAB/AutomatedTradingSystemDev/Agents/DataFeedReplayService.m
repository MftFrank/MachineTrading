classdef DataFeedReplayService < Streaming
    % Example class for streaming historical data with two events
    
    
    % Copyright 2015 The MathWorks, Inc.
    
    properties
        ReplaySpeed = 2;
        Index = 1;
        SymbolList;
        Data
    end
    
    events
        TradeNotification;
        QuoteNotification;
    end
    
    methods
        function obj = DataFeedReplayService(source,period)
            if nargin < 2
                period = 2;
            end
            obj = obj@Streaming(period);
            
            % Determine source type
            switch class(source)
                case 'char' % a file name
                    t = readtable(source);
                    t = table2struct(t);
                case 'table'
                    t = table2struct(source);
                case 'struct'
                    obj.Data = source;
                case {'database', 'database.ODBCConnection'}
                    %TODO: add code to connect to database
                otherwise
                    error('DataFeedReplay:UnkownSource','This source is not supported');
            end
            
            obj.Data = t;
            obj.SymbolList = unique({obj.Data.Symbol});
        end
        
        function step(obj)
            switch lower(obj.Data(obj.Index).Type)
                case 'trade'
                    notify(obj,'TradeNotification',TradeData(obj.Data(obj.Index)))
                case 'quote'
                    notify(obj,'QuoteNotification',QuoteData(obj.Data(obj.Index)))
            end
            obj.Index = obj.Index + 1;
        end
    end
end