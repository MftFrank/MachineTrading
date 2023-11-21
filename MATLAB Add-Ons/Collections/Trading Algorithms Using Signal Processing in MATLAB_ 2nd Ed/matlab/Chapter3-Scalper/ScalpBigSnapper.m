%{
lenFast        = input(defval=21, title="Fast MA - Length", minval=1)
// Medium MA - type, length
typeMedium     = input(defval="EMA", title="Medium MA Type: ", options=["SMA", "EMA", "WMA", "VWMA", "SMMA", "DEMA", "TEMA", "HullMA", "ZEMA", "TMA", "SSMA"], type=string)
lenMedium      = input(defval=55, title="Medium MA - Length", minval=1)
// Slow MA - type, length
typeSlow       = input(defval="EMA", title="Slow MA Type: ", options=["SMA", "EMA", "WMA", "VWMA", "SMMA", "DEMA", "TEMA", "HullMA", "ZEMA", "TMA", "SSMA"], type=string)
lenSlow        = input(defval=89, title="Slow MA Length", minval=1)
// 3xMA source
ma_src         = input(close)
uKC             = false // input(false,title="Use Keltner Channel (KC) instead of Bollinger")
bbLength        = input(20,minval=2,step=1,title="Bollinge Bands Length")
bbStddev        = input(2.0,minval=0.5,step=0.1,title="Bollinger Bands StdDevs")
oiLength        = input(8, title="Bollinger Outside In LookBack")
//
SFactor         = input(3.618, minval=1.0, title="SuperTrend Factor")
SPd             = input(5, minval=1, title="SuperTrend Length")
// Returns MA input selection variant, default to SMA if blank or typo.
variant(type, src, len) =>
    v1 = sma(src, len)                                                  // Simple
    v2 = ema(src, len)                                                  // Exponential
    v3 = wma(src, len)                                                  // Weighted
    v4 = vwma(src, len)                                                 // Volume Weighted
    v5 = 0.0
    v5 := na(v5[1]) ? sma(src, len) : (v5[1] * (len - 1) + src) / len    // Smoothed
    v6 = 2 * v2 - ema(v2, len)                                          // Double Exponential
    v7 = 3 * (v2 - ema(v2, len)) + ema(ema(v2, len), len)               // Triple Exponential
    v8 = wma(2 * wma(src, len / 2) - wma(src, len), round(sqrt(len)))   // Hull WMA = (2*WMA (n/2) − WMA (n)), sqrt (n))
    v11 = sma(sma(src,len),len)                                         // Triangular
    // SuperSmoother filter
    // © 2013  John F. Ehlers
    a1 = exp(-1.414*3.14159 / len)
    b1 = 2*a1*cos(1.414*3.14159 / len)
    c2 = b1
    c3 = (-a1)*a1
    c1 = 1 - c2 - c3
    v9 = 0.0
    v9 := c1*(src + nz(src[1])) / 2 + c2*nz(v9[1]) + c3*nz(v9[2])
    // Zero Lag Exponential
    e = ema(v1, len)
    v10 = v1+(v1-e)
    // return variant, defaults to SMA if input invalid.
    type=="EMA"?v2 : type=="WMA"?v3 : type=="VWMA"?v4 : type=="SMMA"?v5 : type=="DEMA"?v6 : type=="TEMA"?v7 : type=="HullMA"?v8 : type=="SSMA"?v9 : type=="ZEMA"?v10 : type=="TMA"? v11: v1
// === /FUNCTIONS ===

// === SERIES VARIABLES ===
// MA's
ma_fast     = variant(typeFast, ma_src, lenFast)
ma_medium   = variant(typeMedium, ma_src, lenMedium)
ma_slow     = variant(typeSlow, ma_src, lenSlow)
ma_coloured = variant(typeColoured, srcColoured, lenColoured)

// Get Direction of Coloured Moving Average
clrdirection = 1
clrdirection := rising(ma_coloured,2) ? 1 : falling(ma_coloured,2)? -1  : nz(clrdirection[1],1)

// get 3xMA trend direction based on selections.
madirection  =  ma_fast>ma_medium and ma_medium>ma_slow? 1 : ma_fast<ma_medium and ma_medium<ma_slow? -1 : 0
madirection  := disableSlowMAFilter?  ma_fast>ma_medium? 1 : ma_fast<ma_medium? -1 : 0 : madirection
madirection  := disableMediumMAFilter?  ma_fast>ma_slow? 1 : ma_fast<ma_slow? -1 : 0 : madirection
madirection  := disableFastMAFilter?  ma_medium>ma_slow? 1 : ma_medium<ma_slow? -1 : 0 : madirection
madirection  := disableFastMAFilter and disableMediumMAFilter?  ma_coloured>ma_slow? 1 : -1 : madirection
madirection  := disableFastMAFilter and disableSlowMAFilter?    ma_coloured>ma_medium? 1 : -1 : madirection
madirection  := disableSlowMAFilter and disableMediumMAFilter?  ma_coloured>ma_fast? 1 : -1 : madirection
// Supertrend Calculations
SUp=hl2-(SFactor*atr(SPd))
SDn=hl2+(SFactor*atr(SPd))

STrendUp   = 0.0
STrendDown = 0.0
STrendUp   := close[1]>STrendUp[1]? max(SUp,STrendUp[1]) : SUp
STrendDown := close[1]<STrendDown[1]? min(SDn,STrendDown[1]) : SDn
STrend = 0
STrend := close > STrendDown[1] ? 1: close< STrendUp[1]? -1: nz(STrend[1],1)
Tsl = STrend==1? STrendUp: STrendDown

// Standard Bollinger or KC Bands
basis = sma(ma_src, bbLength)
rangema = sma(tr, bbLength)
dev =   uKC? bbStddev*rangema : bbStddev * stdev(ma_src, bbLength)

// Calculate Bollinger or KC Channel
upper = basis + dev
lower = basis - dev
%}
function out = ScalpBigSnapper(H,L,C,V)
lenColoured    = 18;
lenFast        = 21;
lenMedium      = 55;
lenSlow        = 89;
ma_src         = C;
bbLength        = 20;
bbStddev        = 2.0;
oiLength        = 8;
SFactor         = 3.618;
SPd             = 5;
aSPd               = 1/SPd;
HL2             = (H+L)/2;
Z = zeros(1,length(H));
persistent XBigSnap
if isempty(XBigSnap)
    XBigSnap.VCwin = repmat(V.*C,lenSlow,1);
    XBigSnap.Vwin = repmat(V,lenSlow,1);
    XBigSnap.Cwin = repmat(C,lenSlow,1);
    tmp = max(H-L,max(H-C,abs(L-C)));
    XBigSnap.atrwin = repmat(tmp,bbLength,1);
    XBigSnap.atrp = tmp;
    XBigSnap.STrendUpp   = Z;
    XBigSnap.STrendDownp = Z;
    XBigSnap.Cp = C;
end
XBigSnap.VCwin = [V.*C;XBigSnap.VCwin(1:end-1,:)];
XBigSnap.Vwin = [V;XBigSnap.Vwin(1:end-1,:)];
XBigSnap.Cwin = [C;XBigSnap.Cwin(1:end-1,:)];
ma_fast     = sum(XBigSnap.VCwin(1:lenFast,:))./...
    sum(XBigSnap.Vwin(1:lenFast,:));
ma_medium     = sum(XBigSnap.VCwin(1:lenMedium,:))./...
    sum(XBigSnap.Vwin(1:lenMedium,:));
ma_slow     = sum(XBigSnap.VCwin(1:lenSlow,:))./...
    sum(XBigSnap.Vwin(1:lenSlow,:));
ma_coloured     = sum(XBigSnap.VCwin(1:lenColoured,:))./...
    sum(XBigSnap.Vwin(1:lenColoured,:));
atr = max(H-L,max(H-XBigSnap.Cwin(2,:),...
    abs(L-XBigSnap.Cwin(2,:))));
atrSPd = (1-aSPd)*XBigSnap.atrp + aSPd*atr;
XBigSnap.atrwin = [atr;XBigSnap.atrwin(1:end-1,:)];
SUp = HL2 - SFactor*atrSPd;
SDn = HL2 + SFactor*atrSPd;
STrendUp   = SUp;
STrendDown = SDn;
k = find(XBigSnap.Cp>XBigSnap.STrendUpp);
STrendUp(k) = max(SUp(k),XBigSnap.STrendUpp(k));
k = find(XBigSnap.Cp<XBigSnap.STrendDownp);
STrendDown(k) = min(SDn(k),XBigSnap.STrendDownp(k));
tmp = Z;
tmp(C<XBigSnap.STrendDownp) = -1;
STrend = tmp;
STrend(C > XBigSnap.STrendDownp) = 1;
Tsl = STrendDown;
k = find(STrend==1);
Tsl(k) = STrendUp(k);
basis = sum(XBigSnap.Cwin(1:bbLength,:))/bbLength;
% rangema = sum(XBigSnap.atrwin(1:bbLength,:))/bbLength;
dev = bbStddev * std(XBigSnap.Cwin(1:bbLength,:));
upper = basis + dev;
lower = basis - dev;
XBigSnap.atrp = atr;
XBigSnap.Cp = C;
XBigSnap.STrendUpp = STrendUp;
XBigSnap.STrendDownp = STrendDown;
out(1,:) = STrendUp;
out(2,:) = STrendDown;
out(3,:) = ma_fast;
out(4,:) = ma_medium;
out(5,:) = ma_slow;
out(6,:) = ma_coloured;
out(7,:) = basis;
out(8,:) = upper;
out(9,:) = lower;
end
