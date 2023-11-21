%{
https://www.youtube.com/watch?v=7vhIsk51_Ro
https://www.tradingview.com/script/2KE8wTuF-Indicator-WaveTrend-Oscillator-WT/
study(title="WaveTrend [LazyBear]", shorttitle="WT_LB")
n1 = input(10, "Channel Length")
n2 = input(21, "Average Length")
obLevel1 = input(60, "Over Bought Level 1")
obLevel2 = input(53, "Over Bought Level 2")
osLevel1 = input(-60, "Over Sold Level 1")
osLevel2 = input(-53, "Over Sold Level 2")
 
ap = hlc3 
esa = ema(ap, n1)
d = ema(abs(ap - esa), n1)
ci = (ap - esa) / (0.015 * d)
tci = ema(ci, n2)
 
wt1 = tci
wt2 = sma(wt1,4)
%}
function out = waveTrend(H,L,C)
n1 = 10;
n2  = 21;
a1 = 2/(n1+1);
a2 = 2/(n2+1);
ap = (H+L+C)/3;
Z = zeros(1,length(ap));
persistent Xwtr
if isempty(Xwtr)
    Xwtr.esap = ap;
    Xwtr.dp = Z;
    Xwtr.tcip = Z;
    Xwtr.wt2win = repmat(Z,4,1);
end
esa = (1-a1)*Xwtr.esap + a1*ap;
d = (1-a1)*Xwtr.dp + a1*abs(ap-esa);
ci = (ap - esa) ./ (0.015 * d);
Xwtr.tcip(isnan(Xwtr.tcip)) = 0;
tci = (1-a2)*Xwtr.tcip + a2*ci;
wt1 = tci;
Xwtr.wt2win = [wt1;Xwtr.wt2win(1:end-1,:)];
wt2 = sum(Xwtr.wt2win)/4;
Xwtr.esap = esa;
Xwtr.dp = d;
Xwtr.tcip = tci;
out(1,:) = wt1;
out(2,:) = wt2;
out(3,:) = wt1-wt2;
end
