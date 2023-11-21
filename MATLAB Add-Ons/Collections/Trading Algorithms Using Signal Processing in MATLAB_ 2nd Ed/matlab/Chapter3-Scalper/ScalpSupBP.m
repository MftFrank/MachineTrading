%{
https://www.tradingview.com/script/T0c3oqfk-Ehlers-Super-PassBand-Filter-CC/
study("Ehlers Super PassBand Filter [CC]", overlay=false)

inp = input(title="Source", type=input.source, defval=close)
src = security(syminfo.tickerid, res, inp[rep ? 0 : barstate.isrealtime ? 1 : 0])[rep ? 0 : barstate.isrealtime ? 0 : 1]
length1 = input(title="Length1", type=input.integer, defval=40, minval=1)
length2 = input(title="Length2", type=input.integer, defval=60, minval=1)
rmsLength = input(title="RMSLength", type=input.integer, defval=50, minval=1)

pi = 2 * asin(1)
a1 = 5.0 / length1
a2 = 5.0 / length2

pb = 0.0
pb := ((a1 - a2) * src) + (((a2 * (1 - a1)) - (a1 * (1 - a2))) * nz(src[1])) + (((1 - a1) + (1 - a2)) * nz(pb[1])) - ((1 - a1) * (1 - a2) * nz(pb[2]))

rms = 0.0
for i = 0 to rmsLength - 1
    rms := rms + pow(nz(pb[i]), 2)
rms := sqrt(rms / rmsLength)

sig = pb > 0 ? 1 : pb < 0 ? -1 : 0
%}
function out = ScalpSupBP(C)
src = C;
length1 = 40;
length2 = 60;
rmsLength = 50;
a1 = 5.0 / length1;
a2 = 5.0 / length2;
persistent XScSupbp
if isempty(XScSupbp)
    XScSupbp.srcp = src;
    XScSupbp.pbp = zeros(1,length(src));
    XScSupbp.pbpp = zeros(1,length(src));
    XScSupbp.pbwin = repmat(zeros(1,length(src)),rmsLength,1);
end
pb = ((a1 - a2) * src) + ...
    (((a2 * (1 - a1)) - (a1 * (1 - a2))) * XScSupbp.srcp) + ...
    (((1 - a1) + (1 - a2)) * XScSupbp.pbp) - ...
    ((1 - a1) * (1 - a2) * XScSupbp.pbp);
XScSupbp.pbwin = [pb;XScSupbp.pbwin(1:end-1,:)];
rms = zeros(1,length(src));
for i = 1:rmsLength
    rms = rms + power(XScSupbp.pbwin(i,:), 2);
end
rms = sqrt(rms / rmsLength);
sig = zeros(1,length(src));
sig(pb<0) = -0.45;
sig(pb>0) = 0.45;
% updates
XScSupbp.srcp = src;
XScSupbp.pbpp = XScSupbp.pbp;
XScSupbp.pbp = pb;
out(1,:) = pb;
out(2,:) = rms;
out(3,:) = sig;
end
