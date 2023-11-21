%{
study("Universal Oscillator [LazyBear]", shorttitle="UNIOSC_LB")
bandedge= input(20, title="BandEdge")
showHisto=input(true, type=bool, title="Show Histogram?")
showMA=input(false, type=bool, title="Show Signal?")
lengthMA=input(9, title="EMA signal length")
enableBarColors=input(false, title="Color Bars?")

whitenoise= (close - close[2])/2
a1= exp(-1.414 * 3.14159 / bandedge)
b1= 2.0*a1 * cos(1.414*180 /bandedge)
c2= b1
c3= -a1 * a1
c1= 1 - c2 - c3
filt= c1 * (whitenoise + nz(whitenoise[1]))/2 + c2*nz(filt[1]) + c3*nz(filt[2])
filt1= iff(cum(1) == 0, 0, iff(cum(1) == 2, c2*nz(filt1[1]),
	iff(cum(1) == 3, c2*nz(filt1[1]) + c3*nz(filt1[2]), filt)))

pk= iff(cum(1) == 2, .0000001,
	iff(abs(filt1) > nz(pk[1]), abs(filt1), 0.991 * nz(pk[1])))
denom= iff(pk==0, -1, pk)
euo=iff(denom == -1, nz(euo[1]), filt1/pk)
euoMA=ema(euo, lengthMA)
%}
function out = EhlersUO(C)
close = C;
bandedge = 20;
lengthMA = 9;
a = 2/(lengthMA+1);
Z = zeros(1,length(C));
persistent Xeuo
if isempty(Xeuo)
    Xeuo.Cp = close;
    Xeuo.whitenoisep = Z;
    Xeuo.filtp = Z;
    Xeuo.filtpp = Z;
    Xeuo.pkp = Z;
    Xeuo.euop = Z;
    Xeuo.euoMAp = Z;
end
whitenoise = (close - Xeuo.Cp)/2;
a1 = exp(-1.414 * 3.14159 / bandedge);
b1 = 2.0*a1 * cos(1.414*180 /bandedge);
c2 = b1;
c3 = -a1 * a1;
c1 = 1 - c2 - c3;
filt = c1 * (whitenoise + Xeuo.whitenoisep)/2 + ...
    c2*Xeuo.filtp + c3*Xeuo.filtpp;
filt1 = filt;
pk = abs(filt1);
k = find(abs(filt1) < Xeuo.pkp);
pk(k) = 0.991*Xeuo.pkp(k);
denom = pk;
denom(denom==0) = -1;
euo = filt1./pk;
k = find(denom==-1);
euo(k) = Xeuo.euop(k);
euoMA = (1-a)*Xeuo.euoMAp + a*euo;
Xeuo.Cp = close;
Xeuo.whitenoisep = whitenoise;
Xeuo.filtpp = Xeuo.filtp;
Xeuo.filtp = filt;
Xeuo.pkp = pk;
Xeuo.euop = euo;
Xeuo.euoMAp = euoMA;
out(1,:) = euo;
out(2,:) = euoMA;
out(3,:) = euo - euoMA;
end
