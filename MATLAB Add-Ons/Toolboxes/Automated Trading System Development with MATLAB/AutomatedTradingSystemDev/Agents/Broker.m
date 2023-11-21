classdef Broker < handle
    % Example broker class to handle orders and trade against current
    % quotes
    
    
    % Copyright 2015 The MathWorks, Inc.
    
    properties
        QuoteBook = table;
    end
    properties (SetObservable)
        TradeBook;
    end
    methods
        function obj = Broker()
            
        end
        
        function orderTable = placeOrder(obj,symbol,pos,trader)
            if isempty(obj.QuoteBook)
                orderTable = [];
                return;
            end
            if ischar(symbol)
                symbol = {symbol};
            end
            indx = ismember(obj.QuoteBook.Symbol,symbol);
            if pos > 0 %'buy'
                action = {'buy'};
                % look up ask price and quantity
                fillPrice = obj.QuoteBook.AskPrice(indx);
                fillSize = obj.QuoteBook.AskSize(indx);
            elseif pos < 0 %'sell'
                % look up bid price and quantity
                action = {'sell'};
                fillPrice = obj.QuoteBook.BidPrice(indx);
                fillSize = obj.QuoteBook.BidSize(indx);
            end
            if pos > fillSize
                fillSize = abs(pos);
            elseif pos < fillSize
                fillSize = abs(pos);
            end
            orderTable.Symbol = symbol;
            orderTable.FillPrice = fillPrice;
            orderTable.FillQty = fillSize;
            orderTable.QuoteTime = obj.QuoteBook.DateTime(indx);
            orderTable.TimeStamp = {datestr(now)};
            orderTable.TraderID = {trader};
            orderTable.Action = action;
            if isa(orderTable,'struct')
                orderTable = struct2table(orderTable);
            end
            obj.TradeBook = [obj.TradeBook; orderTable];
        end
        
        function quoteUpdate(obj,newquotes)
            vars = {'DateTime','Symbol','BidPrice','BidSize','AskPrice','AskSize'};
            if isa(newquotes,'struct')
                quoteTable = struct2table(newquotes);
                if ischar(quoteTable.DateTime)
                    quoteTable.DateTime = cellstr(quoteTable.DateTime);
                end
                if ischar(quoteTable.Symbol)
                    quoteTable.Symbol = cellstr(quoteTable.Symbol);
                end
            end
            if isempty(obj.QuoteBook)
                obj.QuoteBook = quoteTable(:,vars);
            else
                indx = ismember(obj.QuoteBook.Symbol,quoteTable.Symbol);
                if ~any(indx)
                    obj.QuoteBook(end+1,:) = quoteTable(:,vars);
                else
                    obj.QuoteBook(indx,:) = quoteTable(:,vars);
                end
            end
        end
    end
    
end
