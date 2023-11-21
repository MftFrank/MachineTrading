%{
// Copyright (c) 2018-present, Alex Orekhov (everget)
// Ehlers Distance Coefficient Filter script may be freely distributed under the MIT license.
study("Ehlers Distance Coefficient Filter", 
length = input(title="Length", type=integer, defval=14)
src = input(title="Source", type=source, defval=hl2)
srcSum = 0.0
coefSum = 0.0
for count = 0 to length - 1
	distance = 0.0

	for lookback = 1 to length - 1
		distance := distance + pow(src[count] - src[count + lookback], 2)

	srcSum := srcSum + distance * src[count]
	coefSum := coefSum + distance

dcf = coefSum != 0 ? srcSum / coefSum : 0.0
%}
function out = EhlersDistCoefFilt(H,L)
Length = 14;
src = (H+L)/2;
srcSum = 0.0;
coefSum = 0.0;
persistent XDCoefFil
if isempty(XDCoefFil)
    XDCoefFil.srcwin = repmat(src,2*Length,1);
end
XDCoefFil.srcwin = [src;XDCoefFil.srcwin(1:end-1,:)];
for count = 1:Length
    distance = 0;
    for lookback = 1:Length
        distance = distance + ...
            power(XDCoefFil.srcwin(count,:) - ...
            XDCoefFil.srcwin(count+lookback,:),2);
    end
    srcSum = srcSum + distance .* XDCoefFil.srcwin(count,:);
	coefSum = coefSum + distance;
end
coefSum(coefSum==0) = 1;
k = find(srcSum==0);
srcSum(k) = src(k);
dcf = srcSum ./ coefSum;
out = dcf;
end
