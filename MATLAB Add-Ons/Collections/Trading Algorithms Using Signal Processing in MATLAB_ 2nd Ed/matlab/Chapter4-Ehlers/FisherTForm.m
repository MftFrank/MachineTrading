%{
Inputs: price((H+L)/2),
Len(13);

Var: MaxH(0),
MinL(0),
Fish(0);

MaxH = Highest(Price, Len);
MinL = Lowest(Price, Len);

Value1 = .5*2*((Price-MinL)/(MaxH-MinL)-.5)+.5*Value1[1];

If Value1 > .9999 then Value1 = .9999;
If Value1 < -.9999 then Value1 = -.9999;

Fish = 0.25*Log((1+Value1)/(1-Value1)) +.5*Fish[1];
%}
function out = FisherTForm(H,L)
persistent XFish
Len = 13;
Price = (H + L)/2;
if isempty(XFish)
    XFish.Value1p = zeros(1,length(H));
    XFish.Fishp = zeros(1,length(H));
    XFish.MaxHwin = repmat(Price,Len,1);
end
XFish.MaxHwin = [Price;XFish.MaxHwin(1:end-1,:)];
MaxH = max(XFish.MaxHwin);
MinL = min(XFish.MaxHwin);
Value1 = .5*2*((Price-MinL)/(MaxH-MinL)-.5)+.5*XFish.Value1p;
Value1(Value1>0.9999) = 0.9999;
Value1(Value1<-0.9999) = -0.9999;
Fish = 0.25*log((1+Value1)./(1-Value1))+.5*XFish.Fishp;
% updates
XFish.Value1p = Value1;
XFish.Fishp = Fish;
out(1,:) = Value1;
out(2,:) = Fish;
end
