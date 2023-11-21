%{
https://www.tradingview.com/script/b2aAujaw-INDYAN-RSI-MACD/
study(title="{INDYAN} RSI + MACD", shorttitle="{INDYAN} RSI+MACD Divergence")
len = input(title="RSI Period", minval=1, defval=7)
src = input(title="RSI Source", defval=close)
osc = rsi(src, len)
fast_length = input(title="Fast Length", type=input.integer, defval=5)
slow_length = input(title="Slow Length", type=input.integer, defval=8)
srcd = input(title="Source", type=input.source, defval=close)
signal_length = input(title="Signal Smoothing", type=input.integer, minval = 1, maxval = 50, defval = 3)
sma_source = input(title="Simple MA(Oscillator)", type=input.bool, defval=false)
sma_signal = input(title="Simple MA(Signal Line)", type=input.bool, defval=false)

// Plot colors
col_grow_above = #26A69A
col_grow_below = #FFC1D5
col_fall_above = #B2DFDB
col_fall_below = #EF5550
col_macd = #0094ff
col_signal = #ff6a00

// Calculating
fast_ma = sma_source ? sma(src, fast_length) : ema(src, fast_length)
slow_ma = sma_source ? sma(src, slow_length) : ema(src, slow_length)
macd = fast_ma - slow_ma
signal = sma_signal ? sma(macd, signal_length) : ema(macd, signal_length)
hist = macd - signal
%}
function out = Scalprsimacd(C)
len = 14;
fast_length = 5;
slow_length = 8;
signal_length = 50;
aF = 2/(fast_length+1);
aS = 2/(slow_length+1);
aSL = 2/(signal_length+1);
Z = zeros(1,length(C));
persistent XSrsimacd
if isempty(XSrsimacd)
    XSrsimacd.rsip = Z;
    XSrsimacd.avgUp = Z;
    XSrsimacd.avgDp = Z;
    XSrsimacd.rsiwin = repmat(50*ones(1,length(C)),len,1);
    XSrsimacd.fast_lengthp = C;
    XSrsimacd.slow_lengthp = C;
    XSrsimacd.signal_lengthp = Z;
    XSrsimacd.Cp = C;
end
XSrsimacd.rsiwin = [C-XSrsimacd.Cp;XSrsimacd.rsiwin(1:end-1,:)];
alph = 1/len;
tmpU = XSrsimacd.rsiwin;
tmpU(tmpU<0)=0;
tmpD = XSrsimacd.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*XSrsimacd.avgUp + alph*avgU;
emaavgD = (1-alph)*XSrsimacd.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
rsi = 100*(1 - 1./(1+RS));
osc = rsi;
fast_ma = (1-aF)*XSrsimacd.fast_lengthp + aF*C;
slow_ma = (1-aS)*XSrsimacd.slow_lengthp + aS*C;
macd = fast_ma - slow_ma;
signal = (1-aSL)*XSrsimacd.signal_lengthp + aSL*macd;
hist = macd - signal;
% updates
XSrsimacd.fast_lengthp = fast_ma;
XSrsimacd.slow_lengthp = slow_ma;
XSrsimacd.signal_lengthp = signal;
XSrsimacd.avgUp = emaavgU;
XSrsimacd.avgDp = emaavgD;
XSrsimacd.Cp = C;
out(1,:) = osc;
out(2,:) = fast_ma;
out(3,:) = slow_ma;
out(4,:) = signal;
out(5,:) = hist;
out(6,:) = macd;
end
