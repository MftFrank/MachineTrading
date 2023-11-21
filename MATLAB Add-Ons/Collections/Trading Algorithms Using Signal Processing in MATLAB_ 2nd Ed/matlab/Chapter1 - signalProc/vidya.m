%{
The Variable Moving Average (VMA) aka Volatility Index 
Dynamic Average (VIDYA) was developed by Tushar S. Chande 
and first presented in the March 1992 edition of 
Technical Analysis of Stocks & Commodities – Adapting Moving 
Averages To Market Volatility

Chande’s theory was that the performance of an 
exponential moving average could be improved by using a 
Volatility Index (VI) to adjust the smoothing period as
market conditions change.  The idea being that when 
prices are congested an average should slow down to avoid 
whipsaws but when prices are trending strongly an average 
should speed up to capture the major price moves.
study(title="Variable Index Dynamic Average", shorttitle="VIDYA", overlay=true)

length = input(title="Length", type=integer, defval=14)
highlightMovements = input(title="Highlight Movements ?", type=bool, defval=true)
src = input(title="Source", type=source, defval=close)

// Chande Momentum Oscillator
getCMO(src, length) =>
    mom = change(src)
    upSum = sum(max(mom, 0), length)
    downSum = sum(-min(mom, 0), length)
    out = (upSum - downSum) / (upSum + downSum)
    out

cmo = abs(getCMO(src, length))

alpha = 2 / (length + 1)

vidya = 0.0
vidya := src * alpha * cmo + nz(vidya[1]) * (1 - alpha * cmo)study(title="Variable Index Dynamic Average", shorttitle="VIDYA", overlay=true)

length = input(title="Length", type=integer, defval=14)
highlightMovements = input(title="Highlight Movements ?", type=bool, defval=true)
src = input(title="Source", type=source, defval=close)
%}
function out = vidya(C)
src = C;
Length = 14;
persistent Xvid
if isempty(Xvid)
    Xvid.srcp = src;
    Xvid.cmowin = zeros(Length,length(src));
    Xvid.vidyap = src;
end
Xvid.cmowin = [src-Xvid.srcp;Xvid.cmowin(1:end-1,:)];
upSum = sum(max(Xvid.cmowin, zeros(Length,length(src))));
downSum = sum(-min(Xvid.cmowin, zeros(Length,length(src))));
upSum(upSum==0) = 1;
downSum(downSum==0) = 1;
tmp = (upSum - downSum) ./ (upSum + downSum);
cmo = abs(tmp);
alpha = 2 / (Length + 1);
vidya = src * alpha .* cmo + Xvid.vidyap .* (1 - alpha * cmo);
Xvid.srcp = src;
Xvid.vidyap = vidya;
out(1,:) = vidya;
end
