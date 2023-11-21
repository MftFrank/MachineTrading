%{
https://www.tradingview.com/script/Et8ou2hJ-RSI-buy-sell-force/
study(title = "RSI buy sell force ", overlay = false)
length=input(14)
p=input(close)

min =input(1440,   title = 'Length time distance')
len = timeframe.isintraday and timeframe.multiplier >= 1 ? 
   min / timeframe.multiplier * 7 : 
   timeframe.isintraday and timeframe.multiplier < 60 ? 
   60 / timeframe.multiplier * 24 * 7 : 7

vrsi = rsi(p, length)
pp=ema(vrsi,len)

d=(vrsi-pp)*5
bb=(vrsi-d+pp)/2
cc=(vrsi+d+pp)/2

avg=(cc+bb)/2
%}
function out = rsibuysell(C)
Length = 14;
arsi = 1/Length;
len = 7;
a = 1/7;
p = C;
Z = zeros(1,length(p));
persistent Xrsibs
if isempty(Xrsibs)
    Xrsibs.rsiwin = repmat(Z,Length+1,1);
    Xrsibs.Cp = p;
    Xrsibs.vrsip = Z;
    Xrsibs.rrfxupP = Z;
    Xrsibs.rrfxdownP = Z;
end
Xrsibs.rsiwin = [p-Xrsibs.Cp;Xrsibs.rsiwin(1:end-1,:)];
rrfxup = max(Xrsibs.rsiwin);
rrfxup(rrfxup<0) = 0;
rrfxdown = min(Xrsibs.rsiwin);
rrfxdown(rrfxdown>0) = 0;
rrfxdown = abs(rrfxdown);
rrfxup = (1-arsi)*Xrsibs.rrfxupP + arsi*rrfxup;
rrfxdown = (1-arsi)*Xrsibs.rrfxdownP + arsi*rrfxdown;
vrsi(rrfxdown == 0) = 100;
k = find(rrfxdown ~= 0);
vrsi(k) = 100 - (100 ./ (1 + rrfxup(k) ./ rrfxdown(k)));
pp = (1-a)*Xrsibs.vrsip + a*vrsi;
d=(vrsi-pp)*5;
bb=(vrsi-d+pp)/2;
cc=(vrsi+d+pp)/2;
cc = max(min(cc,100),0);
bb = max(min(bb,100),0);
avg=(cc+bb)/2;
Xrsibs.Cp = p;
Xrsibs.rrfxupP = rrfxup;
Xrsibs.rrfxdownP = rrfxdown;
Xrsibs.vrsip = pp;
out(1,:) = bb;
out(2,:) = cc;
out(3,:) = avg;
end
