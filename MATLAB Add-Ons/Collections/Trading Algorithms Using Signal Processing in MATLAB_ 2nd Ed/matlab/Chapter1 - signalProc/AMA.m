%{
https://www.tradingview.com/script/RsdQHpdq-Kaufman-Moving-Average-Adaptive-KAMA/
https://www.tradingview.com/script/OexuoYG3-MAMA-by-EHLERS/
Adaptive Momentum Smoothing Filters
Adaptive RSI: Adaptive Relative Strength Indicator
Smoothing function based on RSI
input: period(20);
    
if currentbar <= period then ARSI = close
else begin
    sc = (absvalue(RSI(close, period)/100);
    ARSI = ARSI[1] + sc*(close - ARSI[1]);
    end;
This indicator, an adaptive moving
average (AMA), moves very slowly when markets are 
moving sideways but moves swiftly when the markets also 
move swiftly, change directions or break out of
a trading range.

study(title="Kaufman Moving Average Adaptive (KAMA)", shorttitle="Kaufman Moving Average Adaptive (KAMA)", overlay = true)
Length = input(21, minval=1)
xPrice = close
xvnoise = abs(xPrice - xPrice[1])
nfastend = 0.666
nslowend = 0.0645
nsignal = abs(xPrice - xPrice[Length])
nnoise = sum(xvnoise, Length)
nefratio = iff(nnoise != 0, nsignal / nnoise, 0)
nsmooth = pow(nefratio * (nfastend - nslowend) + nslowend, 2) 
nAMA = nz(nAMA[1]) + nsmooth * (xPrice - nz(nAMA[1]))
study("MAMA by EHLERS", shorttitle="MAMA", overlay=true)
Price=input(hl2, title="Source")
fastlimit=input(0.5, title="Fast Limit")
slowlimit=input(0.05, title="Slow Limit")

smooth = (4*Price + 3*Price[1] + 2*Price[2] + Price[3])/10
detrender = (0.0962*smooth + 0.5769*nz(smooth[2]) - 0.5769*nz(smooth[4])- 0.0962*nz(smooth[6]))*(0.075*nz(Period[1]) + 0.54)
q1 = (0.0962*detrender + 0.5769*nz(detrender[2]) - 0.5769*nz(detrender[4])- 0.0962*nz(detrender[6]))*(0.075*nz(Period[1]) + 0.54)
i1 = nz(detrender[3])
jI = (0.0962*i1 + 0.5769*nz(i1[2]) - 0.5769*nz(i1[4])- 0.0962*nz(i1[6]))*(0.075*nz(Period[1]) + 0.54)
jq = (0.0962*q1 + 0.5769*nz(q1[2]) - 0.5769*nz(q1[4])- 0.0962*nz(q1[6]))*(0.075*nz(Period[1]) + 0.54)
i21 = i1 - jq
q21 = q1 + jI
i2 = 0.2*i21 + 0.8*nz(i2[1])
q2 = 0.2*q21 + 0.8*nz(q2[1])
re1 = i2*nz(i2[1]) + q2*nz(q2[1])
im1 = i2*nz(q2[1]) - q2*nz(i2[1])
re = 0.2*re1 + 0.8*nz(re[1])
im = 0.2*im1 + 0.8*nz(im[1])
p1 = iff(im!=0 and re!=0, 2* 4 * atan(1)/atan(im/re), nz(Period[1]))
p2 = iff(p1 > 1.5*nz(p1[1]), 1.5*nz(p1[1]), iff(p1 < 0.67*nz(p1[1]), 0.67*nz(p1[1]), p1))
p3 = iff(p2<6, 6, iff (p2 > 50, 50, p2))
Period = 0.2*p3 + 0.8*nz(p3[1])
SmoothPeriod = 0.33*Period + 0.67*nz(SmoothPeriod[1])
Phase = 180/(4 * atan(1))*atan(q1 / i1)
DeltaPhase1 = nz(Phase[1]) - Phase
DeltaPhase = iff(DeltaPhase1< 1, 1, DeltaPhase1)
alpha1 = fastlimit / DeltaPhase
alpha = iff(alpha1 < slowlimit, slowlimit, iff(alpha1 > fastlimit, fastlimit, alpha1))
MAMA = alpha*Price + (1 - alpha)*nz(MAMA[1])
FAMA = 0.5*alpha*MAMA + (1 - 0.5*alpha)*nz(FAMA[1])
%}
function out = AMA(H,L,C)
Len = 21;
xPrice = C;
nfastend = 0.666;
nslowend = 0.0645;
Period = 20;
rsilen = 14;
alph = 1/rsilen;
Z = zeros(1,length(C));
Price = (H+L)/2;
fastlimit = 0.5;
slowlimit = 0.05;
bsm = [4 3 2 1]/10;
bdet = [0.0962 0 0.5769 0 -0.5769 0 -0.0962];
persistent Xama
if isempty(Xama)
    Xama.rsiwin = repmat(Z,rsilen,1);
    Xama.xvnoisewin = repmat(Z,Len,1);
    Xama.xPwin = repmat(xPrice,Len,1);
    Xama.Pwin = repmat(Price,length(bsm),1);
    Xama.smwin = repmat(Price,length(bdet),1);
    Xama.detwin = repmat(Z,length(bdet),1);
    Xama.i1win = repmat(Z,length(bdet),1);
    Xama.q1win = repmat(Z,length(bdet),1);
    Xama.Cp = C;
    Xama.arsip = C;
    Xama.KAMAp = C;
    Xama.MAMAp = Price;
    Xama.FAMAp = Price;
    Xama.avgUp = Z;
    Xama.avgDp = Z;
    Xama.Periodp = Z;
    Xama.i2p = Z;
    Xama.q2p = Z;
    Xama.rep = Z;
    Xama.imp = Z;
    Xama.p1p = Z;
    Xama.p2p = Z; 
    Xama.p3p = Z;
    Xama.Phasep = Z;
    Xama.SmoothPeriodp = Z; 
end
Xama.rsiwin = [C-Xama.Cp;Xama.rsiwin(1:end-1,:)];
Xama.xPwin = [xPrice;Xama.xPwin(1:end-1,:)];
Xama.Pwin = [Price;Xama.Pwin(1:end-1,:)];
tmpU = Xama.rsiwin;
tmpU(tmpU<0)=0;
tmpD = Xama.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*Xama.avgUp + alph*avgU;
emaavgD = (1-alph)*Xama.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
rsi = 100*(1 - 1./(1+RS));
sc = abs(rsi)/100;
arsi = Xama.arsip + sc.*(xPrice - Xama.arsip);
xvnoise = abs(xPrice - Xama.Cp);
Xama.xvnoisewin = [xvnoise;Xama.xvnoisewin(1:end-1,:)];
nsignal = abs(xPrice - Xama.xPwin(end,:));
nnoise = sum(Xama.xvnoisewin);
nefratio = Z;
k = find(nnoise ~= 0);
nefratio(k) = nsignal(k) ./ nnoise(k);
nsmooth = power(nefratio .* (nfastend - nslowend) + nslowend, 2);
KAMA = Xama.KAMAp + nsmooth .* (xPrice - Xama.KAMAp);
smooth = sum(bsm'.*Xama.Pwin);
Xama.smwin = [smooth;Xama.smwin(1:end-1,:)];
tmpD = 0.075*Xama.Periodp + 0.54;
detrender = sum(bdet'.*Xama.smwin).*tmpD;
Xama.detwin = [detrender;Xama.detwin(1:end-1,:)];
q1 = sum(bdet'.*Xama.detwin).*tmpD;
i1 = Xama.detwin(4,:);
Xama.q1win = [q1;Xama.q1win(1:end-1,:)];
Xama.i1win = [i1;Xama.i1win(1:end-1,:)];
jI = sum(bdet'.*Xama.i1win).*tmpD;
jq = sum(bdet'.*Xama.q1win).*tmpD;
i21 = i1 - jq;
q21 = q1 + jI;
i2 = 0.2*i21 + 0.8*Xama.i2p;
q2 = 0.2*q21 + 0.8*Xama.q2p;
re1 = i2.*Xama.i2p + q2.*Xama.q2p;
im1 = i2.*Xama.q2p - q2.*Xama.i2p;
re = 0.2*re1 + 0.8*Xama.rep;
im = 0.2*im1 + 0.8*Xama.imp;
p1 = Xama.Periodp;
k = find(im~=0 & re~=0);
p1(k) = 2 * 4 * atan(1)./atan(im(k)./re(k));
p1tmp = max(0.67*Xama.p1p, p1);
p2 = min(1.5*Xama.p1p,p1tmp);
p3 = min(50,p2);
p3 = max(6,p3);
Period = 0.2*p3 + 0.8*Xama.p3p;
SmoothPeriod = 0.33*Period + 0.67*Xama.SmoothPeriodp;
Phase = 180/(4 * atan(1))*atan(q1 ./ i1);
DeltaPhase1 = Xama.Phasep - Phase;
DeltaPhase = max(1, DeltaPhase1);
alpha1 = fastlimit ./ DeltaPhase;
tmpA = min(fastlimit, alpha1);
alpha = max(alpha1 , slowlimit);
MAMA = alpha.*Price + (1 - alpha).*Xama.MAMAp;
FAMA = 0.5*alpha.*MAMA + (1 - 0.5*alpha).*Xama.FAMAp;

% updates
Xama.Cp = C;
Xama.avgUp = avgU;
Xama.avgDp = avgD;
Xama.arsip = arsi;
Xama.KAMAp = KAMA;
Xama.MAMAp = MAMA;
Xama.FAMAp = FAMA;
Xama.Periodp = Period;
Xama.i2p = i2;
Xama.q2p = q2;
Xama.rep = re;
Xama.imp = im;
Xama.p1p = p1;
Xama.p2p = p2;
Xama.p3p = p3;
Xama.SmoothPeriodp = SmoothPeriod;
Xama.Phasep = Phase;
out(1,:) = arsi;
out(2,:) = KAMA;
out(3,:) = MAMA;
out(4,:) = FAMA;
end
