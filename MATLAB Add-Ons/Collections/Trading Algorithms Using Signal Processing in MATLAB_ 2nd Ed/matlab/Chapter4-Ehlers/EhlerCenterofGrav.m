%{
//// Ehlers Center of Gravity Oscillator - coded by dn
//// From Cybernetic Analysis for Stocks and Futures

Inputs: Price((H+L)/2),
Length(10);

Vars: Count(0),
Num(0),
Denom(0),
CG(0);

Num = 0;Denom = 0;For count = 0 to length - 1 begin
Num = Num + (1+count)*Price[count];

Denom = Denom + (Price[count]);
End;

If Denom <> 0 then CG = -Num/Denom + (Length + 1)/2;
%}
function out = EhlerCenterofGrav(H,L)
persistent XehlCOG
Price = (H+L)/2;
Leng = 10;
Num = zeros(1,length(H));
Denom = zeros(1,length(H));
if isempty(XehlCOG)
    XehlCOG.Pricewin = repmat(Price,Leng,1);
end
XehlCOG.Pricewin = [Price;XehlCOG.Pricewin(1:end-1,:)];
for count = 1:Leng
    Num = Num + (0+count)*XehlCOG.Pricewin(count,:);
    Denom = Denom + XehlCOG.Pricewin(count,:);
end
CG = -Num./Denom + (Leng + 1)/2;
out = CG;
end
