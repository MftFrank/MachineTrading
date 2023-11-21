%{
///// EHLERS INSTANTANEOUS TREND INDICATOR /////
Inputs: Price ((H+L)/2), alpha(.07);
Vars: Smooth(0),
iTrend(0),
Trigger(0);

iTrend = (alpha- alpha*alpha/4)*price
+ .5* alpha * alpha * Price[1] -
(alpha - .75 * alpha*alpha) * Price[2] + 2
*(1 - alpha) * iTrend[1] -(1 - alpha)
*(1-alpha)*iTrend[2];
If currentBar < 7 then iTrend = Price + 2*price[1]
+ Price[2]/4;

Trigger = 2*iTrend - iTrend[2];
%}
function out = ITrend(H,L)
Price = (H + L)/2;
alpha = 0.07;
persistent XITrend
if isempty(XITrend)
    XITrend.Pricep = Price;
    XITrend.Pricepp = Price;
    XITrend.iTrendp = Price;
    XITrend.iTrendpp = Price;
end
iTrend = (alpha- alpha*alpha/4)*Price ...
+ .5* alpha * alpha * XITrend.Pricep - ...
(alpha - .75 * alpha*alpha) * XITrend.Pricepp + 2 ...
*(1 - alpha) * XITrend.iTrendp -(1 - alpha) ...
*(1-alpha)*XITrend.iTrendpp;
Trigger = 2*iTrend - XITrend.iTrendpp;
% updates
XITrend.Pricepp = XITrend.Pricep;
XITrend.Pricep = Price;
XITrend.iTrendpp = XITrend.iTrendp;
XITrend.iTrendp = iTrend;
out(1,:) = iTrend;
out(2,:) = Trigger;
end