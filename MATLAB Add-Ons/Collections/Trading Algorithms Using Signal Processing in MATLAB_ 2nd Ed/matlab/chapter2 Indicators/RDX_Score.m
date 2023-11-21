%{
study("RDX Score", overlay=true)
len = input(title="length_ADX", type=integer, defval=14)
th = input(title="threshold_ADX", type=integer, defval=14)

TrueRange = max(max(high-low, abs(high-nz(close[1]))), abs(low-nz(close[1])))
DirectionalMovementPlus = high-nz(high[1]) > nz(low[1])-low ? max(high-nz(high[1]), 0): 0
DirectionalMovementMinus = nz(low[1])-low > high-nz(high[1]) ? max(nz(low[1])-low, 0): 0

SmoothedTrueRange = nz(SmoothedTrueRange[1]) - (nz(SmoothedTrueRange[1])/len) + TrueRange
SmoothedDirectionalMovementPlus = nz(SmoothedDirectionalMovementPlus[1]) - (nz(SmoothedDirectionalMovementPlus[1])/len) + DirectionalMovementPlus
SmoothedDirectionalMovementMinus = nz(SmoothedDirectionalMovementMinus[1]) - (nz(SmoothedDirectionalMovementMinus[1])/len) + DirectionalMovementMinus

DIPlus = SmoothedDirectionalMovementPlus / SmoothedTrueRange * 100
DIMinus = SmoothedDirectionalMovementMinus / SmoothedTrueRange * 100
DX = abs(DIPlus-DIMinus) / (DIPlus+DIMinus)*100
ADX = sma(DX, len)


length_RSI = input(14 )
priceRSI = close
vrsi = rsi(priceRSI, length_RSI)

m5 = ADX[1]<ADX and vrsi<30
plotshape(m5, title="SCORE -5", text="-5", textcolor=white, style=shape.labeldown, location=location.abovebar, color=red, transp=0, size=size.tiny)

m4 = (ADX[1]>ADX and vrsi<30) or (ADX[1]<ADX and vrsi<35 and vrsi>30)
plotshape(m4, title="SCORE -4", text="-4", textcolor=white, style=shape.labeldown, location=location.abovebar, color=red, transp=0, size=size.tiny)

m3 = (ADX[1]>ADX and vrsi<35 and vrsi>30) or (ADX[1]<ADX and vrsi<40 and vrsi>35)
plotshape(m3, title="SCORE -3", text="-3", textcolor=white, style=shape.labeldown, location=location.abovebar, color=red, transp=0, size=size.tiny)

m2 = (ADX[1]>ADX and vrsi<40 and vrsi>35) or (ADX[1]<ADX and vrsi<45 and vrsi>40)
plotshape(m2, title="SCORE -2", text="-2", textcolor=white, style=shape.labeldown, location=location.abovebar, color=red, transp=0, size=size.tiny)

m1 = ADX[1]>ADX and vrsi<45 and vrsi>40
plotshape(m1, title="SCORE -1", text="-1", textcolor=white, style=shape.labeldown, location=location.abovebar, color=red, transp=0, size=size.tiny)

m0 = vrsi<55 and vrsi>45
//plotshape(m0, title="QQE short", text="0", textcolor=black, style=shape.labeldown, location=location.abovebar, color=yellow, transp=0, size=size.tiny)
plotshape(m0, title="QQE long", text="0", textcolor=black, style=shape.labelup, location=location.belowbar, color=yellow, transp=0, size=size.tiny)

p1 = ADX[1]>ADX and vrsi>55 and vrsi<60
plotshape(p1, title="SCORE 1", text="1", textcolor=white, style=shape.labelup, location=location.belowbar, color=green, transp=0, size=size.tiny)

p2 = (ADX[1]>ADX and vrsi>60 and vrsi<65) or (ADX[1]<ADX and vrsi>55 and vrsi<60)
plotshape(p2, title="SCORE 2", text="2", textcolor=white, style=shape.labelup, location=location.belowbar, color=green, transp=0, size=size.tiny)

p3 = (ADX[1]>ADX and vrsi>65 and vrsi<70) or (ADX[1]<ADX and vrsi>60 and vrsi<65)
plotshape(p3, title="SCORE 3", text="3", textcolor=white, style=shape.labelup, location=location.belowbar, color=green, transp=0, size=size.tiny)

p4 = (ADX[1]>ADX and vrsi>70) or (ADX[1]<ADX and vrsi>65 and vrsi<70)
plotshape(p4, title="SCORE 4", text="4", textcolor=white, style=shape.labelup, location=location.belowbar, color=green, transp=0, size=size.tiny)

p5 = ADX[1]<ADX and vrsi>70
plotshape(p5, title="SCORE 5", text="5", textcolor=white, style=shape.labelup, location=location.belowbar, color=green, transp=0, size=size.tiny)
%}
function out = RDX_Score(H,L,C)
len = 14;
th = 14;
length_RSI = 14;
arsi = 1/length_RSI;
priceRSI = C;
high = H;
low = L;
Z = zeros(1,length(C));
persistent Xrdx
if isempty(Xrdx)
    Xrdx.Cp = priceRSI;
    Xrdx.Hp = high;
    Xrdx.Lp = low;
    Xrdx.SmoothedTrueRangeP = Z;
    Xrdx.SmoothedDirectionalMovementPlusP = Z;
    Xrdx.SmoothedDirectionalMovementMinusP = Z;
    Xrdx.DXwin = repmat(Z,len,1);
    Xrdx.rsiwin = repmat(Z,length_RSI,1);
    Xrdx.rsiupP = Z;
    Xrdx.rsidownP = Z;
    Xrdx.adxP = Z;
end
Xrdx.rsiwin = [priceRSI-Xrdx.Cp;Xrdx.rsiwin(1:end-1,:)];
TrueRange = max(max(high-low, abs(high-Xrdx.Cp)), ...
    abs(low-Xrdx.Cp));
DirectionalMovementPlus = max(high-Xrdx.Hp, 0);
DirectionalMovementPlus(high-Xrdx.Hp < Xrdx.Lp-low) = 0;
DirectionalMovementMinus = max(Xrdx.Lp-low, 0);
DirectionalMovementMinus(Xrdx.Lp-low < high-Xrdx.Hp) = 0;
SmoothedTrueRange = Xrdx.SmoothedTrueRangeP - ...
    (Xrdx.SmoothedTrueRangeP/len) + TrueRange;
SmoothedDirectionalMovementPlus = Xrdx.SmoothedDirectionalMovementPlusP - ...
    Xrdx.SmoothedDirectionalMovementPlusP/len +...
    DirectionalMovementPlus;
SmoothedDirectionalMovementMinus = Xrdx.SmoothedDirectionalMovementMinusP - ...
    (Xrdx.SmoothedDirectionalMovementMinusP/len) + ...
    DirectionalMovementMinus;
DIPlus = SmoothedDirectionalMovementPlus ./ ...
    SmoothedTrueRange * 100;
DIMinus = SmoothedDirectionalMovementMinus ./ ...
    SmoothedTrueRange * 100;
DX = abs(DIPlus-DIMinus) ./ (DIPlus+DIMinus)*100;
Xrdx.DXwin = [DX;Xrdx.DXwin(1:end-1,:)];
ADX = sum(Xrdx.DXwin)/len;
rsiup = max(Xrdx.rsiwin);
rsiup(rsiup<0) = 0;
rsidown = min(Xrdx.rsiwin);
rsidown(rsidown>0) = 0;
rsidown = abs(rsidown);
rsiup = (1-arsi)*Xrdx.rsiupP + arsi*rsiup;
rsidown = (1-arsi)*Xrdx.rsidownP + arsi*rsidown;
vrsi(rsidown == 0) = 100;
k = find(rsidown ~= 0);
vrsi(k) = 100 - (100 ./ (1 + rsiup(k) ./ rsidown(k)));
m5 = Xrdx.adxP<ADX & vrsi<30;
m4 = (Xrdx.adxP>ADX & vrsi<30) | (Xrdx.adxP<ADX & vrsi<35 & vrsi>30);
m3 = (Xrdx.adxP>ADX & vrsi<35 & vrsi>30) | ...
    (Xrdx.adxP<ADX & vrsi<40 & vrsi>35);
m2 = (Xrdx.adxP>ADX & vrsi<40 & vrsi>35) | ...
    (Xrdx.adxP<ADX & vrsi<45 & vrsi>40);
m1 = Xrdx.adxP>ADX & vrsi<45 & vrsi>40;
m0 = vrsi<55 & vrsi>45;
p3 = (Xrdx.adxP>ADX & vrsi>65 & vrsi<70) | ...
    (Xrdx.adxP<ADX & vrsi>60 & vrsi<65);
p4 = (Xrdx.adxP>ADX & vrsi>70) | ...
    (Xrdx.adxP<ADX & vrsi>65 & vrsi<70);
p5 = Xrdx.adxP<ADX & vrsi>70;
% updates
Xrdx.Cp = priceRSI;
Xrdx.Hp = high;
Xrdx.Lp = low;
Xrdx.SmoothedTrueRangeP = SmoothedTrueRange;
Xrdx.SmoothedDirectionalMovementPlusP = SmoothedDirectionalMovementPlus;
Xrdx.SmoothedDirectionalMovementMinusP = SmoothedDirectionalMovementMinus;
Xrdx.rsiupP = rsiup;
Xrdx.rsidownP = rsidown;
Xrdx.adxP = ADX;
out(1,:) = ADX;
out(2,:) = vrsi;
out(3,:) = m5;
out(4,:) = m4;
out(5,:) = m3;
out(6,:) = m2;
out(7,:) = m1;
out(8,:) = m0;
out(9,:) = p3;
out(10,:) = p4;
out(11,:) = p5;
end
