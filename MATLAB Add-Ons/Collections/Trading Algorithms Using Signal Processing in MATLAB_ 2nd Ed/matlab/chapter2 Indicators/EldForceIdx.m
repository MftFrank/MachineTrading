%{
https://pastebin.com/aUEGnLqC
study(title="Elder's Force Index [LazyBear]", shorttitle="EFI_LB")
length = input(13, minval=1)
lengthMA=input(8)
efi = sma(change(close) * volume, length)
s=sma(efi, lengthMA)
 
hline(0, title="Zero")
plot(efi, color=green, title="EFI", linewidth=2)
plot(s, color=orange)
 
// Draw BB on indices
BBEnabled=input(false,title="BB Enabled?", type=bool)
mult=input(2.5)
length_bb=input(20, title="BB Length")
HighlightBreaches=input(false, type=bool)
 
bb_s = s
basis = sma(bb_s, length)
dev = (mult * stdev(bb_s, length))
upper = (basis + dev)
lower = (basis - dev)
%}
function out = EldForceIdx(C,V)
close = C;volume = V;
Length = 13;
lengthMA = 8;
mult = 2.5;
Z = zeros(1,length(close));
persistent Xefi
if isempty(Xefi)
    Xefi.Cp = close;
    Xefi.smawin = repmat(Z,Length,1);
    Xefi.volwin = repmat(volume,Length,1);
    Xefi.efiwin = repmat(Z,lengthMA,1);
    Xefi.bbswin = repmat(Z,Length,1);
end
Xefi.smawin = [(close-Xefi.Cp).*volume;Xefi.smawin(1:end-1,:)];
Xefi.volwin = [volume;Xefi.volwin(1:end-1,:)];
volavg = sum(Xefi.volwin)/Length;
efi = sum(Xefi.smawin)/Length./volavg;
Xefi.efiwin = [efi;Xefi.efiwin(1:end-1,:)];
s = sum(Xefi.efiwin)/lengthMA;
bb_s = s;
Xefi.bbswin = [bb_s;Xefi.bbswin(1:end-1,:)];
basis = sum(Xefi.bbswin)/Length;
dev = (mult * std(Xefi.bbswin));
upper = (basis + dev);
lower = (basis - dev);
Xefi.Cp = close;
out(1,:) = efi;
out(2,:) = s;
out(3,:) = basis;
out(4,:) = upper;
out(5,:) = lower;
end
