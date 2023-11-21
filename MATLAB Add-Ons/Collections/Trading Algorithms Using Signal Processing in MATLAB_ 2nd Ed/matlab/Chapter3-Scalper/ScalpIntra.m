%{
study(title="CRUDE OIL BUY/SELL",shorttitle="CRUDE Scalp |3 Min",precision=2,overlay=true)
https://www.tradingview.com/script/BqkzYNrk-Intraday-BUY-SELL/
Rsi_value=input(14,title="RSI Length",step=1)
hl=input(75,title="Higher Value of RSI",step=1)
ll=input(25,title="Lower value of RSI",step=1)
rs=rsi(close,Rsi_value)

sma_value=input(50,title="SMA Length",step=1)
sma1=sma(close,sma_value)

dist_SMA=1
candle_length=1

mycolor= iff(rs>=hl or rs<=ll,color.yellow,iff(low> sma1,color.lime,iff(high<sma1,color.red,color.yellow)))
gaps=sma1+dist_SMA  //Gap between price and SMA for Sell
gapb=sma1-dist_SMA  //Gap between price and SMA for Buy
chartgap=gaps or gapb  //for both below or above the SMA 
gap1=sma1+5
gapvalue=(open/100)*candle_length     //setting % with its Share price
gapp=(high-low)>gapvalue //or rs<50     // Condition for Min candle size to be eligible for giving signal - Buy Calls
gapp2=(high-low)>gapvalue //or rs>55    // Condition for Min candle size to be eligible for giving signal - Sell Calls
bull=open<close and (high-low)>2*gapvalue and close>(high+open)/2
bear=open>close and (high-low)>2*gapvalue and close<(low+open)/2


rev1=rs>68 and open>close and open>gaps and (high-low)>gapvalue+0.5 and low!=close      //over red candles  "S" - uptrend
rev1a=rs>90 and open<close and close>gaps and high!=close and open!=low                             // over green candles"S" - uptrend
sellrev= rev1 or rev1a

rev2=rs<50 and open<close and open<gapb and open==low  //over green candles"B"
rev3=rs<30 and open>close and high>gapb and open!=high and barstate.isconfirmed!=bear  //over red candles"B"
rev4=rs<85 and close==high and (high-low)>gapvalue and open<close    //over green candle in both trends
hlrev_s=crossunder(rs,hl)
llrev_b=crossover(rs,ll) and open<close

buycall=open<close and open>sma1 and cross(close[1],sma1) and close>sma1
sellcall=cross(close,sma1) and open>close
BUY=crossover(close[1],sma1) and close[1]>open[1] and high[0]>high[1] and close[0]>open[0]  
SELL=crossunder(low[1],sma1) and close[1]<open[1] and low[0]<low[1] and close[0]<open[0]
%}
function out = ScalpIntra(C)
sma_value = 50;
Rsi_value = 14;
h1 = 75;
l1 = 25;
dist_SMA=1;
candle_length=1;
persistent XscInt
if isempty(XscInt)
    XscInt.Cwin = repmat(C,sma_value,1);
    XscInt.rsiwin = repmat(zeros(1,length(C)),Rsi_value,1);
    XscInt.Cp = C;
    XscInt.avgUp = zeros(1,length(C));
    XscInt.avgDp = zeros(1,length(C));
end
XscInt.Cwin = [C;XscInt.Cwin(1:end-1,:)];
XscInt.rsiwin = [C-XscInt.Cp;XscInt.rsiwin(1:end-1,:)];
sma1 = sum(XscInt.Cwin)/sma_value;

alph = 1/Rsi_value;
tmpU = XscInt.rsiwin;
tmpU(tmpU<0)=0;
tmpD = XscInt.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*XscInt.avgUp + alph*avgU;
emaavgD = (1-alph)*XscInt.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
rsi = 100*(1 - 1./(1+RS));
% updates
XscInt.avgUp = emaavgU;
XscInt.avgDp = emaavgD;
XscInt.Cp = C;
out(1,:) = sma1;
out(2,:) = rsi;
end