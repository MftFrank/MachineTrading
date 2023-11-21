%{
https://www.tradingview.com/script/5gmbUNQV-Stoch-RSI-With-Color-Combination/
study(title="Stoch+RSI With Color Combination. ", shorttitle="Stoch+RSI By RRanjanFX", format=format.price, precision=2, resolution="")
odk = input(21, title="K", minval=1)
dP = input(7, title="D", minval=1)
sK = input(7, title="Smooth", minval=1)
lK = sma(stoch(close, high, low, odk), sK)
bnd = sma(lK, dP)
plot(bnd, title="%D", color=#FF6A00)
//Stochastic. 
It is calculated by a formula: 
100 * (close - lowest(low, length)) / 
    (highest(high, length) - lowest(low, length)).

//RSI
rrfxlen = input(10, minval=1, title="Length")
rrfxsrc = input(close, "Source", type = input.source)
rrfxup = rma(max(change(rrfxsrc), 0), rrfxlen)
rrfxdown = rma(-min(change(rrfxsrc), 0), rrfxlen)
rrfxrsi = rrfxdown == 0 ? 100 : rrfxup == 0 ? 0 : 100 - (100 / (1 + rrfxup / rrfxdown))
//rsi equations
u = max(x - x[1], 0) // upward change
d = max(x[1] - x, 0) // downward change
rs = rma(u, y) / rma(d, y)
res = 100 - 100 / (1 + rs)
%}
function out = StochPlusRSI(H,L,C)
odk = 21;
dP = 7;
sK = 7;
rrfxlen = 10;
arsi = 1/rrfxlen;
close = C;
high = H;
low = L;
rrfxsrc = close;
Z = zeros(1,length(close));
persistent Xsprsi
if isempty(Xsprsi)
    Xsprsi.lowwin = repmat(low,odk,1);
    Xsprsi.highwin = repmat(high,odk,1);
    Xsprsi.stochwin = repmat(50*ones(1,length(H)),sK,1);
    Xsprsi.bndwin = repmat(50*ones(1,length(H)),dP,1);
    Xsprsi.rsiwin = repmat(Z,rrfxlen+1,1);
    Xsprsi.Cp = close;
    Xsprsi.rrfxupP = Z;
    Xsprsi.rrfxdownP = Z;
end
Xsprsi.lowwin = [low;Xsprsi.lowwin(1:end-1,:)];
Xsprsi.highwin = [high;Xsprsi.highwin(1:end-1,:)];
Xsprsi.rsiwin = [close-Xsprsi.Cp;Xsprsi.rsiwin(1:end-1,:)];
stoch = 100*(close - min(Xsprsi.lowwin))./...
    (max(Xsprsi.highwin) - min(Xsprsi.lowwin));
Xsprsi.stochwin = [stoch;Xsprsi.stochwin(1:end-1,:)];
lk = sum(Xsprsi.stochwin)/sK;
Xsprsi.bndwin = [lk;Xsprsi.bndwin(1:end-1,:)];
bnd = sum(Xsprsi.bndwin)/dP;
rrfxup = max(Xsprsi.rsiwin);
rrfxup(rrfxup<0) = 0;
rrfxdown = min(Xsprsi.rsiwin);
rrfxdown(rrfxdown>0) = 0;
rrfxdown = abs(rrfxdown);
rrfxup = (1-arsi)*Xsprsi.rrfxupP + arsi*rrfxup;
rrfxdown = (1-arsi)*Xsprsi.rrfxdownP + arsi*rrfxdown;
rrfxrsi(rrfxdown == 0) = 100;
k = find(rrfxdown ~= 0);
rrfxrsi(k) = 100 - (100 ./ (1 + rrfxup(k) ./ rrfxdown(k)));
Xsprsi.Cp = close;
Xsprsi.rrfxupP = rrfxup;
Xsprsi.rrfxdownP = rrfxdown;
out(1,:) = bnd;
out(2,:) = rrfxrsi;
end
