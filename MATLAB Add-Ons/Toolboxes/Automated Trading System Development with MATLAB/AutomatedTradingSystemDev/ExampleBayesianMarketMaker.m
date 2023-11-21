%% Example Bayesian Market Maker
% This example runs a market maker based upon bayesian updating of the
% probability of the bid or ask price.

% Copyright 2015 The MathWorks, Inc.

%% Load in Data
addpath('Data')
load MSFTData
plot(msftask)
hold on
plot(msftbid)
hold off
title('MSFT Bid/Ask')
legend('Ask','Bid')

%% Bayesian Market Maker
% Parameters
alpha = 0.9;
sigma = 0.13;
P0 = 28.585;

%%
% Inital position and profit
pos = 0;
profit = 0;

%%
% Initialize probablility distribution
addpath('Models')
addpath('Charts')
[P,V] = initializeProbability(P0,sigma);
plot(V,P)
xlabel('Price')
ylabel('Probability')
title('MSFT')

%%
% Calculate bid/ask prices
[PBid,PAsk] = calcBidAsk(V,P,alpha)

%%
% iniitlialize plot
init = nan(size(msftask));
marketMakerPlot(init,init,init,init,0)

%%
% Continue to loop over the prices and update the different states of the
% model.
for i = 1:length(msftask)
    bid = msftbid(i);
    ask = msftask(i);
    Pmid = 0.5*(bid+ask);
    
    % When a quote is received, can either place a buy or sell at market.
    if bid >= PAsk
        % market sell order
        pos = pos - 1;
        profit = profit + (bid+ask)/2;
        P = Probability(PAsk,1,alpha,P,V);
        % update bid/ask price estimates
        [PBid,PAsk] = calcBidAsk(V,P,alpha);
        % Contol inventory
        [PBid,PAsk] = inventoryControl(pos,PBid,PAsk);
    elseif ask <= PBid
        % market buy order
        pos = pos + 1;
        profit = profit - (ask+bid)/2;
        P = Probability(PBid,-1,alpha,P,V);
        % update bid/ask price estimates
        [PBid,PAsk] = calcBidAsk(V,P,alpha);
        % Contol inventory
        [PBid,PAsk] = inventoryControl(pos,PBid,PAsk);
    end
    
    % update plots
    marketMakerPlot(PAsk,PBid,Pmid,pos,profit,i)
end

%% Run Strategy as Event Based System
% Create a replay service
clear all, close all, clc
load MSFTData
dates = (today+0.39584) + (0:length(msftask)-1)'./184610;
data = table(repmat({'MSFT'},size(msftask)),msftask,msftbid,...
    randi(100,size(msftask)),randi(100,size(msftask)),...
    cellstr(datestr(dates)),repmat({'quote'},size(msftask)),...
    'VariableNames',{'Symbol','AskPrice','BidPrice','AskSize','BidSize',...
    'DateTime','Type'});
theFeed = DataFeedReplayService(data)
data(1:5,:)
clear data msftask msftbid msftema dates

%%
% Add a broker that will execute trades for MSFT
b = Broker;
bl = addlistener(theFeed,'QuoteNotification',@(~,e) quoteUpdate(b,e.Data));

%%
% Create the Market Maker using above strategy and assign Broker
bmm = BayesianMarketMaker(28.585,0.13,'MSFT','MSFTMarketMaker');
addlistener(theFeed,'QuoteNotification',@(~,e)strategy(bmm,e.Data));
addBroker(bmm,b)
display(b)

%%
% Create a quote monitor
qm = createNBBODisplay(theFeed.SymbolList);
qml = addlistener(theFeed,'QuoteNotification',...
        @(~,e) updateNBBODisplay(qm,e.Data,theFeed.SymbolList));

%%
% Set replay speed to 0.1 seconds
setPeriod(theFeed,0.1);
display(theFeed)

%%
% Intitialize plot and add plot to listen to trading activity
init = nan(size(theFeed.Data));
marketMakerPlot(init,init,init,init,0)
pl = addlistener(theFeed,'QuoteNotification',@(~,~) plot(bmm,theFeed));

%%
start(theFeed)

while theFeed.Index < length(theFeed.Data)
    % wait for all data to stream
    pause(10)
end

stop(theFeed);