%{
https://www.tradingview.com/script/efHJsedw-Indicator-Rahul-Mohindar-Oscillator-RMO/
study(title = "Rahul Mohinder Oscillator [LazyBear]", shorttitle="RMO_LB")
C=close
cm2(x) => sma(x,2)
ma1=cm2(C)
ma2=cm2(ma1)
ma3=cm2(ma2)
ma4=cm2(ma3)
ma5=cm2(ma4)
ma6=cm2(ma5)
ma7=cm2(ma6)
ma8=cm2(ma7)
ma9=cm2(ma8)
ma10=cm2(ma9)
SwingTrd1 = 100 * (close - (ma1+ma2+ma3+ma4+ma5+ma6+ma7+ma8+ma9+ma10)/10)/(highest(C,10)-lowest(C,10))
SwingTrd2=ema(SwingTrd1,30)
SwingTrd3=ema(SwingTrd2,30)
RMO= ema(SwingTrd1,81)
Buy=cross(SwingTrd2,SwingTrd3)
Sell=cross(SwingTrd3,SwingTrd2)
Bull_Trend=ema(SwingTrd1,81)>0
Bear_Trend=ema(SwingTrd1,81)<0
Ribbon_kol=Bull_Trend ? green : (Bear_Trend ? red : blue)
%}
function out = RahMohWsc_optim(close,ast2,ast3,armo,Len,n,lo,hi)
C = close;
% ast2 = 30; ast2 = 30; armo = 81; Len = 10;rsilen = 14;
% odk = 21;dP = 7;sK = 7;
rsilen = 10;
odk = 15;
dP = 7;
sK = 7;
a2 = 2/(ast2+1);
a3 = 2/(ast3+1);
aST = 2/(armo+1);
arsi = 1/rsilen;
Z = zeros(size(close));
persistent Xrmw
if isempty(Xrmw) || n==1
    Cmat = zeros(Len,Len);
    ma = [.5 .5];
    Cmat(1,1:2) = ma;
    for i=2:Len
        Cmat(i,1:i+1) = conv(ma,Cmat(i-1,1:i));
    end
    Xrmw.Cp = C;
    Xrmw.Buyp = Z;
    Xrmw.Sellp = Z;
    Xrmw.Cmat = Cmat;
    Xrmw.Cwin = repmat(C,Len+1,1);
    Xrmw.est2p = Z;
    Xrmw.est3p = Z;
    Xrmw.ermop = Z;
    Xrmw.rsiwin = repmat(Z,rsilen+1,1);
    Xrmw.rrfxupP = Z;
    Xrmw.rrfxdownP = Z;
    Xrmw.lowwin = repmat(lo,odk,1);
    Xrmw.highwin = repmat(hi,odk,1);
    Xrmw.stochwin = repmat(50*ones(1,length(hi)),sK,1);
    Xrmw.bndwin = repmat(50*ones(1,length(hi)),dP,1);
end
Xrmw.Cwin = [C;Xrmw.Cwin(1:end-1,:)];
Xrmw.rsiwin = [C-Xrmw.Cp;Xrmw.rsiwin(1:end-1,:)];
Xrmw.lowwin = [lo;Xrmw.lowwin(1:end-1,:)];
Xrmw.highwin = [hi;Xrmw.highwin(1:end-1,:)];
lomin = min(Xrmw.lowwin);
lomax = max(Xrmw.highwin);
stoch = 100*(close - lomin)./(lomax - lomin);
Xrmw.stochwin = [stoch;Xrmw.stochwin(1:end-1,:)];
lk = sum(Xrmw.stochwin)/sK;
Xrmw.bndwin = [lk;Xrmw.bndwin(1:end-1,:)];
bnd = sum(Xrmw.bndwin)/dP;
for i = 1:Len
    mamat(i,:) = sum(Xrmw.Cmat(i,:)'.*Xrmw.Cwin);
end
den = max(Xrmw.Cwin)-min(Xrmw.Cwin);
den(den==0) = 1;
SwingTrd1 = 100 * (C - sum(mamat)/Len)./...
    den;
Xrmw.est2p(isnan(Xrmw.est2p)) = 0;
Xrmw.est2p(isinf(Xrmw.est2p)) = 0;
Xrmw.est3p(isnan(Xrmw.est3p)) = 0;
Xrmw.est3p(isinf(Xrmw.est3p)) = 0;
Xrmw.est3p(isnan(Xrmw.ermop)) = 0;
Xrmw.est3p(isinf(Xrmw.ermop)) = 0;
SwingTrd2 = (1-a2)*Xrmw.est2p + a2*SwingTrd1;
SwingTrd3 = (1-a3)*Xrmw.est3p + a3*SwingTrd2;
RMO = (1-aST)*Xrmw.ermop + aST*SwingTrd1;
rrfxup = max(Xrmw.rsiwin);
rrfxup(rrfxup<0) = 0;
rrfxdown = min(Xrmw.rsiwin);
rrfxdown(rrfxdown>0) = 0;
rrfxdown = abs(rrfxdown);
rrfxup = (1-arsi)*Xrmw.rrfxupP + arsi*rrfxup;
rrfxdown = (1-arsi)*Xrmw.rrfxdownP + arsi*rrfxdown;
rrfxrsi(rrfxdown == 0) = 100;
k = find(rrfxdown ~= 0);
rrfxrsi(k) = 100 - (100 ./ (1 + rrfxup(k) ./ rrfxdown(k)));
crsi = Z;
crsi(k) = rrfxrsi(k) - 50;
Buy = SwingTrd2>SwingTrd3;
Sell = SwingTrd2<SwingTrd3;
% if Buy~=Xrmw.Buyp
Tradeb = Z;
Tradeb(Buy~=Xrmw.Buyp) = 1;
Trades = Z;
Trades(Sell~=Xrmw.Sellp) = 1;
Trade = Trades + Tradeb;
% end
Xrmw.est2p = SwingTrd2;
Xrmw.est3p = SwingTrd3;
Xrmw.ermop = RMO;
Xrmw.Cp = C;
Xrmw.Buyp = Buy;
Xrmw.Sellp = Sell;
out(1,:) = RMO;
out(2,:) = SwingTrd2;
out(3,:) = SwingTrd3;
out(4,:) = Buy;
out(5,:) = Sell;
out(6,:) = rrfxrsi;
out(7,:) = bnd;
out(8,:) = crsi;
out(9,:) = Trade;
end
