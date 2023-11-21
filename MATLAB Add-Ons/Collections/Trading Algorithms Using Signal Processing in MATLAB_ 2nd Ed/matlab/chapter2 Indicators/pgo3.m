%{
https://www.tradingview.com/script/GhxOzF0z-3-new-Indicators-PGO-RAVI-TII/
study(title="Pretty Good Oscillator [LazyBear]", shorttitle="PGO_LB")
length=input(89)
pgo = (close - sma(close, length))/ema(tr, length)
https://www.tradingview.com/script/pZkdfat6-Range-Action-Verification-Index-RAVI/fastLength = input(title="Fast MA Length", type=integer, defval=7, minval=1)
study("Range Action Verification Index (RAVI)", shorttitle="RAVI")
fastMAInput = input(title="Fast MA", defval="SMA", options=["EMA", "SMA", "VWMA", "WMA"])
slowLength = input(title="Slow MA Length", type=integer, defval=65, minval=1)
slowMAInput = input(title="Slow MA", defval="SMA", options=["EMA", "SMA", "VWMA", "WMA"])
breakoutLevel = input(title="Breakout Level", type=float, minval=0, step=0.1, defval=3)
src = input(title="Source", type=source, defval=close)
highlightMovements = input(title="Highlight Movements ?", type=bool, defval=true)
highlightBreakouts = input(title="Highlight Level Breakouts ?", type=bool, defval=true)

fastMA = iff(fastMAInput == "EMA", ema(src, fastLength),
	 iff(fastMAInput == "SMA", sma(src, fastLength),
	 iff(fastMAInput == "VWMA", vwma(src, fastLength),
	 iff(fastMAInput == "WMA", wma(src, fastLength),
	 na))))

slowMA = iff(slowMAInput == "EMA", ema(src, slowLength),
	 iff(slowMAInput == "SMA", sma(src, slowLength),
	 iff(slowMAInput == "VWMA", vwma(src, slowLength),
	 iff(slowMAInput == "WMA", wma(src, slowLength),
	 na))))

ravi = 100 * abs(fastMA - slowMA) / slowMA
https://www.tradingview.com/script/KYZOCAsk-Trend-Intensity-Index/
study("Trend Intensity Index", shorttitle="TII")
majorLength = input(title="Major Length", type=integer, defval=60)
minorLength = input(title="Minor Length", type=integer, defval=30)
upperLevel = input(title="Upper Level", type=integer, defval=80)
lowerLevel = input(title="Lower Level", type=integer, defval=20)
highlightBreakouts = input(title="Highlight Overbought/Oversold Breakouts ?", type=bool, defval=true)
src = input(title="Source", type=source, defval=close)

sma = sma(src, majorLength)

positiveSum = 0.0
negativeSum = 0.0

for i = 0 to minorLength - 1
    price = nz(src[i])
    avg = nz(sma[i])
    positiveSum := positiveSum + (price > avg ? price - avg : 0)
    negativeSum := negativeSum + (price > avg ? 0 : avg - price)

tii = 100 * positiveSum / (positiveSum + negativeSum)
%}
function out = pgo3(H,L,C)
src = C;
Lenpgo = 89;
fastLength = 7;
slowLength = 65;
majorLength = 60;
minorLength = 30;
ap = 2/(Lenpgo+1);
persistent Xpgo3
if isempty(Xpgo3)
    Xpgo3.srcwin = repmat(src,Lenpgo,1);
    Xpgo3.smatiiwin = repmat(src,minorLength,1);
    tr = max(H-L,max(abs(H-C),abs(L-C)));
    Xpgo3.epgop = tr;
    Xpgo3.Cp = C;
end
Xpgo3.srcwin = [src;Xpgo3.srcwin(1:end-1,:)];
% pgo
tr = max(H-L,max(abs(H-Xpgo3.Cp),abs(L-Xpgo3.Cp)));
ema = (1-ap)*Xpgo3.epgop + ap*tr;
sma = sum(Xpgo3.srcwin)/Lenpgo;
pgo = (src - sma)./ema;
% ravi
fastMA = sum(Xpgo3.srcwin(1:fastLength,:))/fastLength;
slowMA = sum(Xpgo3.srcwin(1:slowLength,:))/slowLength;
ravi = 100 * abs(fastMA - slowMA) ./ slowMA;
% trend intensity index
smatii = sum(Xpgo3.srcwin(1:majorLength,:))/majorLength;
Xpgo3.smatiiwin = [smatii;Xpgo3.smatiiwin(1:end-1,:)];
positiveSum = 0.0;
negativeSum = 0.0;
for i = 1:minorLength
    price = Xpgo3.srcwin(i,:);
    avg = Xpgo3.smatiiwin(i,:);
    tmp1 = price - avg;
    tmp1(price < avg) = 0;
    positiveSum = positiveSum + tmp1;
    tmp1 = avg - price;
    tmp1(price > avg) = 0;
    negativeSum = negativeSum + tmp1;
end
tii = 100 * positiveSum ./ (positiveSum + negativeSum);
Xpgo3.Cp = C;
Xpgo3.epgop = ema;
out(1,:) = pgo;
out(2,:) = ravi;
out(3,:) = tii;
end
