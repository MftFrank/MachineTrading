%{
https://www.tradingview.com/script/cGtwC2C9-Indicator-Vertical-Horizontal-Filter-VHF/
// VHF determines whether prices are in trneding or congestion phase. 
// 
study(title = "Vertical Horizontal Filter [LazyBear]", shorttitle="VHF_LB")
src=close
length=input(28, title="VHF Period")
showEma=input(false, title="Show EMA?", type=bool)

hcp=highest(src, length)
lcp=lowest(src, length)
cdiff=abs(close-close[1])

N=abs(hcp-lcp)
D=sum(cdiff, length)
vhf=N/D
%}
function out = VHF(C)
src = C;
Length = 28;
Z = zeros(1,length(src));
persistent Xvhf
if isempty(Xvhf)
    Xvhf.Cwin = repmat(src,Length,1);
    Xvhf.cdiffwin = repmat(Z,Length,1);
    Xvhf.Cp = src;
end
Xvhf.Cwin = [src;Xvhf.Cwin(1:end-1,:)];
hcp=max(Xvhf.Cwin);
lcp=min(Xvhf.Cwin);
cdiff=abs(src-Xvhf.Cp);
Xvhf.cdiffwin = [cdiff;Xvhf.cdiffwin(1:end-1,:)];
N=abs(hcp-lcp);
D=sum(Xvhf.cdiffwin);
vhf=N./D;
Xvhf.Cp = src;
out = vhf;
end
