%{
https://www.tradingview.com/script/qcmM1Ocn-Indicators-Constance-Brown-Composite-Index-RSI-Avgs/
study(title="Constance Brown Composite Index [LazyBear]", shorttitle="CBIDX_LB")
src = close
rsi_length=input(14, title="RSI Length")
rsi_mom_length=input(9, title="RSI Momentum Length")
rsi_ma_length=input(3, title="RSI MA Length")
ma_length=input(3, title="SMA Length")
fastLength=input(13)
slowLength=input(33)

r=rsi(src, rsi_length)
rsidelta = mom(r, rsi_mom_length)
rsisma = sma(rsi(src, rsi_ma_length), ma_length)
s=rsidelta+rsisma

plot(s, color=red, linewidth=2)
plot(sma(s, fastLength), color=green)
plot(sma(s, slowLength), color=orange)
%}
function out = cbCompIdx(C)
src = C;
rsi_length = 14;
rsi_mom_length = 9;
rsi_ma_length = 3;
ma_length = 3;
fastLength = 13;
slowLength = 33;
Z = zeros(1,length(src));
persistent Xcbci
if isempty(Xcbci)
    Xcbci.srcwin = repmat(Z,rsi_length,1);
    Xcbci.momrwin = repmat(Z,rsi_mom_length,1);
    Xcbci.src2win = repmat(src,rsi_ma_length,1);
    Xcbci.smawin = repmat(Z,ma_length,1);
    Xcbci.sma2win = repmat(Z,slowLength,1);
    Xcbci.Cp = src;
    Xcbci.avgUp = Z;
    Xcbci.avgDp = Z;
    Xcbci.avgU2p = Z;
    Xcbci.avgD2p = Z;
    Xcbci.rp = Z;
end
Xcbci.srcwin = [src-Xcbci.Cp;Xcbci.srcwin(1:end-1,:)];
Xcbci.src2win = [src-Xcbci.Cp;Xcbci.src2win(1:end-1,:)];
% rsi calcs
tmpU = Xcbci.srcwin;
tmpU(tmpU<0)=0;
tmpD = Xcbci.srcwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (avgU-Xcbci.avgUp)/rsi_length + Xcbci.avgUp;
emaavgD = (avgD-Xcbci.avgDp)/rsi_length + Xcbci.avgDp;
tmp = emaavgD;
tmp(tmp==0) = 1;
rs = emaavgU./tmp;
r = 100 - (100 ./ (1 + rs));
Xcbci.momrwin = [r-Xcbci.rp;Xcbci.momrwin(1:end-1,:)];
rsidelta = Xcbci.momrwin(end,:);
% rsi calcs
tmpU = Xcbci.src2win;
tmpU(tmpU<0)=0;
tmpD = Xcbci.src2win;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU2 = (avgU-Xcbci.avgU2p)/rsi_ma_length + Xcbci.avgU2p;
emaavgD2 = (avgD-Xcbci.avgD2p)/rsi_ma_length + Xcbci.avgD2p;
tmp = emaavgD2;
tmp(tmp==0) = 1;
rs = emaavgU2./tmp;
r2 = 100 - (100 ./ (1 + rs));
Xcbci.smawin = [r2;Xcbci.smawin(1:end-1,:)];
rsisma = sum(Xcbci.smawin)/ma_length;
s = rsidelta + rsisma;
Xcbci.sma2win = [s;Xcbci.sma2win(1:end-1,:)];
sfast = sum(Xcbci.sma2win(1:fastLength,:))/fastLength;
sslow = sum(Xcbci.sma2win)/slowLength;
Xcbci.Cp = src;
Xcbci.rp = r;
Xcbci.avgUp = emaavgU;
Xcbci.avgDp = emaavgD;
Xcbci.avgU2p = emaavgU2;
Xcbci.avgD2p = emaavgD2;
out(1,:) = s;
out(2,:) = sfast;
out(3,:) = sslow;
end
