%{
// Ehlers Super PassBand Filter [CC] 
study("Ehlers Super PassBand Filter [CC]", overlay=false)

inp = input(title="Source", type=input.source, defval=close)
res = input(title="Resolution", type=input.resolution, defval="")
rep = input(title="Allow Repainting?", type=input.bool, defval=false)
bar = input(title="Allow Bar Color Change?", type=input.bool, defval=true)
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
function out = ScSuperBP(C)
src = C;
length1 = 40;
length2 = 60;
rmslength = 50;
a1 = 5/length1;
a2 = 5/length2;
persistent XSSBP
if isempty(XSSBP)
    XSSBP.srcp = src;
    XSSBP.pbp = zeros(1,length(src));
    XSSBP.pbpp = zeros(1,length(src));
    XSSBP.rmswin = zeros(rmslength,length(src));
end
pb = ((a1 - a2) * src) + ...
    (((a2 * (1 - a1)) - (a1 * (1 - a2))) * XSSBP.srcp) + ...
    (((1 - a1) + (1 - a2)) * XSSBP.pbp) - ...
    ((1 - a1) * (1 - a2) * XSSBP.pbpp);
XSSBP.rmswin = [pb;XSSBP.rmswin(1:end-1,:)];
rms = zeros(1,length(src));
for i = 1:rmslength
    rms = rms + XSSBP.rmswin(i,:).*XSSBP.rmswin(i,:);
end
rms = sqrt(rms / rmslength);
% updates
XSSBP.pbpp = XSSBP.pbp;
XSSBP.pbp = pb;
XSSBP.srcp = src;
out(1,:) = pb;
out(2,:) = rms;
end
