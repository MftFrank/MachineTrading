%{
https://www.tradingview.com/script/xzRPAboO-Indicator-Kairi-Relative-Index-KRI/
// http://www.investopedia.com/articles/forex/09/kairi-relative-strength-index.asp
// The Kairi Relative Index is considered an oscillator as well as a leading indicator.
//

study("Kairi Relative Index [LazyBear]", shorttitle="KAIRI_LB")
length=input(14)
ki(src)=>
    ((src - sma(src, length))/sma(src, length)) * 100
plot(ki(close), color=red, linewidth=2)
%}
function out = kairiIdx(C)
Length = 14;
src = C;
persistent Xkairi
if isempty(Xkairi)
    Xkairi.srcwin = repmat(src,Length,1);
end
Xkairi.srcwin = [src;Xkairi.srcwin(1:end-1,:)];
tmp = sum(Xkairi.srcwin)/Length;
ki = (src - tmp)./tmp*100;
out = ki;
end
