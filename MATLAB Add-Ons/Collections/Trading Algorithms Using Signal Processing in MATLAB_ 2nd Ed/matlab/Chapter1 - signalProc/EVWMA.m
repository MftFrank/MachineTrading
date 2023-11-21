%{
study("Elastic Volume Weighted Moving Average", 
shorttitle="EVWMA", overlay=true)

length = input(title="Length", type=integer, defval=14)
highlightMovements = input(title="Highlight Movements ?", 
type=bool, defval=true)
src = input(title="Source", type=source, defval=close)

volumeSum = sum(volume, length)

evwma = 0.0
evwma := ((volumeSum - volume) * nz(evwma[1]) + volume * src) / volumeSum
%}
function out = EVWMA(C,V)
Length = 14;
src = C;
persistent Xevwma
if isempty(Xevwma)
    Xevwma.volwin = repmat(V,Length,1);
    Xevwma.evwmap = C;
end
Xevwma.volwin = [V;Xevwma.volwin(1:end-1,:)];
volumeSum = sum(Xevwma.volwin);
evwma = ((volumeSum - V) .* Xevwma.evwmap + V .* src) ./ volumeSum;
Xevwma.evwmap = evwma;
out(1,:) = evwma;
end
