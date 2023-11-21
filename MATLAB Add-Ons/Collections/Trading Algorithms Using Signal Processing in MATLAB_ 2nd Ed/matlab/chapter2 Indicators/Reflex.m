%{
https://www.tradingview.com/script/qpFGRuYr-Reflex-A-new-Ehlers-indicator/
study("Reflex",overlay=false)
Length = input(40,"Reflex Period",input.integer)
Threshold = input(1,"Oscillator Range",input.float,step=0.1)
Source =input(close,"Source",input.source)
ATR = input(true,"Show ATR label",input.bool)
var atr_lbl = label.new(0, 0,"yolo", xloc.bar_index, yloc.price, color.black, label.style_label_left, color.white, size.large, text.align_center, "Average True Range of the previous 10 bars. \nUnits are in 'Min Tick' of current asset.")

//  int Length -> look back period
//  source Source -> series to perform Reflex computation
reflex(Source,Length)=>
    Slope=0.0
    Sum=0.0
    a1=0.0
    b1=0.0
    c1=0.0
    c2=0.0
    c3=0.0
    Filt=0.0
    MS=0.0
    Reflex=0.0
    
    //Gently smooth the data in a SuperSmoother
    a1 := exp(-1.414*3.14159 / (.5*Length))
    b1 := 2*a1*cos(1.414*180 / (.5*Length))
    c2 := b1
    c3 := -a1*a1
    c1 := 1 - c2 - c3
    Filt := c1*(Source + Source[1]) / 2 + c2*nz(Filt[1]) + c3*nz(Filt[2])
    //Length is assumed cycle period
    Slope := (nz(Filt[Length]) - Filt) / Length
    //Sum the differences
    for count = 1 to Length 
        Sum := Sum + (Filt + count*Slope) - nz(Filt[count])
    Sum := Sum / Length
    //Normalize in terms of Standard Deviations
    MS := .04*Sum*Sum + .96*nz(MS[1])
    if(MS != 0)
        Reflex := Sum / sqrt(MS)
    Reflex
%}
function out = Reflex(H,L,C)
Length = 40;
Threshold = 1;
aSPd = 2/(10+1);
Source = C;
Z = zeros(1,length(C));
persistent Xref
if isempty(Xref)
    a1 = exp(-1.414*3.14159 / (.5*Length));
    b1 = 2*a1*cos(1.414*180 / (.5*Length));
    Xref.c2 = b1;
    Xref.c3 = -a1*a1;
    Xref.c1 = 1 - Xref.c2 - Xref.c3;
    Xref.Cp = Source;
    Xref.Filtp = Source;
    Xref.Filtpp = Source;
    Xref.Filtwin = repmat(Source,Length,1);
    Xref.MSp = Source;
    atr = max(H-L,max(H-Source,...
        abs(L-Source)));
    Xref.atrp = atr;
end
Filt = Xref.c1*(Source + Xref.Cp) / 2 + ...
    Xref.c2*Xref.Filtp + Xref.c3*Xref.Filtpp;
Xref.Filtwin = [Filt;Xref.Filtwin(1:end-1,:)];
Slope = (Xref.Filtwin(end,:) - Filt) / Length;
Sum = Z;
for count = 1:Length 
    Sum = Sum + (Filt + count*Slope) - ...
        Xref.Filtwin(count,:);
end
Sum = Sum / Length;
MS = .04*Sum.*Sum + .96*Xref.MSp;
Reflex = Sum ./ sqrt(MS);
k = find(MS==0);
Reflex(k) = Z(k);
atr = max(H-L,max(H-Xref.Cp,...
    abs(L-Xref.Cp)));
atrSPd = (1-aSPd)*Xref.atrp + aSPd*atr;
% Xref.atrwin = [atr;Xref.atrwin(1:end-1,:)];
Xref.Cp = Source;
Xref.Filtp = Source;
Xref.Filtpp = Source;
Xref.MSp = MS;
Xref.atrp = atrSPd;
out(1,:) = Filt;
out(2,:) = Reflex;
out(3,:) = atrSPd;
end
