%{
https://www.tradingview.com/script/YCkuD0nx-e2-Voss-Predictive-Filter/
study("Voss Predictive Filter", "VPF", false)
// Inputs {
src             = input(close,  "Source", input.source)
int     len     = input(20,	    "Length")
int     pre     = input(3,		"Predict")
float   band    = input(0.25,	"Bandwidth")
// }
// Voss Predictive Filter {
f_vpf(_len, _pre, _band, _src) =>
	float _filt = .0, float _sumC = .0, float _voss = .0
	_pi  = 2 * asin(1)
	_ord = 3 * _pre
	_f1  = cos(2 * _pi / _len)
	_g1  = cos(_band * 2 * _pi / _len)
	_s1  = 1 / _g1 - sqrt(1 / (_g1 * _g1) - 1)
	_s2  = 1 + _s1, _s3 = 1 - _s1
	_x1  = nz(_src) - nz(_src[2])
	_x2  = (3 + _ord) / 2
	for _i = 0 to (_ord - 1)
		_sumC := _sumC + ((_i + 1) / _ord) * _voss[_ord - _i]
	if bar_index <= _ord
		_filt := 0		
		_voss := 0		
	else			
		_filt := 0.5 * _s3 * _x1 + _f1 * _s2 * _filt[1] - _s1 * _filt[2]
		_voss := _x2 * _filt - _sumC
	[_voss, _filt]

[voss, filt] = f_vpf(len, pre, band, src)
%}
function out = EhlerVoss(C)
src     = C;
len     = 20;
pre     = 3;
band    = 0.25;
Z = zeros(1,length(src));
persistent XEVoss
if isempty(XEVoss)
    ord = 3 * pre;
    f1  = cos(2 * pi / len);
    g1  = cos(band * 2 * pi / len);
    s1  = 1 / g1 - sqrt(1 / (g1 * g1) - 1);
    s2  = 1 + s1;
    s3 = 1 - s1;
    XEVoss.ord = ord;
    XEVoss.f1 = f1;
    XEVoss.g1 = g1;
    XEVoss.s1 = s1;
    XEVoss.s2 = s2;
    XEVoss.s3 = s3;
    XEVoss.Cp = src;
    XEVoss.Cpp = src;
    XEVoss.filtp = Z;
    XEVoss.filtpp = Z;
    XEVoss.vosswin = repmat(Z,ord,1);
end
ord = XEVoss.ord;
f1 = XEVoss.f1;
g1 = XEVoss.g1;
s1 = XEVoss.s1;
s2 = XEVoss.s2;
s3 = XEVoss.s3;
x1  = src - XEVoss.Cpp;
x2  = (3 + ord) / 2;
sumC = Z;
for i = 1:ord
    sumC = sumC + ...
        ((i + 1) / ord) * XEVoss.vosswin(ord-i+1,:);
end
filt = 0.5 * s3 * x1 + ...
    f1 * s2 * XEVoss.filtp - s1 * XEVoss.filtp;
voss = x2 * filt - sumC;
XEVoss.vosswin = [voss;XEVoss.vosswin(1:end-1,:)];
XEVoss.Cpp = XEVoss.Cp;
XEVoss.Cp = src;
XEVoss.filtpp = XEVoss.filtp;
XEVoss.filtp = filt;
out(1,:) = filt;
out(2,:) = voss;
end
