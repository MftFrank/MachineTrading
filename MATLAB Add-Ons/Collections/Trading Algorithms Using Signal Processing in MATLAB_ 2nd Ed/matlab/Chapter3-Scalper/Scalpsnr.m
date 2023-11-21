%{
https://www.tradingview.com/script/GVCNmuK0-Ehlers-Alternate-Signal-To-Noise-Ratio-CC/
study("Ehlers Alternate Signal To Noise Ratio [CC]", overlay=false)

f_security(_symbol, _res, _src, _repaint) => 
    security(_symbol, _res, _src[_repaint ? 0 : barstate.isrealtime ? 1 : 0])[_repaint ? 0 : barstate.isrealtime ? 0 : 1]
    
res = input(title="Resolution", type=input.resolution, defval="")
rep = input(title="Allow Repainting?", type=input.bool, defval=false)
bar = input(title="Allow Bar Color Change?", type=input.bool, defval=true)
src = f_security(syminfo.tickerid, res, hl2, rep)
h = f_security(syminfo.tickerid, res, high, rep)
l = f_security(syminfo.tickerid, res, low, rep)

pi = 2 * asin(1)
period = 0.0
range = 0.0
range := (0.1 * (h - l)) + (0.9 * nz(range[1]))

smooth = ((4 * src) + (3 * nz(src[1])) + (2 * nz(src[2])) + nz(src[3])) / 10
detrender = ((0.0962 * smooth) + (0.5769 * nz(smooth[2])) - (0.5769 * nz(smooth[4])) - (0.0962 * nz(smooth[6]))) * ((0.075 * nz(period[1])) + 0.54)

q1 = ((0.0962 * detrender) + (0.5769 * nz(detrender[2])) - (0.5769 * nz(detrender[4])) - (0.0962 * nz(detrender[6]))) * ((0.075 * nz(period[1])) + 0.54)
i1 = nz(detrender[3])

jI = ((0.0962 * i1) + (0.5769 * nz(i1[2])) - (0.5769 * nz(i1[4])) - (0.0962 * nz(i1[6]))) * ((0.075 * nz(period[1])) + 0.54)
jQ = ((0.0962 * q1) + (0.5769 * nz(q1[2])) - (0.5769 * nz(q1[4])) - (0.0962 * nz(q1[6]))) * ((0.075 * nz(period[1])) + 0.54)

i2 = i1 - jQ
i2 := (0.2 * i2) + (0.8 * nz(i2[1]))
q2 = q1 + jI
q2 := (0.2 * q2) + (0.8 * nz(q2[1]))

re = (i2 * nz(i2[1])) + (q2 * nz(q2[1]))
re := (0.2 * re) + (0.8 * nz(re[1]))
im = (i2 * nz(q2[1])) - (q2 * nz(i2[1]))
im := (0.2 * im) + (0.8 * nz(im[1]))

period := im != 0 and re != 0 ? 2 * pi / atan(im / re) : 0
period := min(max(period, 0.67 * nz(period[1])), 1.5 * nz(period[1]))
period := min(max(period, 6), 50)
period := (0.2 * period) + (0.8 * nz(period[1]))

snr = 0.0
snr := range > 0 ? (0.25 * ((10 * log((re + im) / (range * range)) / log(10)) + 6)) + (0.75 * nz(snr[1])) : 0

hline(6)
sig = src > smooth ? 1 : src < smooth ? -1 : 0
%}
function out = Scalpsnr(H,L,C)
src = (H+L)/2;
bsm = [4 3 2 1]/10;
bbp = [0.0962 0 0.5769 0 -0.5769 0 -0.0962];
persistent Xsnr
if isempty(Xsnr)
    Z = zeros(1,length(H));
    Xsnr.rangep = H-L;
    Xsnr.periodp = Z;
    Xsnr.srcwin = repmat(src,length(bsm),1);
    Xsnr.smwin = repmat(Z,length(bbp),1);
    Xsnr.detwin = repmat(Z,length(bbp),1);
    Xsnr.i1win = repmat(Z,length(bbp),1);
    Xsnr.q1win = repmat(Z,length(bbp),1);
    Xsnr.I2p = Z;
    Xsnr.Q2p = Z;
    Xsnr.rep = Z;
    Xsnr.imp = Z;
    Xsnr.snrp = Z;
end
tmp = (0.075 * Xsnr.periodp) + 0.54;
Xsnr.srcwin = [src;Xsnr.srcwin(1:end-1,:)];
range = 0.1*(H-L).*(H-L)/4 + 0.9*Xsnr.rangep;
smooth = sum(bsm'.*Xsnr.srcwin);
Xsnr.smwin = [smooth;Xsnr.smwin(1:end-1,:)];
detrender = sum(bbp'.*Xsnr.smwin.*tmp);
Xsnr.detwin = [detrender;Xsnr.detwin(1:end-1,:)];
q1 = sum(bbp'.*Xsnr.detwin.*tmp);
i1 = Xsnr.detwin(4,:);
Xsnr.i1win = [i1;Xsnr.i1win(1:end-1,:)];
Xsnr.q1win = [q1;Xsnr.q1win(1:end-1,:)];
jI = sum(bbp'.*Xsnr.i1win.*tmp);
jQ = sum(bbp'.*Xsnr.q1win.*tmp);
i2 = i1 - jQ;
i2 = 0.2 * i2 + 0.8 * Xsnr.I2p;
q2 = q1 + jI;
q2 = 0.2 * q2 + 0.8 * Xsnr.Q2p;
re = (i2 .* Xsnr.I2p) + (q2 .* Xsnr.Q2p);
re = (0.2 * re) + (0.8 * Xsnr.rep);
im = (i2 .* Xsnr.Q2p) - (q2 .* Xsnr.I2p);
im = (0.2 * im) + (0.8 * Xsnr.imp);
period = zeros(1,length(C));
k = find(im ~= 0 & re ~= 0);
period(k) = 2 * pi ./ atan(im(k) ./ re(k));
period = min(period,1.5 * Xsnr.periodp);
period = max(period,0.67 * Xsnr.periodp);
period = min(period,50);
period = max(period,6);
period = (0.2 * period) + (0.8 * Xsnr.periodp);
snr = zeros(1,length(C));
k = find((range > 0)&(re ~= 0)&(im ~= 0));
snr(k) = (0.25 * ((10 * log((re(k) + im(k)) ./ ...
    (range(k) .* range(k))) ./ log(10)) + 6)) + ...
    (0.75 * Xsnr.snrp(k));
% updates
Xsnr.rangep = range;
Xsnr.I2p = i2;
Xsnr.Q2p = q2;
Xsnr.rep = re;
Xsnr.imp = im;
Xsnr.periodp = period;
Xsnr.snrp = snr;
out(1,:) = smooth;
out(2,:) = detrender;
out(3,:) = snr;
out(4,:) = period;
out(5,:) = re;
out(6,:) = im;
out(7,:) = range;
end
