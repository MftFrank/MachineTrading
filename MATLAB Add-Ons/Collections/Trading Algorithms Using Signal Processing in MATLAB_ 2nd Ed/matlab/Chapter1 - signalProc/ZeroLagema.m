%{
https://www.tradingview.com/script/LTqZz3l9-Indicator-Zero-Lag-EMA-a-simple-trading-strategy/
study(title = "Almost Zero Lag EMA [LazyBear]", shorttitle="ZeroLagEMA_LB", overlay=true)
length=input(10)
src=close
ema1=ema(src, length)
ema2=ema(ema1, length)
d=ema1-ema2
zlema=ema1+d
%}
function out = ZeroLagema(C)
src = C;
Length = 10;
a = 2/(Length+1);
persistent Xzle
if isempty(Xzle)
    Xzle.e1p = src;
    Xzle.e2p = src;
end
ema1 = (1-a)*Xzle.e1p + a*src;
ema2 = (1-a)*Xzle.e2p + a*ema1;
d = ema1-ema2;
zlema = ema1+d;
Xzle.e1p = ema1;
Xzle.e2p = ema2;
out(1,:) = zlema;
end
