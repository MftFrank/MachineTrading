%{
study("Vertical Horizontal Moving Average [AneoPsy & alexgrover]", "VHMA", true)
length   = input(defval=50, type=input.integer, title="Length")
src      = input(defval=close, type=input.source, title="Source")
alert = input("VHMA Direction Change","Alert Conditions",
  options=["VHMA Direction Change","SRC/VHMA Crossover"])
//------------------------------------------------------------------------------
vhma=0.
R = highest(src, length) - lowest(src, length)
vhf = R / sum(abs(change(src)), length)
vhma := nz(vhma[1] + pow(vhf, 2) * (src - vhma[1]),src)study("Vertical Horizontal Moving Average [AneoPsy & alexgrover]", "VHMA", true)
length   = input(defval=50, type=input.integer, title="Length")
src      = input(defval=close, type=input.source, title="Source")
alert = input("VHMA Direction Change","Alert Conditions",
  options=["VHMA Direction Change","SRC/VHMA Crossover"])
//------------------------------------------------------------------------------
vhma=0.
R = highest(src, length) - lowest(src, length)
vhf = R / sum(abs(change(src)), length)
vhma := nz(vhma[1] + pow(vhf, 2) * (src - vhma[1]),src)
%}
function out = vhmaDel(C)
src = C;
Length = 50;
Z = zeros(1,length(src));
persistent XvhfD
if isempty(XvhfD)
    XvhfD.Cwin = repmat(src,Length,1);
    XvhfD.cdiffwin = repmat(Z,Length,1);
    XvhfD.Cp = src;
    XvhfD.vhma1p = src;
    XvhfD.vhma2p = src;
end
XvhfD.Cwin = [src;XvhfD.Cwin(1:end-1,:)];
hcp=max(XvhfD.Cwin);
lcp=min(XvhfD.Cwin);
cdiff=abs(src-XvhfD.Cp);
XvhfD.cdiffwin = [cdiff;XvhfD.cdiffwin(1:end-1,:)];
N=abs(hcp-lcp);
D=sum(XvhfD.cdiffwin);
D(D==0) = 1;
vhf=N./D;
vhf(isnan(vhf)) = 0;
vhma1 = XvhfD.vhma1p + power(vhf, 0.5) .* (src - XvhfD.vhma1p);
vhma2 = XvhfD.vhma2p + power(vhf, 2.0) .* (src - XvhfD.vhma2p);
dif2 = vhma2 - XvhfD.vhma2p;
XvhfD.Cp = src;
XvhfD.vhma1p = vhma1;
XvhfD.vhma2p = vhma2;
out(1,:) = vhf;
out(2,:) = vhma1;
out(3,:) = vhma2;
out(4,:) = vhma1-vhma2;
out(5,:) = dif2;
end
