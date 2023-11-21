%{
study(title="Schaff Trend Cycle [LazyBear]", shorttitle="STC_LB", overlay=true)
length=input(10)
fastLength=input(23)
slowLength=input(50)
macd(source, fastLength, slowLength) =>
    fastMA = ema(source, fastLength)
    slowMA = ema(source, slowLength)
    macd = fastMA - slowMA
    macd
stc(length, fastLength, slowLength) => 
    factor=input(0.5)  
    m = macd(close,fastLength,slowLength)     
    v1 = lowest(m, length)
    v2 = highest(m, length) - v1    
    f1 = (v2 > 0 ? ((m - v1) / v2) * 100 : nz(f1[1])) 
    pf = (na(pf[1]) ? f1 : pf[1] + (factor * (f1 - pf[1]))) 
    v3 = lowest(pf, length) 
    v4 = highest(pf, length) - v3     
    f2 = (v4 > 0 ? ((pf - v3) / v4) * 100 : nz(f2[1])) 
    pff = (na(pff[1]) ? f2 : pff[1] + (factor * (f2 - pff[1])))
    pff
%}
function out = Schaff(C)
Length = 10;
fastLength = 23;
slowLength = 50;
af = 2/(fastLength+1);
as = 2/(slowLength+1);
factor = 0.5;
Z = zeros(1,length(C));
persistent Xsch
if isempty(Xsch)
    Xsch.fmap = C;
    Xsch.smap = C;
    Xsch.macdwin = repmat(Z,Length,1);
    Xsch.pfwin = repmat(Z,Length,1);
    Xsch.f1p = Z;
    Xsch.pfp = Z;
    Xsch.f2p = Z;
    Xsch.pffp = Z;
end
fastMA = (1-af)*Xsch.fmap + af*C;
slowMA = (1-as)*Xsch.smap + as*C;
m = fastMA - slowMA; % MACD
Xsch.macdwin = [m;Xsch.macdwin(1:end-1,:)];
v1 = min(Xsch.macdwin);
v2 = max(Xsch.macdwin) - v1;
f1 = Xsch.f1p;
k = find(v2>0);
f1(k) = (m(k) - v1(k)) ./ v2(k) * 100;
pf = Xsch.pfp + factor * (f1 - Xsch.pfp);
k = find(Xsch.pfp);
pf(k) = f1(k);
Xsch.pfwin = [pf;Xsch.pfwin(1:end-1,:)];
v3 = min(Xsch.pfwin);
v4 = max(Xsch.pfwin) - v3;
f2 = Xsch.f2p;
k = find(v4>0);
f2(k) = (pf(k) - v3(k)) ./ v4(k) * 100;
pff = Xsch.pffp + factor * (f2 - Xsch.pffp);
k = find(Xsch.pffp);
pff(k) = f2(k);
Xsch.fmap = fastMA;
Xsch.smap = slowMA;
Xsch.f1p = f1;
Xsch.pfp = pf;
out(1,:) = pff;
out(2,:) = m;
out(3,:) = fastMA;
out(4,:) = slowMA;
end
