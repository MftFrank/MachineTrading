%{
https://www.tradingview.com/chart/BTCUSD/UFv7wX1B-Indicator-Kaufman-AMA-Binary-Wave/
https://pastebin.com/aUkLWDaw
study(title = "Kaufman Binary Wave [LazyBear]", shorttitle="AMAWave_LB", overlay=true)
src=close
length=input(20)
filterp = input(10, title="Filter %", type=integer)
cf=input(true, "Color Buy/Sell safe areas?", type=bool)
dw=input(true, "Draw Wave?", type=bool)
 
d=abs(src-src[1])
s=abs(src-src[length])
noise=sum(d, length)
efratio=s/noise
fastsc=0.6022
slowsc=0.0645 
 
smooth=pow(efratio*fastsc+slowsc, 2)
ama=nz(ama[1], close)+smooth*(src-nz(ama[1], close))
filter=filterp/100 * stdev(ama-nz(ama), length)
amalow=ama < nz(ama[1]) ? ama : nz(amalow[1])
amahigh=ama > nz(ama[1]) ? ama : nz(amahigh[1])
bw=(ama-amalow) > filter ? 1 : (amahigh-ama > filter ? -1 : 0)
%}
function out = kamabinwav(C)
src = C;
Length = 20;
filterp = 10;
fastsc = 0.6022;
slowsc = 0.0645;
Z = zeros(1,length(C));
persistent Xkbw
if isempty(Xkbw)
    Xkbw.srcp = src;
    Xkbw.amap = src;
    Xkbw.amalowp = src;
    Xkbw.amahighp = src;
    Xkbw.srcwin = repmat(src,Length,1);
    Xkbw.noisewin = repmat(Z,Length,1);
end
Xkbw.srcwin = [src;Xkbw.srcwin(1:end-1,:)];
d=abs(src-Xkbw.srcp);
Xkbw.noisewin = [d;Xkbw.noisewin(1:end-1,:)];
s = abs(src-Xkbw.srcwin(end,:));
noise = sum(Xkbw.noisewin);
efratio = s/noise;
smooth = power(efratio*fastsc+slowsc, 2);
ama = Xkbw.amap+smooth.*(src-Xkbw.amap);
filter = filterp/100 * std(ama-Xkbw.amap);
amalow = ama;
k = find(ama > Xkbw.amap);
amalow(k) = Xkbw.amalowp(k);
amahigh = ama;
k = find(ama < Xkbw.amap);
amahigh(k) = Xkbw.amahighp(k);
tmp = Z;
tmp(amahigh-ama > filter) = -1;
bw = tmp;
bw((ama-amalow) > filter) = 1;
Xkbw.srcp = src;
Xkbw.amap = ama;
Xkbw.amalowp = amalow;
Xkbw.amahighp = amahigh;
out(1,:) = ama;
out(2,:) = amalow;
out(3,:) = amahigh;
out(4,:) = bw;
end
