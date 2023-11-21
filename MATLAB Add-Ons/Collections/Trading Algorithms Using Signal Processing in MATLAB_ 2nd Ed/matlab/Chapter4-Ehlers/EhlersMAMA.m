
function out = EhlersMAMA(C,H,L)
persistent XehlMAMA
bhp = [0.0962 0 0.5769 0 -0.5769 0 -0.0962];a = 1;
bsm = [4 3 2 1]/10;
Price = (H+L)/2;
FastLimit = 0.5;
SlowLimit = .05;
if isempty(XehlMAMA)
    XehlMAMA.prwin = repmat(Price,7,1);
    XehlMAMA.ITrendwin = repmat(Price,7,1);
    XehlMAMA.smwin = repmat(Price,7,1);
    XehlMAMA.smPricewin = repmat(Price,50,1);
    XehlMAMA.Pricewin = repmat(Price,50,1);
    XehlMAMA.cycwin = zeros(20,length(C));
    XehlMAMA.Detrendwin = repmat(Price,7,1);
    XehlMAMA.I1win = zeros(7,length(C));
    XehlMAMA.Q1win = zeros(7,length(C));
    XehlMAMA.smp = Price;
    XehlMAMA.smpp = Price;
    XehlMAMA.I2p = ones(1,length(C));
    XehlMAMA.Q2p = ones(1,length(C));
    XehlMAMA.Rep = ones(1,length(C));
    XehlMAMA.Imp = ones(1,length(C));
    XehlMAMA.Phasep = 0.1*ones(1,length(C));
    XehlMAMA.InstPeriodp = 15*ones(1,length(C));
    XehlMAMA.Periodp = 15*ones(1,length(C));
    XehlMAMA.smPeriodp = 15*ones(1,length(C));
    XehlMAMA.Trendp = ones(1,length(C));
    XehlMAMA.buysellp = zeros(1,length(C));
    XehlMAMA.MAMAp = Price;
    XehlMAMA.FAMAp = Price;
end
XehlMAMA.prwin = [Price;XehlMAMA.prwin(1:end-1,:)];
smooth = sum(bsm'.*XehlMAMA.prwin(1:4,:));
XehlMAMA.smwin = [smooth;XehlMAMA.smwin(1:end-1,:)];
tmp = 0.075*XehlMAMA.Periodp + 0.54;
Detrender = sum(bhp'.*XehlMAMA.smwin.*tmp);
XehlMAMA.Detrendwin = [Detrender;XehlMAMA.Detrendwin(1:end-1,:)];
% Compute InPhase and Quadrature components
Q1 = sum(bhp'.*XehlMAMA.Detrendwin.*tmp);
I1 = XehlMAMA.Detrendwin(4,:);
XehlMAMA.Q1win = [XehlMAMA.Q1win(2:end,:);Q1];
XehlMAMA.I1win = [XehlMAMA.I1win(2:end,:);I1];
% Advance the phase of I1 and Q1 by 90 degrees
jI = sum(bhp'.*XehlMAMA.I1win.*tmp);
jQ = sum(bhp'.*XehlMAMA.Q1win.*tmp);
% Phasor addition for 3-bar averaging
I2 = I1 - jQ;
Q2 = Q1 + jI;
% Smooth the I and Q components before applying the discriminator
I2 = 0.8*XehlMAMA.I2p + 0.2*I2;
Q2 = 0.8*XehlMAMA.Q2p + 0.2*Q2;
% Homodyne Discriminator
Re = I2.*XehlMAMA.I2p + Q2.*XehlMAMA.Q2p;
Im = I2.*XehlMAMA.Q2p - Q2.*XehlMAMA.I2p;
Re = 0.8*XehlMAMA.Rep + 0.2*Re;
Im = 0.8*XehlMAMA.Imp + 0.2*Im;
Im(Im==0) = 0.1;
Re(Re==0) = 0.1;
Period = 2*pi./atan(Im./Re);
Period = min(Period,1.5*XehlMAMA.Periodp);
Period = max(Period,0.67*XehlMAMA.Periodp);
Period = max(Period,6);
Period = min(Period,50);
Period = 0.8*XehlMAMA.Periodp + 0.2*Period;
smPeriod = 0.67*XehlMAMA.smPeriodp + 0.33*Period;
XehlMAMA.smPricewin = [smooth;XehlMAMA.smPricewin(1:end-1,:)];
XehlMAMA.Pricewin = [Price;XehlMAMA.Pricewin(1:end-1,:)];
Phase = XehlMAMA.Phasep;
I1(I1==0) = 0.1;
Phase(I1~=0) = atan(Q1./I1);
DeltaPhase = XehlMAMA.Phasep - Phase;
DeltaPhase(DeltaPhase<1) = 1;
alpha = FastLimit ./ DeltaPhase;
alpha = max(alpha,SlowLimit*ones(size(alpha)));
alpha = min(alpha,FastLimit*ones(size(alpha)));
MAMA = alpha.*Price + (1 - alpha).*XehlMAMA.MAMAp;
FAMA = .5*alpha.*MAMA + (1 - .5*alpha).*XehlMAMA.FAMAp;

% updates
XehlMAMA.Periodp = Period;
XehlMAMA.smPeriodp = smPeriod;
XehlMAMA.I2p = I2;
XehlMAMA.Q2p = Q2;
XehlMAMA.Phasep = Phase;
XehlMAMA.MAMAp = MAMA;
XehlMAMA.FAMAp = FAMA;

out(1,:) = smooth;
out(2,:) = Detrender;
out(3,:) = MAMA;
out(4,:) = FAMA;
end
