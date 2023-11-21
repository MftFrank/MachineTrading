%{
Ehlers - Rocket Science for Traders
Sinewave Indicator (Figure 9.3)

Inputs:
Price((H+L)/2);

If CurrentBar > 5 Then Begin
Smooth = (4*Price + 3*Price[1] + 2*Price[2] + Price[3]) / 10;
Detrender = (.0962*Smooth + .5769*Smooth[2] - .5769*Smooth[4]
- .0962*Smooth[6])*(.075*Period[1] + .54);

{Compute InPhase and Quadrature components}
Q1 = (.0962*Detrender + .5769*Detrender[2] - .5769*Detrender[4]
- .0962*Detrender[6])*(.075*Period[1] + .54);
I1 = Detrender[3];

{Advance the phase of I1 and Q1 by 90 degrees}
jI = (.0962*I1 + .5769*I1[2] - .5769*I1[4] - .0962*I1[6])*(.075*Period[1] + .54);
JQ = (.0962*Q1 + .5769*Q1[2] - .5769*Q1[4] - .0962*Q1[6])*(.075*Period[1] + .54);

{Phasor addition for 3 bar averaging}
I2 = I1 - JQ;
Q2 = Q1 + jI;

{Smooth the I and Q components before applying the discriminator}
I2 = .2*I2 + .8*I2[1];
Q2 = .2*Q2 + .8*Q2[1];

{Homodyne Discriminator}
Re = I2*I2[1] + Q2*Q2[1];
Im = I2*Q2[1] - Q2*I2[1];
Re = .2*Re + .8*Re[1];
Im = .2*Im + .8*Im[1];

If Im <> 0 And Re <> 0 Then Period = 360/ArcTangent(Im/Re);
If Period > 1.5*Period[1] Then Period = 1.5*Period[1];
If Period < .67*Period[1] Then Period = .67*Period[1];
If Period < 6 Then Period = 6;
If Period > 50 Then Period = 50;
Period = .2*Period + .8*Period[1];
SmoothPeriod = .33*Period + .67*SmoothPeriod[1];

{Compute Dominant Cycle Phase}
SmoothPrice = (4*price + 3*Price[1] + 2*Price[2] + Price[3]) / 10;
DCPeriod = IntPortion(SmoothPeriod + .5);
RealPart = 0;
ImagPart = 0;

For count = 0 To DCPeriod - 1 Begin
RealPart = RealPart + Sine(360*count/DCPeriod)*(SmoothPrice[count]);
ImagPart = ImagPart + CoSine(360*count/DCPeriod)*(SmoothPrice[count]);
End;

If AbsValue(ImagPart) > 0 Then DCPhase = Arctangent(RealPart/ImagPart);
If AbsValue(ImagPart) <= .001 Then DCPhase = DCPhase + 90*Sign(RealPart);
DCPhase = DCPhase + 90;

{Compensate for one bar lag of the Weighted Moving Average}
DCPhase = DCPhase + 360 / SmoothPeriod;

If ImagPart < 0 Then DCPhase = DCPhase + 180;
If DCPhase > 315 Then DCPhase = DCPhase - 360;

Plot1(Sine(DCPhase), "Sine");
Plot2(Sine(DCPhase + 45), "LeadSine");
%}
function out = EhlersSWInd_v1(H,L)
Price = (H+L)/2;
b = [4 3 2 1]/10;
bhp = [0.0962 0 0.5769 0 -0.5769 0 -0.0962];
persistent XSWindV1
if isempty(XSWindV1)
    XSWindV1.prwin = repmat(Price,length(b),1);
    XSWindV1.smwin = repmat(Price,length(bhp),1);
    XSWindV1.smprwin = repmat(Price,70,1);
    XSWindV1.detrendwin = repmat(zeros(1,length(H)),length(bhp),1);
    XSWindV1.I1win = repmat(zeros(1,length(H)),length(bhp),1);
    XSWindV1.Q1win = repmat(zeros(1,length(H)),length(bhp),1);
    XSWindV1.Periodp = 15*ones(1,length(H));
    XSWindV1.smPeriodp = 15*ones(1,length(H));
    XSWindV1.I2p = zeros(1,length(H));
    XSWindV1.Q2p = zeros(1,length(H));
    XSWindV1.Rep = zeros(1,length(H));
    XSWindV1.Imp = zeros(1,length(H));
end
XSWindV1.prwin = [Price;XSWindV1.prwin(1:end-1,:)];
Smooth = sum(b'.*XSWindV1.prwin);
XSWindV1.smwin = [Smooth;XSWindV1.smwin(1:end-1,:)];
tmp = 0.075*XSWindV1.Periodp + 0.54;
Detrender = sum(bhp'.*XSWindV1.smwin.*tmp);
XSWindV1.detrendwin = [Detrender;XSWindV1.detrendwin(1:end-1,:)];
% Compute InPhase and Quadrature components
Q1 = sum(bhp'.*XSWindV1.detrendwin.*tmp);
I1 = XSWindV1.detrendwin(4,:);
XSWindV1.Q1win = [Q1;XSWindV1.Q1win(1:end-1,:)];
XSWindV1.I1win = [I1;XSWindV1.I1win(1:end-1,:)];
% Advance the phase of I1 and Q1 by 90 degrees
JI = sum(bhp'.*XSWindV1.I1win.*tmp);
JQ = sum(bhp'.*XSWindV1.Q1win.*tmp);
% Phasor addition for 3 bar averaging
I2 = I1 - JQ;
Q2 = Q1 + JI;
% Smooth the I and Q components before applying the discriminator
I2 = .2*I2 + .8*XSWindV1.I2p;
Q2 = .2*Q2 + .8*XSWindV1.Q2p;
% {Homodyne Discriminator}
Re = I2.*XSWindV1.I2p + Q2.*XSWindV1.Q2p;
Im = I2.*XSWindV1.Q2p - Q2.*XSWindV1.I2p;
Re = .2*Re + .8*XSWindV1.Rep;
Im = .2*Im + .8*XSWindV1.Imp;

Im(Im==0) = 0.1;
Re(Re==0) = 0.1;
Period = 2*pi./atan(Im./Re);
% If Im <> 0 And Re <> 0 Then Period = 360/ArcTangent(Im/Re);
Period = min(1.5*XSWindV1.Periodp,Period);
Period = max(0.67*XSWindV1.Periodp,Period);
Period = max(6,Period);
Period = min(50,Period);
Period = .2*Period + .8*XSWindV1.Periodp;
SmoothPeriod = .33*Period + .67*XSWindV1.smPeriodp;
% {Compute Dominant Cycle Phase}
SmoothPrice = sum(b'.*XSWindV1.prwin);
XSWindV1.smprwin = [SmoothPrice;XSWindV1.smprwin(1:end-1,:)];
DCPeriod = floor(SmoothPeriod + .5);
RealPart = zeros(1,length(H));
ImagPart = zeros(1,length(H));
for count = 1:DCPeriod
    RealPart = RealPart + ...
        sin(2*pi*count./DCPeriod).*XSWindV1.smprwin(count,:);
    ImagPart = ImagPart + ...
        cos(2*pi*count./DCPeriod).*XSWindV1.smprwin(count,:);
end
idxIPlarge = find(abs(ImagPart)>0.001);
idxIPsmall = find(abs(ImagPart)<=0.001);
DCPHase(idxIPlarge) = ...
    atan(RealPart(idxIPlarge) ./ ImagPart(idxIPlarge));
DCPHase(idxIPsmall) = pi/2*sign(RealPart(idxIPsmall));
DCPHase = DCPHase + pi/2;
% {Compensate for one bar lag of the Weighted Moving Average}
DCPHase = DCPHase + 2*pi./ SmoothPeriod;
idxIP_0 = find(ImagPart<0.0);
idxIP_315 = find(DCPHase>315/180*pi);
DCPHase(idxIP_0) = DCPHase(idxIP_0) + pi;
DCPHase(idxIP_315) = DCPHase(idxIP_315) - 2*pi;
Sine = sin(DCPHase);
LeadSine = sin(DCPHase+pi/4);

% updates
XSWindV1.Periodp = Period;
XSWindV1.smPeriodp = SmoothPeriod;
XSWindV1.Q2p = Q2;
XSWindV1.I2p = I2;
out(1,:) = Sine;
out(2,:) = LeadSine; 
out(3,:) = SmoothPrice; 
out(4,:) = Detrender; 
end
