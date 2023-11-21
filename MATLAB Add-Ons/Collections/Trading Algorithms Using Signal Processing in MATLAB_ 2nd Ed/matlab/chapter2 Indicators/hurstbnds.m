%{
http://fxcodebase.com/code/viewtopic.php?f=27&t=61074
study("Hurst Bands [LazyBear]", shorttitle="H%Bands_LB", overlay=true)
price = hl2
length = input(10, title="Displacement length")
InnerValue = input(1.6, title="Innerbands %")
OuterValue = input(2.6, title="Outerbands %")
ExtremeValue = input(4.2, title="Extremebands %")
showExtremeBands = input(false, type=bool, title="Display Extreme Bands?")
showClosingPriceLine = input(false, type=bool, title="Plot Close price?")
smooth = input(1, title="EMA Length for Close")

displacement = (length / 2) + 1
dPrice = price[displacement]

CMA = not na(dPrice) ?  sma(dPrice, abs(length)) : nz(CMA[1]) + (nz(CMA[1]) - nz(CMA[2]))
HO = MA - CMA[Period/2-1]
CenteredMA=plot(not na(dPrice) ? CMA : na, color=blue , linewidth=2)
CenterLine=plot(not na(price) ? CMA : na, linewidth=2, color=aqua)

ExtremeBand = CMA * ExtremeValue / 100
OuterBand   = CMA * OuterValue / 100
InnerBand   = CMA * InnerValue / 100

UpperExtremeBand=plot(showExtremeBands and (not na(price)) ? CMA + ExtremeBand : na)
LowerExtremeBand=plot(showExtremeBands and (not na(price)) ? CMA - ExtremeBand : na)
UpperOuterBand=  plot(not na(price) ? CMA + OuterBand : na)
LowerOuterBand=  plot(not na(price) ? CMA - OuterBand : na)
UpperInnerBand=  plot(not na(price) ? CMA + InnerBand : na)
LowerInnerBand=  plot(not na(price) ? CMA - InnerBand : na)

fill(UpperOuterBand, UpperInnerBand, color=red, transp=85)
fill(LowerInnerBand, LowerOuterBand, color=green, transp=85)

FlowValue = close > close[1] ? high : close < close[1] ? low : hl2
FlowPrice = plot(showClosingPriceLine ? sma(FlowValue, smooth) : na, linewidth=1)
%}
function out = hurstbnds(H,L)
price = (H+L)/2;
Length = 10;
InnerValue = 1.6;
OuterValue = 2.6;
ExtremeValue = 4.2;
smooth = 1;
displacement = (Length / 2) + 1;
persistent Xhb
if isempty(Xhb)
    Xhb.pwin = repmat(price,displacement,1);
    Xhb.CMAwin = repmat(price,displacement,1);
    Xhb.dpricewin = repmat(price,Length,1);
    Xhb.cmaP = price;
end
Xhb.pwin = [price;Xhb.pwin(1:end-1,:)];
dPrice = Xhb.pwin(end,:);
Xhb.dpricewin = [dPrice;Xhb.dpricewin(1:end-1,:)];
CMA = sum(Xhb.dpricewin)/Length;
Xhb.CMAwin = [CMA;Xhb.CMAwin(1:end-1,:)];
MA = sum(Xhb.pwin)/displacement;
HO = MA - Xhb.CMAwin(end,:);
ExtremeBand = CMA * ExtremeValue / 100;
OuterBand   = CMA * OuterValue / 100;
InnerBand   = CMA * InnerValue / 100;
UpperExtremeBand = CMA + ExtremeBand;
LowerExtremeBand = CMA - ExtremeBand;
UpperOuterBand =  CMA + OuterBand;
LowerOuterBand =  CMA - OuterBand;
UpperInnerBand =  CMA + InnerBand;
LowerInnerBand =  CMA - InnerBand;
Xhb.cmaP = CMA;
out(1,:) = CMA;
out(2,:) = UpperExtremeBand;
out(3,:) = LowerExtremeBand;
out(4,:) = UpperOuterBand;
out(5,:) = LowerOuterBand;
out(6,:) = UpperInnerBand;
out(7,:) = LowerInnerBand;
out(8,:) = HO;
end
