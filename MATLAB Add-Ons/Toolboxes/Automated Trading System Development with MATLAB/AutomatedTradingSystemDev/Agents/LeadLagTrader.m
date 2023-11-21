classdef LeadLagTrader < handle
    % Example lead/lag trader as class
    
    % Copyright 2015 The MathWorks, Inc.
    
    properties
        Symbol
        TraderID
        Broker
        pos = 0;
        profit = 0;
        N = 12;
        M = 26;
    end
    properties (Access = private)
        PriceHistory = [];
        count = 1000;
        signal = 0;
    end
    methods
        function obj = LeadLagTrader(N,M,symbol,trader)
            obj.Symbol = symbol;
            obj.N = N;
            obj.M = M;
            obj.TraderID = trader;
        end
        
        function obj = strategy(obj,newData)
            if ~strcmpi(newData.Symbol,obj.Symbol)
                return;
            end
            price = (newData.BidPrice + newData.AskPrice)/2;
            obj.PriceHistory = [obj.PriceHistory price];
            if length(obj.PriceHistory) > obj.M
                s = leadlag(obj.PriceHistory',obj.N,obj.M);
            else
                s = 0;
            end
            
            if s(end) ~= obj.signal
                if s(end) > 0
                    % buy
                    if sign(obj.pos) == -1
                        qty = 2;
                    else
                        qty = 1;
                    end
                    placeOrder(obj,qty);
                    obj.profit = obj.profit - (price * qty);
                elseif s(end) < 0
                    % sell
                    if sign(obj.pos) == 1
                        qty = -2;
                    else
                        qty = -1;
                    end
                    placeOrder(obj,qty);
                    obj.profit = obj.profit + (price * abs(qty));
                end
                obj.pos = qty;
                obj.signal = s(end);
            end
        end
        function orderTable = placeOrder(obj,pos)
            orderTable = obj.Broker.placeOrder(obj.Symbol,pos,obj.TraderID);
        end
        function addBroker(obj,Broker)
            obj.Broker = Broker;
        end
        function plot(obj,feedObj)
            if obj.count < feedObj.Index
                obj.count = obj.count+1000;
                
                if length(obj.PriceHistory)> obj.M
                    leadlag(obj.PriceHistory',obj.N,obj.M)
                end
            end
        end
    end
end