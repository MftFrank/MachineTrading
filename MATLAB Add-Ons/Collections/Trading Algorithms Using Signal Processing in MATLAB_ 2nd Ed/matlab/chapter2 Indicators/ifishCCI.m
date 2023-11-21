%{
https://www.tradingview.com/scripts/commoditychannelindex/
https://www.tradingview.com/script/oyfd86j2-Indicators-Three-included-IFT-on-CCI-Z-Score-and-R-Squared/
study("Inverse Fisher Transform CCI [LazyBear]", shorttitle="IFTCCI_LB")
length = input(title="CCI Length", type=integer, defval=20)
src = close
cc=cci(src, length)

// Calculate IFT on CCI
lengthwma=input(9, title="Smoothing length")
calc_ifish(series, lengthwma) =>
    v1=0.1*(series-50)
    v2=wma(v1,lengthwma)
    ifish=(exp(2*v2)-1)/(exp(2*v2)+1)
    ifish

plot(calc_ifish(cc, lengthwma), color=teal, linewidth=1)
CCI Calculation
There are several steps involved in calculating the Commodity Channel Index. The following example is for a typical 20 Period CCI:

CCI = (Typical Price  -  20 Period SMA of TP) / (.015 x Mean Deviation)
Typical Price (TP) = (High + Low + Close)/3
Constant = .015
The Constant is set at .015 for scaling purposes. By including the constant, the majority of CCI values will fall within the 100 to -100 range. There are three steps to calculating the Mean Deviation.

Subtract the most recent 20 Period Simple Moving from each typical price (TP) for the Period.
Sum these numbers strictly using absolute values.
Divide the value generated in step 3 by the total number of Periods (20 in this case).
%}
function out = ifishCCI(H,L,C)
tp = (H+L+C)/3;
Period = 20;
constant = 0.015;
Z = zeros(1,length(H));
lengthwma = 9;
bwma = lengthwma:-1:1;
bwma = bwma/sum(bwma);
persistent Xifcci
if isempty(Xifcci)
    Xifcci.devwin = repmat(Z,Period,1);
    Xifcci.tpwin = repmat(tp,Period,1);
    Xifcci.v1win = repmat(Z,lengthwma,1);
end
Xifcci.tpwin = [tp;Xifcci.tpwin(1:end-1,:)];
sma = sum(Xifcci.tpwin)/Period;
% compute deviation
Xifcci.devwin = [tp-sma;Xifcci.devwin(1:end-1,:)];
dev = sum(Xifcci.devwin)/Period;
cci = (tp - sma)./(constant*dev);
% Calculate IFT on CCI
v1=0.1*(cci-50);
Xifcci.v1win = [v1;Xifcci.v1win(1:end-1,:)];
v2 = sum(bwma'.*Xifcci.v1win);
ifish = (exp(2*v2)-1)./(exp(2*v2)+1);
out(1,:) = cci;
out(2,:) = ifish;
end
