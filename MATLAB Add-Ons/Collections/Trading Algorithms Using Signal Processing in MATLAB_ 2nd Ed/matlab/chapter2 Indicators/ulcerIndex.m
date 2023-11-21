%{
https://www.tradingview.com/script/QuqgdJgF-Indicator-Ulcer-Index/
study(title = "Ulcer Index [LazyBear]", shorttitle="UlcerIndex_LB")
length=input(10)
cutoff=input(5)
hcl=highest(close,length)
r=100.0*((close-hcl)/hcl)
ui=sqrt(sum(pow(r,2), length)/length)
%}
function out = ulcerIndex(C)
Length = 10;
cutoff = 5;
persistent Xuidx
if isempty(Xuidx)
    Xuidx.Cwin = repmat(C,Length,1);
    Xuidx.r2win = repmat(C,Length,1);
end
Xuidx.Cwin = [C;Xuidx.Cwin(1:end-1,:)];
hcl = max(Xuidx.Cwin);
r = 100*(C-hcl)./hcl;
Xuidx.r2win = [power(r,2);Xuidx.r2win(1:end-1,:)];
ui = sqrt(sum(Xuidx.r2win)/Length);
out(1,:) = ui;
out(2,:) = cutoff;
end
