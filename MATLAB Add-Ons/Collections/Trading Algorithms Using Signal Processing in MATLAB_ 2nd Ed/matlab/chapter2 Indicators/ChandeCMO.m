%{
https://www.tradingview.com/script/ogmWth5h-Chande-Momentum-Oscillator/
https://www.tradingview.com/scripts/chandemo/
study("Chande Momentum Oscillator", shorttitle="CMO")
This indicator was developed and described by Tushar S. Chande and Stanley Kroll in their book "The New Technical Trader" (1994, Chapter 5: New Momentum Oscillators).length = input(title="Length", type=integer, defval=9)
obLevel = input(title="Overbought Level", type=integer, defval=50)
osLevel = input(title="Oversold Level", type=integer, defval=-50)
highlightBreakouts = input(title="Highlight Overbought/Oversold Breakouts ?", type=bool, defval=true)
src = input(title="Source", type=source, defval=close)

mom = change(src)

upSum = sum(max(mom, 0), length)
downSum = sum(-min(mom, 0), length)

cmo = 100 * (upSum - downSum) / (upSum + downSum)
%}
function out = ChandeCMO(C)
Length = 9;
src = C;
Z = zeros(1,length(src));
persistent Xcmo
if isempty(Xcmo)
    Xcmo.momwin = repmat(Z,Length,1);
    Xcmo.srcP = src;
end
Xcmo.momwin = [src-Xcmo.srcP;Xcmo.momwin(1:end-1,:)];
mom = Xcmo.momwin;
upSum = sum(max(mom, 0));
downSum = sum(-min(mom, 0));
den = upSum + downSum;
den(den==0) = 1;
cmo = 100 * (upSum - downSum) ./ den;
Xcmo.srcP = src;
out(1,:) = cmo;
end
