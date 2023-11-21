%{
study("Ehlers Hurst Coefficient [CC]", overlay=false)

inp = input(title="Source", type=input.source, defval=close)
src = security(syminfo.tickerid, res, inp[rep ? 0 : barstate.isrealtime ? 1 : 0])[rep ? 0 : barstate.isrealtime ? 0 : 1]
length = input(title="Length", type=input.integer, defval=30, minval=1)
ssfLength = input(title="SSFLength", type=input.integer, defval=20, minval=1)

pi = 2 * asin(1)
alpha = exp(-1.414 * pi / ssfLength)
beta = 2 * alpha * cos(1.414 * pi / ssfLength)
c2 = beta
c3 = -alpha * alpha
c1 = 1 - c2 - c3
hLength = ceil(length / 2)

n3 = (highest(src, length) - lowest(src, length)) / length
hh = src, ll = src
for i = 0 to hLength - 1
    price = nz(src[i])
    hh := price > hh ? price : hh
    ll := price < ll ? price : ll
    
n1 = (hh - ll) / hLength
hh := nz(src[hLength])
ll := nz(src[hLength])
for i = hLength to length - 1
    price = nz(src[i])
    hh := price > hh ? price : hh
    ll := price < ll ? price : ll
    
n2 = (hh - ll) / hLength
dimen = 0.0
dimen := n1 > 0 and n2 > 0 and n3 > 0 ? 0.5 * (((log(n1 + n2) - log(n3)) / log(2)) + dimen[1]) : 0
hurst = 2 - dimen

smoothHurst = 0.0
smoothHurst := (c1 * ((hurst + nz(hurst[1])) / 2)) + (c2 * nz(smoothHurst[1])) + (c3 * nz(smoothHurst[2]))

sig = smoothHurst > 0.5 ? 1 : smoothHurst < 0.5 ? -1 : 0
%}
function out = EhlersHurst(C)
src = C;
Length = 30;
ssfLength = 20;
hLength = ceil(Length / 2);
Z = zeros(1,length(src));
persistent XEHst
if isempty(XEHst)
    alpha = exp(-1.414 * pi / ssfLength);
    beta = 2 * alpha * cos(1.414 * pi / ssfLength);
    c2 = beta;
    c3 = -alpha * alpha;
    c1 = 1 - c2 - c3;
    XEHst.c1 = c1;
    XEHst.c2 = c2;
    XEHst.c3 = c3;
    XEHst.srcwin = repmat(src,Length,1);
    XEHst.dimenp = Z;
    XEHst.hurstp = ones(1,length(src));
    XEHst.smoothHurstp = Z;
    XEHst.smoothHurstpp = Z;
end
c1 = XEHst.c1;
c2 = XEHst.c2;
c3 = XEHst.c3;
XEHst.srcwin = [src;XEHst.srcwin(1:end-1,:)];
n3 = (max(XEHst.srcwin) - min(XEHst.srcwin)) / Length;
hh = src; ll = src;
for hi = 1:hLength
    price = XEHst.srcwin(hi,:);
    k = find(price > hh);
    hh(k) = price(k);
    k = find(price < ll);
    ll(k) = price(k);
end
n1 = (hh - ll) / hLength;
hh = XEHst.srcwin(hLength,:);
ll = XEHst.srcwin(hLength,:);
for i = hLength:Length
    price = XEHst.srcwin(i,:);
    k = find(price > hh);
    hh(k) = price(k);
    k = find(price < ll);
    ll(k) = price(k);
end
n2 = (hh - ll) / hLength;
dimen = Z;
k = find(n1 > 0 & n2 > 0 & n3 > 0);
dimen(k) = 0.5 * (((log(n1(k) + n2(k)) - log(n3(k))) / log(2))...
    + XEHst.dimenp(k));
hurst = 2 - dimen;
smoothHurst = c1 * (hurst + XEHst.hurstp) / 2 + ...
    (c2 * XEHst.smoothHurstp) + ...
    (c3 * XEHst.smoothHurstpp);
sig = Z;
sig(smoothHurst > 0.5) = 1;
sig(smoothHurst < 0.5) = -1;
XEHst.dimenp = dimen;
XEHst.hurstp = hurst;
XEHst.smoothHurstpp = XEHst.smoothHurstp;
XEHst.smoothHurstp = smoothHurst;
out(1,:) = hurst;
out(2,:) = smoothHurst;
end
