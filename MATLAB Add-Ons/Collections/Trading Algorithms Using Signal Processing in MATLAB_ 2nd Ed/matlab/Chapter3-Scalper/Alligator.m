%{
https://www.tradingview.com/script/WubeYtxk-bill-williams-alligator-fractals-res-sup-combined-by-vlkvr/
study("Bill Williams. Alligator, Fractals & Res-Sup combined", shorttitle="🐲 AlFReSco", overlay=true)

// Alligator
smma(src, length) =>
    smma = 0.0
    smma := na(smma[1]) ? sma(src, length) : (smma[1] * (length - 1) + src) / length
lipsLength  = input(title=" Lips Length", defval=5)
teethLength = input(title=" Teeth Length", defval=8)
jawLength   = input(title=" Jaw Length", defval=13)
lipsOffset  = input(title=" Lips Offset", defval=3)
teethOffset = input(title=" Teeth Offset", defval=5)
jawOffset   = input(title=" Jaw Offset", defval=8)
lips        = smma(hl2, lipsLength)
teeth       = smma(hl2, teethLength)
jaw         = smma(hl2, jawLength)
%}
function out = Alligator(H,L)
src = (H+L)/2;
lipsLength  = 5;
teethLength = 8;
jawLength   = 13;
persistent Xallig
if isempty(Xallig)
    Xallig.sma1p = src;
    Xallig.sma2p = src;
    Xallig.sma3p = src;
end
smma1 = (Xallig.sma1p * (lipsLength - 1) + src) / lipsLength;
smma2 = (Xallig.sma2p * (teethLength - 1) + src) / teethLength;
smma3 = (Xallig.sma3p * (jawLength - 1) + src) / jawLength;
Xallig.sma1p = smma1;
Xallig.sma2p = smma2;
Xallig.sma3p = smma3;
out(1,:) = smma1;
out(2,:) = smma2;
out(3,:) = smma3;
out(4,:) = smma1-smma2;
out(5,:) = smma1-smma3;
end
