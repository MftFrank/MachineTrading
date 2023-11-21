%{
//// Ehlers Stochastic CG (Center of Gravity) indicator/oscillator 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers

Inputs: Price((H+L)/2);
Var{Inputs}:Length(8),SCGdelimiter(80);
Vars: count(0),Num(0),Denom(0),CG(0),MaxCG(0),MinCG(0);
Num = 0; Denom = 0;
For count = 0 to Length - 1 begin
Num = Num + (1 + count)*(Price[count]);
Denom = Denom + (Price[count]);
End;
If Denom <> 0 then CG = -Num/Denom + (Length + 1) / 2;
MaxCG = Highest(CG, Length);
MinCG = Lowest(CG, Length);
If MaxCG <> MinCG then Value1 = (CG - MinCG) / (MaxCG - MinCG);
Value2 = (4*Value1 + 3*Value1[1] + 2*Value1[2] + Value1[3]) / 10;
Value2 = 2*(Value2 - .5);
Plot2(.96*(Value2[1] + .02), "Trigger",green);
%}
function out = EhlersStochCG(H,L)
persistent XEhlStochCG
Len = 8;
SGdelimiter = 80;
Price = (H + L)/2;
b = [4 3 2 1]/10;
if isempty(XEhlStochCG)
    XEhlStochCG.prwin = repmat(Price,Len,1);
    XEhlStochCG.CGwin = repmat(ones(1,length(H)),Len,1);
    XEhlStochCG.Val2win = repmat(zeros(1,length(H)),length(b),1);
    XEhlStochCG.Value2p = zeros(1,length(H));
end
Num = zeros(1,length(H));
Denom = zeros(1,length(H));
XEhlStochCG.prwin = [Price;XEhlStochCG.prwin(1:end-1,:)];
for count = 1:Len
    Num = Num + (1+count)*XEhlStochCG.prwin(count,:);
    Denom = Denom + XEhlStochCG.prwin(count,:);
end
Denom(Denom==0) = 1;
CG = -Num./Denom + (Len + 1) / 2;
XEhlStochCG.CGwin = [CG;XEhlStochCG.CGwin(1:end-1,:)];
MaxCG = max(XEhlStochCG.CGwin);
MinCG = min(XEhlStochCG.CGwin);
tmp = MaxCG - MinCG;
tmp(tmp==0) = 1;
Value1 = (CG - MinCG) ./ tmp;
XEhlStochCG.Val2win = [Value1;XEhlStochCG.Val2win(1:end-1,:)];
Value2 = sum(b'.*XEhlStochCG.Val2win);
Value2 = 2*(Value2 - .5);
Trigger = 0.96*(XEhlStochCG.Value2p + .02);
XEhlStochCG.Value2p = Value2;
out(1,:) = Value1;
out(2,:) = Value2;
out(3,:) = Trigger;
end
