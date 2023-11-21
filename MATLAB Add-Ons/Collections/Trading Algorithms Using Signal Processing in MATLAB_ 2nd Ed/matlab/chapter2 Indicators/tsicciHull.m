%{
https://www.tradingview.com/script/Ch8xB1Fc-TSI-CCI-Hull-with-profit-Alert-version/
study(title="TSI CCI Hull", shorttitle="TSICCIHULL", overlay=true)
long = input(title="Long Length", type=input.integer, defval=50)
short = input(title="Short Length", type=input.integer, defval=52)
signal = input(title="Signal Length", type=input.integer, defval=24)
price=input(title="Source",type=input.source,defval=close)
Period=input(26, minval=1)
lineupper = input(title="Upper Line", type=input.integer, defval=100)
linelower = input(title="Lower Line", type=input.integer, defval=-100)
p=price
length= Period
double_smooth(src, long, short) =>
    fist_smooth = ema(src, long)
    ema(fist_smooth, short)
pc = change(price)
double_smoothed_pc = double_smooth(pc, long, short)
double_smoothed_abs_pc = double_smooth(abs(pc), long, short)
tsi_value = 100 * (double_smoothed_pc / double_smoothed_abs_pc)
keh = tsi_value*5 > linelower ? color.red : color.lime
teh = ema(tsi_value*5, signal*5) > lineupper ? color.red : color.lime
meh = ema(tsi_value*5, signal*5) > tsi_value*5 ? color.red : color.lime
n2ma = 2 * wma(p, round(length / 2))
nma = wma(p, length)
diff = n2ma - nma
sqn = round(sqrt(length))
n1 = wma(diff, sqn)
cci = (p - n1) / (0.015 * dev(p, length))
c = cci > 0 ? color.lime : color.red
c1 = cci > 20 ? color.lime : color.silver
c2 = cci < -20 ? color.red : color.silver
TSI1=ema(tsi_value*5, signal*5)
TSI2=ema(tsi_value*5, signal*5)[2]

hullma_smoothed = wma(2*wma(n1, Period/2)-wma(n1, Period), round(sqrt(Period)))

longCondition = TSI1>TSI2 and hullma_smoothed<price and cci>0

shortCondition = TSI1<TSI2 and hullma_smoothed>price and cci<0
    
bbuy = longCondition and cci>cci[1] and cci > 0 and n1>n1[1]
ssell = shortCondition and cci<cci[1] and cci < 0 and n1<n1[1]
%}
function out = tsicciHull(C)
long = 50;
short = 52;
signal = 24;
alo = 2/(long+1);
ash = 2/(short+1);
asig = 2/(signal*5+1);
p=C;
Period=26;
Length = Period;
Z = zeros(1,length(C));
tmp = Length:-1:1;
bwma = tmp/sum(tmp);
tmp = Length/2:-1:1;
bwma2 = tmp/sum(tmp);
weirdLen = round(sqrt(Length));
tmp = weirdLen:-1:1;
bw = tmp/sum(tmp);
persistent Xtsicci
if isempty(Xtsicci)
    Xtsicci.Cp = p;
    Xtsicci.pclop = Z;
    Xtsicci.pcshp = Z;
    Xtsicci.pcalop = Z;
    Xtsicci.pcashp = Z;
    Xtsicci.tsip = Z;
    Xtsicci.tsipp = Z;
    Xtsicci.pwin = repmat(p,Length,1);
    Xtsicci.diffwin = repmat(p,round(sqrt(Length)),1);
    Xtsicci.n1win = repmat(p,Period,1);
    Xtsicci.hullwin = repmat(p,round(sqrt(Length)),1);
    Xtsicci.devwin = repmat(p,Length,1);
    Xtsicci.n1p = p;
    Xtsicci.ccip = Z;
end
Xtsicci.pwin = [p;Xtsicci.pwin(1:end-1,:)];
pc = p - Xtsicci.Cp;
tmp1 = (1-alo)*Xtsicci.pclop + alo*pc;
double_smoothed_pc = (1-ash)*Xtsicci.pcshp + ash*tmp1;
tmp2 = (1-alo)*Xtsicci.pcalop + alo*abs(pc);
double_smoothed_abs_pc = (1-ash)*Xtsicci.pcashp + ash*tmp2;
double_smoothed_abs_pc(double_smoothed_abs_pc==0) = 1;
tsi_value = 100 * (double_smoothed_pc ./ ...
	double_smoothed_abs_pc);
tsi_value_5 = (1-asig)*Xtsicci.tsip + asig*tsi_value*5;
diff = 2*sum(bwma2'.*Xtsicci.pwin(1:length(bwma2),:)) - ...
    sum(bwma'.*Xtsicci.pwin);
Xtsicci.diffwin = [diff;Xtsicci.diffwin(1:end-1,:)];
n1 = sum(bw'.*Xtsicci.diffwin);
Xtsicci.n1win = [n1;Xtsicci.n1win(1:end-1,:)];
Xtsicci.devwin = [abs(p - sum(Xtsicci.pwin)/Length);...
    Xtsicci.devwin(1:end-1,:)];
tmpdev = sum(Xtsicci.devwin)/Length;
cci = (p - n1) ./ (0.015 * tmpdev);
TSI1 = tsi_value_5;
TSI2 = Xtsicci.tsipp;
tmph = 2*sum(bwma2'.*Xtsicci.n1win(1:length(bwma2),:)) - ...
    sum(bwma'.*Xtsicci.n1win);
Xtsicci.hullwin = [tmph;Xtsicci.hullwin(1:end-1,:)];
hullma_smoothed = sum(bw'.*Xtsicci.hullwin);
longCondition = TSI1>TSI2 & hullma_smoothed<p & cci>0;
shortCondition = TSI1<TSI2 & hullma_smoothed>p & cci<0;
bbuy = longCondition & cci>Xtsicci.ccip & cci > 0 & n1>Xtsicci.n1p;
ssell = shortCondition & cci<Xtsicci.ccip & cci < 0 & n1<Xtsicci.n1p;
Xtsicci.pclop = tmp1;
Xtsicci.pcshp = double_smoothed_pc;
Xtsicci.pcalop = tmp2;
Xtsicci.pcashp = double_smoothed_abs_pc;
Xtsicci.tsipp = Xtsicci.tsip;
Xtsicci.tsip = tsi_value_5;
Xtsicci.n1p = n1;
Xtsicci.ccip = cci;
out(1,:) = hullma_smoothed;
out(2,:) = cci;
out(3,:) = bbuy;
out(4,:) = ssell;
end
