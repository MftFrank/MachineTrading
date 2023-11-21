%{
//// Ehlers Cyber Cycle indicator - coded by dn
//// From Cybernetic Analysis for Stocks and Futures

Inputs: Price2((H+L)/2), alpha2(.07);
Vars: smooth2(0), Cycle2(0);
Smooth2 = (Price2 + 2*Price2[1] + 2*Price2[2] + Price2[3])/6;
Cycle2=(1-0.5*alpha2)*(1-0.5*alpha2)*(Smooth2-2*Smooth2[1]+Smooth2[2])+
2*(1-alpha2)*Cycle2[1]-(1-alpha2)*(1-alpha2)*Cycle2[2];
If currentbar < 7 then Cycle2 = (Price2 - 2*Price2[1] +Price2[2])/4;
%}
function out = EhlerCyberCyc(H,L)
Price = (H+L)/2;
bsm = [1 2 2 1]/6;
alpha2 = 0.07;
persistent XehlCyb
if isempty(XehlCyb)
    XehlCyb.prwin = repmat(Price,length(bsm),1);
    XehlCyb.Smooth2p = Price;
    XehlCyb.Smooth2pp = Price;
    XehlCyb.Cycle2p = zeros(1,length(H));
    XehlCyb.Cycle2pp = zeros(1,length(H));
end
XehlCyb.prwin = [Price;XehlCyb.prwin(1:end-1,:)];
Smooth2 = sum(bsm'.*XehlCyb.prwin);
Cycle2=(1-0.5*alpha2)*(1-0.5*alpha2)*...
    (Smooth2-2*XehlCyb.Smooth2p+XehlCyb.Smooth2pp)+...
    2*(1-alpha2)*XehlCyb.Cycle2p-(1-alpha2)*(1-alpha2)*XehlCyb.Cycle2pp;

% updates
XehlCyb.Smooth2pp = XehlCyb.Smooth2p;
XehlCyb.Smooth2p = Smooth2;
XehlCyb.Cycle2pp = XehlCyb.Cycle2p;
XehlCyb.Cycle2p = Cycle2;
out(1,:) = Smooth2;
out(2,:) = Cycle2;
end
