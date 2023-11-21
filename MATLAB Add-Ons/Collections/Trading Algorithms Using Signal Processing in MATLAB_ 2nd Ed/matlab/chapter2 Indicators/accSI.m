%{
https://www.tradingview.com/script/ezHLOxrK-Indicators-AccSwingIndex-ASI-Oscillator-and-RangeExpansionInde/
study("Accumulation Swing Index [LazyBear]", shorttitle="ASI_LB")
limit = input(30, "Limit")
lengthMA=input(8, "SMA Length")
showMA=input(true, type=bool)

swingindex( limit ) =>
    r1 = abs( high - close[1] )
    r2 = abs( low - close[1] )
    r3 = abs( high - low )
    r4 = abs( close[1] - open[1] )
    k = max( r1, r2 )
    r = iff( r1 >= max( r2, r3 ), r1 - r2/2 + r4/4,
        iff( r2 >= max( r1, r3 ), r2 - r1/2 + r4/4,
            r3 + r4/4 ) )
    iff( r == 0, 0, 50 * ( ( close - close[1] + 0.5 * ( close - open ) + 0.25 * ( close[1] - open[1] ) ) / r ) * k/limit )

calc_asi( limit ) => 
    cum( swingindex( limit ) )

asi=calc_asi( limit )
s=sma(asi,lengthMA)
%}
function out = accSI(O,H,L,C)
open = O;high = H;low = L;close = C;
limit = 30;
lengthMA = 8;
Z = zeros(1,length(high));
persistent XaccSI
if isempty(XaccSI)
    XaccSI.Cp = close;
    XaccSI.Op = open;
    XaccSI.asiwin = repmat(Z,lengthMA,1);
    XaccSI.SIp = Z;
end
r1 = abs( high - XaccSI.Cp );
r2 = abs( low - XaccSI.Cp );
r3 = abs( high - low );
r4 = abs( XaccSI.Cp - XaccSI.Op );
k = max( r1, r2 );
tmp = r3 + r4/4;
m = find(r2 >= max( r1, r3 ));
tmp(m) = r2(m) - r1(m)/2 + r4(m)/4;
r = tmp;
m = find(r1 >= max( r2, r3 ));
r(m) = r1(m) - r2(m)/2 + r4(m)/4;
SI = 50 * ( ( close - XaccSI.Cp + 0.5 * ( close - open ) + ...
    0.25 * ( XaccSI.Cp - XaccSI.Op ) ) ./ r ) .* k/limit;
asi = XaccSI.SIp + SI;
XaccSI.asiwin = [asi;XaccSI.asiwin(1:end-1,:)];
s = sum(XaccSI.asiwin)/lengthMA;
XaccSI.Cp = close;
XaccSI.Op = open;
XaccSI.SIp = asi;
out(1,:) = asi;
out(2,:) = s;
out(3,:) = asi - s;
end
