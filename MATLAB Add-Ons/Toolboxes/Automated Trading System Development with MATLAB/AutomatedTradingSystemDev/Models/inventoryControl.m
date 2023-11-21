function [PBid,PAsk] = inventoryControl(pos,PBid,PAsk)
% Inventory calculation for Bayesian Market Maker

% Copyright 2015 The MathWorks, Inc.

% sigmoidal function
sig = (10*(1+tanh(-3:0.5:3)));
xc= 0:length(sig)-1;

% calculate offset
offset = round(sign(pos)*interp1(xc,sig,abs(pos),'linear',max(sig)))/100;

if pos > 0
    PAsk = PAsk - offset;
    PBid = PBid - offset;
end