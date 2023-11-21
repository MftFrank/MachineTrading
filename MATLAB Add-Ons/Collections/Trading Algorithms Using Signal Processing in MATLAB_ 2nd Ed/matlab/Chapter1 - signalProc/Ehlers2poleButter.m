%{
{2 Pole Butterworth Filter - 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 
} 

Input: Price((H+L)/2), Period(15);
Var: a1(0), b1(0), coef1(0), coef2(0), coef3(0), Butter(0);

a1=expvalue(-1.414*3.14159/Period);
b1=2*a1*Cosine(1.414*180/Period);
coef2=b1;
coef3=-a1*a1;
coef1=(1-b1+a1*a1)/4;
Butter = coef1*(Price+2*Price[1]+Price[2])+ coef2*Butter[1] + coef3*Butter[2];
If CurrentBar<3 then Butter=Price;
Plot1(Butter,"Butter");
%}
function out = Ehlers2poleButter(H,L)
Price = (H+L)/2;
Period = 15;

persistent X2pole
if isempty(X2pole)
    X2pole.prp = Price;
    X2pole.prpp = Price;
    X2pole.Butterp = Price;
    X2pole.Butterpp = Price;
    X2pole.a1 = exp(-1.414*3.14159/Period);
    X2pole.b1 = 2*X2pole.a1*cos(1.414*pi/2/Period);
end
coef2 = X2pole.b1;
coef3 = -X2pole.a1*X2pole.a1;
coef1=(1-X2pole.b1+X2pole.a1*X2pole.a1)/4;
Butter = coef1*(Price+2*X2pole.prp+X2pole.prpp)+ ...
    coef2*X2pole.Butterp + coef3*X2pole.Butterpp;
% updates
X2pole.prpp = X2pole.prp;
X2pole.prp = Price;
X2pole.Butterpp = X2pole.Butterp;
X2pole.Butterp = Butter;
out = Butter;
end