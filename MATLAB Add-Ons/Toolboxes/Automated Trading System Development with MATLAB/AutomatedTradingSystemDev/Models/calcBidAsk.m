function [PBid,PAsk] = calcBidAsk(V,P,alpha)
% Bid/Ask calculation for Bayesian Market Maker

% Copyright 2015 The MathWorks, Inc.

N = length(V);

% Expected value, rounded to nearest cent
E = round(sum(V.*P)*100)/100;
Pinfo = 0.5+0.5*alpha;


% Find where E is in V
bidError = zeros(N,1);
PBid = zeros(N,1);
for i = 1:N 
    % from Vmin to V=E 
    [PBid(i), bidError(i)] = bidCalc(i,V,P,Pinfo);
end
[minerr,ind] = min(bidError);
PBid = min(V(ind),E);

askError = zeros(N,1);
PAsk = zeros(N,1);
% loop over all values of V from E to Vmax
for i = 1:N
    % from V=E to Vmax
    [PAsk(i), askError(i)] = askCalc(i,V,P,Pinfo);
end
[minerr,ind] = min(askError);
PAsk = max(V(ind), E);

%% Bid Calculation
function [PBid,bidError] = bidCalc(count,V,P,Pinfo)
N = length(V);
a = 0;
b = 0;
for i =1:count
    a = a + V(i)*P(i);
end

for i = count+1:N
    b = b + V(i)*P(i);
end
PBid = 2*(Pinfo*a + (1-Pinfo)*b);
bidError = abs(V(count) - PBid);

%% Ask Calculation
function [PAsk, AskError] = askCalc(count,V,P,Pinfo)
N = length(V);
a  =0;
b = 0;
for i = 1:count-1
    a = a  +V(i)*P(i);
end

for i = count:N
    b = b + V(i)*P(i);
end
PAsk = 2*((1-Pinfo)*a + Pinfo*b);
AskError = abs(V(count) - PAsk);





    
