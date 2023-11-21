%{
{3 Pole Butterworth Filter - 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 

Input: Price((H+L)/2), Period(15);
Var: a1(0), b1(0), c1(0), coef1(0), coef2(0), coef3(0), coef4(0), Butter(0);

a1=expvalue(-3.14159/Period);
b1=2*a1*Cosine(1.738*180/Period);
c1=a1*a1;
coef2=b1+c1;
coef3=-(c1+b1*c1);
coef4=c1*c1;
coef1=(1-b1+c1)*(1-c1)/8;

Butter = coef1*(Price+3*Price[1]+3*Price[2]+Price[3])+coef2*Butter[1]+coef3*Butter[2]+coef4*Butter[3];
%}
function out = Ehlers3poleButter(H,L)
Price = (H+L)/2;
Period = 15;

persistent X3pole
if isempty(X3pole)
    X3pole.prp = Price;
    X3pole.prpp = Price;
    X3pole.prppp = Price;
    X3pole.Butterp = Price;
    X3pole.Butterpp = Price;
    X3pole.Butterppp = Price;
    X3pole.a1 = exp(-pi/Period);
    X3pole.b1 = 2*X3pole.a1*cos(1.738*pi/2/Period);
    X3pole.c1 = X3pole.a1*X3pole.a1;
end
coef2 = X3pole.b1 + X3pole.c1;
coef3 = -(X3pole.c1 + X3pole.b1*X3pole.c1);
coef4 = X3pole.c1*X3pole.c1;
coef1 = (1-X3pole.b1+X3pole.c1)*(1-X3pole.c1)/8;
Butter = coef1*(Price+3*X3pole.prp+3*X3pole.prpp+X3pole.prppp)+...
    coef2*X3pole.Butterp+coef3*X3pole.Butterpp+...
    coef4*X3pole.Butterppp;
% updates
X3pole.prppp = X3pole.prpp;
X3pole.prpp = X3pole.prp;
X3pole.prp = Price;
X3pole.Butterppp = X3pole.Butterpp;
X3pole.Butterpp = X3pole.Butterp;
X3pole.Butterp = Butter;
out = Butter;
end
