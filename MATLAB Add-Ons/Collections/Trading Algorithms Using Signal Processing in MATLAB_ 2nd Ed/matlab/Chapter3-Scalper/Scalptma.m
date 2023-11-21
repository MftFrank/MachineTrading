%{
https://www.tradingview.com/script/kPV0Kl8w-Triangular-Moving-Average-TMA-bands/
Triangular Moving Average (TMA) bands
study("TMA bands", shorttitle="TMA bands", overlay=true)
TMAPeriodBack = input(defval=35, title="TMA number of bars back")
ATRPeriodBack = input(defval=75, title="ATR number of bars back")
ATRMultiplier = input(defval=4.0, title="ATR Multiplier")
src = input(close, title="Price")

ssi=wma(src,TMAPeriodBack)
tma = swma(ssi)
range = atr(ATRPeriodBack)*ATRMultiplier
tmah = tma+range
tmal = tma-range 
%}
function out = Scalptma(H,L,C)
TMAPeriodBack = 35;
ATRPeriodBack = 75;
ATRMultiplier = 4.0;
src = C;
tmp = [TMAPeriodBack:-1:1];
bwma = tmp/sum(tmp);
bsm = [1 2 2 1]/6;
atrlen = ATRPeriodBack;
atrL = 1/atrlen;

persistent XSctma
if isempty(XSctma)
    XSctma.Cwin = repmat(C,TMAPeriodBack,1);
    XSctma.smCwin = repmat(C,length(bsm),1);
    XSctma.atrp = max(H-L,max(H-C,abs(L-C)));
end
XSctma.Cwin = [C;XSctma.Cwin(1:end-1,:)];
ssi = sum(bwma'.*XSctma.Cwin);
XSctma.smCwin = [ssi;XSctma.smCwin(1:end-1,:)];
tma = sum(bsm'.*XSctma.smCwin);
atr = max(H-L,max(H-XSctma.Cwin(2,:),...
    abs(L-XSctma.Cwin(2,:))));
atr = (1-atrL)*XSctma.atrp + atrL*atr;
range = atr*ATRMultiplier;
tmah = tma+range;
tmal = tma-range;
XSctma.atrp = atr;
out(1,:) = ssi;
out(2,:) = tma;
out(3,:) = tmah;
out(4,:) = tmal;
end
