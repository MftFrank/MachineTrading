%{
https://www.tradingview.com/script/dB56X9AU-Indicator-Volume-ROC/
// Volume ROC is calculated by dividing the amount the volume changed over the last
// "n" days by volume "n" days ago. The result is the % volume change. 
//
// If volume today is higher than "n" days ago, VROC will be positive, else negative. 
//
study(title = "Volume ROC [LazyBear]", shorttitle="VolumeROC[LB]")
length=input(12)
vroc = ((volume - volume[length]) / (volume[length])) * 100
%}
function out = VolROC(V)
Length = 12;
persistent Xvroc
if isempty(Xvroc)
    Xvroc.vrocwin = repmat(V,Length,1);
end
Xvroc.vrocwin = [V;Xvroc.vrocwin(1:end-1,:)];
vroc = ((V - Xvroc.vrocwin(end,:)) ./ ...
    Xvroc.vrocwin(end,:)) * 100;
out = vroc;
end
