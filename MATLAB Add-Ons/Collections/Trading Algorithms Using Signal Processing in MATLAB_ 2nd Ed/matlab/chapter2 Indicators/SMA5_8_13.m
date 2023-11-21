%{
Scalper 5-8-13 simple moving average (SMA) consisting of 3 SMA's at varying
lengths.
%}
function out = SMA5_8_13(C,H,L)
len5  = 5;
len8  = 8;
len13 = 13;
persistent Xsma58_13
if isempty(Xsma58_13)
    Xsma58_13.smawin = repmat((C+H+L)/3,len13,1);
end
Xsma58_13.smawin = [(C+H+L)/3;Xsma58_13.smawin(1:end-1,:)];
sma5 = sum(Xsma58_13.smawin(1:len5,:))/len5;
sma8 = sum(Xsma58_13.smawin(1:len8,:))/len8;
sma13 = sum(Xsma58_13.smawin)/len13;
out(1,:) = sma5;
out(2,:) = sma8;
out(3,:) = sma13;
end
