%{
{Smoothed Adaptive Momentum indicator - 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 

Inputs: Price((H+L)/2), alpha(.07), Cutoff(8);
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
Period=.15*InstPeriod+.85*Period[1];
Value1 = Price-Price[IntPortion(Period-1)];
a1=expvalue(-3.14159/Cutoff);
b1=2*a1*Cosine(1.738*189/Cutoff);
c1=a1*a1;
coef2=b1+c1;
coef3=-(c1+b1*c1);coef4=c1*c1;
coef1=1-coef2-coef3-coef4;
Filt3=coef1*Value1+coef2*Filt3[1]+coef3*Filt3[2]+coef4*Filt3[3];
%}
function out = SmoothAdapMomInd(H,L)
Price = (H+L)/2;
alpha = 0.07;
Cutoff = 8;
b = [1 2 2 1]/6;
bhp = [0.0962 0 0.5769 0 -0.5769 0 -0.0962];
persistent XSAMom
if isempty(XSAMom)
    XSAMom.prwin = repmat(Price,length(b),1);
    XSAMom.pricewin = repmat(Price,70,1);
    XSAMom.cycwin = repmat(zeros(1,length(H)),length(bhp),1);
    XSAMom.DelPhasewin = repmat(0.5*ones(1,length(H)),5,1);
    XSAMom.smp = Price;
    XSAMom.smpp = Price;
    XSAMom.cycp = zeros(1,length(H));
    XSAMom.cycpp = zeros(1,length(H));
    XSAMom.Q1p = ones(1,length(H));
    XSAMom.I1p = ones(1,length(H));
    XSAMom.a1 = exp(-pi/Cutoff);
    XSAMom.b1 = 2*XSAMom.a1*cos(1.738*pi/180*189/Cutoff);
    XSAMom.Filtp = zeros(1,length(H));
    XSAMom.Filtpp = zeros(1,length(H));
    XSAMom.Filtppp = zeros(1,length(H));
    XSAMom.InstPeriodp = zeros(1,length(H));
    XSAMom.Periodp = zeros(1,length(H));
end
XSAMom.prwin = [Price;XSAMom.prwin(1:end-1,:)];
XSAMom.pricewin = [Price;XSAMom.pricewin(1:end-1,:)];
Smooth = sum(b'.*XSAMom.prwin);
Cycle = (1-.5*alpha)*(1-.5*alpha)*...
    (Smooth-2*XSAMom.smp+XSAMom.smpp)+...
    2*(1-alpha)*XSAMom.cycp-...
    (1-alpha)*(1-alpha)*XSAMom.cycpp;
% XSAMom.smwin = [smooth;XSAMom.smwin(1:end-1,:)];
tmp = 0.5+ 0.08*XSAMom.InstPeriodp;
XSAMom.cycwin = [Cycle;XSAMom.cycwin(1:end-1,:)];
Q1 = sum(bhp'.*XSAMom.cycwin(1:length(bhp),:).*tmp);
I1 = XSAMom.cycwin(4,:);
Q1(Q1==0) = 1;
XSAMom.Q1p(XSAMom.Q1p==0) = 1;
DeltaPhase=(I1./Q1-XSAMom.I1p./XSAMom.Q1p)./...
    (1+I1.*XSAMom.I1p./(Q1.*XSAMom.Q1p));
DeltaPhase = max(0.1*ones(1,length(H)),DeltaPhase);
DeltaPhase = min(1.1*ones(1,length(H)),DeltaPhase);
XSAMom.DelPhasewin = [DeltaPhase;XSAMom.DelPhasewin(1:end-1,:)];
MedianDelta = median(XSAMom.DelPhasewin);
DC = 2*pi./MedianDelta + 0.5;
DC(MedianDelta==0) = 15;
InstPeriod=.33*DC+.67*XSAMom.InstPeriodp;
Period = 0.15*InstPeriod + 0.85*XSAMom.Periodp;
Period(Period<2) = 2;
[nr, nc] = size(XSAMom.pricewin);
rows = floor(Period-1);
tmpVV = XSAMom.pricewin(sub2ind([nr, nc], rows, 1:nc));
Value1 = Price - tmpVV;
c1 = XSAMom.a1*XSAMom.a1;
coef2 = XSAMom.b1 + c1;
coef3 = -(c1 + XSAMom.b1*c1);
coef4 = c1*c1;
coef1 = 1 - coef2 - coef3 - coef4;
Filt3 = coef1*Value1 + ...
    coef2*XSAMom.Filtp+...
    coef3*XSAMom.Filtpp+...
    coef4*XSAMom.Filtppp;
% updates
XSAMom.smpp = XSAMom.smp;
XSAMom.smp = Smooth;
XSAMom.cycpp = XSAMom.cycp;
XSAMom.cycp = Cycle;
XSAMom.InstPeriodp = InstPeriod;
XSAMom.Periodp = Period;
XSAMom.Filtppp = XSAMom.Filtpp;
XSAMom.Filtpp = XSAMom.Filtp;
XSAMom.Filtp = Filt3;
out(1,:) = Filt3;
end
