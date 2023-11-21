classdef BayesianMarketMaker < handle
% Example strategy class for  market maker
    
% Copyright 2015 The MathWorks, Inc.

    properties
        Symbol
        TraderID
        Broker;
        pos = 0;
        profit = 0;
        alpha = 0.90;
        sigma = 0.13;
        P0 = 28.585;
    end
    properties (Access = private)
        PAsk = 0;
        PBid = 0;
        P = [];
        V = [];
    end
    methods
        function obj = BayesianMarketMaker(P0,sigma,symbol,trader)
            if nargin == 0
                [obj.P, obj.V] = initializeProbability();
            else
                obj.P0 = P0;
                obj.sigma = sigma;
                obj.Symbol = symbol;
                [obj.P, obj.V] = initializeProbability(P0,sigma);
                obj.TraderID = trader;
            end
            % calculate bid/ask prices
            [obj.PBid, obj.PAsk] = calcBidAsk(obj.V,obj.P,obj.alpha);
        end
        
        function obj = strategy(obj,newData)
            if ~strcmpi(newData.Symbol,obj.Symbol)
                return;
            end
            bid = newData.BidPrice;
            ask = newData.AskPrice;
            
            if bid >= obj.PAsk
                % market sell order
                placeOrder(obj,-1);
                obj.pos = obj.pos - 1;
                obj.profit = obj.profit + (bid+ask)/2;
                obj.P = Probability(obj.PAsk,1,obj.alpha,obj.P,obj.V);
                % update bid/ask price estimates
                [obj.PBid,obj.PAsk] = calcBidAsk(obj.V,obj.P,obj.alpha);
                % Contol inventory
                [obj.PBid,obj.PAsk] = inventoryControl(obj.pos,obj.PBid,obj.PAsk);
            elseif ask <= obj.PBid
                % market buy order
                placeOrder(obj,1);
                obj.pos = obj.pos + 1;
                obj.profit = obj.profit - (ask+bid)/2;
                obj.P = Probability(obj.PBid,-1,obj.alpha,obj.P,obj.V);
                % update bid/ask price estimates
                [obj.PBid,obj.PAsk] = calcBidAsk(obj.V,obj.P,obj.alpha);
                % Contol inventory
                [obj.PBid,obj.PAsk] = inventoryControl(obj.pos,obj.PBid,obj.PAsk);
            end
        end
        
        function orderTable = placeOrder(obj,pos)
            orderTable = obj.Broker.placeOrder(obj.Symbol,pos,obj.TraderID);
        end
        function addBroker(obj,Broker)
            obj.Broker = Broker;
        end
        function plot(obj,feedObj)
            iter = feedObj.Index;
            marketMakerPlot(obj.PAsk,obj.PBid,(obj.PAsk+obj.PBid)/2,...
                obj.pos,obj.profit,iter);
        end
    end
end

