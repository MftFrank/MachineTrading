%{
study("Inverse Fisher Transform RSI [LazyBear]", shorttitle="IFTRSI_LB")
s=close
length=input(14, "RSI length")
lengthwma=input(9, title="Smoothing length")
RSI Calculation
RSI = 100 – 100/ (1 + RS)
RS = Average Gain of n days UP  / Average Loss of n days DOWN

change = change(close)
gain = change >= 0 ? change : 0.0
loss = change < 0 ? (-1) * change : 0.0
avgGain = rma(gain, 14)
avgLoss = rma(loss, 14)
rs = avgGain / avgLoss
rsi = 100 - (100 / (1 + rs))

MFI Calculation
There are four separate steps to calculate the Money Flow Index. The following example is for a 14 Period MFI:

1. Calculate the Typical Price

(High + Low + Close) / 3 = Typical Price
2. Calculate the Raw Money Flow

Typical Price x Volume = Raw Money Flow
3. Calculate the Money Flow Ratio

(14 Period Positive Money Flow) / (14 Period Negative Money Flow)
Positive Money Flow is calculated by summing the Money Flow of all of the days in the period where Typical Price is higher than the previous period Typical Price.

Negative Money Flow is calculated by summing the Money Flow of all of the days in the period where Typical Price is lower than the previous period Typical Price.
4. Calculate the Money Flow Index.

100 - 100/(1 + Money Flow Ratio) = Money Flow Index)

The following inverse Fisher (calc_ifish) is applied to the input.
calc_ifish(series, lengthwma) =>
    v1=0.1*(series-50)
    v2=wma(v1,lengthwma)
    ifish=(exp(2*v2)-1)/(exp(2*v2)+1)
    ifish

plot(calc_ifish(rsi(s, length), lengthwma), color=orange, linewidth=2)
%}
function out = ifishrsimfi(C,V)
s = C;
Length = 14;
alph = 1/Length;
lengthwma = 9;
Z = zeros(1,length(s));
bwma = lengthwma:-1:1;
bwma = bwma/sum(bwma);
persistent Xifish
if isempty(Xifish)
    Xifish.rsiwin = repmat(Z,Length,1);
    Xifish.rsiv1win = repmat(Z,Length,1);
    Xifish.mfiwin = repmat(Z,Length,1);
    Xifish.mfiv1win = repmat(Z,Length,1);
    Xifish.volwin = repmat(V,Length,1);
    Xifish.sP = s;
    Xifish.gainP = s;
    Xifish.lossP = s;
    Xifish.avgUp = Z;
    Xifish.avgDp = Z;
    Xifish.avgmfiUp = Z;
    Xifish.avgmfiDp = Z;
end
change = s - Xifish.sP;
Xifish.rsiwin = [change;Xifish.rsiwin(1:end-1,:)];
Xifish.volwin = [V;Xifish.volwin(1:end-1,:)];
Xifish.mfiwin = [V.*change;Xifish.mfiwin(1:end-1,:)];
% rsi calcs
tmpU = Xifish.rsiwin;
tmpU(tmpU<0)=0;
tmpD = Xifish.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*Xifish.avgUp + alph*avgU;
emaavgD = (1-alph)*Xifish.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
rs = emaavgU./tmp;
rsi = 100 - (100 ./ (1 + rs));
v1 = 0.1*(rsi - 50);
Xifish.rsiv1win = [v1;Xifish.rsiv1win(1:end-1,:)];
v2 = sum(bwma'.*Xifish.rsiv1win(1:lengthwma,:));
ifishrsi = (exp(2*v2)-1)./(exp(2*v2)+1);
% mfi calcs
tmp = Xifish.mfiwin./sum(Xifish.volwin);
tmpU = tmp;
tmpU(tmpU<0)=0;
tmpD = tmp;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgmfU = (1-alph)*Xifish.avgmfiUp + alph*avgU;
emaavgmfD = (1-alph)*Xifish.avgmfiDp + alph*avgD;
tmp = emaavgmfD;
tmp(tmp==0) = 1;
mf = emaavgmfU./tmp;
mfi = 100 - (100 ./ (1 + mf));
v1 = 0.1*(mfi - 50);
Xifish.mfiv1win = [v1;Xifish.mfiv1win(1:end-1,:)];
v2 = sum(bwma'.*Xifish.mfiv1win(1:lengthwma,:));
ifishmfi = (exp(2*v2)-1)./(exp(2*v2)+1);
Xifish.sP = s;
Xifish.avgUp = emaavgU;
Xifish.avgDp = emaavgD;
Xifish.avgmfiUp = emaavgmfU;
Xifish.avgmfiDp = emaavgmfD;
out(1,:) = rsi;
out(2,:) = mfi;
out(3,:) = ifishrsi;
out(4,:) = ifishmfi;
end
