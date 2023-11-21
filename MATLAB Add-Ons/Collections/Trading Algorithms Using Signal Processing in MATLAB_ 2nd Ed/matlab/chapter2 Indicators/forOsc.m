%{
https://www.tradingview.com/script/CMSQGuGP-Indicator-Forecast-Oscillator-a-BB-extrapolation-experiment/
study(title = "Forecast Oscillator [LazyBear]", shorttitle="ForecastOsc_LB")
pf=100*((close[0]-close[1])/close[0])
//plot(pf, color=green)
plot(sma(pf,3), color=orange)
%}
function out = forOsc(C)
t = 3;
persistent Xfosc
if isempty(Xfosc)
    Xfosc.Cp = C;
    Xfosc.pfwin = repmat(zeros(1,length(C)),t,1);
end
pf = 100*(C - Xfosc.Cp)./C;
Xfosc.pfwin = [pf;Xfosc.pfwin(1:end-1,:)];
pfma = sum(Xfosc.pfwin)/t;
Xfosc.Cp = C;
out(1,:) = pf;
out(2,:) = pfma;
end
