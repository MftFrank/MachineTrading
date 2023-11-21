%{
https://www.tradingview.com/script/gjR35HwQ-ADD-for-SPX-intraday-NYSE-Adv-Decl-Tom1trader/
// This is the NYSE Advancers - decliners which the SPX pretty much has to follow. The level gives an idea of days move
//  but I follow the direction as when more advance (green) or decline (red) the index tends to track it pretty closely.

// On SPX and correlateds - very useful for intr-day trading (Scalping or 0DTE option trades) but not for higher time fromes at all.

// I left it at 5 minutes timeframe which displays well on any intraday chart. You can change it by changing the "5" in the security
//  function on line 13 to what you want or change it to timeframe.period (no quotes). 5 min displays better on higher i.e. 15min.

//@version=4
study("ADD", overlay=false)
a = security("USI:ADD", "5", hlc3)

dircol = a>a[1] ? color.green : color.red
plot(a, title="ADD", color=dircol, linewidth=4)
m10 = sma(a, 10)
plot(m10, color=color.black, linewidth=2)
%}
function out = ScalpADD(H,L,C)
a = (H+L+C)/3;
persistent Xscadd
if isempty(Xscadd)
    Xscadd.awin = repmat(a,10,1);
end
Xscadd.awin = [a;Xscadd.awin(1:end-1,:)];
m10 = sum(Xscadd.awin)/10;
out(1,:) = m10;
out(2,:) = a-m10;
end
