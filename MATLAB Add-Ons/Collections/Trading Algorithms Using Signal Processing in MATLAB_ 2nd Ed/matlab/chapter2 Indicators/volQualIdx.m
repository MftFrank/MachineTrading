%{
https://www.quantshare.com/item-1033-volatility-quality-index
https://www.tradingview.com/script/MbAO4zo0-Indicator-Volatility-Quality-Index-VQI/
study("Volatility Quality Index [LazyBear]", shorttitle="VQI_LB")
length_slow=input(9, title="Fast EMA Length")
length_fast=input(200, title="Slow EMA Length")
vqi_t=iff((tr != 0) and ((high - low) != 0) ,(((close-close[1])/tr)+((close-open)/(high-low)))*0.5,nz(vqi_t[1]))
vqi = abs(vqi_t) * ((close - close[1] + (close - open)) * 0.5)
vqi_sum=cum(vqi)
plot(vqi_sum, color=red, linewidth=2)
plot(sma(vqi_sum,length_slow), color=green, linewidth=2)
plot(sma(vqi_sum,length_fast),color=orange, linewidth=2)
%}
function out = volQualIdx(O,H,L,C)
length_fast = 9;
length_slow = 200;
af = 2/(length_fast+1);
as = 2/(length_slow+1);
close = C;
high = H;
low = L;
open = O;
Z = zeros(1,length(O));
persistent Xvqi
if isempty(Xvqi)
    Xvqi.Cp = C;
    Xvqi.vqi_tP = Z;
    Xvqi.sumSP = Z;
    Xvqi.sumFP = Z;
    Xvqi.vqisum = Z;
end
tr = max(H-L,max(H-Xvqi.Cp,abs(L-Xvqi.Cp)));
vqi_t = Xvqi.vqi_tP;
k = find((tr ~= 0) & ((high - low) ~= 0));
vqi_t(k) = (((close(k)-Xvqi.Cp(k))./tr(k))+...
    ((close(k)-open(k))./(high(k)-low(k))))*0.5;
vqi = abs(vqi_t) .* ((close - Xvqi.Cp + (close - open)) * 0.5);
vqi_sum = Xvqi.vqisum + vqi;
vqi_sumS = (1-as)*Xvqi.sumSP + as*vqi_sum;
vqi_sumF = (1-af)*Xvqi.sumFP + af*vqi_sum;
Xvqi.Cp = C;
Xvqi.vqi_tP = vqi_t;
Xvqi.vqisum = vqi_sum;
Xvqi.sumSP = vqi_sumS;
Xvqi.sumFP = vqi_sumF;
out(1,:) = vqi_t;
out(2,:) = vqi_sum;
out(3,:) = vqi_sumF;
out(4,:) = vqi_sumS;
end
