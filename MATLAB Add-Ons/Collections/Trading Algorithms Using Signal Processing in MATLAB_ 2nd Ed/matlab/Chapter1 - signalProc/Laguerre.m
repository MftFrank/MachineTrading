%{
{Laguerre Filter (four elements) with FIR filter for comparison -
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 

Input: Price((H+L)/2), gamma(.8);
Var: L0(0), L1(0), L2(0), L3(0), Filt(0), FIR(0);
L0=(1-gamma)*Price+gamma*L0[1];
L1=-gamma*L0+L0[1]+gamma*L1[1];
L2=-gamma*L1+L1[1]+gamma*L2[1];
L3=-gamma*L2+L2[1]+gamma*L3[1];
FIlt=(L0+2*L1+2*L1+L3)/6;
FIR=(Price+2*Price[1]+2*Price[2]+Price[3])/6;

{The green generalized finite impulse response filter (FIR) has very little lag but is very whippy.
The Laguerre filter (same length) has virtually the same crossing signals but is much smoother due
to the introduction of the dampening factor (gamma).
If you set gamma to 0 Laguerre will be identical to the FIR filter.
This filter can be used to dampen other indicators with similar results.}
%}
function out = Laguerre(H,L)
Price = (H+L)/2;
gamma = 0.8;
b = [1 2 2 1]/6;
persistent XLag
if isempty(XLag)
    XLag.L0p = Price;
    XLag.L1p = Price;
    XLag.L2p = Price;
    XLag.L3p = Price;
    XLag.prwin = repmat(Price,length(b),1);
end
L0 = (1-gamma)*Price + gamma*XLag.L1p;
L1 = -gamma*L0 + XLag.L0p + gamma*XLag.L1p;
L2 = -gamma*L1 + XLag.L1p + gamma*XLag.L2p;
L3 = -gamma*L2 + XLag.L2p + gamma*XLag.L3p;
Filt = (L0+2*L1+2*L1+L3)/6;
XLag.prwin = [Price;XLag.prwin(1:end-1,:)];
FIR = sum(b'.*XLag.prwin);
% FIR=(Price+2*Price[1]+2*Price[2]+Price[3])/6;
% updates
XLag.L0p = L0;
XLag.L1p = L1;
XLag.L2p = L2;
XLag.L3p = L3;
out(1,:) = Filt;
out(2,:) = FIR;
end
