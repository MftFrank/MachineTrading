%{
https://www.tradingview.com/script/jRrLUjPJ-EMA-Enveloper-Indicator-a-crazy-prediction/
study(title = "EMAEnvelope [LazyBear]", shorttitle="EMAEnvelope[LB]", overlay=true)
src = close
length=input(20)
HighlightColors = input(true, title="Bull/Bear highlights?", type=bool)

e=ema(close, length)
eu = ema(high, length)
el = ema(low, length)

plot(e, style=cross, color=aqua)
plot(eu, color=red, linewidth=2)
plot(el, color=lime, linewidth=2)
%}
function out = EMAenvelope(H,L,C)
Length = 20;
src = C;
high = H;
low = L;
a = 2/(Length+1);
persistent Xenv
if isempty(Xenv)
    Xenv.ep = src;
    Xenv.eup = high;
    Xenv.elp = low;
end
e = (1-a)*Xenv.ep + a*src;
eu = (1-a)*Xenv.eup + a*high;
el = (1-a)*Xenv.elp + a*low;
bull_f = (high > eu & low > el);
bear_f = (high < eu & low < el);
sidewise_f = (~ bull_f) & (~ bear_f);
Xenv.ep = e;
Xenv.eup = eu;
Xenv.elp = el;
out(1,:) = e;
out(2,:) = eu;
out(3,:) = el;
out(4,:) = bull_f;
out(5,:) = bear_f;
out(6,:) = sidewise_f;
end
