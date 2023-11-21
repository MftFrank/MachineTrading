%{
//// Ehlers Fisher Stochastic CG (Center of Gravity) indicator/oscillator
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers

Inputs: Price((H+L)/2),
Length(8);
Vars: count(0),
Num(0),
Denom(0),
CG(0),
MaxCG(0),
MinCG(0);
Num = 0;
Denom = 0;
For count = 0 to Length - 1 begin
Num = Num + (1 + count)*(Price[count]);
Denom = Denom + (Price[count]);
End;
If Denom <> 0 then CG = -Num/Denom + (Length + 1) / 2;
MaxCG = Highest(CG, Length);
MinCG = Lowest(CG, Length);
If MaxCG <> MinCG then Value1 = (CG - MinCG) / (MaxCG - MinCG);
Value2 = (4*Value1 + 3*Value1[1] + 2*Value1[2] + Value1[3]) / 10;

Value3 = .5*Log((1+1.98*(Value2-.5))/(1-1.98*(Value2-.5)));

Plot1 (Value3, "CG");
Plot2(Value3[1], "Trigger");
%}
function out = EhlerStochCG(H,L)
Price = (H+L)/2;
Len = 8;
b = [4 3 2 1]/10;
persistent XStochCG
if isempty(XStochCG)
    XStochCG.prwin = repmat(Price,Len,1);
    XStochCG.CGwin = repmat(ones(1,length(H)),Len,1);
    XStochCG.Val1win = repmat(ones(1,length(H)),length(b),1);
    XStochCG.Val3p = ones(1,length(H));
end
Num = 0;
Denom = 0;
XStochCG.prwin = [Price;XStochCG.prwin(1:end-1,:)];
for count = 1:Len
    Num = Num + (0 + count)*XStochCG.prwin(count,:);
    Denom = Denom + XStochCG.prwin(count,:);
end
Denom(Denom==0) = 1;
CG = -Num./Denom + (Len + 1) / 2;
XStochCG.CGwin = [CG;XStochCG.CGwin(1:end-1,:)];
MaxCG = max(XStochCG.CGwin);
MinCG = min(XStochCG.CGwin);
tmp = MaxCG - MinCG;
tmp(tmp==0) = 1;
Value1 = (CG - MinCG) ./ tmp;
XStochCG.Val1win = [Value1;XStochCG.Val1win(1:end-1,:)];
Value2 = sum(b'.*XStochCG.Val1win);
Value3 = .5*log((1+1.98*(Value2-.5))./...
    (1-1.98*(Value2-.5)));
Trigger = XStochCG.Val3p;
XStochCG.Val3p = Value3;
out(1,:) = Value1;
out(2,:) = Value2;
out(3,:) = CG;
out(4,:) = Trigger;
end
