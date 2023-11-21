%{
https://www.tradingview.com/script/nbx4UFZ6-Indicator-4MACD/
study(title = "4MACD [LazyBear]", shorttitle="4MACD_LB")

source=close
mult_b=input(4.3, title="Blue multiplier")
mult_y=input(1.4, title="Yellow multiplier")

ema5=ema(close,5)
ema8=ema(close,8)
ema10=ema(close,10)
ema17=ema(source,17)
ema14=ema(source,14)
ema16=ema(close,16)
ema17_14 = ema17-ema14
ema17_8=ema17-ema8
ema10_16=ema10-ema16
ema5_10=ema5-ema10

MACDBlue=mult_b*(ema17_14-ema(ema17_14,5))
MACDRed=ema17_8-ema(ema17_8,5)
MACDYellow=mult_y*(ema10_16-ema(ema10_16,5))
MACDGreen=ema5_10-ema(ema5_10,5)
%}
function out = macd4(C)
source=C;
mult_b=4.3;
mult_y=1.4;
a5 = 2/(5+1);
a8 = 2/(8+1);
a10 = 2/(10+1);
a14 = 2/(14+1);
a16 = 2/(16+1);
a17 = 2/(17+1);
Z = zeros(1,length(C));
persistent X4macd
if isempty(X4macd)
    X4macd.e5p = source;
    X4macd.e8p = source;
    X4macd.e10p = source;
    X4macd.e14p = source;
    X4macd.e16p = source;
    X4macd.e17p = source;
    X4macd.e17_14p = Z;
    X4macd.e17_8p = Z;
    X4macd.e10_16p = Z;
    X4macd.e5_10p = Z;
end
ema5 = (1-a5)*X4macd.e5p + a5*source;
ema8 = (1-a8)*X4macd.e8p + a8*source;
ema10 = (1-a10)*X4macd.e10p + a10*source;
ema14 = (1-a14)*X4macd.e14p + a14*source;
ema16 = (1-a16)*X4macd.e16p + a16*source;
ema17 = (1-a17)*X4macd.e17p + a17*source;
ema17_14 = ema17-ema14;
ema17_8 = ema17-ema8;
ema10_16 = ema10-ema16;
ema5_10 = ema5-ema10;
Mema17_14 = (1-a5)*X4macd.e17_14p + a5*ema17_14;
Mema17_8 = (1-a5)*X4macd.e17_8p + a5*ema17_8;
Mema10_16 = (1-a5)*X4macd.e10_16p + a5*ema10_16;
Mema5_10 = (1-a5)*X4macd.e5_10p + a5*ema5_10;
MACDBlue = mult_b*(ema17_14-Mema17_14);
MACDRed = ema17_8-Mema17_8;
MACDYellow = mult_y*(ema10_16-Mema10_16);
MACDGreen = ema5_10-Mema5_10;
X4macd.e5p = ema5;
X4macd.e8p = ema8;
X4macd.e10p = ema10;
X4macd.e14p = ema14;
X4macd.e16p = ema16;
X4macd.e17p = ema17;
X4macd.e17_14p = Mema17_14;
X4macd.e17_8p = Mema17_8;
X4macd.e10_16p = Mema10_16;
X4macd.e5_10p = Mema5_10;
out(1,:) = ema5;
out(2,:) = ema8;
out(3,:) = ema10;
out(4,:) = ema14;
out(5,:) = ema16;
out(6,:) = ema17;
out(7,:) = MACDBlue;
out(8,:) = MACDRed;
out(9,:) = MACDYellow;
out(10,:) = MACDGreen;
end
