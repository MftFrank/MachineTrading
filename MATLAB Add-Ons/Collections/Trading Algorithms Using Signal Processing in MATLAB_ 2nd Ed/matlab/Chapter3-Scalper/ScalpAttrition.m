%{
https://www.tradingview.com/script/KDLzj2PW-Attrition-Scalper-v1-0/
VID(src, vidyauzunluk) =>
    momentum = change(src)
    upSum = sum(max(momentum, 0), vidyauzunluk)
    downSum = sum(-min(momentum, 0), vidyauzunluk)
    oute = (upSum - downSum) / (upSum + downSum)
    oute

vidyakaynak = close
vidyauzunluk = 9
vid = abs(VID(vidyakaynak, vidyauzunluk))
alpha = 2 / (vidyauzunluk + 1)
vidya = 0.0
vidya2 = 0.0
vidya3 = 0.0
vidya := vidyakaynak * alpha * vid + nz(vidya[1]) * (1 - alpha * vid)

lan = 20
p = close
sma = sma(p, lan)
avg = atr(lan)
fibratio1 = 1.618
fibratio2 = 2.618
fibratio3 = 4.236
r1 = avg * fibratio1
r2 = avg * fibratio2
r3 = avg * fibratio3
top3 = sma + r3
top2 = sma + r2
top1 = sma + r1
bott1 = sma - r1
bott2 = sma - r2
bott3 = sma - r3
%}
function out = ScalpAttrition(H,L,C)
lan = 20;
alph = 1/lan;
v = 9;
alpha = 2/(v+1);
p = C;
fibratio1 = 1.618;
fibratio2 = 2.618;
fibratio3 = 4.236;
persistent XScAtt
if isempty(XScAtt)
    XScAtt.Cwin = repmat(p,lan,1);
    XScAtt.atrp = max(H-L,max(H-p,abs(L-p)));
    XScAtt.momentum = zeros(v,length(H));
    XScAtt.vidyap = p;
end
XScAtt.Cwin = [p;XScAtt.Cwin(1:end-1,:)];
XScAtt.momentum = [XScAtt.Cwin(1,:)-XScAtt.Cwin(2,:);...
    XScAtt.momentum(1:end-1,:)];
upSum = sum(max(XScAtt.momentum,0));
downSum = sum(-min(XScAtt.momentum,0));
vid = abs(upSum - downSum) ./ (upSum + downSum);
vid(isnan(vid)) = 0;
vidya = p.*alpha.*vid + XScAtt.vidyap .* (1 - alpha .* vid);
sma = sum(XScAtt.Cwin)/lan;
atr = max(H-L,max(H-XScAtt.Cwin(2,:),...
    abs(L-XScAtt.Cwin(2,:))));
avg = (1-alph)*XScAtt.atrp + alph*atr;
r1 = avg * fibratio1;
r2 = avg * fibratio2;
r3 = avg * fibratio3;
top3 = sma + r3;
top2 = sma + r2;
top1 = sma + r1;
bott1 = sma - r1;
bott2 = sma - r2;
bott3 = sma - r3;
% updates
XScAtt.vidyap = vidya;
XScAtt.atrp = avg;
out(1,:) = sma;
out(2,:) = top1;
out(3,:) = top2;
out(4,:) = top3;
out(5,:) = bott1;
out(6,:) = bott2;
out(7,:) = bott3;
out(8,:) = vidya;
end
