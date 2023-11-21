%{
https://www.tradingview.com/script/yTMOV9NM-Indicator-STARC-Bands/
study(title = "STARC Bands [LazyBear]", shorttitle="StarcBands_LB", overlay=true)
src = close
length=input(15)
tr_custom() => 
    x1=high-low
    x2=abs(high-close[1])
    x3=abs(low-close[1])
    max(x1, max(x2,x3))
    
atr_custom(x,y) => 
    sma(x,y)
    
tr_v = tr_custom()
basis=sma(src, 6)
acustom=(2*atr_custom(tr_v, length))
ul=basis+acustom
ll=basis-acustom
%}
function out = starc(H,L,C)
high = H;
low = L;
close = C;
Length = 15;
Lbas = 6;
persistent Xstarc
if isempty(Xstarc)
    Xstarc.Cwin = repmat(close,Lbas,1);
    Xstarc.tr_vwin = repmat(high-low,Length,1);
    Xstarc.Cp = close;
end
Xstarc.Cwin = [close;Xstarc.Cwin(1:end-1,:)];
x1 = high - low;
x2 = abs(high - Xstarc.Cp);
x3 = abs(low - Xstarc.Cp);
tr_v = max(x1,max(x2,x3));
Xstarc.tr_vwin = [tr_v;Xstarc.tr_vwin(1:end-1,:)];
basis = sum(Xstarc.Cwin)/Lbas;
atr_custom = sum(Xstarc.tr_vwin)/Length;
acustom = 2*atr_custom;
ul=basis+acustom;
ll=basis-acustom;
Xstarc.Cp = close;
out(1,:) = basis;
out(2,:) = ul;
out(3,:) = ll;
end
