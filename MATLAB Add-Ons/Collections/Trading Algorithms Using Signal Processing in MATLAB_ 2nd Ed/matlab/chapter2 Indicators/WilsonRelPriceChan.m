%{
Wilson Relative Price Channel
Name:  Wilson Relative Price Channel
Formula:
Periods:=Input("Channel Periods",1, 250, 34);
Smoothing:=Input("Smoothing", 1, 55, 1);
Value2:=Input("Over Bought", 50, 99, 70);
Value3:=Input("Over Sold", 1, 50, 30);
Value4:=Input("Upper Neutral Zone", 50, 99, 55);
Value5:=Input("Lower Neutral Zone", 1, 50, 45);
OB:=Mov(RSI(Periods)-Value2,Smoothing,E);
OS:=Mov(RSI(Periods)-Value3,Smoothing,E);
NZU:=Mov(RSI(Periods)-Value4,Smoothing,E);
NZL:=Mov(RSI(Periods)-Value5,Smoothing,E);
{OverSold}
CLOSE-(CLOSE*(OS/100));
{OverBought}
CLOSE-(CLOSE*(OB/100));
{NeutUp}
CLOSE-(CLOSE*(NZU/100));
{NeutLower}
CLOSE-(CLOSE*(NZL/100));
%}
function out = WilsonRelPriceChan(close)
periods = 34;
% smoothing = 1;
smoothing = 5;
overbought = 70;
oversold = 30;
upperNeutralZone = 55;
lowerNeutralZone = 45;
alph = 2/(smoothing+1);
rsi = rsiWilChan(close,periods);
persistent Xwilchan
if isempty(Xwilchan)
    %Xwilchan.obp = rsi - overbought;
    %Xwilchan.osp = rsi - oversold;
    %Xwilchan.nzup = rsi - upperNeutralZone;
    %Xwilchan.nzlp = rsi - lowerNeutralZone;
    Xwilchan.obp = close;
    Xwilchan.osp = close;
    Xwilchan.nzup = close;
    Xwilchan.nzlp = close;
end
ob = (1-alph)*Xwilchan.obp + alph*(rsi - overbought);
os = (1-alph)*Xwilchan.osp + alph*(rsi - oversold);
nzu = (1-alph)*Xwilchan.nzup + alph*(rsi - upperNeutralZone);
nzl = (1-alph)*Xwilchan.nzlp + alph*(rsi - lowerNeutralZone);
out(1,:) = rsi;
out(2,:) = close.*(1 - ob/100);
out(3,:) = close.*(1 - os/100);
out(4,:) = close.*(1 - nzu/100);
out(5,:) = close.*(1 - nzl/100);
% updates
Xwilchan.obp = ob;
Xwilchan.osp = os;
Xwilchan.nzup = nzu;
Xwilchan.nzlp = nzl;
end

function out = rsiWilChan(close,periods)
persistent Xrsi
if isempty(Xrsi)
    Xrsi.win = zeros(periods,length(close));
    Xrsi.clp = close;
    Xrsi.avgUp = zeros(1,length(close));
    Xrsi.avgDp = zeros(1,length(close));
end
alph = 2/(periods+1);
Xrsi.win = [close-Xrsi.clp;Xrsi.win(1:end-1,:)];
tmpU = Xrsi.win;
tmpU(tmpU<0)=0;
tmpD = Xrsi.win;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*Xrsi.avgUp + alph*avgU;
emaavgD = (1-alph)*Xrsi.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
out = 100*(1 - 1./(1+RS));
% updates
Xrsi.avgUp = emaavgU;
Xrsi.avgDp = emaavgD;
Xrsi.clp = close;
end
