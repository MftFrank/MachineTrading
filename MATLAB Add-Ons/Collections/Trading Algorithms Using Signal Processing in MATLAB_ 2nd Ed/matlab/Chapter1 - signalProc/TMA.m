%{
https://www.thebalance.com/triangular-moving-average-tma-description-and-uses-1031203
The triangular moving average (TMA) is an average of an average, of the last N prices (P).
First, calculate the simple moving average (SMA):
    SMA = (P1 + P2 + P3 + P4 + ... + PN) / N
Then, take the average of all the SMA values to get TMA values.
    TMA = (SMA1 + SMA2 + SMA3 + SMA4 + ... SMAN) / N
The TMA can also be expressed as: TMA = SUM (SMA values) /
%}
function out = TMA(C)
P = C;
N = 10;
persistent Xtma
if isempty(Xtma)
    Xtma.Pwin = repmat(P,N,1);
    Xtma.tmawin = repmat(P,N,1);
end
Xtma.Pwin = [P;Xtma.Pwin(1:end-1,:)];
sma = sum(Xtma.Pwin)/N;
Xtma.tmawin = [sma;Xtma.tmawin(1:end-1,:)];
tma = sum(Xtma.tmawin)/N;
out(1,:) = sma;
out(2,:) = tma;
end
