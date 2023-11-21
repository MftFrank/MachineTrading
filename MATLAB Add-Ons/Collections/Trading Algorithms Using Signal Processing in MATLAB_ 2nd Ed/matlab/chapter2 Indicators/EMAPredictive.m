%{
LongPeriod=input(25.0,"Long Period")
ShortPeriod=input(8.0,"Short Period")
ExtraTimeForward=input(1.0,"Extra Time Forward") 

p1=2.0/(LongPeriod+1.0)
p3=2.0/(ShortPeriod+1.0)
t1=(LongPeriod-1.0)/2.0
t3=(ShortPeriod-1.0)/2.0
t=ShortPeriod + ExtraTimeForward

ma1=close
ma3=ma1
val=ma1
slope1=ma1
predict=ma1
ExtBuffer=ma1
for i=1 to LongPeriod
    val:=close[i]
    ma1:=p1*val + (1.0-p1)*ma1
    ma3:=p3*val + (1.0-p3)*ma3
    slope1:=(ma3-ma1)/(t1-t3)
    predict:=ma3 + slope1*t
    ExtBuffer:= predict
%}
function out = EMAPredictive(C)
LongPeriod = 25.0;
ShortPeriod = 8.0;
ExtraTimeForward = 1.0; 
p1 = 2.0/(LongPeriod+1.0);
p3=2.0/(ShortPeriod+1.0);
t1=(LongPeriod-1.0)/2.0;
t3=(ShortPeriod-1.0)/2.0;
t=ShortPeriod + ExtraTimeForward;
ma1=C;
ma3=ma1;
ExtBuffer=ma1;
persistent XEMAPred
if isempty(XEMAPred)
    XEMAPred.clwin = repmat(C,LongPeriod,1);
end
XEMAPred.clwin = [C;XEMAPred.clwin(1:end-1,:)];
for i=LongPeriod:-1:1
    val=XEMAPred.clwin(i,:);
    ma1=p1*val + (1.0-p1)*ma1;
    ma3=p3*val + (1.0-p3)*ma3;
    slope1=(ma3-ma1)/(t1-t3);
    predict=ma3 + slope1*t;
    ExtBuffer= predict;
end
out(1,:) = ma1;
out(2,:) = ma3;
out(3,:) = ExtBuffer;
end
