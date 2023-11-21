%{
https://www.tradingview.com/script/eM057Bu5-Indicators-Volume-Zone-Indicator-Price-Zone-Indicator/
Volume Zone Indicator (VZO) and Price Zone Indicator (PZO) are by Waleed Aly Khalil.
Volume Zone Indicator (VZO)
------------------------------------------------------------
VZO is a leading volume oscillator that evaluates volume in relation to the direction of the net price change on each bar.

A value of 40 or above shows bullish accumulation. Low values (< 40) are bearish . Near zero or between +/- 20, the market is either in consolidation or near a break out. When VZO is near +/- 60, an end to the bull/bear run should be expected soon. If that run has been opposite to the long term price trend direction, then a reversal often will occur.

Traditional way of looking at this also works:
* +/- 40 levels are overbought / oversold
* +/- 60 levels are extreme overbought / oversold

More info:
https://drive.google.com/file/d/0Bx48Du_2aPFncEM3dHhyaWtTdjA/edit

Price Zone Indicator (PZO)
------------------------------------------------------------
PZO is interpreted the same way as VZO (same formula with "close" substituted for "volume").
study("Volume Zone Oscillator [LazyBear]", shorttitle="VZO_LB")
length=input(20, title="MA Length")

dvol=sign(close-close[1]) * volume
dvma=ema(dvol, length)
vma=ema(volume, length)
vzo=iff(vma != 0, 100 * dvma / vma,0)
%}
function out = pzovzo(C,V)
Length = 20;
a = 2/(Length+1);
close = C;
volume = V;
Z = zeros(1,length(volume));
persistent Xzo
if isempty(Xzo)
    Xzo.Cp = close;
    Xzo.dvmap = Z;
    Xzo.dpmap = Z;
    Xzo.vmap = volume;
    Xzo.clmap = close;
end
dvol = sign(close-Xzo.Cp) .* volume;
dprice = sign(close-Xzo.Cp) .* close;
dvma = (1-a)*Xzo.dvmap + a*dvol;
dpma = (1-a)*Xzo.dpmap + a*dprice;
vma = (1-a)*Xzo.vmap + a*volume;
clma = (1-a)*Xzo.clmap + a*close;
vzo = 100 * dvma ./ vma;
pzo = 100 * dpma ./ clma;
Xzo.Cp = close;
Xzo.dvmap = dvma;
Xzo.dpmap = dpma;
Xzo.vmap = vma;
Xzo.clmap = clma;
out(1,:) = vzo;
out(2,:) = pzo;
end
