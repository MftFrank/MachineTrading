%{
study(shorttitle="mForex - BB - Pinbar", title="mForex - Bollinger Bands - Pinbar scalping system", overlay=true)
length = input(20, minval=1, title="BB Length")
mult = input(2.0, minval=0.001, maxval=50, title="BB StdDev")
lengthRSI = input(9, minval=1, title="RSI Length")
pinbardown = input(75, minval=1, maxval=99, title="Bearish pinbar when RSI >= ")
pinbarup = input(25, minval=1, maxval=99, title="Bullish pinbar when RSI <= ")

basis = sma(close, length)
dev = mult * stdev(close, length)
upper = basis + dev
lower = basis - dev
plot(basis, "Basis", color=#872323, offset = 0)
p1 = plot(upper, "Upper", color=color.teal, offset = 0)
p2 = plot(lower, "Lower", color=color.teal, offset = 0)
fill(p1, p2, title = "Background", color=#198787, transp=95)

rsi = rsi(close, lengthRSI)
body = abs(close-open)
upshadow = open>close?(high-open):(high-close)
downshadow = open>close?(close-low):(open-low)
pinbar_h = close[1]>open[1] and rsi > pinbardown ?(body[1]>body?(upshadow>0.8*body?(upshadow>2*downshadow?1:0):0):0):0
pinbar_l = open[1]>close[1] and rsi < pinbarup ?(body[1]>body?(downshadow>0.8*body?(downshadow>2*upshadow?1:0):0):0):0
%}
function out = ScalpBollB(O,H,L,C)
Length = 20;
mult = 2.0;
lengthRSI = 9;
pinbardown = 75;
pinbarup = 25;
persistent XSboll
if isempty(XSboll)
    XSboll.Cwin = repmat(C,Length,1);
    XSboll.rsiwin = repmat(C,lengthRSI,1);
    XSboll.avgUp = zeros(1,length(C));
    XSboll.avgDp = zeros(1,length(C));
    XSboll.bodyp = abs(C-O);
    XSboll.Cp = C;
    XSboll.Op = O;
end
XSboll.Cwin = [C;XSboll.Cwin(1:end-1,:)];
XSboll.rsiwin = [C-XSboll.Cp;XSboll.rsiwin(1:end-1,:)];
basis = sum(XSboll.Cwin)/Length;
dev = mult * std(XSboll.Cwin);
upper = basis + dev;
lower = basis - dev;
alph = 1/lengthRSI;
tmpU = XSboll.rsiwin;
tmpU(tmpU<0)=0;
tmpD = XSboll.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*XSboll.avgUp + alph*avgU;
emaavgD = (1-alph)*XSboll.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
rsi = 100*(1 - 1./(1+RS));
body = abs(C-O);
upshadow = H-C;
k = find(O>C);
upshadow(k) = H(k)-O(k);
downshadow = O-L;
downshadow(k) = C(k)-L(k);
tmpH1 = zeros(1,length(O));
tmpL1 = zeros(1,length(O));
k = find(upshadow>2*downshadow);
tmpH1(k) = 1;
k = find(downshadow>2*upshadow);
tmpL1(k) = 1;
tmpH2 = zeros(1,length(O));
tmpL2 = zeros(1,length(O));
k = find(upshadow>0.8*body);
tmpH2(k) = tmpH1(k);
k = find(downshadow>0.8*body);
tmpL2(k) = tmpL1(k);
tmpH3 = zeros(1,length(O));
tmpL3 = zeros(1,length(O));
k = find(XSboll.bodyp>body);
tmpH3(k) = tmpH2(k);
tmpL3(k) = tmpL2(k);
pinbar_h = zeros(1,length(O));
pinbar_l = zeros(1,length(O));
k = find((XSboll.Cp>XSboll.Op)&(rsi>pinbardown));
pinbar_h(k) = tmpH3(k);
k = find((XSboll.Op>XSboll.Cp)&(rsi<pinbarup));
pinbar_l(k) = tmpL3(k);
% updates
XSboll.bodyp = body;
XSboll.Cp = C;
XSboll.Op = O;
out(1,:) = basis;
out(2,:) = upper;
out(3,:) = lower;
out(4,:) = rsi;
out(5,:) = upshadow;
out(6,:) = downshadow;
out(7,:) = pinbar_h;
out(8,:) = pinbar_l;
end
