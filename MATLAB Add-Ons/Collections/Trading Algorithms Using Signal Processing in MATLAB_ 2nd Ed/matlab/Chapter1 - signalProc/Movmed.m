%{
Moving median
From a statistical point of view, the moving average, 
when used to estimate the underlying trend in a 
time series, is susceptible to rare events such as 
rapid shocks or other anomalies. A more robust estimate 
of the trend is the simple moving median over n time points:
psm = median(pvec(n length))
where the median is found by, for example, sorting the 
values inside the brackets and finding the value in the 
middle. 
%}
function out = Movmed(C)
P = C;
N = 5;
persistent Xmomed
if isempty(Xmomed)
    Xmomed.Pwin = repmat(P,N,1);
end
Xmomed.Pwin = [P;Xmomed.Pwin(1:end-1,:)];
smm = median(Xmomed.Pwin);
out(1,:) = smm;
end
