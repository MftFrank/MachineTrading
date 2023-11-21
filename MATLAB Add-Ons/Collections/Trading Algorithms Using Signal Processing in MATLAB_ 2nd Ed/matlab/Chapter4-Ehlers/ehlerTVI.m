%{
https://quantstrattrader.wordpress.com/2014/05/29/trend-vigor-part-ii-the-delta-parameter-ehlers-entries-and-exits-and-vaguely-intelligent-portfolio-management/
http://www.tradingblox.com/Manuals/BloxBuilderHTML/trend_vigor.htm
"TVI" <- function(x, period=20, delta=.2, triggerLag=1, ...) 
    beta <- cos(2*pi/period)
    gamma <- 1/cos(4*pi*delta/period)
    alpha <- gamma - sqrt(gamma*gamma-1)
    BP <- .5*(1-alpha)*(x-lag(x,2))
    BP[1] <- BP[2] <- 0
    BP <- filter(BP, c(beta*(1+alpha),-1*alpha),method="recursive")
    BP <- xts(BP, order.by=index(x))
    signal <- BP - lag(BP, round(period/2))
    lead <- 1.4*(BP-lag(BP, round(period/4)))
     
    BP2 <- BP*BP
    LBP2 <- lag(BP2, round(period/4))
    power <- runSum(BP2, period)+runSum(LBP2, period)
    RMS <- sqrt(power/period)
    PtoP <- 2*sqrt(2)*RMS
     
    a1 <- exp(-sqrt(2)*pi/period)
    b1 <- 2*a1*cos(sqrt(2)*pi/period)
    coef2 <- b1
    coef3 <- -a1*a1
    coef1 <- 1-coef2-coef3
    trend <- coef1*(x-lag(x, period))
    trend[is.na(trend)] <- 0
    trend <- filter(trend, c(coef2, coef3), method="recursive")
    trend <- xts(trend, order.by=index(x))
    vigor <- trend/PtoP
    vigor[vigor > 2] <- 2
    vigor[vigor < -2] <- -2
    vigor[is.na(vigor)] <- 0
    trigger <- lag(vigor, triggerLag)
%}
function out = ehlerTVI(C)
period=20;
delta=.2;
triggerLag=1;
bet = cos(2*pi/period);
gamm = 1/cos(4*pi*delta/period);
alph = gamm - sqrt(gamm*gamm-1);
Z = zeros(1,length(C));
persistent Xtvi
if isempty(Xtvi)
    Xtvi.bp1 = Z;
    Xtvi.bp2 = Z;
    Xtvi.trp = Z;
    Xtvi.trpp = Z;
    Xtvi.vigp = Z;
    Xtvi.Cp = C;
    Xtvi.Cpp = C;
    Xtvi.bpwin = repmat(Z,round(period),1);
    Xtvi.Cwin = repmat(C,round(period),1);
    Xtvi.lbp2win = repmat(Z,round(period),1);
    Xtvi.lagbp2win = repmat(Z,round(period),1);
end
BP = .5*(1-alph)*(C-Xtvi.Cpp) + bet*(1+alph)*Xtvi.bp1...
    - alph*Xtvi.bp2;
Xtvi.bpwin = [BP;Xtvi.bpwin(1:end-1,:)];
Xtvi.Cwin = [C;Xtvi.Cwin(1:end-1,:)];
signal = BP - Xtvi.bpwin(round(period/2),:);
lead = 1.4*(BP - Xtvi.bpwin(round(period/4),:));
BP2 = BP.*BP;
Xtvi.lbp2win = [BP2;Xtvi.lbp2win(1:end-1,:)];
LBP2 = Xtvi.lbp2win(round(period/4),:);
Xtvi.lagbp2win = [LBP2;Xtvi.lagbp2win(1:end-1,:)];
power = sum(Xtvi.lbp2win)+sum(Xtvi.lagbp2win);
RMS = sqrt(power/period);
PtoP = 2*sqrt(2)*RMS;
a1 = exp(-sqrt(2)*pi/period);
b1 = 2*a1*cos(sqrt(2)*pi/period);
coef2 = b1;
coef3 = -a1*a1;
coef1 = 1-coef2-coef3;
trend = coef1*(C-Xtvi.Cwin(end,:)) + coef2*Xtvi.trp...
    + coef3*Xtvi.trpp;
vigor = trend./PtoP;
vigor(vigor>2) = 2;
vigor(vigor<-2) = -2;
trigger = Xtvi.vigp;
Xtvi.bp2 = Xtvi.bp1;
Xtvi.bp1 = BP;
Xtvi.Cpp = Xtvi.Cp;
Xtvi.Cp = C;
Xtvi.trpp = Xtvi.trp;
Xtvi.trp = trend;
Xtvi.vigp = vigor;
out(1,:) = signal;
out(2,:) = lead;
out(3,:) = RMS;
out(4,:) = vigor;
out(5,:) = trigger;
end
