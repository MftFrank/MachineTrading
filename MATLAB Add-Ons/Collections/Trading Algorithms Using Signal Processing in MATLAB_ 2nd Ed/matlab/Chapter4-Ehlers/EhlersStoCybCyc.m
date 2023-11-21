%{
//// Ehl Stochastic Cyber Cycle
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers

Inputs: Price((H+L)/2);
Var{Inputs}: alpha(.07),Len(8),CCdelimiter(80);
vars: Smooth(0),Cycle(0),MaxCycle(0),MinCycle(0);
Smooth=(Price+2*Price[1]+2*Price[2]+Price[3])/6;
Cycle=(1-.5*alpha)*(1-.5*alpha)*(Smooth-2*Smooth[1]+Smooth[2])+2*(1-alpha)*Cycle[1]-(1-alpha)*(1-alpha)*Cycle[1];
If currentbar <7 then Cycle=(Price-2*Price[1]+Price[2])/4;
MaxCycle = Highest (Cycle, Len);
MinCycle = Lowest (Cycle, Len);
If MaxCycle <> MinCycle then Value1 = (Cycle - MinCycle) / (MaxCycle - MinCycle);
Value2 = (4*Value1 + 3*Value1[1] + 2*Value1[2] + Value1[3]) / 10;
Value2 = 2*(Value2 - .5);
Plot2 (.96*(Value2[1] + .02), "Trigger",green);
%}
function out = EhlersStoCybCyc(H,L)
persistent XStoCybCyc
Len = 8;
Price = (H+L)/2;
alpha = 0.07;
CCdelimiter = 80;
bsm = [1 2 2 1]/6;
b = [4 3 2 1]/10;
if isempty(XStoCybCyc)
    XStoCybCyc.smp = Price;
    XStoCybCyc.smpp = Price;
    XStoCybCyc.cycp = zeros(1,length(H));
    XStoCybCyc.cycpp = zeros(1,length(H));
    XStoCybCyc.prwin = repmat(Price,length(bsm),1);
    XStoCybCyc.cycwin = repmat(zeros(1,length(H)),Len,1);
    XStoCybCyc.Val1win = repmat(zeros(1,length(H)),length(b),1);
    XStoCybCyc.Val2p = zeros(1,length(H));
end
XStoCybCyc.prwin = [Price;XStoCybCyc.prwin(1:end-1,:)];
Smooth = sum(bsm'.*XStoCybCyc.prwin);
Cycle=(1-.5*alpha)*(1-.5*alpha)*...
    (Smooth-2*XStoCybCyc.smp+XStoCybCyc.smpp)...
    +2*(1-alpha)*XStoCybCyc.cycp...
    -(1-alpha)*(1-alpha)*XStoCybCyc.cycpp;
XStoCybCyc.cycwin = [Cycle;XStoCybCyc.cycwin(1:end-1,:)];
MaxCycle = max(XStoCybCyc.cycwin);
MinCycle = min(XStoCybCyc.cycwin);
tmp = MaxCycle - MinCycle;
tmp(tmp==0) = 1;
Value1 = (Cycle - MinCycle) ./ tmp;
XStoCybCyc.Val1win = [Value1;XStoCybCyc.Val1win(1:end-1,:)];
Value2 = sum(b'.*XStoCybCyc.Val1win);
Value2 = 2*(Value2 - .5);
Trigger = 0.96*(XStoCybCyc.Val2p + .02);
% updates
XStoCybCyc.smpp = XStoCybCyc.smp;
XStoCybCyc.smp = Smooth;
XStoCybCyc.cycpp = XStoCybCyc.cycp;
XStoCybCyc.cycp = Cycle;
XStoCybCyc.Val2p = Value2;
out(1,:) = Value1;
out(2,:) = Value2;
out(3,:) = Trigger;
end
