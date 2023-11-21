%{
{Adaptive RVI indicator - //// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers //// code compiled by dn
} // plot on a subgraph separate from the price region

Inputs: Price((H+L)/2), alpha(.07);
Vars: Smooth(0),Cycle(0),Q1(0),I1(0),DeltaPhase(0),MedianDelta(0),DC(0),InstPeriod(0),Period(0),
Count(0),Length(0),Num(0),Denom(0),RVI(0),MaxRVI(0),MinRVI(0);

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
Period = .15*InstPeriod+.85*Period[1];
Length = intportion((4*Period+3*Period[1]+2*Period[3]+Period[4])/20);
Value1=((Close-Open)+2*(Close[1]-Open[1])+2*(Close[2]-Open[2])+(Close[3]-Open[3]))/6;
Value2=((High-Low)+2*(High[1]-Low[1])+2*(High[2]-Low[2])+(High[3]-Low[3]))/6;
Num = 0;
Denom = 0;
For Count = 0 to Length - 1 begin
Num = Num + Value1[count];
Denom = Denom + Value2[count]; End;
If Denom <> 0 then RVI = Num/Denom;
Plot1(RVI,"RVI",blue);
Plot2(RVI[1],"Trigger",green);
%}
function out = EhlersAdapRVI(C,O,H,L)
Price = (H+L)/2;
alpha = 0.07;
b = [1 2 2 1]/6;
b20 = [4 3 2 1]/20;
bhp = [0.0962 0 0.5769 0 -0.5769 0 0.0962];
persistent XAdapRVI
if isempty(XAdapRVI)
    XAdapRVI.prwin = repmat(Price,50,1);
    XAdapRVI.cyc1win = repmat(zeros(1,length(H)),length(bhp),1);
    XAdapRVI.DelPhase = repmat(0.5*ones(1,length(H)),5,1);
    XAdapRVI.smp = Price;
    XAdapRVI.smpp = Price;
    XAdapRVI.Q1p = ones(1,length(H));
    XAdapRVI.I1p = ones(1,length(H));
    XAdapRVI.InstPeriodp = 15*ones(1,length(H));
    XAdapRVI.Periodwin = repmat(15*ones(1,length(H)),length(b20),1);
    XAdapRVI.Val1p = 15*ones(1,length(H));
    XAdapRVI.RVIp = 0*ones(1,length(H));
    XAdapRVI.cowin = repmat(C-O,length(b),1);
    XAdapRVI.hlwin = repmat(H-L,length(b),1);
    XAdapRVI.Val1win = repmat(C-O,50,1);
    XAdapRVI.Val2win = repmat(H-L,50,1);
end
XAdapRVI.prwin = [Price;XAdapRVI.prwin(1:end-1,:)];
XAdapRVI.cowin = [C-O;XAdapRVI.cowin(1:end-1,:)];
XAdapRVI.hlwin = [H-L;XAdapRVI.hlwin(1:end-1,:)];
Smooth = sum(b'.*XAdapRVI.prwin(1:length(b),:));
Cycle = (1 - .5*alpha)*(1 - .5*alpha)*...
    (Smooth - 2*XAdapRVI.smp + XAdapRVI.smpp) ...
    + 2*(1-alpha)*XAdapRVI.cyc1win(1,:) - ...
    (1 - alpha)*(1-alpha)*XAdapRVI.cyc1win(2,:);
XAdapRVI.cyc1win = [Cycle;XAdapRVI.cyc1win(1:end-1,:)];
tmp = (.5+.08*XAdapRVI.InstPeriodp);
Q1 = sum(bhp'.*XAdapRVI.cyc1win.*tmp);
I1 = XAdapRVI.cyc1win(3,:);
Q1(Q1==0) = 0.1;
XAdapRVI.Q1p(XAdapRVI.Q1p==0) = 0.1;
DeltaPhase = (I1./Q1 - XAdapRVI.I1p./XAdapRVI.Q1p) ./ ...
    (1 + I1.*XAdapRVI.I1p./(Q1.*XAdapRVI.Q1p));
DeltaPhase(DeltaPhase<0.1) = 0.1;
DeltaPhase(DeltaPhase>1.1) = 1.1;
XAdapRVI.DelPhase = [DeltaPhase;XAdapRVI.DelPhase(1:end-1,:)];
MedianDelta = median(XAdapRVI.DelPhase);
DC(MedianDelta==0) = 15;
DC(MedianDelta~=0) = 6.28318 ./ MedianDelta + .5;
InstPeriod = .33*DC + .67*XAdapRVI.InstPeriodp;
Period = .15*InstPeriod+.85*XAdapRVI.Periodwin(1,:);
XAdapRVI.Periodwin = [Period;XAdapRVI.Periodwin(1:end-1,:)];
Length = floor(sum(b20'.*XAdapRVI.Periodwin));
Value1 = sum(b'.*XAdapRVI.cowin);
Value2 = sum(b'.*XAdapRVI.hlwin);
XAdapRVI.Val1win = [Value1;XAdapRVI.Val1win(1:end-1,:)];
XAdapRVI.Val2win = [Value2;XAdapRVI.Val2win(1:end-1,:)];

Num = zeros(1,length(H));
Denom = ones(1,length(H));
for count = 1:Length
    Num = Num + (0+count)*XAdapRVI.Val1win(count,:);
    Denom = Denom + XAdapRVI.Val2win(count,:);
end
RVI(Denom~=0) = -Num./Denom;
Trigger = XAdapRVI.RVIp;
% updates
XAdapRVI.smpp = XAdapRVI.smp;
XAdapRVI.smp = Smooth;
XAdapRVI.Q1p = Q1;
XAdapRVI.I1p = I1;
XAdapRVI.InstPeriodp = InstPeriod;
XAdapRVI.Val1p = Value1;
XAdapRVI.RVIp = RVI;
out(1,:) = Smooth;
out(2,:) = Q1;
out(3,:) = I1;
out(4,:) = InstPeriod;
out(5,:) = RVI;
out(6,:) = Trigger;
end
