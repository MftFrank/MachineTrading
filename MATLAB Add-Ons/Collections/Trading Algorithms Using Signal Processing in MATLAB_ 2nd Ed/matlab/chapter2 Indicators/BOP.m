%{
https://www.tradingview.com/script/tzZx7dTy-Indicator-Balance-Of-Power/
study(title = "Balance of Power [LazyBear]",shorttitle="BOP_LB")
PlotEMA=input(true, "Plot SMA?", type=bool)
PlotOuterLine=input(false, "Plot Outer line?", type=bool )
length=input(14, title="MA length")
BOP=(close - open) / (high - low)
b_color=(BOP>=0 ? (BOP>=BOP[1] ? green : orange) : (BOP>=BOP[1] ? orange : red))
hline(0)
plot(BOP, color=b_color, style=columns, linewidth=3)
plot(PlotOuterLine?BOP:na, color=gray, style=line, linewidth=2)
plot(PlotEMA?sma(BOP, length):na, color=navy, linewidth=2)
%}
function out = BOP(O,H,L,C)
Length = 14;
bop = (C - O)./(H - L);
persistent Xbop
if isempty(Xbop)
    Xbop.win = repmat(bop,Length,1);
end
Xbop.win = [bop;Xbop.win(1:end-1,:)];
smbop = sum(Xbop.win)/Length;
out(1,:) = bop;
out(2,:) = smbop;
end
