%{
https://www.tradingview.com/script/Q8NTThaR-Sniper-Scalper/
//-----Support and Resistance
supportSource = input(title="Suppport & Resistance source", type=input.source, defval=low)
resistanceSource = input(title="Suppport & Resistance source", type=input.source, defval=high)resistance = 21
resistanceTop = valuewhen(high >= highest(high, resistance), resistanceSource, 0)
stopZoneTop1 = atr(14) + resistanceTop
stopZoneTop2 = 2 * atr(14) + resistanceTop

resistanceBottom = valuewhen(low <= lowest(resistance), supportSource, 0)
stopZoneBottom1 = resistanceBottom - atr(14)
stopZoneBottom2 = resistanceBottom -  2 * atr(14)

resTop = plot(resistanceTop, color=resistanceTop != resistanceTop[1] ? na : color.red, linewidth=1, offset=0, transp=100)
stopT1 = plot(stopZoneTop1, color=resistanceTop != resistanceTop[1] ? na : color.red, linewidth=1, offset=0)
stopT2 = plot(stopZoneTop2, color=resistanceTop != resistanceTop[1] ? na : color.red, linewidth=1, offset=0)
fill(resTop, stopT1, color=color.red, transp=85)
fill(stopT1, stopT2, color=color.red, transp=80)

resBottom = plot(resistanceBottom, color=resistanceBottom != resistanceBottom[1] ? na : color.green, linewidth=1, offset=0, transp=100)
stopB1 = plot(stopZoneBottom1, color=resistanceBottom != resistanceBottom[1] ? na : color.green, linewidth=1, offset=0)
stopB2 = plot(stopZoneBottom2, color=resistanceBottom != resistanceBottom[1] ? na : color.green, linewidth=1, offset=0)
fill(resBottom, stopB1, color=color.green, transp=85)
fill(stopB1, stopB2, color=color.green, transp=80)

tema (src, len) => 
    ema1 = ema(src, len)
    ema2 = ema(ema1, len)
    ema3 = ema(ema2, len)
    (3*ema1)-(3*ema2) + ema3
    

// SWITCH MA Type
trendMaType = input(title="Trend MA type", options=["sma", "tema", "ema", "hma", "wma"], defval="ema")
trendMaSource = input(title="Trend MA source", type=input.source, defval=close)
trendMaLength = input(title="Trend MA length", defval=55)

entryMaLength = input(title="Entry MA length", defval=21)
entryMaSource = input(title="Entry MA source", type=input.source, defval=close)
entryMaType = input(title="Entry MA type", options=["sma", "tema", "ema", "hma", "wma"], defval="ema")

getMovingAverage(type, src, len) =>
      type == "sma"  ? sma(src, len) :
      type == "tema" ? tema(src, len) :
      type == "ema" ? ema(src, len) :
      type == "hma" ? hma(src, len) :
      type == "wma" ? wma(src, len) :
      na

    
trendMovingAverage = getMovingAverage(trendMaType, trendMaSource, trendMaLength)
plot(trendMovingAverage, color=color.orange)
entryMovingAverage = getMovingAverage(entryMaType, entryMaSource, entryMaLength)
plot(entryMovingAverage, color=color.blue)

maStop1 = plot(entryMovingAverage + atr(14), color=resistanceTop != resistanceTop[1] ? na : color.red, linewidth=1, offset=0, transp=100)
maStop2 = plot(entryMovingAverage - atr(14), color=resistanceTop != resistanceTop[1] ? na : color.red, linewidth=1, offset=0, transp=100)
fill(maStop1, maStop2, color=color.orange, transp=90)
%}
function out = ScalpSniper(H,L,C)
resistance = 21;
resistanceSource = H;
supportSource = L;
atrlen = 14;
entryMaLength = 21;
trendMaLength = 55;
ae = 2/(entryMaLength+1);
at = 2/(trendMaLength+1);
persistent Xsnip
if isempty(Xsnip)
    Xsnip.clwin = repmat(C,atrlen,1);
    Xsnip.hiwin = repmat(H,resistance,1);
    Xsnip.lowin = repmat(L,resistance,1);
    Xsnip.ema1entp = C;
    Xsnip.ema2entp = C;
    Xsnip.ema3entp = C;
    Xsnip.ema1trp = C;
    Xsnip.ema2trp = C;
    Xsnip.ema3trp = C;
end
Xsnip.clwin = [C;Xsnip.clwin(1:end-1,:)];
Xsnip.hiwin = [H;Xsnip.hiwin(1:end-1,:)];
Xsnip.lowin = [L;Xsnip.lowin(1:end-1,:)];
highest = max(Xsnip.hiwin);
k = find(H>=highest);
resistanceTop = resistanceSource;
resistanceTop(k) = H(k);
atr = max(H-L,max(H-Xsnip.clwin(2,:),...
    abs(L-Xsnip.clwin(2,:))));
stopZoneTop1 = resistanceTop + atr;
stopZoneTop2 = resistanceTop + 2*atr;
lowest = min(Xsnip.lowin);
k = find(L<=lowest);
resistanceBottom = supportSource;
resistanceBottom(k) = L(k);
atr = max(H-L,max(H-Xsnip.clwin(2,:),...
    abs(L-Xsnip.clwin(2,:))));
stopZoneBottom1 = resistanceBottom - atr;
stopZoneBottom2 = resistanceBottom - 2*atr;
ema1e = (1-ae)*Xsnip.ema1entp + ae*C;
ema2e = (1-ae)*Xsnip.ema2entp + ae*ema1e;
ema3e = (1-ae)*Xsnip.ema3entp + ae*ema2e;
entryMovingAverage = 3*(ema1e - ema2e) + ema3e;
ema1t = (1-at)*Xsnip.ema1trp + at*C;
ema2t = (1-at)*Xsnip.ema2trp + at*ema1t;
ema3t = (1-at)*Xsnip.ema3trp + at*ema2t;
trendMovingAverage = 3*(ema1t - ema2t) + ema3t;
maStop1 = entryMovingAverage + atr;
maStop2 = entryMovingAverage - atr;
% updates
Xsnip.ema1entp = ema1e;
Xsnip.ema2entp = ema2e;
Xsnip.ema3entp = ema3e;
Xsnip.ema1trp = ema1t;
Xsnip.ema2trp = ema2t;
Xsnip.ema3trp = ema3t;
out(1,:) = entryMovingAverage;
out(2,:) = trendMovingAverage;
out(3,:) = maStop1;
out(4,:) = maStop2;
out(5,:) = resistanceTop;
out(6,:) = stopZoneTop1;
out(7,:) = stopZoneTop2;
out(8,:) = resistanceBottom;
out(9,:) = stopZoneBottom1;
out(10,:) = stopZoneBottom2;
end
