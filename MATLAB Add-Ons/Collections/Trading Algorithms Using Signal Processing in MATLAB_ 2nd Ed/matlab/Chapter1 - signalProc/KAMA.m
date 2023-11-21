%{
Kaufman's Adaptive Moving Average (KAMA) is a moving average designed to 
account for market noise or volatility.
KAMA(10,2,30).
10 is the number of periods for the Efficiency Ratio (ER).
2 is the number of periods for the fastest EMA constant.
30 is the number of periods for the slowest EMA constant.
Efficiency Ratio (ER)
ER = Change/Volatility
Change = ABS(Close - Close (10 periods ago))
Volatility = Sum10(ABS(Close - Prior Close))
Volatility is the sum of the absolute value of the 
last ten price changes (Close - Prior Close). 
Smoothing Constant (SC)
SC = [ER x (fastest SC - slowest SC) + slowest SC]2
SC = [ER x (2/(2+1) - 2/(30+1)) + 2/(30+1)]2
Current KAMA = Prior KAMA + SC x (Price - Prior KAMA)
%}
function out = KAMA(C)
Price = C;
periodsER = 10;
periodsfast = 2;
periodsslow = 30;
SCfast = 2/(periodsfast+1);
SCslow = 2/(periodsslow+1);
persistent Xkama
if isempty(Xkama)
    Xkama.prwin = repmat(Price,periodsER,1);
    Xkama.difwin = repmat(zeros(1,length(Price)),periodsER,1);
    Xkama.kamap = Price;
end
Xkama.prwin = [Price;Xkama.prwin(1:end-1,:)];
Xkama.difwin = [Xkama.prwin(1,:)-Xkama.prwin(2,:);...
    Xkama.difwin(1:end-1,:)];
Change = abs(Xkama.prwin(1,:)-Xkama.prwin(end,:));
Volatility = sum(abs(Xkama.difwin));
ER = Change/Volatility;
SC = [ER * (SCfast - SCslow) + SCslow]^2;
kama = Xkama.kamap + SC * (Price - Xkama.kamap);
Xkama.kamap = kama;
out = kama;
end
