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
function out = Reflex(C)
Source = C;
Length = 40;
Z = zeros(1,length(Source));
persistent Xrefl
if isempty(Xrefl)
    Xrefl.Sp = Source;
    Xrefl.filtp = Source;
    Xrefl.filtpp = Source;
    Xrefl.MSp = Source;
    Xrefl.filtwin = repmat(Source,Length,1);
end
a1 = exp(-1.414*3.14159 / (.5*Length));
b1 = 2*a1*cos(1.414*180 / (.5*Length));
c2 = b1;
c3 = -a1*a1;
c1 = 1 - c2 - c3;
Filt = c1*(Source + Xrefl.Sp) ./ 2 + ...
    c2*Xrefl.filtp + c3*Xrefl.filtpp;
Xrefl.filtwin = [Filt;Xrefl.filtwin(1:end-1,:)];
Slope = (Xrefl.filtwin(end,:) - Filt) / Length;
Sum = Z;
for count = 1:Length 
    Sum = Sum + (Filt + count*Slope) - ...
        Xrefl.filtwin(count,:);
end
Sum = Sum / Length;
MS = .04*Sum.*Sum + .96*Xrefl.MSp;
Reflex = Sum ./ sqrt(MS);
Xrefl.Sp = Source;
Xrefl.filtpp = Xrefl.filtp;
Xrefl.filtp = Filt;
Xrefl.MSp = MS;
out(1,:) = Reflex;
end
