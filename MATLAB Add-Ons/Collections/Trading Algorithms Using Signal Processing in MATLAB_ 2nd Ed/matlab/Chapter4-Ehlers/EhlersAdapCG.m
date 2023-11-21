%{
{Adaptive Center of Gravity indicator - 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 
}
Inputs: Price((H+L)/2), alpha(.07);
Vars: Smooth(0),Cycle(0),Q1(0),I1(0),DeltaPhase(0),MedianDelta(0),DC(0),InstPeriod(0),Period(0),
Count(0),Num(0),Denom(0),CG(0),IntPeriod(0);

Smooth = (Price + 2*Price[1] + 2*Price[2] + Price[3])/6;
Cycle=(1-.5*alpha)*(1-.5*alpha)*(Smooth-2*Smooth[1]+Smooth[2])+2*(1-alpha)*Cycle[1]-(1-alpha)*(1-alpha)*Cycle[2];
If currentbar<7 then Cycle = (Price-2*Price[1]+Price[2])/4;
Q1=(.0962*Cycle+.5769*Cycle[2]-.5769*Cycle[4]-.0962*Cycle[6])*(.5+.08*InstPeriod[1]);
I1 = Cycle[3];
If Q1<>0 and Q1[1]<>0 then DeltaPhase=(I1/Q1-I1[1]/Q1[1])/(1+I1*I1[1]/(Q1*Q1[1]));
If DeltaPhase <0.1 then Deltaphase = 0.1;
If DeltaPhase >1.1 then Deltaphase = 1.1;
MedianDelta = Median(DeltaPhase,5);
If MedianDelta = 0 then DC = 15 else DC = 6.28318/MedianDelta + .5;
InstPeriod = .33*DC + .67*InstPeriod[1];
Value1 = .15*InstPeriod + .85*Value1[1];
IntPeriod = intportion(Value1/2);
Num = 0;
Denom = 0;
For Count = 0 to IntPeriod - 1 begin
Num = Num + (1+Count)*(Price[count]);
Denom = Denom + (Price[count]); End;
If Denom <> 0 then CG = -Num/Denom + (IntPeriod + 1)/2;
Plot2(CG[1],"Trigger",green);
%}
function out = EhlersAdapCG(H,L)
Price = (H+L)/2;
alpha = 0.07;
b = [1 2 2 1]/6;
bhp = [0.0962 0 0.5769 0 -0.5769 0 0.0962];
persistent XAdapCG
if isempty(XAdapCG)
    XAdapCG.prwin = repmat(Price,50,1);
    XAdapCG.cyc1win = repmat(zeros(1,length(H)),length(bhp),1);
    XAdapCG.DelPhase = repmat(0.5*ones(1,length(H)),5,1);
    XAdapCG.smp = Price;
    XAdapCG.smpp = Price;
    XAdapCG.Q1p = ones(1,length(H));
    XAdapCG.I1p = ones(1,length(H));
    XAdapCG.InstPeriodp = 15*ones(1,length(H));
    XAdapCG.Val1p = 15*ones(1,length(H));
    XAdapCG.CGp = 15*ones(1,length(H));
end
XAdapCG.prwin = [Price;XAdapCG.prwin(1:end-1,:)];
Smooth = sum(b'.*XAdapCG.prwin(1:length(b),:));
Cycle = (1 - .5*alpha)*(1 - .5*alpha)*...
    (Smooth - 2*XAdapCG.smp + XAdapCG.smpp) ...
    + 2*(1-alpha)*XAdapCG.cyc1win(1,:) - ...
    (1 - alpha)*(1-alpha)*XAdapCG.cyc1win(2,:);
XAdapCG.cyc1win = [Cycle;XAdapCG.cyc1win(1:end-1,:)];
tmp = (.5+.08*XAdapCG.InstPeriodp);
Q1 = sum(bhp'.*XAdapCG.cyc1win.*tmp);
I1 = XAdapCG.cyc1win(3,:);
Q1(Q1==0) = 0.1;
XAdapCG.Q1p(XAdapCG.Q1p==0) = 0.1;
DeltaPhase = (I1./Q1 - XAdapCG.I1p./XAdapCG.Q1p) ./ ...
    (1 + I1.*XAdapCG.I1p./(Q1.*XAdapCG.Q1p));
DeltaPhase(DeltaPhase<0.1) = 0.1;
DeltaPhase(DeltaPhase>1.1) = 1.1;
XAdapCG.DelPhase = [DeltaPhase;XAdapCG.DelPhase(1:end-1,:)];
MedianDelta = median(XAdapCG.DelPhase);
DC(MedianDelta==0) = 15;
DC(MedianDelta~=0) = 6.28318 ./ MedianDelta + .5;
InstPeriod = .33*DC + .67*XAdapCG.InstPeriodp;
Value1 = .15*InstPeriod + .85*XAdapCG.Val1p;
IntPeriod = floor(Value1/2);
Num = zeros(1,length(H));
Denom = ones(1,length(H));
for count = 1:IntPeriod
    Num = Num + (0+count)*XAdapCG.prwin(count,:);
    Denom = Denom + XAdapCG.prwin(count,:);
end
CG(Denom~=0) = -Num./Denom + (IntPeriod + 1)/2;
Trigger = XAdapCG.CGp;
% updates
XAdapCG.smpp = XAdapCG.smp;
XAdapCG.smp = Smooth;
XAdapCG.Q1p = Q1;
XAdapCG.I1p = I1;
XAdapCG.InstPeriodp = InstPeriod;
XAdapCG.Val1p = Value1;
XAdapCG.CGp = CG;
out(1,:) = Smooth;
out(2,:) = Q1;
out(3,:) = I1;
out(4,:) = InstPeriod;
out(5,:) = CG;
out(6,:) = Trigger;
end
