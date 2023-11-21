%{
//@version=4
// Copyright (c) 2019-present, Franklin Moormann (cheatcountry)
// Ehlers BandPass Filter [CC] 
study("Ehlers BandPass Filter [CC]", overlay=false)

inp = input(title="Source", type=input.source, defval=close)
res = input(title="Resolution", type=input.resolution, defval="")
rep = input(title="Allow Repainting?", type=input.bool, defval=false)
bar = input(title="Allow Bar Color Change?", type=input.bool, defval=true)
src = security(syminfo.tickerid, res, inp[rep ? 0 : barstate.isrealtime ? 1 : 0])[rep ? 0 : barstate.isrealtime ? 0 : 1]
length = input(title="Length", type=input.integer, defval=20, minval=1)
bw = input(title="Bandwidth", type=input.float, defval=0.3, minval=0.01, step = 0.01)

pi = 2 * asin(1)
twoPiPrd1 = 0.25 * bw * 2 * pi / length
twoPiPrd2 = 1.5 * bw * 2 * pi / length
beta = cos(2 * pi / length)
gamma = 1.0 / cos(2 * pi * bw / length)
alpha1 = gamma - sqrt((gamma * gamma) - 1)
alpha2 = (cos(twoPiPrd1) + sin(twoPiPrd1) - 1) / cos(twoPiPrd1)
alpha3 = (cos(twoPiPrd2) + sin(twoPiPrd2) - 1) / cos(twoPiPrd2)

hp = 0.0
hp := ((1 + (alpha2 / 2)) * (src - nz(src[1]))) + 
    ((1 - alpha2) * nz(hp[1]))

bp = 0.0
bp := bar_index > 2 ? (0.5 * (1 - alpha1) * 
    (hp - nz(hp[2]))) + 
    (beta * (1 + alpha1) * nz(bp[1])) - (alpha1 * nz(bp[2])) : 0

peak = 0.0
peak := 0.991 * nz(peak[1])
peak := abs(bp) > peak ? abs(bp) : peak

signal = peak != 0 ? bp / peak : 0
trigger = 0.0
trigger := ((1 + (alpha3 / 2)) * 
    (signal - nz(signal[1]))) + ((1 - alpha3) * nz(trigger[1]))
%}
function out = ScalpEhlersBP(C)
src = C;
Length = 20;
bw = 0.3;
persistent XScEBP
if isempty(XScEBP)
    twoPiPrd1 = 0.25 * bw * 2 * pi / Length;
    twoPiPrd2 = 1.5 * bw * 2 * pi / Length;
    XScEBP.beta = cos(2 * pi / Length);
    gamma = 1.0 / cos(2 * pi * bw / Length);
    XScEBP.alpha1 = gamma - sqrt((gamma * gamma) - 1);
    XScEBP.alpha2 = (cos(twoPiPrd1) + sin(twoPiPrd1) - 1) / ...
        cos(twoPiPrd1);
    XScEBP.alpha3 = (cos(twoPiPrd2) + sin(twoPiPrd2) - 1) / ...
        cos(twoPiPrd2);
    XScEBP.srcp = src;
    XScEBP.hpp = zeros(1,length(src));
    XScEBP.hppp = zeros(1,length(src));
    XScEBP.bpp = zeros(1,length(src));
    XScEBP.bppp = zeros(1,length(src));
    XScEBP.peakp = zeros(1,length(src));
    XScEBP.sigp = zeros(1,length(src));
    XScEBP.trigp = zeros(1,length(src));
end
hp = ((1 + (XScEBP.alpha2 / 2)) * (src - XScEBP.srcp)) + ...
    ((1 - XScEBP.alpha2) * XScEBP.hpp);
bp = 0.5 * (1 - XScEBP.alpha1) * (hp - XScEBP.hppp) + ...
    XScEBP.beta * (1 + XScEBP.alpha1) * XScEBP.bpp - ...
    XScEBP.alpha1 * XScEBP.bppp;
peak = 0.991*XScEBP.peakp;
peak = max(abs(bp),peak);
signal = zeros(1,length(src));
k = find(peak~=0);
signal(k) = bp(k)./peak(k);
trigger = ((1 + (XScEBP.alpha3 / 2)) * ...
    (signal - XScEBP.sigp)) + ...
    ((1 - XScEBP.alpha3) * XScEBP.trigp);
% updates
XScEBP.srcp = src;
XScEBP.hppp = XScEBP.hpp;
XScEBP.hpp = hp;
XScEBP.bppp = XScEBP.bpp;
XScEBP.bpp = bp;
XScEBP.peakp = peak;
XScEBP.sigp = signal;
XScEBP.trigp = trigger;
out(1,:) = signal;
out(2,:) = trigger;
end
