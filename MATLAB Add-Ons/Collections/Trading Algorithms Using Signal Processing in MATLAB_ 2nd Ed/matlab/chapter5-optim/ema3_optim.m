function out = ema3_optim(n,H,L,P1,P2,P3,Psig)

Price = (H+L)/2;
a1 = 2/(P1+1);
a2 = 2/(P2+1);
a3 = 2/(P3+1);
asig = 2/(Psig+1);
Z = zeros(1,length(H));
O = ones(1,length(H));
persistent Xema3
if isempty(Xema3) || n==1
    Xema3.C1p = Price;
    Xema3.C2p = Price;
    Xema3.C3p = Price;
    Xema3.sigp = Z;
    Xema3.buyp = Z;
    Xema3.sellp = Z;
end
% ema calc
ema_1 = (1-a1)*Xema3.C1p + a1*Price;
ema_2 = (1-a2)*Xema3.C2p + a2*Price;
ema_3 = (1-a3)*Xema3.C3p + a3*Price;
% mmacd = 2*ema_1 - ema_2 - ema_3;
mmacd = ema_1 - ema_2;
ema_sig = (1-asig)*Xema3.sigp + asig*mmacd;
buy = Z;sell = Z;
buy(ema_sig>0) = 1;
sell(ema_sig<0) = 1;
chk = ema_sig>0;
chk1 = ema_sig<0;
chk3 = ema_3>Xema3.C3p;
chk4 = ema_3<Xema3.C3p;

Xema3.C1p = ema_1;
Xema3.C2p = ema_2;
Xema3.C3p = ema_3;
Xema3.sigp = ema_sig;
Xema3.buyp = buy;
Xema3.sellp = sell;
out(1,:) = ema_1;
out(2,:) = ema_2;
out(3,:) = ema_3;
out(4,:) = ema_sig;
out(5,:) = buy;
out(6,:) = sell;
end
