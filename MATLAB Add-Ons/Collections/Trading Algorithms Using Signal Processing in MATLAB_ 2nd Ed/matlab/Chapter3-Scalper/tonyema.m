%{
https://www.tradingview.com/script/egfSfN1y-TonyUX-EMA-Scalper-Buy-Sell/
study(title="Tony's EMA Scalper - Buy / Sell", shorttitle="TUX EMA Scalper", overlay=true)
len = input(20, minval=1, title="Length")
src = input(close, title="Source")
out = ema(src, len)
plot(out, title="EMA", color=blue)
last8h = highest(close, 8)
lastl8 = lowest(close, 8)
%}
function out = tonyema(C)
len = 20;
src = C;
lenwt = 8;
a = 2/(len+1);
persistent Xtema
if isempty(Xtema)
    Xtema.emap = src;
    Xtema.lastwin = repmat(src,lenwt,1);
end
Xtema.lastwin = [src;Xtema.lastwin(1:end-1,:)];
ema = (1-a)*Xtema.emap + a*src;
last8h = max(Xtema.lastwin);
lastl8 = min(Xtema.lastwin);
Xtema.emap = ema;
out(1,:) = ema;
out(2,:) = last8h;
out(3,:) = lastl8;
end
