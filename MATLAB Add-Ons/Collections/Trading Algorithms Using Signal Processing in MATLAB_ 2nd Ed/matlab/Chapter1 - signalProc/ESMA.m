%{
Error incorporation into filtering
Esma = sma(src,N) - sma(E,N)
src is Close
b is sma filter = [1 2 2 1]/6
E is sma error from Close 
%}
function out = ESMA(C)
src = C;
b = [1 2 2 1]/6;
persistent Xesma
if isempty(Xesma)
    Xesma.smawin = repmat(src,length(b),1);
    Xesma.Esmawin = repmat(zeros(1,length(src)),length(b),1);
end
Xesma.smawin = [src;Xesma.smawin(1:end-1,:)];
sma = sum(b'.*Xesma.smawin);
Xesma.Esmawin = [src-sma;Xesma.Esmawin(1:end-1,:)];
E = sum(b'.*Xesma.Esmawin);
Esma = sma - E;
out(1,:) = sma;
out(2,:) = Esma;
end
