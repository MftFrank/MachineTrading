%{
https://www.tradingview.com/script/0t5z9xe2-Indicator-Bears-Bulls-power/
study(title = "Bears/Bulls [LazyBear]", shorttitle="BearsBulls_LB")
length=input(13)
src=close

s_ma = sma(src, length)
s_bulls = high - s_ma
s_bears = low - s_ma
%}
function out = BearsBulls(H,L,C)
src = C;
high = H;
low = L;
Length = 13;
persistent Xbebull
if isempty(Xbebull)
    Xbebull.srcwin = repmat(src,Length,1);
end
Xbebull.srcwin = [src;Xbebull.srcwin(1:end-1,:)];
s_ma = sum(Xbebull.srcwin)/Length;
s_bulls = high - s_ma;
s_bears = low - s_ma;
out(1,:) = s_ma;
out(2,:) = s_bulls;
out(3,:) = s_bears;
end
