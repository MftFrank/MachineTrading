%{
https://www.tradingview.com/script/Ox9gyUFA-Indicator-OBV-Oscillator/
study(title="On Balance Volume Oscillator [LazyBear]", shorttitle="OBVOSC_LB")
src = close
length=input(20)
obv(src) => cum(change(src) > 0 ? volume : change(src) < 0 ? -volume : 0*volume)
os=obv(src)
obv_osc = (os - ema(os,length))
obc_color=obv_osc > 0 ? green : red
%}
function out = OBVosc(C,V)
src = C;
Length = 20;
a = 2/(Length+1);
Z = zeros(1,length(src));
persistent Xobvosc
if isempty(Xobvosc)
    Xobvosc.Cp = src;
    Xobvosc.obvp = Z;
    Xobvosc.osp = Z;
end
tmp = src - Xobvosc.Cp;
Up = find(tmp>0);
Dn = find(tmp<0);
obv = Xobvosc.obvp;
obv(Up) = obv(Up) + V(Up);
obv(Dn) = obv(Dn) + V(Dn);
os = obv;
ema = (1-a)*Xobvosc.osp + a*os;
obv_osc = os - ema;
Xobvosc.Cp = src;
Xobvosc.osp = ema;
out(1,:) = os;
out(2,:) = ema;
out(3,:) = obv_osc;
end
