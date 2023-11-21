%{
https://www.forexfactory.com/attachment.php/845855?attachmentid=845855&d=1322724313
 The general formula
(which is referred to as “generalized DEMA”) is:

GD(n,v) = EMA(n) * (1+v) - EMA(EMA(n)) * v

When v = 0, GD is just an EMA, and when v = 1, GD is DEMA. 
In between, GD is a less aggressive version of DEMA. 
By using a value for v less than 1, we cure the multiple 
DEMA overshoot problem but at the cost of accepting some 
additional phase delay. Now we can run GD through itself 
multiple times to define a new, smoother moving average 
(T3) that does not overshoot the data:
T3(n) = GD(GD(GD(n)))
If x stands for the action of running a time series through
an EMA, f is our formula for generalized DEMA with the
variable “a” standing for our volume factor:
f:= (1+ a) x – ax^2

Running the filter though itself three times is equivalent to
cubing f:
–a^3 + x^6 + (3a^2 + 3a^3)x^5 + (–6a^2–3a–3a^3)x^4
+ (1+3a+a^3+3a^2)x^3
Thus, the MetaStock 6.5 code for T3 is:
periods:=Input(“Periods? “,1,63,5);
a:=Input(“Hot? “,0,2,.7);
e1:=Mov(P,periods,E);
e2:=Mov(e1,periods,E);
e3:=Mov(e2,periods,E);
e4:=Mov(e3,periods,E);
e5:=Mov(e4,periods,E);
e6:=Mov(e5,periods,E);
c1:=-a*a*a;
c2:=3*a*a+3*a*a*a;
c3:=-6*a*a-3*a-3*a*a*a;
c4:=1+3*a+a*a*a+3*a*a;
c1*e6+c2*e5+c3*e4+c4*e3;
%}
function out = T3Tillson(C)
a = 0.7;
P = C;
periods = 5;
alpha = 2/(periods+1);
persistent XT3
if isempty(XT3)
    XT3.e1p = P;
    XT3.e2p = P;
    XT3.e3p = P;
    XT3.e4p = P;
    XT3.e5p = P;
    XT3.e6p = P;
    XT3.c1 = -a*a*a;
    XT3.c2 = 3*a*a + 3*a*a*a;
    XT3.c3 = -6*a*a - 3*a - 3*a*a*a;
    XT3.c4 = 1 + 3*a + a*a*a + 3*a*a;
end
e1 = (1-alpha)*XT3.e1p + alpha*P;
e2 = (1-alpha)*XT3.e2p + alpha*e1;
e3 = (1-alpha)*XT3.e3p + alpha*e2;
e4 = (1-alpha)*XT3.e4p + alpha*e3;
e5 = (1-alpha)*XT3.e5p + alpha*e4;
e6 = (1-alpha)*XT3.e6p + alpha*e5;
T3 = XT3.c1*e6 + XT3.c2*e5 + XT3.c3*e4 + XT3.c4*e3;
XT3.e1p = e1;
XT3.e2p = e2;
XT3.e3p = e3;
XT3.e4p = e4;
XT3.e5p = e5;
XT3.e6p = e6;
out(1,:) = T3;
end
