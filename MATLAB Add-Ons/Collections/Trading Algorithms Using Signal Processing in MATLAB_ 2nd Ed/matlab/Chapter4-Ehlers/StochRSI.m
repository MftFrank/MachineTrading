%{
//// STOCHASTIC RSI STRATEGY ////
Var {Inputs}: Delimiter(80), MA(0), MAlength(1{144}), 
Var{Input}: RSILength(8), StocLength(8), WMALength(8), 
StoRSI1(0), StoRSI2(0),StoRSI3(0),StoRSI4(0),StoRSI5(0);
MA=(Average(C, MAlength));
StoRSI1=RSI (Close, RSILength) - 
Lowest(RSI(Close, RSILength), StocLength);
StoRSI2 = Highest(RSI(Close, RSILength), StocLength) - 
Lowest(RSI(Close, RSILength), StocLength);
If StoRSI2<> 0 then StoRSI3 = StoRSI1/StoRSI2;
StoRSI4 = 2*(WAverage(StoRSI3, WMALength) - .5);
StoRSI5 = StoRSI4[1]; //define trigger
//Plot1(StoRSI4, "StocRSI",blue); 
Plot2(StoRSI5, "Trig",green); 
Plot3(0,"Zero",yellow); 
Plot4(.6,"",black);
Plot5(-.6,"",black);
%}
function out = StochRSI(C)
Delimiter = 80;
MAlength = 144;
RSILength = 8;
StocLength = 8;
WMALength = 8;
persistent Xstrsi
if isempty(Xstrsi)
    % weighted ave calculations
    Xstrsi.wnum = (WMALength + 1)*ones(1,WMALength) - [1:WMALength];
    Xstrsi.wden = WMALength*(WMALength+1) - sum(1:WMALength);
    Xstrsi.MAwin = repmat(C,MAlength,1);
    Xstrsi.RSIwin = repmat(zeros(1,length(C)),RSILength+1,1);
    Xstrsi.RSIlenwin = repmat(zeros(1,length(C)),StocLength,1);
    Xstrsi.StoRSI3win = repmat(zeros(1,length(C)),WMALength,1);
    Xstrsi.StoRSI4p = zeros(1,length(C));
end
Xstrsi.MAwin = [C;Xstrsi.MAwin(1:end-1,:)];
MA = mean(Xstrsi.MAwin);
tmpdif = diff(Xstrsi.MAwin(1:RSILength+1,:));
tmpU = tmpdif>0;
tmpD = tmpdif<0;
URS = sum(tmpU.*tmpdif);
DRS = sum(abs(tmpD.*tmpdif));
if isempty(find(DRS,1))|isempty(find(URS,1))
    rsi = zeros(1,length(C));
else
    DRS(DRS==0) = 1;
    rsi = 100*(1-1./(1+URS./DRS));
end
Xstrsi.RSIwin = [rsi;Xstrsi.RSIwin(1:end-1,:)];
Xstrsi.RSIlenwin = [rsi;Xstrsi.RSIlenwin(1:end-1,:)];
StoRSI1 = rsi - min(Xstrsi.RSIlenwin);
StoRSI2 = max(Xstrsi.RSIlenwin) - min(Xstrsi.RSIlenwin);
StoRSI2(StoRSI2==0) = 1;
StoRSI3 = StoRSI1./StoRSI2;
Xstrsi.StoRSI3win = [StoRSI3;Xstrsi.StoRSI3win(1:end-1,:)];
StoRSI4 = 2*sum(Xstrsi.wnum'.*Xstrsi.StoRSI3win - .5)/Xstrsi.wden;
StoRSI5 = Xstrsi.StoRSI4p; % define trigger
Xstrsi.StoRSI4p = StoRSI4;
out(1,:) = StoRSI4;
out(2,:) = StoRSI5;
end
