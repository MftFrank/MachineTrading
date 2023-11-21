%{
Keltner Channel with ema & ATR
Middle Line: 20-period Exponential Moving Average (EMA)
Upper Channel Line: 20 EMA + (2 * Average True Range)
Lower Channel Line: 20 EMA – (2 * Average True Range)
%}
function out = KeltChanEMA_ATR(C,H,L)
lengthMiddle  = 20;
channelATR  = 10;
channelWidth = 2;
persistent XsimpKC
if isempty(XsimpKC)
    XsimpKC.alph = 2/(lengthMiddle+1);
    XsimpKC.emap = C;
    XsimpKC.Cp = C;
    Cp = C;
    atr = max(H-C,max(abs(H-Cp),abs(L-Cp)));
    XsimpKC.atrwin = repmat(atr,channelATR,1);
end
emaVal = (1-XsimpKC.alph)*XsimpKC.emap + XsimpKC.alph*C;
atr = max(H-C,max(abs(H-XsimpKC.Cp),abs(L-XsimpKC.Cp)));
XsimpKC.atrwin = [atr;XsimpKC.atrwin(1:end-1,:)];
atravg = sum(XsimpKC.atrwin);
upperVal = emaVal + channelWidth * atravg;
lowerVal = emaVal - channelWidth * atravg;
% updates
XsimpKC.emap = emaVal;
XsimpKC.Cp = C;
out(1,:) = emaVal;
out(2,:) = upperVal;
out(3,:) = lowerVal;
end
