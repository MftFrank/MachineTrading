%{
https://www.tradingview.com/script/Gmx3PwhE-Linda-Raschke-3-10-oscillator/
Linda Raschke - 3/10 oscillator
fast = 3, slow = 10, smoothing = 16
fastMA = sma(close, fast)
slowMA = sma(close, slow)
macd = fastMA - slowMA
hline(0,linestyle=solid)
signal = sma(macd, smoothing)
%}
function out = raschkeOsc(C)
fast = 3; slow = 10; smoothing = 16;
close = C;
Z = zeros(1,length(C));
persistent Xrosc
if isempty(Xrosc)
    Xrosc.Cwin = repmat(close,slow,1);
    Xrosc.macdwin = repmat(Z,smoothing,1);
end
Xrosc.Cwin = [close;Xrosc.Cwin(1:end-1,:)];
fastMA = sum(Xrosc.Cwin(1:fast,:))/fast;
slowMA = sum(Xrosc.Cwin(1:slow,:))/slow;
macd = fastMA - slowMA;
Xrosc.macdwin = [macd;Xrosc.macdwin(1:end-1,:)];
signal = sum(Xrosc.macdwin)/smoothing;
out(1,:) = fastMA;
out(2,:) = slowMA;
out(3,:) = macd;
out(4,:) = signal;
end
