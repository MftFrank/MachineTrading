%{
https://www.tradingview.com/script/LjT0cZUy-ATR-VWAP-Alert/
study('ATR+VWAP Alert', overlay=true)
// data series for RSI with length 14
rsi = rsi(close, 14)
// data series for ATR with length 14
vol = atr(14)
// data series for VWAP
VWAP = vwap(0)
// data series for VWMAs, length 13 and 62
ma1 = vwma(close, 13)
ma2 = vwma(close, 62)
%}
function out = Scalpatrvwap(H,L,C,V)
P = (H+L+C)/3;
rsilen = 14;
len1 = 13;
len2 = 62;
alph = 1/rsilen;
atrL = alph;
Z = zeros(1,length(H));
persistent Xscatrvwap
if isempty(Xscatrvwap)
    Xscatrvwap.rsiwin = Z;
    Xscatrvwap.Cp = C;
    Xscatrvwap.avgUp = Z;
    Xscatrvwap.avgDp = Z;
    Xscatrvwap.atrp = max(H-L,max(H-C,abs(L-C)));
    Xscatrvwap.vwmap = repmat(V.*C,len2,1);
    Xscatrvwap.Vwin = repmat(V,len2,1);
    Xscatrvwap.Cwin = repmat(C,len2,1);
    Xscatrvwap.VWAP = repmat(V.*P,len2,1);
end
Xscatrvwap.rsiwin = [C-Xscatrvwap.Cp;Xscatrvwap.rsiwin(1:end-1,:)];
Xscatrvwap.vwmap = [V.*C;Xscatrvwap.vwmap(1:end-1,:)];
Xscatrvwap.Vwin = [V;Xscatrvwap.Vwin(1:end-1,:)];
Xscatrvwap.Cwin = [C;Xscatrvwap.Cwin(1:end-1,:)];
Xscatrvwap.VWAP = [V.*P;Xscatrvwap.VWAP(1:end-1,:)];
tmpU = Xscatrvwap.rsiwin;
tmpU(tmpU<0)=0;
tmpD = Xscatrvwap.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*Xscatrvwap.avgUp + alph*avgU;
emaavgD = (1-alph)*Xscatrvwap.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
rsi = 100*(1 - 1./(1+RS));
atr = max(H-L,max(H-Xscatrvwap.Cwin(2,:),...
    abs(L-Xscatrvwap.Cwin(2,:))));
vol = (1-atrL)*Xscatrvwap.atrp + atrL*atr;
vwap = sum(Xscatrvwap.VWAP(1:len1,:))./sum(Xscatrvwap.Vwin(1:len1,:));
ma1 = sum(Xscatrvwap.vwmap(1:len1,:))./sum(Xscatrvwap.Vwin(1:len1,:));
ma2 = sum(Xscatrvwap.vwmap)./sum(Xscatrvwap.Vwin);
Xscatrvwap.avgUp = emaavgU;
Xscatrvwap.avgDp = emaavgD;
Xscatrvwap.atrp = vol;
out(1,:) = rsi;
out(2,:) = vol;
out(3,:) = vwap;
out(4,:) = ma1;
out(5,:) = ma2;
end
