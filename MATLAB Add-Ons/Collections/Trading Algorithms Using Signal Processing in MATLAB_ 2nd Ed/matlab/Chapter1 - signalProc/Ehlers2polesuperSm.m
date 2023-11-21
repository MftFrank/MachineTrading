%{
{2 Pole Super Smoother - 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 
} 

Input: Price((H+L)/2), Period(15);
Var: a1(0), b1(0), coef1(0), coef2(0), coef3(0), Filt2(0);

a1=expvalue(-1.414*3.14159/Period);
b1=2*a1*Cosine(1.414*180/Period);
coef2=b1;
coef3=-a1*a1;
coef1=1-coef2-coef3;;
Filt2 = coef1*Price+coef2*Filt2[1]+coef3*Filt2[2];
%}
function out = Ehlers2polesuperSm(H,L)
Price = (H+L)/2;
Period = 15;

persistent X2pole
if isempty(X2pole)
    X2pole.filtp = Price;
    X2pole.filtpp = Price;
    X2pole.a1 = exp(-1.414*pi/Period);
    X2pole.b1 = 2*X2pole.a1*cos(1.414*pi/2/Period);
end
coef2 = X2pole.b1;
coef3 = -X2pole.a1*X2pole.a1;
coef1=1 - coef2 - coef3;
Filt2 = coef1*Price + ...
    coef2*X2pole.filtp + coef3*X2pole.filtpp;
% updates
X2pole.filtpp = X2pole.filtp;
X2pole.filtp = Filt2;
out = Filt2;
end
