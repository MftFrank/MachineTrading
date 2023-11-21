%{
//
// @author LazyBear
// @credits http://freethinkscript.blogspot.com/2009/05/only-scalpers-channel-that-you-will.html
//
study(title = "Scalper's Channel [LazyBear]", 
shorttitle="weak_volume_dependency [LB]", overlay=true)
length = input(20)
factor = input(15)
pi = atan(1)*4
Average(x,y) => (sum(x,y) / y)
scalper_line= plot(Average(close, factor) - log(pi * (atr(factor))), color=blue, linewidth=3)
hi = plot (highest(length), color=fuchsia)
lo = plot (lowest(length), color=fuchsia)
%}
function out = ScalpChan(C)
Length = 20;
factor = 15;
b = ones(1,factor)/factor;
persistent XScCh
if isempty(XScCh)
    XScCh.lenwin = repmat(C,Length,1);
    XScCh.factwin = repmat(C,factor,1);
    XScCh.Cp = C;
end
XScCh.lenwin = [C;XScCh.lenwin(1:end-1,:)];
XScCh.factwin = [C;XScCh.factwin(1:end-1,:)];
maxC = max(XScCh.factwin);
minC = min(XScCh.factwin);
atr = max(maxC-minC,max(abs(maxC-XScCh.Cp),abs(minC-XScCh.Cp)));
scalper_line = mean(XScCh.factwin) - log(pi*atr);
scalper_line_atr = mean(XScCh.factwin) - atr;
hi = max(XScCh.lenwin);
lo = min(XScCh.lenwin);
XScCh.Cp = C;
out(1,:) = scalper_line;
out(2,:) = scalper_line_atr;
out(3,:) = hi;
out(4,:) = lo;
end
