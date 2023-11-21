%{
https://www.tradingview.com/script/WNxR3zVA/?comments_sort=created
// Modified Fractal adaptive MA //
ma1_len = input(16, title="Choose 1st MA length")
ma2_len = input(20, title="Choose 2nd MA length")
ma3_len = input(26, title="Choose 3rd MA length")
ma4_len = input(30, title="Choose 4th MA length")
ma_source = input(close, title="Choose MA price source")
FC = input(1, type=input.integer, minval=1, title="FRAMA lower shift limit (FC)") 
SC = input(198, type=input.integer, minval=1, title="FRAMA upper shift limit (SC)")

// FRAMA function
pine_frama(x, y, z, v) =>
    // x = source , y = length , z = FC , v = SC
    HL = (highest(high, y) - lowest(low, y)) / y
    HL1 = (highest(high, y/2) - lowest(low, y/2)) / (y/2)
    HL2 =(highest(high, y/2)[y/2] - lowest(low, y/2)[y/2]) / (y/2)
    D = (log(HL1+HL2) - log(HL)) / log(2)
    dim = iff(HL1>0 and HL2>0 and HL>0, D, nz(D[1]))
    w = log(2/(v+1))
    alpha = exp(w*(dim-1))
    alpha1 = alpha>1 ? 1 : (alpha<0.01 ? 0.01 : alpha)
    oldN = (2-alpha1) / alpha1
    newN = (((v-z) * (oldN-1)) / (v-1)) + z
    newalpha = 2/(newN+1)
    newalpha1 = newalpha<2/(v+1) ? 2/(v+1) : (newalpha>1 ? 1 : newalpha)
    frama = 0.0
    frama := (1-newalpha1) * nz(frama[1]) + newalpha1*x
%}
function out = FRAMA1(C,y)
% y = 16;
x = C;
FC = 1; % FRAMA lower shift limit (FC)
SC = 198; % FRAMA upper shift limit (SC)
z = FC; 
v = SC;
persistent XF1
if isempty(XF1)
    XF1.HLwin = repmat(C,y,1);
    XF1.HL1win = repmat(C,y/2,1);
    XF1.HL2win = repmat(zeros(1,length(C)),y/2,1);
    XF1.Dp = zeros(1,length(C));
    XF1.framap = zeros(1,length(C));
end
XF1.HLwin = [C;XF1.HLwin(1:end-1,:)];
XF1.HL1win = [C;XF1.HL1win(1:end-1,:)];
HL = (max(XF1.HLwin) - min(XF1.HLwin))/y;
HL1 = (max(XF1.HL1win) - min(XF1.HL1win))/y*2;
XF1.HL2win = [HL1;XF1.HL2win(1:end-1,:)];
HL2 = XF1.HL2win(y/2,:);
D = (log(HL1+HL2) - log(HL))/log(2);
dim = zeros(1,length(C));
k = HL1>0|HL2>0|HL>0;
dim(k) = D(k);
dim(~k) = XF1.Dp(~k);
w = log(2./(v+1));
alpha = exp(w*(dim-1));
alpha1 = alpha;
alpha1(alpha1>1) = 1;
alpha1(alpha1<0.01) = 0.01;
oldN = (2-alpha1) ./ alpha1;
newN = (((v-z) .* (oldN-1)) ./ (v-1)) + z;
newalpha = 2./(newN+1);
newalpha1 = newalpha;
newalpha1(newalpha<2./(v+1)) = 2./(v+1);
newalpha1(newalpha>1) = 1;
frama = (1-newalpha1).*XF1.framap + newalpha1.*x;

XF1.Dp = D;
XF1.framap = frama;
out = frama;
end
