%{
Ultimate Oscillator = 100 x [(4 x Average7) + (2 x Average14) + Average28] 
    / (4 + 2 + 1)
Buying Pressure (BP) = Current Close – Minimum (Current Low or Previous Close).
True Range (TR) = Maximum (Current High or Previous Close) – 
    Minimum (Current Low or Previous Close)
Average7 = Sum of BP for the past 7 days / Sum of TR for the past 7 days
Average14 = Sum of BP for the past 14 days / Sum of TR for the past 14 days
Average28 = Sum of BP for the past 28 days / Sum of TR for the past 28 days
%}
function out = UltOscLB(cl,hi,lo)
persistent XUO
len7 = 7;
len14 = 14;
len28 = 28;
if isempty(XUO)
    XUO.winbp = ones(len28,length(cl));
    XUO.wintr = ones(len28,length(cl));
    XUO.clp = cl;
end
high_ = max(hi,XUO.clp);
low_ = min(lo,XUO.clp);
bp = cl - low_;
tr_ = high_ - low_;
XUO.winbp = [bp;XUO.winbp(1:end-1,:)];
XUO.wintr = [tr_;XUO.wintr(1:end-1,:)];
avg7 = sum(XUO.winbp(1:len7,:))./sum(XUO.wintr(1:len7,:));
avg14 = sum(XUO.winbp(1:len14,:))./sum(XUO.wintr(1:len14,:));
avg28 = sum(XUO.winbp(1:len28,:))./sum(XUO.wintr(1:len28,:));
out = 100*(4*avg7 + 2*avg14 + avg28)/7;
XUO.clp = cl;
end