%{
https://www.tradingview.com/script/ssL68jQu-Indicator-Chande-s-QStick-Indicator/
study(title = "Tushar Chande's QStick [LazyBear]", 
shorttitle="QStick_LB")
length=input(8)
hline(0)
s2=sma((close-open),length)
c_color=s2 < 0 ? (s2 < s2[1] ? red : lime) : (s2 >= 0 ? (s2 > s2[1] ? lime : red) : na)
%}
function out = TSQstick(O,C)
Length = 8;
close = C;
open = O;
persistent Xtsqs
if isempty(Xtsqs)
    Xtsqs.win = repmat(close-open,Length,1);
end
Xtsqs.win = [close-open;Xtsqs.win(1:end-1,:)];
s2 = sum(Xtsqs.win)/Length;
out = s2;
end
