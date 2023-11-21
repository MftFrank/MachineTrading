%{
https://www.tradingview.com/script/Jccjg8CR-Indicators-Twiggs-Money-Flow-TMF-Wilder-s-MA-WiMA/#tc73426
study("Twiggs Money Flow [LazyBear]", shorttitle="TMF_LB")
length = input( 21, "Period")
WiMA(src, length) => 
    MA_s=(src + nz(MA_s[1] * (length-1)))/length
    MA_s
    
hline(0)
tr_h=max(close[1],high)
tr_l=min(close[1],low)
tr_c=tr_h-tr_l
adv=volume*((close-tr_l)-(tr_h-close))/ iff(tr_c==0,9999999,tr_c)
wv=volume+(volume[1]*0)
wmV= WiMA(wv,length)
wmA= WiMA(adv,length)
tmf= iff(wmV==0,0,wmA/wmV)
%}
function out = twiggMF(H,L,C,V)
close = C;
high = H;
low = L;
volume = V;
Length = 21;
Z = zeros(1,length(high));
persistent Xtwmf
if isempty(Xtwmf)
    Xtwmf.Cp = close;
    Xtwmf.Vp = volume;
    Xtwmf.wmVp = volume;
    Xtwmf.wmAp = Z;
end
tr_h = max(Xtwmf.Cp,high);
tr_l = min(Xtwmf.Cp,low);
tr_c = tr_h - tr_l;
tmp = tr_c;
tmp(tr_c==0) = 9999999;
adv = volume.*((close-tr_l)-(tr_h-close))./tmp;
wv = volume+(Xtwmf.Vp.*0);
wmV = (wv + Xtwmf.wmVp*(Length-1))/Length;
wmA = (adv + Xtwmf.wmAp*(Length-1))/Length;
tmf = wmA./wmV;
tmf(wmV==0) = 0;
Xtwmf.Cp = close;
Xtwmf.Vp = volume;
Xtwmf.wmVp = wmV;
Xtwmf.wmAp = wmA;
out(1,:) = adv;
out(2,:) = wv;
out(3,:) = wmV;
out(4,:) = wmA;
out(5,:) = tmf;
end
