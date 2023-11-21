%{
Hull weighted moving average
//INPUT
src = input(close, title="Source")
length = input(55, 
title="Length(180-200 for floating S/R , 55 for swing entry)")

//FUNCTIONS
//HMA
HMA(_src, _length) =>  wma(2 * wma(_src, _length / 2) - 
    wma(_src, _length), round(sqrt(_length)))
//EHMA    
EHMA(_src, _length) =>  ema(2 * ema(_src, _length / 2) - 
    ema(_src, _length), round(sqrt(_length)))
//THMA    
THMA(_src, _length) =>  wma(wma(_src,_length / 3) * 3 - 
    wma(_src, _length / 2) - wma(_src, _length), _length)
%}
function out = HullMA(C)
src = C;
Length = 55;
persistent XHma
if isempty(XHma)
    b55 = [Length:-1:1]/sum([Length:-1:1]);
    b27 = [round(Length/2):-1:1]/sum([round(Length/2):-1:1]);
    bsr = [round(sqrt(Length)):-1:1]/...
        sum([round(sqrt(Length)):-1:1]);
    XHma.b55 = b55;
    XHma.b27 = b27;
    XHma.bsr = bsr;
    XHma.Cwin = repmat(C,Length,1);
    XHma.Zwin = repmat(C,Length,1);
end
XHma.Cwin = [C;XHma.Cwin(1:end-1,:)];
b27 = XHma.b27;
b55 = XHma.b55;
bsr = XHma.bsr;
tmp = 2*sum(b27'.*XHma.Cwin(1:length(b27),:)) - ...
    sum(b55'.*XHma.Cwin(1:length(b55),:));
XHma.Zwin = [tmp;XHma.Zwin(1:end-1,:)];
HMA = sum(bsr'.*XHma.Zwin(1:length(bsr),:));
out = HMA;
end
