function P = Probability(price,trade,alpha,P,V)
% Probablity calculation for Bayesian Market Maker

% Copyright 2015 The MathWorks, Inc.
Pold = P;
Pinfo = 0.5 + 0.5*alpha;

if trade < 0
    % sell order received        
    for i = 1:length(V)
        if V(i) < price
            P(i) = Pold(i) * Pinfo;
        else
            P(i) = Pold(i) * (1-Pinfo);
        end
    end
elseif trade > 0
    % buy order received 
    for i = 1:length(V)
        if V(i) > price
            P(i) = Pold(i) * Pinfo;
        else
            P(i) = Pold(i) * (1-Pinfo);
        end
    end
end

P = P/sum(P);