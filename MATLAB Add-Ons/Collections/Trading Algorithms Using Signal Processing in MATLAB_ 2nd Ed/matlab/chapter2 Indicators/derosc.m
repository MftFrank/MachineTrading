%{
https://www.tradingview.com/script/6wfwJ6To-Indicator-Derivative-Oscillator/
// @credits Constance Brown
// 
study(title = "Derivative Oscillator [LazyBear]", shorttitle="DO_LB")
length=input(14, title="RSI Length")
p=input(9,title="SMA length")
ema1=input(5,title="EMA1 length")
ema2=input(3,title="EMA2 length")

s1=ema(ema(rsi(close, length), ema1),ema2)
s2=s1 - sma(s1,p)
%}
function out = derosc(C)
close = C;
Length = 14;
alph = 1/Length;
p = 9;
a1 = 2/(5+1);
a2 = 2/(3+1);
Z = zeros(1,length(C));
persistent Xder
if isempty(Xder)
    Xder.Cp = close;
    Xder.rsiwin = repmat(Z,Length,1);
    Xder.s1win = repmat(Z,p,1);
    Xder.avgUp = Z;
    Xder.avgDp = Z;
    Xder.e1p = Z;
    Xder.e2p = Z;
end
Xder.rsiwin = [C-Xder.Cp;Xder.rsiwin(1:end-1,:)];
tmpU = Xder.rsiwin;
tmpU(tmpU<0)=0;
tmpD = Xder.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*Xder.avgUp + alph*avgU;
emaavgD = (1-alph)*Xder.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
rsi = 100*(1 - 1./(1+RS));
e1 = (1-a1)*Xder.e1p + a1*rsi;
s1 = (1-a2)*Xder.e2p + a2*e1;
Xder.s1win = [s1;Xder.s1win(1:end-1,:)];
s2 = s1 - sum(Xder.s1win)/p;
Xder.Cp = close;
Xder.avgUp = emaavgU;
Xder.avgDp = emaavgD;
Xder.e1p = e1;
Xder.e2p = s1;
out(1,:) = rsi;
out(2,:) = e1;
out(3,:) = s1;
out(4,:) = s2;
end
