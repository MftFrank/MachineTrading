%{
{
Roofing filter
© 2013 John F. Ehlers
}
Vars: alpha1(0), HP(0), a1(0), b1(0), c1(0), c2(0), c3(0), Filt(0), Filt2(0);
//Highpass filter cyclic components whose periods are shorter than 48 bars
alpha1 = (Cosine(.707*360 / 48) + Sine (.707*360 / 48) - 1) / Cosine(.707*360 / 48);
HP = (1 - alpha1 / 2)*(1 - alpha1 / 2)*(Close - 2*Close[1] + Close[2]) + 2*(1 -
alpha1)*HP[1] - (1 - alpha1)*(1 - alpha1)*HP[2];
//Smooth with a Super Smoother Filter
a1 = expvalue(-1.414*3.14159 / 10);
b1 = 2*a1*Cosine(1.414*180 / 10);
c2 = b1;
c3 = -a1*a1;
c1 = 1 - c2 - c3;
Filt = c1*(HP + HP[1]) / 2 + c2*Filt[1] + c3*Filt[2];
%}
function out = EhlersRoofingFilter(C)
persistent XEhlRoofFilt
if isempty(XEhlRoofFilt)
    XEhlRoofFilt.alpha1 = (cos(.707*2*pi / 48) + ...
        sin (.707*2*pi / 48) - 1) / cos(.707*2*pi / 48);
    a1 = exp(-1.414*pi / 10);
    b1 = 2*a1*cos(1.414*pi / 10);
    XEhlRoofFilt.c2 = b1;
    XEhlRoofFilt.c3 = -a1*a1;
    XEhlRoofFilt.c1 = 1 - XEhlRoofFilt.c2 - XEhlRoofFilt.c3;
    XEhlRoofFilt.HPp = zeros(1,length(C));
    XEhlRoofFilt.HPpp = zeros(1,length(C));
    XEhlRoofFilt.Filtp = zeros(1,length(C));
    XEhlRoofFilt.Filtpp = zeros(1,length(C));
    XEhlRoofFilt.Cp = C;
    XEhlRoofFilt.Cpp = C;
end
HP = (1 - XEhlRoofFilt.alpha1 / 2)*(1 - XEhlRoofFilt.alpha1 / 2)*...
    (C - 2*XEhlRoofFilt.Cp + XEhlRoofFilt.Cpp) + ...
    2*(1 - XEhlRoofFilt.alpha1)*XEhlRoofFilt.HPp - ...
    (1 - XEhlRoofFilt.alpha1)*(1 - XEhlRoofFilt.alpha1)*XEhlRoofFilt.HPpp;
Filt = XEhlRoofFilt.c1*(XEhlRoofFilt.HPp + XEhlRoofFilt.HPpp) / 2 + ...
    XEhlRoofFilt.c2*XEhlRoofFilt.Filtp + ...
    XEhlRoofFilt.c3*XEhlRoofFilt.Filtpp;
% updates
XEhlRoofFilt.HPpp = XEhlRoofFilt.HPp;
XEhlRoofFilt.HPp = HP;
XEhlRoofFilt.Cpp = XEhlRoofFilt.Cp;
XEhlRoofFilt.Cp = C;
XEhlRoofFilt.Filtpp = XEhlRoofFilt.Filtp;
XEhlRoofFilt.Filtp = Filt;
out = Filt;
end
