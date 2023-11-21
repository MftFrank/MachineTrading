%{
study(title="Scalping EMAs", overlay = true)

len1 = input(8, minval=1, title="EMA 1 (8)")
src1 = input(close, title="Source One")
out1 = ema(src1, len1)
plot(out1, title="EMA 1 (8)", color=aqua, transp=40, linewidth=2)

len2 = input(13, minval=1, title="EMA 2 (13)")
src2 = input(close, title="Source Two")
out2 = ema(src2, len2)
plot(out2, title="EMA 2 (13)", color=fuchsia, transp=40, linewidth=2)

len3 = input(21, minval=1, title="EMA 3 (21)")
src3 = input(close, title="Source Three")
out3 = ema(src3, len3)
plot(out3, title="EMA 3 (21)", color=orange, transp=40, linewidth=2)

len4 = input(96, minval=1, title="EMA 4 (96)")
src4 = input(close, title="Source Four")
out4 = ema(src4, len4)
plot(out4, title="EMA 4 (96)", color=yellow, transp=30, linewidth=3)

len5 = input(252, minval=1, title="EMA 5 (252)")
src5 = input(close, title="Source Five")
out5 = ema(src5, len5)
%}
function out = ScalpEMAs(C)
P = C;
len = [8 13 21 96 252];
a = 2./(len+1);
persistent Xsema
if isempty(Xsema)
    Xsema.emap = repmat(P,length(len),1);
end
ema = (P - Xsema.emap).*a' + Xsema.emap;
Xsema.emap = ema;
out = ema;
end
