%{
study(title="mForex - Keltner channel + EMA Scalping system", shorttitle="mForex - Keltner - EMA", overlay=true)
length = input(42, minval=1, title="Length Keltner")
emaFirst = input(10, minval=1, title="EMA First")
emaSecond = input(110, minval=1, title="EMA Second")

esma(source, length)=>
	s = sma(source, length)
	e = ema(source, length)
	e
	
ma = esma(close, length)
rangema = rma(tr(true), length)
upper = ma + rangema * 1.0
lower = ma - rangema * 1.0
c = color.blue
u = plot(upper, color=#0094FF, title="Upper")
plot(ma, color=#0094FF, title="Basis")
l = plot(lower, color=#0094FF, title="Lower")
fill(u, l, color=#0094FF, transp=95, title="Background")

outEmaFirst = ema(close, emaFirst)
plot(outEmaFirst, color=color.green, title="EMA First", linewidth=2)
outEmaSecond = ema(close, emaSecond)
%}
function out = ScalpKelt(H,L,C)
Length = 42;
emaFirst = 10;
emaSecond = 110;
aL = 2/(Length+1);
a1 = 2/(emaFirst+1);
a2 = 2/(emaSecond+1);
arma = 1/Length;
persistent XScKel
if isempty(XScKel)
    XScKel.emap = C;
    XScKel.ema1p = C;
    XScKel.ema2p = C;
    XScKel.rangep = zeros(1,length(C));
    XScKel.Cp = C;
end
ma = (1-aL)*XScKel.emap + aL*C;
rangema = (1-arma)*XScKel.rangep + ...
    arma*(max(H-L,max(H-XScKel.Cp,abs(L-XScKel.Cp))));
upper = ma + rangema*1.0;
lower = ma - rangema*1.0;
outEmaFirst = (1-a1)*XScKel.ema1p + a1*C;
outEmaSecond = (1-a2)*XScKel.ema2p + a2*C;
% updates
XScKel.emap = ma;
XScKel.rangep = rangema;
XScKel.ema1p = outEmaFirst;
XScKel.ema2p = outEmaSecond;
XScKel.Cp = C;
out(1,:) = ma;
out(2,:) = upper;
out(3,:) = lower;
out(4,:) = outEmaFirst;
out(5,:) = outEmaSecond;
end
