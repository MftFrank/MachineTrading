%% Create a Simple Data Feed Replay Object
% This example shows how to create a simple object in MATLAB(R) that will
% stream data at a specified frequency.

% Copyright 2015 The MathWorks, Inc.

%% Sample Data
% Let's first load in some sample data.  The data we'll use in this example
% is National Best Bid and Offer (NBBO) data.
addpath('Data')
t = readtable('NBBO.csv');
symbolList = sort(unique(t.Symbol))
N = length(symbolList);
t(1:5,:)

%% Define Streaming Display
% To see how our object streams information, let's create a simple diplay
% that shows the bid/ask values for eacht symbol.  The table is created
% using |uitable|
f = figure;
f.Name = 'National Best Bid and Offer';
colNames = {'TimeStamp','Bid','Ask'};
ut = uitable(f,'ColumnName',colNames,'RowName',symbolList);
ut.Units = 'normalized';
ut.ColumnWidth = {150};
ut.Position(3) = ut.Extent(3);
ut.Position(4) = 0.9;
ut.Data = repmat({'NaN'},N,3);

%%
% Create a format string and add it to the display

quoteStr = @(q,v) [num2str(q,'%8.2f'),' x ', num2str(v,'%8.0f')];
quoteStr(t.BidPrice(1),t.BidSize(1))

updateDisplay = @(d) {d.DateTime{:},quoteStr(d.BidPrice,d.BidSize),...
           quoteStr(d.AskPrice,d.AskSize)};
ut.Data(4,:) = updateDisplay(t(1,:)); % ITUB's first record is in index 12
       
%% |FOR| Loop Example
% One method to create display the table is to do it in a for loop.
tic
for i = 1:100
    loc = ismember(symbolList,t.Symbol(i));
    ut.Data(loc,:) = updateDisplay(t(i,:));
    drawnow; % force the display to update
    pause(0.25)
end
toc
%%
% This could have also been done in a while loop.  However, note that both
% would have locked MATLAB from doing additional things while processing
% the block of code in the for loop.

%% Timers
% An alternative approach, that does not lock MATLAB is to use a timer that
% updates the dispaly only when there is new data.  Let's see how we can
% update the data every 0.25 seconds, while allowing MATLAB to do other
% things between updates.
%
% The idea is to create a timer, that will run a callback, the
% updateDispaly function, every 0.25 seconds.  Create a function that
% updates the display.
addpath('Charts')
type updateNBBODisplayTimer

%%
% Now create and start the timer.
myTimer = timer('ExecutionMode','FixedRate',...
                'Period',0.25,...
                'TimerFcn',@(~,~) updateNBBODisplayTimer(ut,t,symbolList))
start(myTimer)

%%
% Run a program while the display updates
for i = 1:100
    disp(['Iteration ',num2str(i),' done!']);
    pause(0.1)
end
%%
% Stop the timer and delete it.
stop(myTimer)
delete(myTimer)
%%
% Notice that both the for loop program, and the display were updating
% simultaneously.

%% Events and Listeners
% The above example shows how to set up a streaming data source.  But how
% can we add muliple functions that listen to and respond to data updates,
% each differently.  We can use the concept of events and listeners from
% Object Oriented Programming to connect a datafeed with multiple traders
% (or strategies).  First create a simple data feed service:
addpath('Agents')
type SimpleStreamer

%%
% Our simple streamer is derived from a Streaming class, which will introduce
% shortly.  The class consistis of an event declaration, as consctrution
% function (method), and a step function.  First create an instance of the
% SimpleStreamer, with an update period of 1 second.
ss = SimpleStreamer(1)

%%
% Note that thhe dumbStreamer has two properties, Period and Timer.  These
% are inherited from the Streaming class.
type Streaming

%%
% This class is simply a timer class that will control a subclass by
% calling the step function (in the timer declaration), and has a start,
% stop, and delete set of functions for controling the streaming behavior
% of the subclass.  Note that step in SimpleStreamer is the function being
% repatedly called every second.  Let's see it in action.
start(ss)
pause(5)
stop(ss)

%%
% Six random prices were generated.  Add some traders (functions) to react
% to the new data.  This is done by adding the traders as a listner to the
% streaming data feed.
Trader1 = @(~,~) disp(['Trader1: Buy ',num2str(round(rand*100)),' shares']);
Trader2 = @(~,~) disp('Trader2: Buy 100 more');
Trader3 = @(~,~) disp('Trader3: Sell all my shares!');

addlistener(ss,'HaveNewData',Trader1);
addlistener(ss,'PriceIsGoingUp',Trader2);
addlistener(ss,'PriceIsGoingDown',Trader3);

start(ss)
pause(5)
stop(ss)
delete(ss)

%%
% We just created a very simplistic automated trading system!  Of course it
% disn't trade on any exchange, or use real data, but the mechanics to
% build a realistic system is the same.  In the next example, we'll show a
% realistic system.

