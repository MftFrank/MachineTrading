%{
Volume Weighted Average Price (VWAP) is
VWAP is calculated by adding up the dollars traded 
for every transaction (price multiplied by the number 
of shares traded) and then dividing by the total shares traded.
The volume weighted average price (VWAP) appears as a 
single line on intraday charts (1 minute, 15 minute, 
and so on), similar to how a moving average looks.
To calculate the VWAP yourself, follow these steps. 
Assume a 5-minute chart; the calculation is same 
regardless of what intraday time frame is used.


Find the average price the stock traded at over the first 
five-minute period of the day. To do this, add the high, 
low, and close, then divide by three. Multiply this by 
the volume for that period. Record the result in a 
spreadsheet, under column PV.
Divide PV by the volume for that period. This will give 
the VWAP value.
To maintain the VWAP value throughout the day, continue 
to add the PV value from each period to the prior values. 
Divide this total by total volume up to that point. 
To make this easier in a spreadsheet, create columns 
for cumulative PV and cumulative volume. Both these 
cumulative values are divided by each other to produce VWAP.
%}
function out = VWAP(H,L,C,V)
Price = (H+L+C)/3;
Len = 14;
persistent Xvwap
if isempty(Xvwap)
    Xvwap.vwapwin = repmat(Price.*V,Len,1);
    Xvwap.volwin = repmat(V,Len,1);
end
Xvwap.vwapwin = [Price.*V;Xvwap.vwapwin(1:end-1,:)];
Xvwap.volwin = [V;Xvwap.volwin(1:end-1,:)];
vwa = sum(Xvwap.vwapwin);
vol = sum(Xvwap.volwin);
vwap = vwa./vol;
out(1,:) = vwap;
end
