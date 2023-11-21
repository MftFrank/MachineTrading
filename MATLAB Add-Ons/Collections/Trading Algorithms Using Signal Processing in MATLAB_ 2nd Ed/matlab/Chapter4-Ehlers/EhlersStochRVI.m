%{
//// Ehlers Stochastic RVI Index - coded by dn -From Cybernetic Analysis for Stocks and Futures - plots same as code below
Var {Inputs}: Length(7),delimiter(80);
Vars: Num(0),Denom(0),count(0),RVI(0),MaxRVI(0),MinRVI(0);
Value1 = ((Close - Open) + 2*(Close[1] - Open[1]) + 2*(Close[2] - Open[2]) + (Close[3] - Open[3]))/6;
Value2 = ((High - Low) + 2*(High[1] - Low[1]) + 2*(High[2] - Low[2]) + (High[3] - Low[3]))/6;
Num = 0; Denom = 0;
For count = 0 to Length - 1 begin
Num = Num + Value1[count];
Denom = Denom + Value2[count];
End;
If Denom <> 0 then RVI = Num / Denom;
MaxRVI = Highest(RVI, Length);
MinRVI = Lowest(RVI, Length);
If MaxRVI <> MinRVI then Value3 = (RVI - MinRvi) / (MaxRVI - MinRVI);
Value4 = (4*Value3 + 3*Value3[1] + 2*value3[2] + Value3[3]) / 10;
Value4 = 2*(Value4 - .5);
Plot1(Value4, "RVI");
Plot2(.96*(Value4[1] + .02), "Trigger", blue);
%}
function out = EhlersStochRVI(C,O,H,L)
Len = 7;
bsm = [1 2 2 1]/6;
b = [4 3 2 1]/10;
persistent XStochRVI
if isempty(XStochRVI)
    XStochRVI.cowin = repmat(C-O,length(bsm),1);
    XStochRVI.hlwin = repmat(H-L,length(bsm),1);
    XStochRVI.Val1win = repmat(ones(1,length(H)),Len,1);
    XStochRVI.Val2win = repmat(ones(1,length(H)),Len,1);
    XStochRVI.rviwin = repmat(ones(1,length(H)),Len,1);
    XStochRVI.Val3win = repmat(zeros(1,length(H)),length(bsm),1);
    XStochRVI.Val4p = zeros(1,length(H));
end
XStochRVI.cowin = [C-O;XStochRVI.cowin(1:end-1,:)];
XStochRVI.hlwin = [H-L;XStochRVI.hlwin(1:end-1,:)];
Value1 = sum(bsm'.*XStochRVI.cowin);
Value2 = sum(bsm'.*XStochRVI.hlwin);
XStochRVI.Val1win = [Value1;XStochRVI.Val1win(1:end-1,:)];
XStochRVI.Val2win = [Value2;XStochRVI.Val2win(1:end-1,:)];
Num = zeros(1,length(H)); 
Denom = zeros(1,length(H));
for count = 1:Len
    Num = Num + XStochRVI.Val1win(count,:);
    Denom = Denom + XStochRVI.Val2win(count,:);
end
Denom(Denom==0) = 1;
RVI = Num ./ Denom;
XStochRVI.rviwin = [RVI;XStochRVI.rviwin(1:end-1,:)];
MaxRVI = max(XStochRVI.rviwin);
MinRVI = min(XStochRVI.rviwin);
tmp = MaxRVI - MinRVI;
tmp(tmp==0) = 1;
Value3 = (RVI - MinRVI) ./ tmp;
XStochRVI.Val3win = [Value3;XStochRVI.Val3win(1:end-1,:)];
Value4 = sum(b'.*XStochRVI.Val3win);
Value4 = 2*(Value4 - .5);
Trigger = 0.96*(XStochRVI.Val4p + .02);
XStochRVI.Val4p = Value4;
out(1,:) = RVI;
out(2,:) = Value3;
out(3,:) = Value4;
out(4,:) = Trigger;
end
