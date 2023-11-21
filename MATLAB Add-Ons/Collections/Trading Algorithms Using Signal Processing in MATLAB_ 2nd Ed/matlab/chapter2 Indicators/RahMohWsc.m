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
function out = RahMohWsc(close)
C = close;
a2 = 2/(30+1);
a3 = 2/(30+1);
aST = 2/(81+1);
Len = 10;
persistent Xrmw
if isempty(Xrmw)
    Cmat = zeros(Len,Len);
    ma = [.5 .5];
    Cmat(1,1:2) = ma;
    for i=2:Len
        Cmat(i,1:i+1) = conv(ma,Cmat(i-1,1:i));
    end
    Xrmw.Cmat = Cmat;
    Xrmw.Cwin = repmat(C,Len+1,1);
    Xrmw.est2p = C;
    Xrmw.est3p = C;
    Xrmw.ermop = C;
end
Xrmw.Cwin = [C;Xrmw.Cwin(1:end-1,:)];
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
Buy = SwingTrd2>SwingTrd3;
Sell = SwingTrd2<SwingTrd3;
Xrmw.est2p = SwingTrd2;
Xrmw.est3p = SwingTrd3;
Xrmw.ermop = RMO;
out(1,:) = RMO;
out(2,:) = SwingTrd2;
out(3,:) = SwingTrd3;
out(4,:) = Buy;
out(5,:) = Sell;
end
