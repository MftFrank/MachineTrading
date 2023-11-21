%{
https://www.tradingview.com/script/XZyG5SOx-CCI-Stochastic-and-a-quick-lesson-on-Scalping-Trading-Systems/
study("CCI Stochastic", shorttitle="CCI_S", overlay=false)

source = input(close)
cci_period = input(28, "CCI Period")
stoch_period = input(28, "Stoch Period")
stoch_smooth_k = input(3, "Stoch Smooth K")
stoch_smooth_d = input(3, "Stoch Smooth D")
OB = input(80, "Overbought", type=input.integer)
OS = input(20, "Oversold", type=input.integer)

cci = cci(source, cci_period)
stoch_cci_k = sma(stoch(cci, cci, cci, stoch_period), stoch_smooth_k)
stoch_cci_d = sma(stoch_cci_k, stoch_smooth_d)
%}
function out = ScalpcciStoch(C)
source = C;
cci_period = 28;
stoch_period = 28;
stoch_smooth_k = 3;
stoch_smooth_d = 3;
Z = zeros(1,length(source));
persistent Xscci
if isempty(Xscci)
    Xscci.srcwin = repmat(source,cci_period,1);
    Xscci.stochsrcwin = repmat(source,stoch_period,1);
    Xscci.cciwin = repmat(Z,stoch_period,1);
    Xscci.ccikwin = repmat(Z,stoch_smooth_k,1);
    Xscci.ccidwin = repmat(Z,stoch_smooth_d,1);
end
Xscci.srcwin = [source;Xscci.srcwin(1:end-1,:)];
Xscci.stochsrcwin = [source;Xscci.stochsrcwin(1:end-1,:)];
tpsma = sum(Xscci.srcwin)/cci_period;
dev = sum(abs(Xscci.srcwin-tpsma))/cci_period;
cci = (source - tpsma)./(0.015*dev);
maxhigh = max(Xscci.stochsrcwin);
minlow = min(Xscci.stochsrcwin);
den = maxhigh - minlow;
den(den==0) = 1;
stoch = 100*(source-minlow)./den;
Xscci.ccikwin = [stoch;Xscci.ccikwin(1:end-1,:)];
stoch_cci_k = sum(abs(Xscci.ccikwin))/stoch_smooth_k;
Xscci.ccidwin = [stoch_cci_k;Xscci.ccidwin(1:end-1,:)];
stoch_cci_d = sum(abs(Xscci.ccidwin))/stoch_smooth_d;
out(1,:) = cci;
out(2,:) = stoch;
out(3,:) = stoch_cci_k;
out(4,:) = stoch_cci_d;
end
