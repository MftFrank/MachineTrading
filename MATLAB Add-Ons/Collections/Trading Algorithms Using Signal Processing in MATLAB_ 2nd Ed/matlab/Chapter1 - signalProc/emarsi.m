%{
https://www.tradingview.com/script/lPQylz1E-EMARSI-New-Moving-Average/
study(title="EMA + RSI", shorttitle="EMARSI", overlay=true, resolution="")
len = input(20, minval=1, title="Length")
src = input(close, title="Source")
offset = input(title="Offset", type=input.integer, defval=0, minval=-500, maxval=500)
smooth_emaRsi = input(false, title="Smooth ?")
RSIEffect = input(10, title="RSI Effect to Price 1-100, Not Smooth", minval=1, maxval=100) * 0.01

//Formula
emaRsi(src,len) =>
    rsiA = rsi(src,len)
    rsiWeight = smooth_emaRsi ? change(rsiA)/nz(avg(rsiA,rsiA[1]), 0.0000000001) * (src / 100) : avg(rsiA,rsiA[1]) * RSIEffect * (src / 100) 
    emaRsi = smooth_emaRsi ? src + rsiWeight : src + rsiWeight - rsiWeight[1]
    ema(emaRsi,len)
    
//
out_ema = ema(src, len)
out_emaRsi = emaRsi(src, len)
%}
function out = emarsi(C)
len = 20;
arsi = 1/len;
aema = 2/(len+1);
src = C;
RSIEffect = 1;
Z = zeros(1,length(C));
persistent Xemarsi
if isempty(Xemarsi)
    Xemarsi.emap = src;
    Xemarsi.Cp = src;
    Xemarsi.rsiwin = repmat(Z,len,1);
    Xemarsi.rsiupP = Z;
    Xemarsi.rsidownP = Z;
    Xemarsi.adxP = Z;
    Xemarsi.rsiAP = Z;
    Xemarsi.rsiWeightP = Z;
    Xemarsi.emarsip = src;
end
Xemarsi.rsiwin = [src-Xemarsi.Cp;Xemarsi.rsiwin(1:end-1,:)];
rsiup = max(Xemarsi.rsiwin);
rsiup(rsiup<0) = 0;
rsidown = min(Xemarsi.rsiwin);
rsidown(rsidown>0) = 0;
rsidown = abs(rsidown);
rsiup = (1-arsi)*Xemarsi.rsiupP + arsi*rsiup;
rsidown = (1-arsi)*Xemarsi.rsidownP + arsi*rsidown;
vrsi(rsidown == 0) = 100;
k = find(rsidown ~= 0);
vrsi(k) = 100 - (100 ./ (1 + rsiup(k) ./ rsidown(k)));
rsiA = vrsi;
rsiWeight = (rsiA+Xemarsi.rsiAP)/2 .* RSIEffect .* (src / 100);
emaRsi = src + rsiWeight - Xemarsi.rsiWeightP;
out_emaRsi = (1-aema)*Xemarsi.emarsip + aema*emaRsi;
out_ema = (1-aema)*Xemarsi.emap + aema*src;
Xemarsi.rsiupP = rsiup;
Xemarsi.rsidownP = rsidown;
Xemarsi.rsiAP = rsiA;
Xemarsi.rsiWeightP = rsiWeight;
Xemarsi.emarsip = out_emaRsi;
Xemarsi.emap = out_ema;
Xemarsi.Cp = src;
out(1,:) = out_ema;
out(2,:) = out_emaRsi;
end
