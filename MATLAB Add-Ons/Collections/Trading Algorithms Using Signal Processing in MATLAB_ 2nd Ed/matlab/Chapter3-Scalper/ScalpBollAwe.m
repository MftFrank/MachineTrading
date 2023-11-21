%{
// - https://www.forexstrategiesresources.com/scalping-forex-strategies-iii/337-bollinger-bands-and-chaos-awesome-scalping-system
// - "Squeeze Momentum Indicator [LazyBear]"
// Bollinger Bands Inputs
bb_use_ema = input(false, title="Use EMA for Bollinger Band")
bb_filter = input(false, title="Filter Buy/Sell with Bollinger Bands")
sqz_filter = input(false, title="Flter Buy/Sell with BB squeeze")
bb_length = input(20, minval=1, title="Bollinger Length")
bb_source = input(close, title="Bollinger Source")
bb_mult = input(2.0, title="Base Multiplier", minval=0.5, maxval=10)
// EMA inputs
fast_ma_len = input(3, title="Fast EMA length", minval=2)
// Awesome Inputs
nLengthSlow = input(34, minval=1, title="Awesome Length Slow")
nLengthFast = input(5, minval=1, title="Awesome Length Fast")

// === /INPUTS ===

sqz_length      = input(100, "BB Relative Squeeze Length", minval = 5)
sqz_threshold   = input(50,  "BB Squeeze Threshold %", maxval=99, step = 5)



// === SERIES ===

// Breakout Indicator Inputs
bb_basis = bb_use_ema ? ema(bb_source, bb_length) : sma(bb_source, bb_length)
fast_ma  = ema(bb_source, fast_ma_len)

// Deviation
// * I'm sure there's a way I could write some of this cleaner, but meh.
dev = stdev(bb_source, bb_length)
bb_dev = bb_mult * dev

// Upper bands
bb_upper = bb_basis + bb_dev
// Lower Bands
bb_lower = bb_basis - bb_dev

// Calculate Awesome Oscillator
xSMA1_hl2 = sma(hl2, nLengthFast)
xSMA2_hl2 = sma(hl2, nLengthSlow)
xSMA1_SMA2 = xSMA1_hl2 - xSMA2_hl2
// Calculate direction of AO
AO = xSMA1_SMA2>=0? xSMA1_SMA2 > xSMA1_SMA2[1] ? 1 : 2 : xSMA1_SMA2 > xSMA1_SMA2[1] ? -1 : -2

// Calculate BB spread and average spread
spread    = bb_upper-bb_lower
avgspread = sma(spread,sqz_length) 

// Calculate BB relative %width for Squeeze indication
bb_squeeze   = (spread/avgspread)*100

// Calculate Upper and Lower band painting offsets based on 50% of atr.
bb_offset    = atr(14)*0.5
bb_sqz_upper = bb_upper + bb_offset
bb_sqz_lower = bb_lower - bb_offset

// === /SERIES ===

// === PLOTTING ===

// plot BB basis
plot(bb_basis, title="Basis Line", color=red, transp=10, linewidth=2)
// plot BB upper and lower bands
ubi = plot(bb_upper, title="Upper Band Inner", color=blue, transp=10, linewidth=1)
lbi = plot(bb_lower, title="Lower Band Inner", color=blue, transp=10, linewidth=1)
// center BB channel fill
fill(ubi, lbi, title="Center Channel Fill", color=silver, transp=90)

//Indicate BB squeeze based on threshold.
usqzi = plot(bb_sqz_upper, "Hide Sqz Upper", transp=100)
lsqzi = plot(bb_sqz_lower, "Hide Sqz Lower", transp=100)
fill(ubi,usqzi, color = bb_squeeze>sqz_threshold ? white:blue, transp = 50)
fill(lbi,lsqzi, color = bb_squeeze>sqz_threshold ? white:blue, transp = 50)

// plot fast ma
plot(fast_ma, title="Fast EMA", color=black, transp=10, linewidth=2)

// Calc breakouts
break_down =   crossunder(fast_ma, bb_basis) and close < bb_basis and abs(AO)==2 and (not bb_filter or close >bb_lower) and (not sqz_filter or bb_squeeze>sqz_threshold)
break_up   =  crossover(fast_ma, bb_basis) and close > bb_basis and abs(AO)==1 and (not bb_filter or close<bb_upper) and (not sqz_filter or bb_squeeze>sqz_threshold)
%}
function out = ScalpBollAwe(H,L,C)
bb_length = 20;
bb_source = C;
bb_mult = 2.0;
% EMA inputs
fast_ma_len = 3;
atrlen = 14;
alen = 2/(bb_length+1);
aF = 2/(fast_ma_len+1);
atrL = 1/atrlen;
% Awesome Inputs
nLengthSlow = 34;
nLengthFast = 5;
sqz_length      = 100;
sqz_threshold   = 50;
HL2 = (H+L)/2;
Z = zeros(1,length(L));
persistent XSbolaw
if isempty(XSbolaw)
    XSbolaw.basisp = bb_source;
    XSbolaw.fastp = bb_source;
    XSbolaw.devp = bb_source;
    XSbolaw.HL2win = repmat(HL2,nLengthSlow,1);
    XSbolaw.bbwin = repmat(bb_source,nLengthSlow,1);
    XSbolaw.spreadwin = repmat(Z,sqz_length,1);
    XSbolaw.atrp = max(H-L,max(H-C,abs(L-C)));
end
XSbolaw.bbwin = [bb_source;XSbolaw.bbwin(1:end-1,:)];
XSbolaw.HL2win = [HL2;XSbolaw.HL2win(1:end-1,:)];
bb_basis = (1-alen)*XSbolaw.basisp + alen*bb_source;
fast_ma = (1-aF)*XSbolaw.fastp + aF*bb_source;
% Bands
dev = std(XSbolaw.bbwin(1:bb_length,:));
bb_dev = bb_mult * dev;
bb_upper = bb_basis + bb_dev;
bb_lower = bb_basis - bb_dev;
% Awesome Oscillator
xSMA1_hl2 = sum(XSbolaw.HL2win(1:nLengthFast,:))/nLengthFast;
xSMA2_hl2 = sum(XSbolaw.HL2win)/nLengthSlow;
xSMA1_SMA2 = xSMA1_hl2 - xSMA2_hl2;
% Calculate BB spread and average spread
spread    = bb_upper-bb_lower;
XSbolaw.spreadwin = [spread;XSbolaw.spreadwin(1:end-1,:)];
avgspread = sum(XSbolaw.spreadwin)/sqz_length; 
bb_squeeze   = (spread/avgspread)*100;
atr = max(H-L,max(H-XSbolaw.bbwin(2,:),...
    abs(L-XSbolaw.bbwin(2,:))));
bb_offset = (1-atrL)*XSbolaw.atrp + atrL*atr;
bb_sqz_upper = bb_upper + bb_offset;
bb_sqz_lower = bb_lower;
% bb_sqz_lower = bb_lower - bb_offset;
XSbolaw.basisp = bb_basis;
XSbolaw.fastp = fast_ma;
XSbolaw.atrp = bb_offset;
out(1,:) = bb_basis;
out(2,:) = fast_ma;
out(3,:) = bb_upper;
out(4,:) = bb_lower;
out(5,:) = xSMA1_SMA2;
out(6,:) = bb_sqz_upper;
out(7,:) = bb_sqz_lower;
end
