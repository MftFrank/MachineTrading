%{
{
My Stochastic Indicator
© 2013 John F. Ehlers
}
Inputs: Length(20);
Vars: alpha1(0), HP(0), a1(0), b1(0), c1(0), c2(0), c3(0), Filt(0),
HighestC(0), LowestC(0), count(0), Stoc(0), MyStochastic(0);
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
HighestC = Filt;
LowestC = Filt;
For count = 0 to Length - 1 Begin
If Filt[count] > HighestC then HighestC = Filt[count];
If Filt[count] < LowestC then LowestC = Filt[count];
End;
Stoc = (Filt - LowestC) / (HighestC - LowestC);
MyStochastic = c1*(Stoc + Stoc[1]) / 2 + c2*MyStochastic[1] + c3*MyStochastic[2];
%}
function out = ElhStoch(C)
persistent XElhStoch
if isempty(XElhStoch)
    XElhStoch.alpha1 = (cos(.707*2*pi / 48) + ...
        sin (.707*2*pi / 48) - 1) / cos(.707*2*pi / 48);
    a1 = exp(-1.414*pi / 10);
    b1 = 2*a1*cos(1.414*pi / 10);
    XElhStoch.c2 = b1;
    XElhStoch.c3 = -a1*a1;
    XElhStoch.c1 = 1 - XElhStoch.c2 - XElhStoch.c3;
    XElhStoch.HPp = zeros(1,length(C));
    XElhStoch.HPpp = zeros(1,length(C));
    XElhStoch.Filtp = zeros(1,length(C));
    XElhStoch.Filtpp = zeros(1,length(C));
    XElhStoch.Cp = C;
    XElhStoch.Cpp = C;
    XElhStoch.stochp = zeros(1,length(C));
    XElhStoch.mystochasticp = zeros(1,length(C));
    XElhStoch.mystochasticpp = zeros(1,length(C));
    XElhStoch.Filtwin = zeros(20,length(C));
end
HP = (1 - XElhStoch.alpha1 / 2)*(1 - XElhStoch.alpha1 / 2)*...
    (C - 2*XElhStoch.Cp + XElhStoch.Cpp) + ...
    2*(1 - XElhStoch.alpha1)*XElhStoch.HPp - ...
    (1 - XElhStoch.alpha1)*(1 - XElhStoch.alpha1)*XElhStoch.HPpp;
Filt = XElhStoch.c1*(XElhStoch.HPp + XElhStoch.HPpp) / 2 + ...
    XElhStoch.c2*XElhStoch.Filtp + ...
    XElhStoch.c3*XElhStoch.Filtpp;
XElhStoch.Filtwin = [Filt;XElhStoch.Filtwin(1:end-1,:)];
HighestC = max(XElhStoch.Filtwin);
LowestC = min(XElhStoch.Filtwin);
Stoc = (Filt - LowestC)./(HighestC - LowestC);
Stoc((HighestC - LowestC)==0) = 0;
MyStochastic = XElhStoch.c1*(Stoc + XElhStoch.stochp) / 2 + ...
    XElhStoch.c2*XElhStoch.mystochasticp + ...
    XElhStoch.c3*XElhStoch.mystochasticpp; 

% updates
XElhStoch.HPpp = XElhStoch.HPp;
XElhStoch.HPp = HP;
XElhStoch.Cpp = XElhStoch.Cp;
XElhStoch.Cp = C;
XElhStoch.Filtpp = XElhStoch.Filtp;
XElhStoch.Filtp = Filt;
XElhStoch.mystochasticpp = XElhStoch.mystochasticp;
XElhStoch.mystochasticp = MyStochastic;
XElhStoch.stochp = Stoc;
out(1,:) = Filt;
out(2,:) = Stoc;
out(3,:) = MyStochastic;
end