%% Lead Lag Trader
% This example shows a back test using a simple momentum trading
% strategy using two moving averages.

% Copyright 2015 The MathWorks, Inc.

%% Backtest Strategy
% Load in bid and ask quote data for Microsoft (MSFT) and calibrate the
% moving average parameters based upon the sharpe ratio
load MSFTData
seq = [1:80 80:5:200];
range = {seq,seq};
annualScaling = sqrt(250*6.5); % assume second level resolution
msftprice = (msftask+msftbid)/2;
cost = 0;

testIndx = 1:length(msftprice)/2;
valIndx = length(msftprice)/2:length(msftprice);

llfun =@(x) leadlagFun(x,msftprice(testIndx),annualScaling,cost);
tic
[~,param,shr,xyz] = parameterSweep(llfun,range);
toc

leadlag(msftprice(testIndx),param(1),param(2),annualScaling,cost)
subplot(2,1,1)
xlabel('Quote Event Sequence')
subplot(2,1,2)
xlabel('Quote Event Sequence')

%% Validation Set Testing
% Test on remaining data set.
leadlag(msftprice(valIndx),param(1),param(2),annualScaling,cost)
subplot(2,1,1)
xlabel('Quote Event Sequence')
subplot(2,1,2)
xlabel('Quote Event Sequence')

%%  Walk Forward Calibration
% Didn't do so well in out of sample test.  Let's rerun the calibration
% over a moving window to see if we can find a stable set of parameters.
win = 1:5000; % 1,000 samples
offset = 1000;  % move window by 100 points

w = win;
i = 1;
p = {}; nm = {}; s = {};
tic
while w(end) <= length(msftprice)
    llfun =@(x) leadlagFun(x,msftprice(w),annualScaling,cost);
    [sh(i),p{i},s{i},nm{i}] = parameterSweep(llfun,range);
    w = w + offset; 
    disp(['Sharpe Ratio: ',num2str(sh(i)),' for N/M of ',num2str(p{i})])
     i = i+1;
end
toc

p = reshape([p{:}],2,[])';
N = p(:,1); M = p(:,2);
[fitresult, gof] = createFit(N, M, sh)

%% Find maximum of fit
% Looks like 5 and 63 are the best parameters.
x = fminsearch(@(x) -fitresult(x(1),x(2)),[11 39]);
x = round(x);
leadlag(msftprice,x(1),x(2),annualScaling,cost)

%% Event-based Testing
% Rerun the strategy using an event based approach.  First reload the data
% ang put into a format our streaming data service can support.
clear all, close all, clc
load MSFTData
dates = (today+0.39584) + (0:length(msftask)-1)'./184610;
data = table(repmat({'MSFT'},size(msftask)),msftask,msftbid,...
    randi(100,size(msftask)),randi(100,size(msftask)),...
    cellstr(datestr(dates)),repmat({'quote'},size(msftask)),...
    'VariableNames',{'Symbol','AskPrice','BidPrice','AskSize','BidSize',...
    'DateTime','Type'});

%%
% Now set up the streaming data feed
theFeed = DataFeedReplayService(data)
data(1:5,:)
clear data msftask msftbid msftema dates

%%
% Add a broker that will execute trades for MSFT at the bid/ask price
b = Broker;
bl = addlistener(theFeed,'QuoteNotification',@(~,e) quoteUpdate(b,e.Data));

%%
% Create the Market Maker using above strategy and assign Broker
llt = LeadLagTrader(5,63,'MSFT','MSFTMarketMaker');
addlistener(theFeed,'QuoteNotification',@(~,e)strategy(llt,e.Data));
addBroker(llt,b)
display(b)

%%
% Set replay speed to 0.1 seconds
setPeriod(theFeed,0.1);
display(theFeed)

%%
% Plot to listen to trading activity (pdates every 1000 iterations)
pl = addlistener(theFeed,'QuoteNotification',@(~,~) plot(llt,theFeed));

%%
% Start streaming and let the trader react to the results
start(theFeed)
%%
% stop the feed
while theFeed.Index < length(theFeed.Data)
    % wait for all data to stream
    pause(10)
end
stop(theFeed);

%%
% Process the trade data from the broker to get final profits for the day
b.TradeBook(1:5,:)
b.TradeBook.Action = categorical(b.TradeBook.Action);
cash = b.TradeBook.FillPrice .* b.TradeBook.FillQty;
cash(b.TradeBook.Action == 'buy') = -cash(b.TradeBook.Action == 'buy');
profit = cumsum(cash);
% sell last shares to go neutral to get profit
if sign(cash(end)) > 0
    x = -1;
else
    x = 1;
end
profit(end+1) = profit(end) + b.TradeBook.FillPrice(end) .* b.TradeBook.FillQty(end).*x;
FinalReturnPct = (1- profit(end)/cash(1))*100

