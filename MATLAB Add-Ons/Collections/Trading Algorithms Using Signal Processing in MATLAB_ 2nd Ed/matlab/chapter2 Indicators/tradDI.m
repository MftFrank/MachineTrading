%{
https://www.tradingview.com/script/sQKGbRRi-Indicators-Traders-Dynamic-Index-HLCTrends-and-Trix-Ribbon/
study("Traders Dynamic Index [LazyBear]", shorttitle="TDI_LB")
lengthrsi=input(13)
src=close
lengthband=input(34)
lengthrsipl=input(2)
lengthtradesl=input(7)

r=rsi(src, lengthrsi)
ma=sma(r,lengthband)
offs=(1.6185 * stdev(r, lengthband))
up=ma+offs
dn=ma-offs
mid=(up+dn)/2
mab=sma(r, lengthrsipl)
mbb=sma(r, lengthtradesl)
%}
function out = tradDI(C)
src = C;
lengthrsi = 13;
lengthband = 34;
lengthrsipl = 2;
lengthtradesl = 7;
Z = zeros(1,length(src));
persistent XtDI
if isempty(XtDI)
    XtDI.rsiwin = repmat(Z,lengthrsi,1);
    XtDI.rwin = repmat(Z,lengthband,1);
    XtDI.Cp = src;
    XtDI.avgUp = Z;
    XtDI.avgDp = Z;
end
XtDI.rsiwin = [src-XtDI.Cp;XtDI.rsiwin(1:end-1,:)];
% rsi calcs
tmpU = XtDI.rsiwin;
tmpU(tmpU<0)=0;
tmpD = XtDI.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (avgU-XtDI.avgUp)/lengthrsi + XtDI.avgUp;
emaavgD = (avgD-XtDI.avgDp)/lengthrsi + XtDI.avgDp;
tmp = emaavgD;
tmp(tmp==0) = 1;
rs = emaavgU./tmp;
r = 100 - (100 ./ (1 + rs));
XtDI.rwin = [r;XtDI.rwin(1:end-1,:)];
ma = sum(XtDI.rwin)/lengthband;
offs = (1.6185 * std(XtDI.rwin));
up = ma+offs;
dn = ma-offs;
mid = (up+dn)/2;
mab = sum(XtDI.rwin(1:lengthrsipl,:))/lengthrsipl;
mbab = sum(XtDI.rwin(1:lengthtradesl,:))/lengthtradesl;
XtDI.Cp = src;
XtDI.avgUp = emaavgU;
XtDI.avgDp = emaavgD;
out(1,:) = r;
out(2,:) = ma;
out(3,:) = up;
out(4,:) = dn;
out(5,:) = mid;
out(6,:) = mab;
out(7,:) = mbab;
end
