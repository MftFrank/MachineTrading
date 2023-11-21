%{
https://www.tradingview.com/script/AbRhwDeX-Double-Exponential-Moving-Average-8-20-63-Strategy/
strategy("Double Exponential Moving Average 8-20-63 Strategy", 
short = input(8, minval=1)
srcShort = input(ohlc4, title="Source Dema 1")

long = input(20, minval=1)
srcLong = input(low, title="Source Dema 2")

long2 = input(63, minval=1)
srcLong2 = input(close, title="Source Dema 3")
e1 = ema(srcShort, short)
e2 = ema(e1, short)
dema1 = 2 * e1 - e2
plot(dema1, color=color.green, linewidth=2)

e3 = ema(srcLong, long)
e4 = ema(e3, long)
dema2 = 2 * e3 - e4
plot(dema2, color=color.blue, linewidth=2)

e5 = ema(srcLong2, long2)
e6 = ema(e5, long2)
dema3 = 2 * e5 - e6
%}
function out = DEMA(O,H,L,C)
srcShort = (O+H+L+C)/4;
srcLong = L;
srcLong2 = C;
short = 8;
long = 20;
long2 = 63;
a1 = 2/(short+1);
a2 = 2/(long+1);
a3 = 2/(long2+1);
persistent Xdema
if isempty(Xdema)
    Xdema.e1p = srcShort;
    Xdema.e2p = srcShort;
    Xdema.e3p = srcLong;
    Xdema.e4p = srcLong;
    Xdema.e5p = srcLong2;
    Xdema.e6p = srcLong2;
end
e1 = (1-a1)*Xdema.e1p + a1*srcShort;
e2 = (1-a1)*Xdema.e2p + a1*e1;
dema1 = 2*e1 - e2;
e3 = (1-a2)*Xdema.e3p + a2*srcLong;
e4 = (1-a2)*Xdema.e4p + a2*e3;
dema2 = 2*e3 - e4;
e5 = (1-a3)*Xdema.e5p + a3*srcLong2;
e6 = (1-a3)*Xdema.e6p + a3*e5;
dema3 = 2*e5 - e6;
% updates
Xdema.e1p = e1;
Xdema.e2p = e2;
Xdema.e3p = e3;
Xdema.e4p = e4;
Xdema.e5p = e5;
Xdema.e6p = e6;
out(1,:) = dema1;
out(2,:) = dema2;
out(3,:) = dema3;
end
