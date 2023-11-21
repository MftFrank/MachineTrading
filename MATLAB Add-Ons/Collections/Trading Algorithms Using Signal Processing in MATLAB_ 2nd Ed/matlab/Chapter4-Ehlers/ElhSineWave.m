%{
{Sine Wave indicator - //// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers //// code compiled by dn
} // plot on a subgraph separate from the price region.

Inputs: Price((H+L)/2), alpha(.07);

Vars: Smooth(0),Cycle(0),I1(0),Q1(0),I2(0),Q2(0),DeltaPhase(0),MedianDelta(0),MaxAmp(0),AmpFix(0),Re(0),Im(0),DC(0),
alpha1(0),InstPeriod(0),DCPeriod(0),count(0),SmoothCycle(0),RealPart(0),ImagPart(0),DCPhase(0);

Smooth = (Price+2*Price[1]+2*Price[2]+Price[3])/6;
Cycle = (1-.5*alpha)*(1-.5*alpha)*(Smooth-2*Smooth[1]+Smooth[2])+2*(1-alpha)*Cycle[1]-(1-alpha)*(1-alpha)*Cycle[2];
If CurrentBar <7 then Cycle=(Price-2*Price[1]+Price[2])/4;
Q1=(.0962*Cycle+.5769*Cycle[2]-.5769*Cycle[4]-.0962*Cycle[6])*(.5+.08*InstPeriod[1]);
I1 = Cycle[3];
If Q1<>0 and Q1[1]<>0 then DeltaPhase=(I1/Q1-I1[1]/Q1[1])/(1+I1*I1[1]/(Q1*Q1[1]));
If DeltaPhase <0.1 then DeltaPhase=0.1;
If DeltaPhase > 1.1 then DeltaPhase = 1.1;
MedianDelta = Median(DeltaPhase,5);
If MedianDelta =0 then DC=15 else DC=6.28318/MedianDelta+.5;
InstPeriod=.33*DC+.67*InstPeriod[1];
Value1 = .15*InstPeriod+.85*Value1[1];
DCPeriod = IntPortion(Value1);
RealPart = 0;
ImagPart = 0;
For count = 0 To DCPeriod - 1 begin
RealPart = RealPart + Sine(360 * count / DCPeriod) * (Cycle[count]);
ImagPart = ImagPart + Cosine(360 * count / DCPeriod) * (Cycle[count]);
End;
If AbsValue(ImagPart) > 0.001 then DCPhase = Arctangent(RealPart / ImagPart);
If AbsValue(ImagPart) <= 0.001 then DCPhase = 90 * Sign(RealPart);

DCPhase = DCPhase + 90;
If ImagPart < 0 then DCPhase = DCPhase + 180;
If DCPhase > 315 then DCPhase = DCPhase - 360;

Plot1(Sine(DCPhase), "Sine",blue);
Plot2(Sine(DCPhase + 45), "LeadSine",green);

{Note: This indicator tries to determine the current phase of the cycles you are in. A sinewave indicator has an advantage over
other oscillators such as RSI and Stochastic because it predicts rather than waits for confirmation. This assumes that the measured
phase has existed at least briefly in the past and will continue at least briefly into the future.
The phase languishes when the market is in a trend mode, and can even have a negative rate of change.
This indicator gives entry and exit signals 1/16th of a cycle period in advance of the cycle turning point
and seldom gives false whipsaw signals when the market is in a trend mode.}
%}
function out = ElhSineWave(H,L)
persistent XehlSW
bhp = [0.0962 0 0.5769 0 -0.5769 0 -0.0962];
bs = [1 2 2 1]/6;
tp = (H+L)/2;
alpha = 0.07;
if isempty(XehlSW)
    XehlSW.prwin = repmat(tp,7,1);
    XehlSW.ITrendwin = repmat(tp,7,1);
    XehlSW.smwin = repmat(tp,7,1);
    XehlSW.smPricewin = repmat(tp,50,1);
    XehlSW.Pricewin = repmat(tp,50,1);
    XehlSW.cycwin = zeros(70,length(H));
    XehlSW.DelPhasewin = ones(5,length(H));
    XehlSW.I1win = zeros(7,length(H));
    XehlSW.Q1win = zeros(7,length(H));
    XehlSW.smp = tp;
    XehlSW.smpp = tp;
    XehlSW.cycp = 0*tp;
    XehlSW.cycpp = 0*tp;
    XehlSW.I1p = ones(1,length(H));
    XehlSW.Q1p = ones(1,length(H));
    XehlSW.I2p = ones(1,length(H));
    XehlSW.Q2p = ones(1,length(H));
    XehlSW.Rep = ones(1,length(H));
    XehlSW.Imp = ones(1,length(H));
    XehlSW.InstPeriodp = 15*ones(1,length(H));
    XehlSW.Val1p = 15*ones(1,length(H));
    XehlSW.Periodp = 15*ones(1,length(H));
    XehlSW.smPeriodp = 15*ones(1,length(H));
    XehlSW.Value1p = 15*ones(1,length(H));
    XehlSW.DCPhasep = 1*ones(1,length(H));
end
XehlSW.prwin = [tp;XehlSW.prwin(1:end-1,:)];
smooth = sum(bs'.*XehlSW.prwin(1:4,:));
Cycle = (1-.5*alpha)*(1-.5*alpha)*...
    (smooth-2*XehlSW.smp+XehlSW.smpp)+...
    2*(1-alpha)*XehlSW.cycp-...
    (1-alpha)*(1-alpha)*XehlSW.cycpp;
XehlSW.smwin = [smooth;XehlSW.smwin(1:end-1,:)];
tmp = 0.5+ 0.08*XehlSW.InstPeriodp;
XehlSW.cycwin = [Cycle;XehlSW.cycwin(1:end-1,:)];
Q1 = sum(bhp'.*XehlSW.cycwin(1:length(bhp),:).*tmp);
I1 = XehlSW.cycwin(4,:);
Q1(Q1==0) = 1;
XehlSW.Q1p(XehlSW.Q1p==0) = 1;
DeltaPhase=(I1./Q1-XehlSW.I1p./XehlSW.Q1p)./...
    (1+I1.*XehlSW.I1p./(Q1.*XehlSW.Q1p));
DeltaPhase = max(0.1*ones(1,length(H)),DeltaPhase);
DeltaPhase = min(1.1*ones(1,length(H)),DeltaPhase);
XehlSW.DelPhasewin = [DeltaPhase;XehlSW.DelPhasewin(1:end-1,:)];
MedianDelta = median(XehlSW.DelPhasewin);
DC = 2*pi./MedianDelta + 0.5;
DC(MedianDelta==0) = 15;
InstPeriod=.33*DC+.67*XehlSW.InstPeriodp;
Value1 = 0.15*InstPeriod + 0.85*XehlSW.Val1p;
DCPeriod = floor(Value1);
RealPart = zeros(1,length(H));
ImagPart = zeros(1,length(H));
for count = 1:max(DCPeriod)
    RealPart = RealPart + ...
        sin(2*pi * count ./ DCPeriod).*XehlSW.cycwin(count,:);
    ImagPart = ImagPart + ...
        cos(2*pi * count ./ DCPeriod).*XehlSW.cycwin(count,:);
end
idxIPlarge = find(abs(ImagPart)>0.001);
idxIPsmall = find(abs(ImagPart)<=0.001);
DCPHase(idxIPlarge) = ...
    atan(RealPart(idxIPlarge) ./ ImagPart(idxIPlarge));
DCPHase(idxIPsmall) = pi/2*sign(RealPart(idxIPsmall));
DCPHase = DCPHase + pi/2;
idxIP_0 = find(ImagPart<0.0);
idxIP_315 = find(DCPHase>315/180*pi);
DCPHase(idxIP_0) = DCPHase(idxIP_0) + pi;
DCPHase(idxIP_315) = DCPHase(idxIP_315) - 2*pi;
Sine = sin(DCPHase);
LeadSine = sin(DCPHase+pi/4);

% updates
XehlSW.cycpp = XehlSW.cycp;
XehlSW.cycp = Cycle;
XehlSW.smpp = XehlSW.smp;
XehlSW.smp = smooth;
XehlSW.InstPeriodp = InstPeriod;
XehlSW.Val1p = Value1;
XehlSW.I1p = I1;
XehlSW.Q1p = Q1;
XehlSW.DCPhasep = DCPHase;

out(1,:) = smooth;
out(2,:) = Cycle;
out(3,:) = Sine;
out(4,:) = LeadSine;
out(5,:) = DeltaPhase;
out(6,:) = DC;
out(7,:) = DCPHase;
end
