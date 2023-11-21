%{
study("ADX Adaptive Stochastic", shorttitle="AADX SO")

len = input(19, title="DI Length")
min_len=input(19, title="Min stoch length")
max_len=input(100, title="Max stoch length Smoothing")
sm = input(2, title="Stoch Smoothing")
inv = input(false, title="Inverse adaptive")

up = change(high)
down = -change(low)
plusDM = na(up) ? na : (up > down and up > 0 ? up : 0)
minusDM = na(down) ? na : (down > up and down > 0 ? down : 0)
truerange = rma(tr, len)
plus = fixnan(100 * rma(plusDM, len) / truerange)
minus = fixnan(100 * rma(minusDM, len) / truerange)
sum = plus + minus
adx = 100 * abs(plus - minus) / (sum == 0 ? 1 : sum)
rsi_adx = rsi(adx,len)

st_min = stoch(close,high,low,min_len)
st_max = stoch(close,high,low,max_len)
st = inv ? sma((1-rsi_adx/100) * st_max + rsi_adx/100 * st_min, sm) : sma(rsi_adx/100 * st_max + (1-rsi_adx/100) * st_min, sm)
%}
function out = adxAdapSt(H,L,C)
high = H;
low = L;
close = C;
len = 19;
min_len = 19;
max_len = 100;
sm = 2;
Z = zeros(1,length(H));
persistent Xadas
if isempty(Xadas)
    Xadas.Hp = H;
    Xadas.Lp = L;
    Xadas.Cp = close;
    Xadas.trp = high - low;
    Xadas.plusp = Z;
    Xadas.minusp = Z;
    Xadas.rsiwin = repmat(Z,len,1);
    Xadas.Hwin = repmat(high,max_len,1);
    Xadas.Lwin = repmat(low,max_len,1);
    Xadas.stinvwin = repmat(Z,sm,1);
    Xadas.stnotinvwin = repmat(Z,sm,1);
    Xadas.adxp = Z;
    Xadas.avgUp = Z;
    Xadas.avgDp = Z;
end
Xadas.Hwin = [high;Xadas.Hwin(1:end-1,:)];
Xadas.Lwin = [low;Xadas.Lwin(1:end-1,:)];
up1 = high - Xadas.Hp;
down1 = -(low - Xadas.Lp);
plusDM = Z;
k = find(up1 > down1 & up1 > 0);
plusDM(k) = up1(k);
minusDM = Z;
k = find(down1 > up1 & down1 > 0);
minusDM(k) = down1(k);
tr = max(high-low,max(abs(high-Xadas.Cp),abs(low-Xadas.Cp)));
truerange = Xadas.trp + 1/len*(tr-Xadas.trp);
truerange(truerange==0) = 1;
plus1 = (Xadas.plusp + 1/len*(100*plusDM./truerange-Xadas.plusp));
minus1 = (Xadas.minusp + 1/len*(100*minusDM./truerange-Xadas.minusp));
plus1(isnan(plus1)) = 0;
minus1(isnan(minus1)) = 0;
plus1 = max(-1e5,plus1);plus1 = min(1e5,plus1);
minus1 = max(-1e5,minus1);minus1 = min(1e5,minus1);
sum1 = plus1 + minus1;
sum1(sum1==0) = 1;
tmp = plus1 - minus1;
% tmp(tmp==0) = 0.1;
adx = 100 * abs(tmp) ./ sum1;
Xadas.rsiwin = [adx-Xadas.adxp;Xadas.rsiwin(1:end-1,:)];
% rsi calcs
tmpU = Xadas.rsiwin;
tmpU(tmpU<0)=0;
tmpD = Xadas.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (avgU-Xadas.avgUp)/len + Xadas.avgUp;
emaavgD = (avgD-Xadas.avgDp)/len + Xadas.avgDp;
tmp = emaavgD;
tmp(tmp==0) = 1;
rs = emaavgU./tmp;
rsi_adx = 100 - (100 ./ (1 + rs));
highestminlen = max(Xadas.Hwin(1:min_len,:));
lowestminlen = min(Xadas.Lwin(1:min_len,:));
highestmaxlen = max(Xadas.Hwin);
lowestmaxlen = min(Xadas.Lwin);
st_min = 100*(close-lowestminlen)./(highestminlen-lowestminlen);
st_max = 100*(close-lowestmaxlen)./(highestmaxlen-lowestmaxlen);
tmp = (1-rsi_adx/100) .* st_max + rsi_adx/100 .* st_min;
tmp1 = rsi_adx/100 .* st_max + (1-rsi_adx/100) .* st_min;
Xadas.stinvwin = [tmp;Xadas.stinvwin(1:end-1,:)];
Xadas.stnotinvwin = [tmp1;Xadas.stnotinvwin(1:end-1,:)];
stinv = sum(Xadas.stinvwin)/sm;
stnotinv = sum(Xadas.stnotinvwin)/sm;
Xadas.Hp = H;
Xadas.Lp = L;
Xadas.Cp = close;
Xadas.trp = truerange;
Xadas.adxp = adx;
Xadas.plusp = plus1;
Xadas.minusp = minus1;
Xadas.avgUp = emaavgU;
Xadas.avgDp = emaavgD;
out(1,:) = adx;
out(2,:) = rsi_adx;
out(3,:) = st_min;
out(4,:) = st_max;
out(5,:) = stinv;
out(6,:) = stnotinv;
end
