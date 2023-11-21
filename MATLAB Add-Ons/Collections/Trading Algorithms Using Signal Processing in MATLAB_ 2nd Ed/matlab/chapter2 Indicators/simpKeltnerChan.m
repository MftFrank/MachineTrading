%{
simple Keltner Channel
The 10-Day Moving Average:
MOV( (H+L+C)/3, 10, Simple )
Upper Keltner Band
MOV((H+L+C)/3,10,S) + MOV((H-L),10,S)
Lower Keltner Band
MOV((H+L+C)/3,10,S) - MOV((H-L),10,S)
H – high, L – low, C – close, MOV – moving average
%}
function out = simpKeltnerChan(C,H,L)
winlen = 10;
persistent XsimpKC
if isempty(XsimpKC)
    XsimpKC.kcwin = repmat((C+H+L)/3,winlen,1);
    XsimpKC.kcbandwin = repmat((H-L),winlen,1);
end
XsimpKC.kcwin = [(C+H+L)/3;XsimpKC.kcwin(1:end-1,:)];
XsimpKC.kcbandwin = [H-L;XsimpKC.kcbandwin(1:end-1,:)];
mov = sum(XsimpKC.kcwin)/winlen;
band = sum(XsimpKC.kcbandwin)/winlen;
up = mov + band;
dn = mov - band;
out(1,:) = mov;
out(2,:) = up;
out(3,:) = dn;
end
