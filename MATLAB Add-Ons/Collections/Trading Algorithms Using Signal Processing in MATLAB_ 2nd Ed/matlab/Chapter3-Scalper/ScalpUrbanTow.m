%{
https://www.tradingview.com/script/z4kWhDYO-Urban-Towers/
study(title="Urban Towers Scalping Strategy", shorttitle="Urban Towers", overlay=true)

// ***
// EMA Criteria
// ***
src = close

ema37 = ema(src, 37)
ema39 = ema(src, 39)
ema41 = ema(src, 41)
ema44 = ema(src, 44)
ema47 = ema(src, 47)
ema50 = ema(src, 50)

// ***
// Candle Criteria
// ***
long = high[2] >= high[1] and high[1] >= high[0] and low < ema37 and close > ema50 and close > ema50
short = high[2] <= high[1] and high[1] <= high[0] and high > ema37 and close < ema50 and close < ema50
%}
function out = ScalpUrbanTow(H,L,C)
high = H;
low = L;
close = C;
a37 = 2/(37+1);
a39 = 2/(39+1);
a41 = 2/(41+1);
a44 = 2/(44+1);
a47 = 2/(47+1);
a50 = 2/(50+1);
persistent Xscut
if isempty(Xscut)
    Xscut.e37p = close;
    Xscut.e39p = close;
    Xscut.e41p = close;
    Xscut.e44p = close;
    Xscut.e47p = close;
    Xscut.e50p = close;
    Xscut.hip = high;
    Xscut.hipp = high;
end
ema37 = (1-a37)*Xscut.e37p + a37*close;
ema39 = (1-a39)*Xscut.e39p + a39*close;
ema41 = (1-a41)*Xscut.e41p + a41*close;
ema44 = (1-a44)*Xscut.e44p + a44*close;
ema47 = (1-a47)*Xscut.e47p + a47*close;
ema50 = (1-a50)*Xscut.e50p + a50*close;
long = Xscut.hipp >= Xscut.hip & Xscut.hip >= high & ...
    low < ema37 & close > ema50;
short = Xscut.hipp <= Xscut.hip & Xscut.hip <= high & ...
    high > ema37 & close < ema50;
Xscut.e37p = ema37;
Xscut.e39p = ema39;
Xscut.e41p = ema41;
Xscut.e44p = ema44;
Xscut.e47p = ema47;
Xscut.e50p = ema50;
Xscut.hipp = Xscut.hip;
Xscut.hip = high;
out(1,:) = ema37;
out(2,:) = ema39;
out(3,:) = ema41;
out(4,:) = ema44;
out(5,:) = ema47;
out(6,:) = ema50;
out(7,:) = long;
out(8,:) = short;
end
