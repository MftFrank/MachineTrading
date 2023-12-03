% Adapted to bitstamp data
% Sum order flow over 1 minute.
clear;

entryThreshold=20;
exitThreshold=0;
lookback=60; % 1 min
%% 1 sec trade ticks

dn_temp=readtable('/Users/wangfuyu/Works/MKRUSDT_AggTrades.csv'); 

dn=dn_temp.T;
tradeSize = dn_temp.q;
tradePrice = dn_temp.p;
side = string(dn_temp.m);
%% order flow
buy=side=="True";
sell=side=="False";

ordflow=zeros(size(tradePrice));
ordflow(buy)=tradeSize(buy);
ordflow(sell)=-tradeSize(sell);

cumOrdflow=smartcumsum(ordflow);

%% order flow per minute
pos=0;%pos=1做多/pos=-1做空/pos=0平仓。状态：0-1/1-0,/-1-0/0--1
PL=0;
cumPL=0;
numTrade=0;
for t=1:length(cumOrdflow)
    idx=find( dn  <= dn(t)-15000);
    
    if (~isempty(idx))
        ordflow_lookback=cumOrdflow(t)-cumOrdflow(idx(end));
        
        if (ordflow_lookback > entryThreshold)%0-1
            if ( pos <= 0)
                entryP=tradePrice(t);
                fprintf('EntryTime: %.0f, Price: %.2f, ordflow: %.2f\n', dn(t), tradePrice(t), ordflow_lookback);
            end
            pos=1;                
        elseif (ordflow_lookback < -entryThreshold)%0--1
            if (pos >= 0)
                entryP=tradePrice(t);
                fprintf('EntryTime: %.0f, Price: %.2f, ordflow: %.2f\n', dn(t), tradePrice(t), ordflow_lookback);
            end
            pos=-1;                
        else
            if (ordflow_lookback <= exitThreshold && pos > 0)
                PL=tradePrice(t)-entryP;
                fprintf('ExitTime: %.0f, Price(t): %.2f, ordflow: %.2f, PL: %.2f\n', dn(t), tradePrice(t), ordflow_lookback, PL);
                pos=0;
            elseif (ordflow_lookback >= -exitThreshold && pos < 0)
                PL=entryP-tradePrice(t);
                fprintf('ExitTime: %.0f, Price(t): %.2f, ordflow: %.2f, PL: %.2f\n', dn(t), tradePrice(t), ordflow_lookback, PL);
                pos=0;
            end
        end
    end
end