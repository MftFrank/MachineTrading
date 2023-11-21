%{
https://www.tradingview.com/script/OQs2lVvr-Ultimate-Moving-Average-Multi-TimeFrame-7-MA-Types/
//TEMA definition
src = close
len = input(20, title="Moving Average Length - LookBack Period")
ema1 = ema(src, len)
ema2 = ema(ema1, len)
ema3 = ema(ema2, len)
tema = 3 * (ema1 - ema2) + ema3
%}
function out = tema(C)
src = C;
len = 20;
n = 3;
alpha = 2/(len+1);
persistent Xtema
if isempty(Xtema)
    Xtema.ema1p = src;
    Xtema.ema2p = src;
    Xtema.ema3p = src;
end
ema1 = (1-alpha)*Xtema.ema1p + alpha*src;
ema2 = (1-alpha)*Xtema.ema2p + alpha*ema1;
ema3 = (1-alpha)*Xtema.ema3p + alpha*ema2;
tema = n * (ema1 - ema2) + ema3;
% updates
Xtema.ema1p = ema1;
Xtema.ema2p = ema2;
Xtema.ema3p = ema3;
out(1,:) = tema;
end
