%{
https://www.tradingview.com/script/rqxaTb6E-ALMA-Function-FN-Arnaud-Legoux-Moving-Average/
study("Alma Function", overlay = true)
ARNAUD LEGOUX MOVING AVERAGE (ALMA)
_alma(_series, _length, _offset, _sigma) =>
    length      = int(_length) // Floating point protection
    numerator   = 0.0
    denominator = 0.0 
    m = _offset * (length - 1)
    s = length / _sigma
    for i=0 to length-1
        weight       = exp(-((i-m)*(i-m)) / (2 * s * s))
        numerator   := numerator   + weight * _series[length - 1 - i]
        denominator := denominator + weight
    numerator / denominator

source = input(close, "ALMA Source", input.source )
length = input(   10, "ALMA Length", input.integer, minval=1)
sigma  = input(  6.0, "ALMA Sigma" , input.float  , minval=0.0, step=0.5)
offset = input( 0.85, "ALMA Offset", input.float  ,   step=0.05)
%}
function out = ALMA(C)
series = C;
Length = 10;
offset = 0.85;
sigma = 6;
numerator   = zeros(1,length(C));
denominator = zeros(1,length(C));
m = offset * Length;
s = Length / sigma;
persistent XALMA
if isempty(XALMA)
    XALMA.serieswin = repmat(series,Length,1);
end
XALMA.serieswin = [series;XALMA.serieswin(1:end-1,:)];
for i=1:Length
    weight = exp(-((i-m)*(i-m)) / (2 * s * s));
    numerator = numerator + weight * XALMA.serieswin(Length+1-i,:);
    denominator = denominator + weight;
end
ALMA = numerator ./ denominator;
out(1,:) = ALMA;
end
