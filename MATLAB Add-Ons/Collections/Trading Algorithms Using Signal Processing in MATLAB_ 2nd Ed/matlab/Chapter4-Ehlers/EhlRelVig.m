%{
//// Ehlers Relative Vigor Index - coded by dn
//// From Cybernetic Analysis for Stocks and Futures

Inputs: Length(10);
Vars: Num(0),
Denom(0),
Count(0),
RVI(0),
Trigger(0);
Value1 = ((Close - Open) + 
2*(Close[1] - Open[1]) + 2*(Close[2] - Open[2])
+ (Close[3] - Open[3]))/6;
Value2 = ((High - Low) + 2 * (High[1]
- Low[1]) + 2 * (High[2] - Low[2]) + (High[3] - Low[3]))/6;
Num = 0;
Denom = 0;
For count = 0 to Length -1 begin
Num = Num + Value1 [count];
Denom = Denom + Value2[count];
End;
If Denom <> 0 then RVI = Num / Denom;
Trigger = RVI[1];
%}
function out = EhlRelVig(C,O,H,L)
persistent XEhlRelVig
Len = 10;
b = [1 2 2 1]/6;
if isempty(XEhlRelVig)
    XEhlRelVig.clopwin = repmat(C-O,length(b),1);
    XEhlRelVig.hilowin = repmat(H-L,length(b),1);
    XEhlRelVig.Val1win = ones(Len,length(H));
    XEhlRelVig.Val2win = ones(Len,length(H));
    XEhlRelVig.RVIp = zeros(1,length(H));
end
XEhlRelVig.clopwin = [C-O;XEhlRelVig.clopwin(1:end-1,:)];
XEhlRelVig.hilowin = [H-L;XEhlRelVig.hilowin(1:end-1,:)];
Value1 = sum(b'.*XEhlRelVig.clopwin);
Value2 = sum(b'.*XEhlRelVig.hilowin);
XEhlRelVig.Val1win = [Value1;XEhlRelVig.Val1win(1:end-1,:)];
XEhlRelVig.Val2win = [Value2;XEhlRelVig.Val2win(1:end-1,:)];
Num = zeros(1,length(H));
DeNum = zeros(1,length(H));
for i = 1:Len
    Num = Num + XEhlRelVig.Val1win(i,:);
    DeNum = DeNum + XEhlRelVig.Val2win(i,:);
end
DeNum(DeNum==0) = 1;
RVI = Num ./ DeNum;
Trigger = XEhlRelVig.RVIp;
XEhlRelVig.RVIp = RVI;
out(1,:) = Value1;
out(2,:) = Value2;
out(3,:) = RVI;
out(4,:) = Trigger;
end
