%{
{3 Pole Super Smoother - 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 

Input: Price((H+L)/2), Period(15);
Var: a1(0), b1(0), c1(0), coef1(0), coef2(0), coef3(0), coef4(0), Filt3(0);
a1=expvalue(-3.14159/Period);
b1=2*a1*Cosine(1.738*180/Period);
c1=a1*a1;
coef2=b1+c1;
coef3=-(c1+b1*c1);
coef4=c1*c1;
coef1=1-coef2-coef3-coef4;
Filt3 = coef1*Price+coef2*Filt3[1]+coef3*Filt3[2]+coef4*Filt3[3];
%}
function out = Ehlers3poleSS(H,L)
Price = (H+L)/2;
Period = 15;

persistent X3poleSS
if isempty(X3poleSS)
    X3poleSS.filtp = Price;
    X3poleSS.filtpp = Price;
    X3poleSS.filtppp = Price;
    X3poleSS.a1 = exp(-pi/Period);
    X3poleSS.b1 = 2*X3poleSS.a1*cos(1.738*pi/2/Period);
    X3poleSS.c1 = X3poleSS.a1*X3poleSS.a1;
end
coef2 = X3poleSS.b1 + X3poleSS.c1;
coef3 = -(X3poleSS.c1 + X3poleSS.b1*X3poleSS.c1);
coef4 = X3poleSS.c1*X3poleSS.c1;
coef1 = 1 - coef2 - coef3 - coef4;
Filt = coef1*Price+...
    coef2*X3poleSS.filtp+coef3*X3poleSS.filtpp+...
    coef4*X3poleSS.filtppp;
% updates
X3poleSS.filtppp = X3poleSS.filtpp;
X3poleSS.filtpp = X3poleSS.filtp;
X3poleSS.filtp = Filt;
out = Filt;
end
