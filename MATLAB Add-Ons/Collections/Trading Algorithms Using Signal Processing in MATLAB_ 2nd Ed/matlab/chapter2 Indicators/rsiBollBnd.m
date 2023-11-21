%{
https://www.tradingview.com/script/4hhFyZwm-Indicator-MFI-or-RSI-enclosed-by-Bollinger-Bands/
study(title = "RSI/MFI with Volatility Bands [LazyBear]", shorttitle="SI+Bands [LB]")
source = hlc3
length = input(14, minval=1), mult = input(2.0, minval=0.001, maxval=50)
DrawRSI_f=input(false, title="Draw RSI?", type=bool)
DrawMFI_f=input(true, title="Draw MFI?", type=bool)
HighlightBreaches=input(true, title="Highlight Oversold/Overbought?", type=bool)

DrawMFI = (not DrawMFI_f) and (not DrawRSI_f) ? true : DrawMFI_f
DrawRSI = (DrawMFI_f and DrawRSI_f) ? false : DrawRSI_f
// RSI
rsi_s = DrawRSI ? rsi(source, length) : na
plot(DrawRSI ? rsi_s : na, color=maroon, linewidth=2)

// MFI
upper_s = DrawMFI ? sum(volume * (change(source) <= 0 ? 0 : source), length) : na
lower_s = DrawMFI ? sum(volume * (change(source) >= 0 ? 0 : source), length) : na
mf = DrawMFI ? rsi(upper_s, lower_s) : na
plot(DrawMFI ? mf : na, color=green, linewidth=2)

// Draw BB on indices
bb_s = DrawRSI ? rsi_s : DrawMFI ? mf : na
basis = sma(bb_s, length)
dev = mult * stdev(bb_s, length)
upper = basis + dev
lower = basis - dev
%}
function out = rsiBollBnd(H,L,C)
source = (H+L+C)/3;
Length = 14;
alph = 1/Length;
mult = 2;
Z = zeros(1,length(C));
persistent Xrbb
if isempty(Xrbb)
    Xrbb.Cp = source;
    Xrbb.rsiwin = repmat(Z,Length,1);
    Xrbb.bbswin = repmat(Z,Length,1);
    Xrbb.avgUp = Z;
    Xrbb.avgDp = Z;
end
Xrbb.rsiwin = [source-Xrbb.Cp;Xrbb.rsiwin(1:end-1,:)];
tmpU = Xrbb.rsiwin;
tmpU(tmpU<0)=0;
tmpD = Xrbb.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*Xrbb.avgUp + alph*avgU;
emaavgD = (1-alph)*Xrbb.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
rsi_s = 100*(1 - 1./(1+RS));
% emaavgU = (1-alph)*Xrbb.avgUp + alph*rsi;
bb_s = rsi_s;
Xrbb.bbswin = [bb_s;Xrbb.bbswin(1:end-1,:)];
basis = sum(Xrbb.bbswin)/Length;
dev = mult * std(Xrbb.bbswin);
upper = basis + dev;
lower = basis - dev;
Xrbb.Cp = source;
Xrbb.avgUp = emaavgU;
Xrbb.avgDp = emaavgD;
out(1,:) = bb_s;
out(2,:) = basis;
out(3,:) = upper;
out(4,:) = lower;
end
