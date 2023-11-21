%{
https://www.investopedia.com/terms/g/guppy-multiple-moving-average.asp
Guppy Multiple Moving Average (GMMA)
The Guppy Multiple Moving Average (GMMA) is a technical 
indicator that identifies changing trends, breakouts, and 
trading opportunities in the price of an asset by 
combining two groups of moving averages (MA) with 
different time periods. There is a short-term group of MAs, 
and a long-term group of MA. Both contain six MAs, 
for a total of 12. The term gets its name from Daryl Guppy, 
an Australian trader who is credited with its development.
The Guppy is composed of 12 EMAs, so essentially 
the Guppy and an EMA are the same thing. 
The Guppy is a collection of EMAs that are believed 
to help isolate trades, spot opportunities, and warn 
about price reversals.
EMA=[Close price−EMA previous]∗M+EMA previous
​	 
or:
SMA= NSum of N closing prices
​	 
where:
EMA=exponential moving average
EMA previous =the exponential moving average from the 
    previous period
(The SMA can substitute for the EMA previous
​	  for the first calculation)
Multiplier M= 2/(N+1)
​	 
SMA=simple moving average
N=number of periods
​The Guppy Multiple Moving Average (GMMA) is applied 
as an overlay on the price chart of an asset.
The short-term MAs are typically set at 3, 5, 8, 10, 12, 
and 15 periods. The longer-term MAs are typically set at 
30, 35, 40, 45, 50, and 60.
The Guppy MMA Oscillator, developed by Leon Wilson, 
is an oscillator representation of difference between GMMA ribbons. 
Look for signal crosses for the triggers.
%}
function out = GMMAosc(C)
P = C;
Nshort = [3 5 8 10 12 15];
Nlong = [30 35 40 45 50 60];
ashort = 2./(Nshort+1);
along = 2./(Nlong+1);
am = 2/(9+1);
Z = zeros(1,length(C));
persistent Xgmma
if isempty(Xgmma)
    Xgmma.shortp = repmat(P,length(Nshort),1);
    Xgmma.longp = repmat(P,length(Nlong),1);
    Xgmma.macdP = repmat(Z,length(Nlong),1);
end
gshort = (P - Xgmma.shortp).*ashort' + Xgmma.shortp;
glong = (P - Xgmma.longp).*along' + Xgmma.longp;
osc = gshort - glong;
macd = (osc - Xgmma.macdP).*am + Xgmma.macdP;
Xgmma.shortp = gshort;
Xgmma.longp = glong;
Xgmma.macdP = macd;
out = [gshort;glong;osc;macd;osc-macd];
end
