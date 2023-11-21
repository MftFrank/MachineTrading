%{
{Cycle Period Measurement from Cybernetic Analysis for Stocks and Futures by John Ehlers - code compiled by dn}
Inputs: Price((H+L)/2), alpha(.07);
Vars: Smooth(0),Cycle(0),Q1(0),I1(0),DeltaPhase(0),MedianDelta(0),DC(0),InstPeriod(0),Period(0),I2(0),Q2(0);
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
Plot1 (Period,"Period",blue);
{This indicator allows the cycle measurement to be determined in very few bars.
It sums the cycle phases until it reaches 360 degrees - a full circle.
The lag in measuring the Dominant Cycle Period is about 8 bars.}
%}
function out = EhlersCycPerMeas(H,L)
Price = (H+L)/2;
alpha = 0.07;
b = [1 2 2 1]/6;
bhp = [0.0962 0 0.5769 0 -0.5769 0 0.0962];
persistent XCycPerMeas
if isempty(XCycPerMeas)
    XCycPerMeas.prwin = repmat(Price,length(b),1);
    XCycPerMeas.cyc1win = repmat(zeros(1,length(H)),length(bhp),1);
    XCycPerMeas.DelPhase = repmat(0.5*ones(1,length(H)),5,1);
    XCycPerMeas.smp = Price;
    XCycPerMeas.smpp = Price;
    XCycPerMeas.Q1p = ones(1,length(H));
    XCycPerMeas.I1p = ones(1,length(H));
    XCycPerMeas.InstPeriodp = 15*ones(1,length(H));
    XCycPerMeas.Periodp = 15*ones(1,length(H));
end
XCycPerMeas.prwin = [Price;XCycPerMeas.prwin(1:end-1,:)];
Smooth = sum(b'.*XCycPerMeas.prwin);
Cycle = (1 - .5*alpha)*(1 - .5*alpha)*...
    (Smooth - 2*XCycPerMeas.smp + XCycPerMeas.smpp) ...
    + 2*(1-alpha)*XCycPerMeas.cyc1win(1,:) - ...
    (1 - alpha)*(1-alpha)*XCycPerMeas.cyc1win(2,:);
XCycPerMeas.cyc1win = [Cycle;XCycPerMeas.cyc1win(1:end-1,:)];
tmp = (.5+.08*XCycPerMeas.InstPeriodp);
Q1 = sum(bhp'.*XCycPerMeas.cyc1win.*tmp);
I1 = XCycPerMeas.cyc1win(3,:);
Q1(Q1==0) = 0.1;
XCycPerMeas.Q1p(XCycPerMeas.Q1p==0) = 0.1;
DeltaPhase = (I1./Q1 - XCycPerMeas.I1p./XCycPerMeas.Q1p) ./ ...
    (1 + I1.*XCycPerMeas.I1p./(Q1.*XCycPerMeas.Q1p));
DeltaPhase(DeltaPhase<0.1) = 0.1;
DeltaPhase(DeltaPhase>1.1) = 1.1;
XCycPerMeas.DelPhase = [DeltaPhase;XCycPerMeas.DelPhase(1:end-1,:)];
MedianDelta = median(XCycPerMeas.DelPhase);
DC(MedianDelta==0) = 15;
DC(MedianDelta~=0) = 6.28318 ./ MedianDelta + .5;
InstPeriod = .33*DC + .67*XCycPerMeas.InstPeriodp;
Period = .15*InstPeriod + .85*XCycPerMeas.Periodp;
% updates
XCycPerMeas.smpp = XCycPerMeas.smp;
XCycPerMeas.smp = Smooth;
XCycPerMeas.Q1p = Q1;
XCycPerMeas.I1p = I1;
XCycPerMeas.InstPeriodp = InstPeriod;
XCycPerMeas.Periodp = Period;
out(1,:) = Smooth;
out(2,:) = Q1;
out(3,:) = I1;
out(4,:) = InstPeriod;
out(5,:) = Period;
end
