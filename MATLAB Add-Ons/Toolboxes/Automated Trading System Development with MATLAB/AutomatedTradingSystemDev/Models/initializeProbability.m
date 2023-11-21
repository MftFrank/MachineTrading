function [P,V] = initializeProbability(P0,sigma)
%% Create a distribution of prices centered around P0

% Copyright 2015 The MathWorks, Inc.
if nargin == 0
    P0 = 28.5850;
    sigma = 0.13;
end

% vector of prices
%V = ( (P0-6*sigma):0.01:(P0+6*sigma) )';
V = (27.9:0.01:29)';

% normal distribution centered around P0
nd = (1/(sigma*sqrt(2*pi)))*exp(-(V-P0).^2/(2*sigma^2));
nd = nd/sum(nd);
P = nd;