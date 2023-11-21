%{
strategy(shorttitle="SSL EMA strat", title="ssl ema", overlay=true)

// Moving average
hma(src, len) =>
    wma(2 * wma(src, len / 2) - wma(src, len), round(sqrt(len)))

ma = input(title="MA type", defval="EMA", options=["EMA", "SMA", "Hull", "WMA"])

MA(price, length) =>
    current = if ma == 'EMA'
        ema(price, length)
    else
        if ma == 'SMA'
            sma(price, length)
        else
            if ma == 'WMA'
                wma(price, length)
            else
                hma(price, length)
    current

price = input(close, title='Price')
maFast = MA(price, input(50))
maSlow = MA(price, input(100, title='MA Slow'))
maTurtle = MA(price, input(200, title='MA Turtle'))
viewCrossFlag = input(false, title='View MA Slow/Turtle crossover')

plot(maTurtle, title="MA Turtle", style=plot.style_circles, linewidth=4, color=maFast >= maSlow ? #CCCCCC : #222222)
plot(maFast, title="MA Fast", style=plot.style_circles, linewidth=4, color=color.yellow, transp=0)
plot(maSlow, title="MA Slow", style=plot.style_circles, linewidth=4, color=color.purple, transp=0)

//plotchar(viewCrossFlag and crossunder(maSlow, maTurtle), char='✜', color=red, location=location.top, transp=0, size=size.tiny)
//plotchar(viewCrossFlag and crossover(maSlow, maTurtle), char='✜', color=green, location=location.bottom, transp=0, size=size.tiny)

period = input(title="Period", defval=10)
len = input(title="Period", defval=10)
smaHigh = sma(high, len)
smaLow = sma(low, len)
Hlv = int(na)
Hlv := close > smaHigh ? 1 : close < smaLow ? -1 : Hlv[1]
sslDown = Hlv < 0 ? smaHigh : smaLow
sslUp = Hlv < 0 ? smaLow : smaHigh

plot(sslDown, linewidth=2, color=color.red)
plot(sslUp, linewidth=2, color=color.lime)
// rsi

length = input( 14 )
overSold = input( 50 )
overBought = input( 50 )
pricev = close

tp = input(200)
sl = input(100)

vrsi = rsi(pricev, length)
co = crossover(vrsi, overSold)
cu = crossunder(vrsi, overBought)
%}
function out = ScalpSSLema(H,L,C)
price = C;
Fast = 50;
Slow = 100;
Turtle = 200;
aF = 2/(Fast+1);
aS = 2/(Slow+1);
aT = 2/(Turtle+1);
period = 10;
len = 10;
persistent Xssl
if isempty(Xssl)
    Xssl.emaFp = price;
    Xssl.emaSp = price;
    Xssl.emaTp = price;
    Xssl.Hwin = repmat(H,len,1);
    Xssl.Lwin = repmat(L,len,1);
    Xssl.H1vp = zeros(1,length(H));
end
Xssl.Hwin = [H;Xssl.Hwin(1:end-1,:)];
Xssl.Lwin = [L;Xssl.Lwin(1:end-1,:)];
maFast = (1-aF)*Xssl.emaFp + aF*price;
maSlow = (1-aS)*Xssl.emaSp + aS*price;
maTurtle = (1-aT)*Xssl.emaTp + aT*price;
smaHigh = sum(Xssl.Hwin)/len;
smaLow = sum(Xssl.Lwin)/len;
tmpH1v = Xssl.H1vp;
k = find(C<smaLow);
tmpH1v(k) = -1;
H1v = tmpH1v;
k = find(C>smaHigh);
H1v(k) = 1;
sslDown = smaLow;
sslUp = smaHigh;
k = find(H1v < 0);
sslDown(k) = smaHigh(k);
sslUp(k) = smaLow(k);
% updates
Xssl.emaFp = maFast;
Xssl.emaSp = maSlow;
Xssl.emaTp = maTurtle;
Xssl.H1vp = H1v;
out(1,:) = maFast;
out(2,:) = maSlow;
out(3,:) = maTurtle;
out(4,:) = smaHigh;
out(5,:) = smaLow;
out(6,:) = sslDown;
out(7,:) = sslUp;
end
