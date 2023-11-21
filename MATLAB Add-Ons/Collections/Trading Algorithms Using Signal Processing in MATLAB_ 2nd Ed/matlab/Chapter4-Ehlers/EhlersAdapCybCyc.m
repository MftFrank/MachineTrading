%{
{Adaptive Cyber Cycle indicator - //// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers //// code compiled by dn
} // plot on a subgraph separate from the price region

Inputs: Price((H+L)/2), alpha(.07);
Vars: Smooth(0),Cycle(0),Q1(0),I1(0),DeltaPhase(0),MedianDelta(0),DC(0),InstPeriod(0),Period(0),
Length(0),Num(0),Denom(0),alpha1(0),AdaptCycle(0);

Smooth = (Price + 2*Price[1] + 2*Price[2] + Price[3])/6;

Cycle = (1 - .5*alpha)*(1 - .5*alpha)*(Smooth - 2*Smooth[1] + Smooth[2]) + 2*(1-alpha)*Cycle[1] - (1 - alpha)*(1-alpha)*Cycle[2];
If currentbar < 7 then Cycle = (Price - 2*Price[1] + Price[2])/4;
Q1 = (.0962*Cycle + .5769*Cycle[2] - .5769*Cycle[4] - .0962*Cycle[6])*(.5+.08*InstPeriod[1]);
I1 = Cycle[3];
If Q1 <> 0 and Q1[1] <> 0 then DeltaPhase = (I1/Q1 - I1[1]/Q1[1]) / (1 + I1*I1[1]/(Q1*Q1[1]));
If DeltaPhase < 0.1 then DeltaPhase = 0.1;
If DeltaPhase > 1.1 then DeltaPhase = 1.1;
MedianDelta = Median(DeltaPhase,5);
If MedianDelta = 0 then DC = 15 else DC = 6.28318 / MedianDelta + .5;
InstPeriod = .33*DC + .67*Instperiod[1];
Period = .15*InstPeriod + .85*Period[1];

alpha1 = 2/(Period + 1);
AdaptCycle=(1-.5*alpha1)*(1-.5*alpha)*(Smooth-2*Smooth[1]+Smooth[2])+2*(1-alpha1)*AdaptCycle[1]-(1-alpha1)*(1-alpha1)*AdaptCycle[2];
If currentbar <7 then AdaptCycle=(Price-2*Price[1]+Price[2])/4;
Plot1(AdaptCycle,"AdaptCycle",blue);
Plot2(AdaptCycle[1],"Trigger",green);
%}
function out = EhlersAdapCybCyc(H,L)
Price = (H+L)/2;
alpha = 0.07;
b = [1 2 2 1]/6;
bhp = [0.0962 0 0.5769 0 -0.5769 0 0.0962];
persistent XAdapCybCyc
if isempty(XAdapCybCyc)
    XAdapCybCyc.prwin = repmat(Price,length(b),1);
    XAdapCybCyc.cyc1win = repmat(zeros(1,length(H)),length(bhp),1);
    XAdapCybCyc.DelPhase = repmat(0.5*ones(1,length(H)),5,1);
    XAdapCybCyc.smp = Price;
    XAdapCybCyc.smpp = Price;
    XAdapCybCyc.Q1p = ones(1,length(H));
    XAdapCybCyc.I1p = ones(1,length(H));
    XAdapCybCyc.InstPeriodp = 15*ones(1,length(H));
    XAdapCybCyc.Periodp = 15*ones(1,length(H));
    XAdapCybCyc.ACp = zeros(1,length(H));
    XAdapCybCyc.ACpp = zeros(1,length(H));
end
XAdapCybCyc.prwin = [Price;XAdapCybCyc.prwin(1:end-1,:)];
Smooth = sum(b'.*XAdapCybCyc.prwin);
Cycle = (1 - .5*alpha)*(1 - .5*alpha)*...
    (Smooth - 2*XAdapCybCyc.smp + XAdapCybCyc.smpp) ...
    + 2*(1-alpha)*XAdapCybCyc.cyc1win(1,:) - ...
    (1 - alpha)*(1-alpha)*XAdapCybCyc.cyc1win(2,:);
XAdapCybCyc.cyc1win = [Cycle;XAdapCybCyc.cyc1win(1:end-1,:)];
tmp = (.5+.08*XAdapCybCyc.InstPeriodp);
Q1 = sum(bhp'.*XAdapCybCyc.cyc1win.*tmp);
I1 = XAdapCybCyc.cyc1win(3,:);
Q1(Q1==0) = 0.1;
XAdapCybCyc.Q1p(XAdapCybCyc.Q1p==0) = 0.1;
DeltaPhase = (I1./Q1 - XAdapCybCyc.I1p./XAdapCybCyc.Q1p) ./ ...
    (1 + I1.*XAdapCybCyc.I1p./(Q1.*XAdapCybCyc.Q1p));
DeltaPhase(DeltaPhase<0.1) = 0.1;
DeltaPhase(DeltaPhase>1.1) = 1.1;
XAdapCybCyc.DelPhase = [DeltaPhase;XAdapCybCyc.DelPhase(1:end-1,:)];
MedianDelta = median(XAdapCybCyc.DelPhase);
DC(MedianDelta==0) = 15;
DC(MedianDelta~=0) = 6.28318 ./ MedianDelta + .5;
InstPeriod = .33*DC + .67*XAdapCybCyc.InstPeriodp;
Period = .15*InstPeriod + .85*XAdapCybCyc.Periodp;
alpha1 = 2./(Period + 1);
AdaptCycle=(1-.5*alpha1).*(1-.5*alpha1).*...
    (Smooth - 2*XAdapCybCyc.smp + XAdapCybCyc.smpp)+...
    2*(1-alpha1).*XAdapCybCyc.ACp-...
    (1-alpha1).*(1-alpha1).*XAdapCybCyc.ACp;
Trigger = XAdapCybCyc.ACp;
% updates
XAdapCybCyc.smpp = XAdapCybCyc.smp;
XAdapCybCyc.smp = Smooth;
XAdapCybCyc.Q1p = Q1;
XAdapCybCyc.I1p = I1;
XAdapCybCyc.InstPeriodp = InstPeriod;
XAdapCybCyc.Periodp = Period;
XAdapCybCyc.ACpp = XAdapCybCyc.ACp;
XAdapCybCyc.ACp = AdaptCycle;
out(1,:) = Smooth;
out(2,:) = Q1;
out(3,:) = I1;
out(4,:) = InstPeriod;
out(5,:) = Period;
out(6,:) = AdaptCycle;
out(7,:) = Trigger;
end
