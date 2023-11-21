%{
//// Ehlers Fisher Cyber Cycle - coded by dn
//// From Cybernetic Analysis for Stocks and Futures
Inputs: Price((H+L)/2),
alpha(.07),
Len(8);
Vars: Smooth(0),
Cycle(0),
MaxCycle(0),
MinCycle(0),
Lead(0);
Smooth = (Price + 2*Price[1] + 2*Price[2] + Price[3])/6;
Cycle=(1-.5*alpha)*(1-.5*alpha)*(Smooth-2*Smooth[1]+Smooth[2])+2*(1-alpha)*Cycle[1]-(1-alpha)*(1-alpha)*Cycle[2];
If currentBar <7 then Cycle=(Price-2*Price[1]+Price[2])/4;
MaxCycle = Highest(Cycle,Len);
MinCycle = Lowest(Cycle,Len);
If MaxCycle <> MinCycle then Value1=(Cycle-MinCycle)/(MaxCycle-MinCycle);
Value2 = (4*Value1+3*Value1[1]+2*Value1[2]+Value1[3])/10;
Value3 = .5*Log((1+1.98*(Value2-.5))/(1-1.98*(Value2-.5)));
%}
function out = EhlersCycleEst(H,L)
Price = (H+L)/2;
bsm = [1 2 2 1]/6;
bsm2 = [4 3 2 1]/10;
alpha2 = 0.07;
Len = 8;
persistent XehlCycEst
if isempty(XehlCycEst)
    XehlCycEst.prwin = repmat(Price,length(bsm),1);
    XehlCycEst.Valwin = repmat(zeros(1,length(H)),length(bsm2),1);
    XehlCycEst.Cycwin = zeros(Len,length(H));
    XehlCycEst.Smoothp = Price;
    XehlCycEst.Smoothpp = Price;
    XehlCycEst.Cyclep = zeros(1,length(H));
    XehlCycEst.Cyclepp = zeros(1,length(H));
end
XehlCycEst.prwin = [Price;XehlCycEst.prwin(1:end-1,:)];
Smooth = sum(bsm'.*XehlCycEst.prwin);
Cycle=(1-0.5*alpha2)*(1-0.5*alpha2)*...
    (Smooth-2*XehlCycEst.Smoothp+XehlCycEst.Smoothpp)+...
    2*(1-alpha2)*XehlCycEst.Cyclep-(1-alpha2)*(1-alpha2)*XehlCycEst.Cyclepp;
XehlCycEst.Cycwin = [Cycle;XehlCycEst.Cycwin(1:end-1,:)];
MaxCycle = max(Cycle);
MinCycle = min(Cycle);
tmp = MaxCycle-MinCycle;
tmp(tmp==0) = 1;
Value1 = (Cycle-MinCycle)./tmp;
XehlCycEst.Valwin = [Value1;XehlCycEst.Valwin(1:end-1,:)];
Value2 = sum(bsm2'.*XehlCycEst.Valwin);
Value3 = .5*log((1+1.98*(Value2-.5))./(1-1.98*(Value2-.5)));
% updates
XehlCycEst.Smoothpp = XehlCycEst.Smoothp;
XehlCycEst.Smoothp = Smooth;
XehlCycEst.Cyclepp = XehlCycEst.Cyclep;
XehlCycEst.Cyclep = Cycle;
out(1,:) = Smooth;
out(2,:) = Cycle;
out(3,:) = Value1;
out(4,:) = Value2;
out(5,:) = Value3;
end
