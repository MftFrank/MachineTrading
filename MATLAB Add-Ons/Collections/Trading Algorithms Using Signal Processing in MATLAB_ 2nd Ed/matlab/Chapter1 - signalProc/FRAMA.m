%{
https://pastebin.com/6xyjP2ST
https://www.tradingview.com/chart/BTCUSD/dGX0ADIk-Indicator-Fractal-Adaptive-Moving-Average-FRAMA/
study(title = "Fractal Adaptive Moving Average [LazyBear]", shorttitle="FRAMA_LB", overlay=true)
length=input(16, title="Period of Fractal AMA (even #)",minval=4,maxval=60)
w=input(-4.6, title="W", type=float)
src=hl2
n3=(highest(high,length)-lowest(low,length))/length
hd2=highest(high,length/2)
ld2=lowest(low,length/2)
n2=(hd2-ld2)/(length/2)
n1=(nz(hd2[round(length/2)])-nz(ld2[round(length/2)]))/round(length/2)
dimen=(n1>0 and n2>0 and n3>0 ? (log(n1+n2)-log(n3))/log(2) : 0)
alpha=exp(w*(dimen-1))
sc=(alpha<.01 ? .01 : (alpha>1 ? 1 : alpha))
//prev(x) => not na(x[1]) ? x[1] : 0
frama=(cum(1)<=2*length ? src : src*sc+nz(frama[1])*(1-sc))
%}
function out = FRAMA(H,L)
src = (H+L)/2;
Length = 16;
w = -4.6;
persistent Xframa
if isempty(Xframa)
    Xframa.hiwin = repmat(H,Length,1);
    Xframa.lowin = repmat(L,Length,1);
    Xframa.hd2win = repmat(H,Length/2,1);
    Xframa.ld2win = repmat(L,Length/2,1);
    Xframa.framap = src;
end
Xframa.hiwin = [H;Xframa.hiwin(1:end-1,:)];
Xframa.lowin = [L;Xframa.lowin(1:end-1,:)];
n3 = (max(Xframa.hiwin)-min(Xframa.lowin))/Length;
hd2 = max(Xframa.hiwin(1:Length/2,:));
ld2 = min(Xframa.lowin(1:Length/2,:));
Xframa.hd2win = [hd2;Xframa.hd2win(1:end-1,:)];
Xframa.ld2win = [ld2;Xframa.ld2win(1:end-1,:)];
n2 = (hd2-ld2)/(Length/2);
n1 = (Xframa.hd2win(end,:)-Xframa.ld2win(end,:))./...
    round(Length/2);
dimen = (log(n1+n2)-log(n3))/log(2);
dimen(~(n1>0 & n2>0 & n3>0)) = 0;
alpha = exp(w*(dimen-1));
tmp = alpha;
tmp(alpha>1) = 1;
sc = tmp;
sc(alpha<.01) = 0.01;
frama = src.*sc + Xframa.framap.*(1-sc);
Xframa.framap = frama;
out(1,:) = frama;
end
