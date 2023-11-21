%{
{ SuperSmoother filter © 2013 John F. Ehlers } 
a1 = expvalue(-1.414*3.14159 / 10); 
b1 = 2*a1*Cosine(1.414*180 / 10); 
c2 = b1; 
c3 = -a1*a1; 
c1 = 1 - c2 - c3; 
Filt = c1*(Close + Close[1]) / 2 + c2*Filt[1] + c3*Filt[2];
%}
function out = EhlersSuperSmooth(C)
persistent XEhlSM
if isempty(XEhlSM)
    s2 = sqrt(2);
    a1 = exp(-s2*pi / 10); 
    b1 = 2*a1*cos(s2*pi / 10); 
    XEhlSM.cp = C;
    XEhlSM.filtp = C;
    XEhlSM.filtpp = C;
    XEhlSM.c2 = b1;
    XEhlSM.c3 = -a1*a1;
    XEhlSM.c1 = 1 - XEhlSM.c2 - XEhlSM.c3;
end
Filt = XEhlSM.c1*(C + XEhlSM.cp) / 2 + ...
    XEhlSM.c2*XEhlSM.filtp + XEhlSM.c3*XEhlSM.filtpp;
% updates
XEhlSM.filtpp = XEhlSM.filtp;
XEhlSM.filtp = Filt;
XEhlSM.cp = C;
out = Filt;
end