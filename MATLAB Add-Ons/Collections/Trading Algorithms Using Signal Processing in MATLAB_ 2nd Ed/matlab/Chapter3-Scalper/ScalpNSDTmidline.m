%{
study(title="NSDT Midline", overlay=true)

t = time("1440", session.extended)

is_first = na(t[1]) and not na(t) or t[1] < t

day_high = float(na)
day_low = float(na)

if is_first and barstate.isnew
    day_high := high
    day_low := low
    day_low
else
    day_high := day_high[1]
    day_low := day_low[1]
    day_low

if high > day_high
    day_high := high
    day_high

if low < day_low
    day_low := low
    day_low

MidLine = input(title="Show Mid Line", type=input.bool, defval=true)
MidlineValue= (day_high + day_low)/2
%}
function out = ScalpNSDTmidline(H,L)
persistent XScnsdt
if isempty(XScnsdt)
    XScnsdt.is_first = 1;
    XScnsdt.day_highp = H;
    XScnsdt.day_lowp = L;
end
if XScnsdt.is_first
    day_high = H;
    day_low = L;
else
    day_high = XScnsdt.day_highp;
    day_low = XScnsdt.day_lowp;
end
k = find(H > day_high);
day_high(k) = H(k);
k = find(L < day_low);
day_low(k) = L(k);
MidlineValue = (day_high + day_low)/2;
k = find(MidlineValue > H*1.0);
day_high(k) = H(k);
k = find(MidlineValue < L*1.0);
day_low(k) = L(k);

XScnsdt.day_highp = day_high;
XScnsdt.day_lowp = day_low;
out(1,:) = day_high;
out(2,:) = day_low;
out(3,:) = MidlineValue;
XScnsdt.is_first = 0;
end
