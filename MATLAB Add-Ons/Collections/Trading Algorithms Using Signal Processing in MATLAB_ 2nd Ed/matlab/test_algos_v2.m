% test_algos.m
clc,clear all,close all,dbstop if error
dbstop('if', 'error', 'MATLAB:badsubscript')
clear obv_adx

vars = whos;
vars = vars([vars.persistent]);
varName = {vars.name};
clear(varName{:});

load stkfiles.mat
nn = length(stk);
len = length(cl(:,1));

for i = 1:len
    out = ehlerTVI(cl(i,:));
    tvisig(i,:) = out(1,:);
    tvilead(i,:) = out(2,:);
    tvirms(i,:) = out(3,:);
    tvivig(i,:) = out(4,:);
    tvitrig(i,:) = out(5,:);
%{
    out = perfectEMA(cl(i,:));
    pema(i,:) = out(1,:);
    pemaosc(i,:) = out(2,:);
    pemaoscf(i,:) = out(3,:);
    pemaT2(i,:) = out(4,:);
    pema1(i,:) = out(5,:);
    pemaosc1(i,:) = out(6,:);
    out = ifishCCI(hi(i,:),lo(i,:),cl(i,:));
    ifcci(i,:) = out(1,:);
    ifcciifish(i,:) = out(2,:);
    out = adxAdapSt(hi(i,:),lo(i,:),cl(i,:));
    adasadx(i,:) = out(1,:);
    adasrsi_adx(i,:) = out(2,:);
    adasst_min(i,:) = out(3,:);
    adasst_max(i,:) = out(4,:);
    adasstinv(i,:) = out(5,:);
    adasstnotinv(i,:) = out(6,:);
    out = GMMAosc(cl(i,:));
    out = vhmaDel(cl(i,:));
    vhvhf(i,:) = out(1,:);
    vhvhma1(i,:) = out(2,:);
    vhvhma2(i,:) = out(3,:);
    vhdif(i,:) = out(4,:);
    vhdif2(i,:) = out(5,:);
    out = EhlerPowMA(hi(i,:),lo(i,:),cl(i,:));
    epma1(i,:) = out(1,:);
    epma2(i,:) = out(2,:);
    epma3(i,:) = out(3,:);
    epma1_2(i,:) = out(4,:);
    epma1_3(i,:) = out(5,:);
    out = EhlerVoss(cl(i,:));
    EVossfilt(i,:) = out(1,:);
    EVoss(i,:) = out(2,:);
    out = hurstbnds(hi(i,:),lo(i,:));
    hbcma(i,:) = out(1,:);
    hbupex(i,:) = out(2,:);
    hbloex(i,:) = out(3,:);
    hbupout(i,:) = out(4,:);
    hbloout(i,:) = out(5,:);
    hbupin(i,:) = out(6,:);
    hbloin(i,:) = out(7,:);
    hbHO(i,:) = out(8,:);
    out = EhlersHurst(cl(i,:));
    EHhurst(i,:) = out(1,:);
    EHsmhurst(i,:) = out(2,:);
    out = ScalpcciStoch(cl(i,:));
    ccist(i,:) = out(1,:);
    ccistoch(i,:) = out(2,:);
    ccistK(i,:) = out(3,:);
    ccistD(i,:) = out(4,:);
    out = Reflex(cl(i,:));
    refl(i,:) = out(1,:);
    refltf(i,:) = out(2,:);
    reflFilt(i,:) = out(3,:);
    out = EhlersUO(cl(i,:));
    euo(i,:) = out(1,:);
    euoMA(i,:) = out(2,:);
    euodif(i,:) = out(3,:);
    out = ScalpADD(hi(i,:),lo(i,:),cl(i,:));
    scaddma(i,:) = out(1,:);
    scadddiff(i,:) = out(2,:);
    out = ScalpUrbanTow(hi(i,:),lo(i,:),cl(i,:));
    scut37(i,:) = out(1,:);
    scut39(i,:) = out(2,:);
    scut41(i,:) = out(3,:);
    scut44(i,:) = out(4,:);
    scut47(i,:) = out(5,:);
    scut50(i,:) = out(6,:);
    scutlong(i,:) = out(7,:);
    scutshort(i,:) = out(8,:);
    out = waveTrend(hi(i,:),lo(i,:),cl(i,:));
    wtwt1(i,:) = out(1,:);
    wtwt2(i,:) = out(2,:);
    wtwt12(i,:) = out(3,:);
    out = pzovzo(cl(i,:),vol(i,:));
    zovzo(i,:) = out(1,:);
    zopzo(i,:) = out(2,:);
    out = tonyema(cl(i,:));
    teema(i,:) = out(1,:);
    tel8h(i,:) = out(2,:);
    tel8(i,:) = out(3,:);
    out = ZLemaOsc(cl(i,:));
    zloe1(i,:) = out(1,:);
    zloo1(i,:) = out(2,:);
    zloe2(i,:) = out(3,:);
    zloo2(i,:) = out(4,:);
    out = Alligator(hi(i,:),lo(i,:));
    allig1(i,:) = out(1,:);
    allig2(i,:) = out(2,:);
    allig3(i,:) = out(3,:);
    allig1_2(i,:) = out(4,:);
    allig1_3(i,:) = out(5,:);
    %out = zlema(cl(i,:));
    %zleEC(i,:) = out(1,:);
    %zleEMA(i,:) = out(2,:);
    %zlediff(i,:) = out(3,:);
    out = tradDI(cl(i,:));
    tdir(i,:) = out(1,:);
    tdima(i,:) = out(2,:);
    tdiup(i,:) = out(3,:);
    tdidn(i,:) = out(4,:);
    tdimid(i,:) = out(5,:);
    tdimab(i,:) = out(4,:);
    tdimbab(i,:) = out(5,:);
    out = EldForceIdx(cl(i,:),vol(i,:));
    efiefi(i,:) = out(1,:);
    efis(i,:) = out(2,:);
    efibasis(i,:) = out(3,:);
    efiup(i,:) = out(4,:);
    efilo(i,:) = out(5,:);
    out = accSI(op(i,:),hi(i,:),lo(i,:),cl(i,:));
    asiasi(i,:) = out(1,:);
    asis(i,:) = out(2,:);
    asidel(i,:) = out(3,:);
    out = cbCompIdx(cl(i,:));
    cbcis(i,:) = out(1,:);
    cbcifast(i,:) = out(2,:);
    cbcislow(i,:) = out(3,:);
    out = raschkeOsc(cl(i,:));
    roscfast(i,:) = out(1,:);
    roscslow(i,:) = out(2,:);
    roscmacd(i,:) = out(3,:);
    roscsig(i,:) = out(4,:);
%}
end
% data plots
k = 12;
%{
% figure
% ax(1) = subplot(211);
% plot(ax(1),[cl(:,k)]),grid on
% title(['Volatility Quality Index of ',stk{k},' at 30 min June 2020'])
% legend('close')
% ax(2) = subplot(212);
% plot(ax(2),[vqisum(:,k),...
%     vqisumF(:,k),vqisumS(:,k)]),grid on
% legend('sum','sumF','sumS','Location','Best')
% linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),hbcma(:,k),hbupex(:,k),hbloex(:,k),...
    hbupout(:,k),hbloout(:,k),hbupin(:,k),hbloin(:,k)]),grid on
title(['Hurst Bands of ',stk{k},' at 30 min June 2020'])
legend('cl','cma','upex','loex','upout','loout',...
    'upin','loin','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[hbHO(:,k)]),grid on
legend('ho','Location','Best')
linkaxes(ax,'x')
figure
ax(1) = subplot(311);
plot(ax(1),[cl(:,k)]),grid on
title(['Inverse Fisher CCI of ',stk{k},' at 30 min June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(312);
plot(ax(2),[ifcci(:,k)]),grid on
legend('cci','Location','Best')
ax(3) = subplot(313);
plot(ax(3),[ifcciifish(:,k)]),grid on
legend('IFcci','Location','Best')
ylim([-1.1 1.1])
linkaxes(ax,'x')
% figure
% ax(1) = subplot(311);
% plot(ax(1),[cl(:,k),guposc1(:,k),guposc2(:,k),guposc3(:,k),...
%     guposc4(:,k),guposc5(:,k),guposc6(:,k),guposc7(:,k),...
%     guposc8(:,k),guposc9(:,k),guposc10(:,k),guposc11(:,k),...
%     guposc12(:,k)...
%     ]),grid on
% title(['Guppy Ribbons of ',stk{k},' at 30 min June 2020'])
% ax(2) = subplot(312);
% plot(ax(2),[guposcO1_7(:,k),guposcO2_8(:,k),guposcO3_9(:,k),...
%     guposcO4_10(:,k),guposcO5_11(:,k),guposcO6_12(:,k),...
%     guposcTr1_7(:,k),guposcTr2_8(:,k),guposcTr3_9(:,k),...
%     guposcTr4_10(:,k),guposcTr5_11(:,k),guposcTr6_12(:,k)...
%     ]),grid on
% title(['Guppy MACD of ',stk{k}])
% ax(3) = subplot(313);
% plot(ax(3),[guposcM1_7(:,k),guposcM2_8(:,k),guposcM3_9(:,k),...
%     guposcM4_10(:,k),guposcM5_11(:,k),guposcM6_12(:,k)...
%     ]),grid on
% title(['Guppy Oscillator of ',stk{k}])
% linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),roscfast(:,k),roscslow(:,k)]),grid on
title(['Raschke 3-10 Osc of ',stk{k},' at 30 min June 2020'])
legend('cl','fast','slow')
ax(2) = subplot(212);
plot(ax(2),[roscmacd(:,k),...
    roscsig(:,k)]),grid on
legend('macd','signal','Location','Best')
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Constance Brown Idx of ',stk{k},' at 30 min June 2020'])
legend('cl')
ax(2) = subplot(212);
plot(ax(2),[cbcis(:,k),...
    cbcifast(:,k),cbcislow(:,k)]),grid on
legend('s','fast','slow','Location','Best')
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Accum Swing Idx of ',stk{k},' at 30 min June 2020'])
legend('cl')
ax(2) = subplot(212);
plot(ax(2),[asiasi(:,k),...
    asis(:,k)]),grid on
legend('asi','s','Location','Best')
linkaxes(ax,'x')
figure
ax(1) = subplot(311);
plot(ax(1),[cl(:,k)]),grid on
title(['Elders Force Idx of ',stk{k},' at 30 min June 2020'])
legend('cl')
ax(2) = subplot(312);
plot(ax(2),[efiefi(:,k),...
    efis(:,k)]),grid on
legend('efi','s','Location','Best')
ax(3) = subplot(313);
plot(ax(3),[efibasis(:,k),efiup(:,k),efilo(:,k)]),grid on
legend('basis','up','lo','Location','Best')
linkaxes(ax,'x')
%}
%{
figure
ax(1) = subplot(311);
plot(ax(1),[cl(:,k)]),grid on
title(['Elders Force Idx of ',stk{k},' at 30 min June 2020'])
legend('cl')
ax(2) = subplot(312);
plot(ax(2),[efiefi(:,k),...
    efis(:,k)]),grid on
legend('efi','s','Location','Best')
ax(3) = subplot(313);
plot(ax(3),[efibasis(:,k),efiup(:,k),efilo(:,k)]),grid on
legend('basis','up','lo','Location','Best')
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Traders Dynamic Idx of ',stk{k},' at 30 min June 2020'])
legend('cl')
ax(2) = subplot(212);
plot(ax(2),[tdir(:,k),tdima(:,k),tdiup(:,k),tdidn(:,k),...
    tdimid(:,k),tdimab(:,k),tdimbab(:,k)]),grid on
legend('r','ma','up','dn','mid','mab','mbab','Location','Northwest')
ylim([0 100])
linkaxes(ax,'x')
figure
    zloe1(i,:) = out(1,:);
    zloo1(i,:) = out(2,:);
    zloe2(i,:) = out(3,:);
    zloo2(i,:) = out(4,:);
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),zloe1(:,k),zloe2(:,k)]),grid on
title(['ZLEMA of ',stk{k},' at 30 min June 2020'])
legend('cl','1','2')
ax(2) = subplot(212);
plot(ax(2),[zloo1(:,k),zloo2(:,k)]),grid on
legend('1','2','Location','Northwest')
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),allig1(:,k),allig2(:,k),allig3(:,k)]),grid on
title(['Alligator Indicator of ',stk{k},' at 30 min June 2020'])
legend('cl','5','8','13')
ax(2) = subplot(212);
plot(ax(2),[allig1_2(:,k),allig1_3(:,k)]),grid on
legend('1-2','1-3')
title(['Alligator Crossover of ',stk{k}])
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),zloe1(:,k),zloe2(:,k)]),grid on
title(['zlema Indicator of ',stk{k},' at 30 min June 2020'])
legend('cl','1','2')
ax(2) = subplot(212);
plot(ax(2),[zloo1(:,k),zloo2(:,k)]),grid on
legend('1','2')
title(['zlema oscillator of ',stk{k}])
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),zloe1(:,k),zloe2(:,k)]),grid on
title(['zlema Indicator of ',stk{k},' at 30 min June 2020'])
legend('cl','1','2')
ax(2) = subplot(212);
plot(ax(2),[zloo1(:,k),zloo2(:,k)]),grid on
legend('1','2')
title(['zlema oscillator of ',stk{k}])
linkaxes(ax,'x')
figure
plot([cl(:,k),teema(:,k),tel8h(:,k),tel8(:,k)]),grid on
title(['tony UX of ',stk{k},' at 30 min June 2020'])
legend('cl','ema','hi','lo')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Volume/Price Zone Oscillator of ',stk{k},' at 30 min June 2020'])
legend('cl')
ax(2) = subplot(212);
plot(ax(2),[zovzo(:,k),zopzo(:,k)]),grid on
legend('vzo','pzo')
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Wave Trend Oscillator of ',stk{k},' at 30 min June 2020'])
legend('cl')
ax(2) = subplot(212);
plot(ax(2),[wtwt1(:,k),wtwt2(:,k),wtwt12(:,k)]),grid on
legend('1','2','1-2')
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),scut37(:,k),scut39(:,k),scut41(:,k),...
    scut44(:,k),scut47(:,k),scut50(:,k)]),grid on
title(['Urban Towers Scalping of ',stk{k},' at 30 min June 2020'])
% legend('cl')
ax(2) = subplot(212);
plot(ax(2),[scutlong(:,k),scutshort(:,k)]),grid on
legend('long','short')
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),scaddma(:,k)]),grid on
title(['Advancers-Decliners of ',stk{k},' at 30 min June 2020'])
% legend('cl','ma')
ax(2) = subplot(212);
plot(ax(2),[scadddiff(:,k)]),grid on
legend('diff')
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Ehlers Universal Osc of ',stk{k},' at 30 min June 2020'])
% legend('cl')
ax(2) = subplot(212);
plot(ax(2),[euo(:,k),euoMA(:,k),euodif(:,k)]),grid on
legend('euo','ma','dif','Location','Best')
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),reflFilt(:,k)]),grid on
title(['Ehlers Reflex of ',stk{k},' at 30 min June 2020'])
legend('cl','Filt')
ax(2) = subplot(212);
plot(ax(2),[refl(:,k),refltf(:,k)]),grid on
legend('reflex','tf','Location','Best')
linkaxes(ax,'x')
figure
ax(1) = subplot(311);
plot(ax(1),[cl(:,k)]),grid on
title(['cci stochastic of ',stk{k},' at 30 min June 2020'])
legend('cl')
ax(2) = subplot(312);
plot(ax(2),[ccistoch(:,k),...
    ccistK(:,k),ccistD(:,k)]),grid on
legend('stoch','K','D','Location','Best')
ax(3) = subplot(313);
plot(ax(3),[ccist(:,k)]),grid on
legend('cci','Location','Best')
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Ehlers Hurst of ',stk{k},' at 30 min June 2020'])
legend('cl')
ax(2) = subplot(212);
plot(ax(2),[EHhurst(:,k),EHsmhurst(:,k)]),grid on
legend('hst','sm','Location','Best')
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Voss Predictive Filt of ',stk{k},' at 30 min June 2020'])
legend('cl')
ax(2) = subplot(212);
plot(ax(2),[EVossfilt(:,k),EVoss(:,k)]),grid on
legend('filt','voss','Location','Best')
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),epma1(:,k),epma2(:,k),epma3(:,k)]),grid on
title(['Powerful MA Xover of ',stk{k},' at 30 min June 2020'])
legend('cl','1','2','3','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[epma1_2(:,k),epma1_3(:,k)]),grid on
legend('1-2','1-3','Location','Best')
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),vhvhma1(:,k),vhvhma2(:,k)]),grid on
title(['Vertical Horizontal MA of ',stk{k},' at 30 min June 2020'])
legend('cl','vhma1','vhma2','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[vhdif(:,k),vhdif2(:,k)]),grid on
legend('dif','dif2','Location','Best')
linkaxes(ax,'x')
figure
ax(1) = subplot(311);
plot(ax(1),[cl(:,k)]),grid on
title(['adx and stoch of ',stk{k},' at 30 min June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(312);
plot(ax(2),[adasadx(:,k),adasrsi_adx(:,k)]),grid on
legend('adx','rsi-adx','Location','Best')
ax(3) = subplot(313);
plot(ax(3),[adasst_min(:,k),adasst_max(:,k),...
    adasstinv(:,k),adasstnotinv(:,k)]),grid on
legend('stmin','stmax','stinv','stNinv','Location','Best')
linkaxes(ax,'x')
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),pema(:,k),pema1(:,k)]),grid on
title(['Perfect MA of ',stk{k},' at 30 min June 2020'])
legend('cl','pema','pema1','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[pemaosc(:,k),pemaosc1(:,k),pemaoscf(:,k),pemaT2(:,k)]),grid on
legend('osc','osc1','oscf','T2','Location','Best')
linkaxes(ax,'x')
%}
figure
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Ehlers TVI of ',stk{k},' at 30 min June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[tvisig(:,k),tvilead(:,k),...
    tvivig(:,k),tvitrig(:,k)]),grid on
legend('sig','lead','vig','trig','Location','Best')
linkaxes(ax,'x')
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
%{
Perfect Moving Averages and Oscillators
Perfect MA: (forward EM + backward EMA)/2
Perfect Oscillator: Subtract forward EMA from the backward EMA
%}
function out = perfectEMA(C)
Lenf = 6;
Lenb = 6;
Losc = 4;
a = 0.5;
Z = zeros(1,length(C));
persistent Xpema
if isempty(Xpema)
    Xpema.Cwin = repmat(C,Lenb,1);
    Xpema.ebwin = repmat(C,Lenf,1);
    Xpema.efp = C;
    Xpema.ebp = C;
    Xpema.oscp = Z;
    Xpema.osc2p = Z;
end
Xpema.Cwin = [C;Xpema.Cwin(1:end-1,:)];
ef = Xpema.efp + 2/(Lenf+1)*(C-Xpema.efp);
Xpema.ebwin = [ef;Xpema.ebwin(1:end-1,:)];
Xpema.ebcp = C;
for ix = 1:Lenb
    eb = Xpema.ebp + ...
        2/(Lenb+1)*(Xpema.Cwin(ix,:)-Xpema.ebp);
    Xpema.ebp = eb;
    ebc = Xpema.ebcp + ...
        2/(Lenb+1)*(Xpema.Cwin(ix,:)-Xpema.ebcp);
    Xpema.ebcp = ebc;
end
Xpema.ebcp = 2*ebc - Xpema.ebwin(end,:);
for ix = Lenb:-1:1
    eb = Xpema.ebp + ...
        2/(Lenb+1)*(Xpema.Cwin(ix,:)-Xpema.ebp);
    Xpema.ebp = eb;
    ebc = Xpema.ebcp + ...
        2/(Lenb+1)*(Xpema.Cwin(ix,:)-Xpema.ebcp);
    Xpema.ebcp = ebc;
end
perfMA = (ef + eb)/2;
perfosc = eb - ef;
perfMA1 = (ef + ebc)/2;
perfosc1 = ebc - ef;
eosc = Xpema.oscp + 2/(Losc+1)*(perfosc-Xpema.oscp);
eosc2 = Xpema.osc2p + 2/(Losc+1)*(eosc-Xpema.osc2p);
T2 = (1+a)*eosc - a*eosc2;
Xpema.efp = ef;
Xpema.ebp = C;
Xpema.oscp = eosc;
Xpema.osc2p = eosc2;
out(1,:) = perfMA;
out(2,:) = perfosc;
out(3,:) = eosc;
out(4,:) = T2;
out(5,:) = perfMA1;
out(6,:) = perfosc1;
end
%{
https://www.tradingview.com/script/6JOLlu1W-adx-adaptive-stochastic/
https://www.tradingview.com/ideas/directionalmovement/
study("ADX Adaptive Stochastic", shorttitle="AADX SO")

len = input(19, title="DI Length")
min_len=input(19, title="Min stoch length")
max_len=input(100, title="Max stoch length Smoothing")
sm = input(2, title="Stoch Smoothing")
inv = input(false, title="Inverse adaptive")

up = change(high)
down = -change(low)
plusDM = na(up) ? na : (up > down and up > 0 ? up : 0)
minusDM = na(down) ? na : (down > up and down > 0 ? down : 0)
truerange = rma(tr, len)
plus = fixnan(100 * rma(plusDM, len) / truerange)
minus = fixnan(100 * rma(minusDM, len) / truerange)
sum = plus + minus
adx = 100 * abs(plus - minus) / (sum == 0 ? 1 : sum)
rsi_adx = rsi(adx,len)

st_min = stoch(close,high,low,min_len)
st_max = stoch(close,high,low,max_len)
st = inv ? sma((1-rsi_adx/100) * st_max + rsi_adx/100 * st_min, sm) : sma(rsi_adx/100 * st_max + (1-rsi_adx/100) * st_min, sm)
%}
function out = adxAdapSt(H,L,C)
high = H;
low = L;
close = C;
len = 19;
min_len = 19;
max_len = 100;
sm = 2;
Z = zeros(1,length(H));
persistent Xadas
if isempty(Xadas)
    Xadas.Hp = H;
    Xadas.Lp = L;
    Xadas.Cp = close;
    Xadas.trp = high - low;
    Xadas.plusp = Z;
    Xadas.minusp = Z;
    Xadas.rsiwin = repmat(Z,len,1);
    Xadas.Hwin = repmat(high,max_len,1);
    Xadas.Lwin = repmat(low,max_len,1);
    Xadas.stinvwin = repmat(Z,sm,1);
    Xadas.stnotinvwin = repmat(Z,sm,1);
    Xadas.adxp = Z;
    Xadas.avgUp = Z;
    Xadas.avgDp = Z;
end
Xadas.Hwin = [high;Xadas.Hwin(1:end-1,:)];
Xadas.Lwin = [low;Xadas.Lwin(1:end-1,:)];
up1 = high - Xadas.Hp;
down1 = -(low - Xadas.Lp);
plusDM = Z;
k = find(up1 > down1 & up1 > 0);
plusDM(k) = up1(k);
minusDM = Z;
k = find(down1 > up1 & down1 > 0);
minusDM(k) = down1(k);
tr = max(high-low,max(abs(high-Xadas.Cp),abs(low-Xadas.Cp)));
truerange = Xadas.trp + 1/len*(tr-Xadas.trp);
truerange(truerange==0) = 1;
plus1 = (Xadas.plusp + 1/len*(100*plusDM./truerange-Xadas.plusp));
minus1 = (Xadas.minusp + 1/len*(100*minusDM./truerange-Xadas.minusp));
plus1(isnan(plus1)) = 0;
minus1(isnan(minus1)) = 0;
plus1 = max(-1e5,plus1);plus1 = min(1e5,plus1);
minus1 = max(-1e5,minus1);minus1 = min(1e5,minus1);
sum1 = plus1 + minus1;
sum1(sum1==0) = 1;
tmp = plus1 - minus1;
% tmp(tmp==0) = 0.1;
adx = 100 * abs(tmp) ./ sum1;
Xadas.rsiwin = [adx-Xadas.adxp;Xadas.rsiwin(1:end-1,:)];
% rsi calcs
tmpU = Xadas.rsiwin;
tmpU(tmpU<0)=0;
tmpD = Xadas.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (avgU-Xadas.avgUp)/len + Xadas.avgUp;
emaavgD = (avgD-Xadas.avgDp)/len + Xadas.avgDp;
tmp = emaavgD;
tmp(tmp==0) = 1;
rs = emaavgU./tmp;
rsi_adx = 100 - (100 ./ (1 + rs));
highestminlen = max(Xadas.Hwin(1:min_len,:));
lowestminlen = min(Xadas.Lwin(1:min_len,:));
highestmaxlen = max(Xadas.Hwin);
lowestmaxlen = min(Xadas.Lwin);
st_min = 100*(close-lowestminlen)./(highestminlen-lowestminlen);
st_max = 100*(close-lowestmaxlen)./(highestmaxlen-lowestmaxlen);
tmp = (1-rsi_adx/100) .* st_max + rsi_adx/100 .* st_min;
tmp1 = rsi_adx/100 .* st_max + (1-rsi_adx/100) .* st_min;
Xadas.stinvwin = [tmp;Xadas.stinvwin(1:end-1,:)];
Xadas.stnotinvwin = [tmp1;Xadas.stnotinvwin(1:end-1,:)];
stinv = sum(Xadas.stinvwin)/sm;
stnotinv = sum(Xadas.stnotinvwin)/sm;
Xadas.Hp = H;
Xadas.Lp = L;
Xadas.Cp = close;
Xadas.trp = truerange;
Xadas.adxp = adx;
Xadas.plusp = plus1;
Xadas.minusp = minus1;
Xadas.avgUp = emaavgU;
Xadas.avgDp = emaavgD;
out(1,:) = adx;
out(2,:) = rsi_adx;
out(3,:) = st_min;
out(4,:) = st_max;
out(5,:) = stinv;
out(6,:) = stnotinv;
end
%{
study("Vertical Horizontal Moving Average [AneoPsy & alexgrover]", "VHMA", true)
length   = input(defval=50, type=input.integer, title="Length")
src      = input(defval=close, type=input.source, title="Source")
alert = input("VHMA Direction Change","Alert Conditions",
  options=["VHMA Direction Change","SRC/VHMA Crossover"])
//------------------------------------------------------------------------------
vhma=0.
R = highest(src, length) - lowest(src, length)
vhf = R / sum(abs(change(src)), length)
vhma := nz(vhma[1] + pow(vhf, 2) * (src - vhma[1]),src)study("Vertical Horizontal Moving Average [AneoPsy & alexgrover]", "VHMA", true)
length   = input(defval=50, type=input.integer, title="Length")
src      = input(defval=close, type=input.source, title="Source")
alert = input("VHMA Direction Change","Alert Conditions",
  options=["VHMA Direction Change","SRC/VHMA Crossover"])
//------------------------------------------------------------------------------
vhma=0.
R = highest(src, length) - lowest(src, length)
vhf = R / sum(abs(change(src)), length)
vhma := nz(vhma[1] + pow(vhf, 2) * (src - vhma[1]),src)
%}
function out = vhmaDel(C)
src = C;
Length = 50;
Z = zeros(1,length(src));
persistent XvhfD
if isempty(XvhfD)
    XvhfD.Cwin = repmat(src,Length,1);
    XvhfD.cdiffwin = repmat(Z,Length,1);
    XvhfD.Cp = src;
    XvhfD.vhma1p = src;
    XvhfD.vhma2p = src;
end
XvhfD.Cwin = [src;XvhfD.Cwin(1:end-1,:)];
hcp=max(XvhfD.Cwin);
lcp=min(XvhfD.Cwin);
cdiff=abs(src-XvhfD.Cp);
XvhfD.cdiffwin = [cdiff;XvhfD.cdiffwin(1:end-1,:)];
N=abs(hcp-lcp);
D=sum(XvhfD.cdiffwin);
D(D==0) = 1;
vhf=N./D;
vhf(isnan(vhf)) = 0;
vhma1 = XvhfD.vhma1p + power(vhf, 0.5) .* (src - XvhfD.vhma1p);
vhma2 = XvhfD.vhma2p + power(vhf, 2.0) .* (src - XvhfD.vhma2p);
dif2 = vhma2 - XvhfD.vhma2p;
XvhfD.Cp = src;
XvhfD.vhma1p = vhma1;
XvhfD.vhma2p = vhma2;
out(1,:) = vhf;
out(2,:) = vhma1;
out(3,:) = vhma2;
out(4,:) = vhma1-vhma2;
out(5,:) = dif2;
end
%{
http://www.dimensionetrading.com/Pattern_e_indicatori/Ehlers%20_Optimal%20Tracking%20Filters_.pdf
https://www.tradingview.com/script/LvaRO3Un-powerful-moving-average-crossover/
study("powerful moving average crossover",shorttitle="Ehlers_Kalman_cross_mcbw_",overlay=true)

// This script is a simplified version of John Ehlers's adaption of Dr. Kalman's optimum estimator as applied to price 
// action (More can be found on this here: http://www.dimensionetrading.com/Pattern_e_indicatori/Ehlers%20_Optimal%20Tracking%20Filters_.pdf). 
// Here I have adapted two of these optimum estimators to work together to provide crossover signals. 
// The user can choose the input of this filter in the 'input source'. 
//The 'Ratio of Uncertainties' controls how adaptive the moving averages are, increasing this number will increase adaptivity and vice versa for decreasing. 
// The 'Kalman Gain' allows the user to choose how much error to let into the calculation. The smaller this number is the quicker the moving average will approach price action.
// In practice this indicator is much smoother than most other moving averages and has significantly less whiplash while still getting very early entries.
// If anyone wants to adapt this script for their own uses please feel free. Message me what you make with it, I am very curious what this can do when in the right hands! 
// Happy trading! 

// User inputs -----------------------------------------------------------------

src_in = input(hlc3,title = 'input source')
trackinrat_01 = input(defval=2.0, minval=0.01, step=0.1, title = "Ratio of Uncertainties 01")
kgain_01 = input(defval=0.7, minval=0.01, maxval=1.1, step=0.01, title = "Kalman Gain 01")
trackinrat_02 = input(defval=2.0, minval=0.01, step=0.1, title = "Ratio of Uncertainties 02")
kgain_02 = input(defval=0.8, minval=0.01, maxval=1.1, step=0.01, title = "Kalman Gain 02")
//trackinrat_03 = input(defval=2.0, minval=0.01, step=0.1, title = "Ratio of Uncertainties 03")
//kgain_03 = input(defval=0.8, minval=0.01, maxval=1.1, step=0.01, title = "Kalman Gain 03")
bgcolor_io = input(true, title ='Show background color')

// Functions -------------------------------------------------------------------

ehlers_optimal_filter(varin_func, trackinrat_func, kgain_func)=>
    movement_uncertainty = trackinrat_func*(varin_func-varin_func[1]) + kgain_func*nz(movement_uncertainty[1])
    measurement_uncertainty_mcbw = 1*(high[1]-low[1])+kgain_func*nz(measurement_uncertainty_mcbw[1])
    lambda = abs(movement_uncertainty/measurement_uncertainty_mcbw)
    alpha = ( -pow(lambda,2) + pow(  (pow(lambda,4) + 16*pow(lambda,2))  ,0.5) )/ 8
    ehlers_optimal_price = alpha*varin_func + (1-alpha)*nz(ehlers_optimal_price[1])

// Function calls  -------------------------------------------------------------

filter_01 = ehlers_optimal_filter(src_in, trackinrat_01, kgain_01)
filter_02 = ehlers_optimal_filter(src_in, trackinrat_02, kgain_02)
//filter_03 = ehlers_optimal_filter(src_in, trackinrat_03, kgain_03)
%}
function out = EhlerPowMA(H,L,C)
src_in = (H+L+C)/3;
trackinrat_01 = 2.0;
kgain_01 = 0.7;
trackinrat_02 = 2.0;
kgain_02 = 0.8;
trackinrat_03 = 2.0;
kgain_03 = 0.85;
Z = zeros(1,length(H));
persistent Xepma
if isempty(Xepma)
    Xepma.varin_funcp = src_in;
    Xepma.Hp = H;
    Xepma.Lp = L;
    Xepma.movement_uncertainty1p = Z;
    Xepma.movement_uncertainty2p = Z;
    Xepma.movement_uncertainty3p = Z;
    Xepma.measurement_uncertainty_mcbw1p = H-L;
    Xepma.measurement_uncertainty_mcbw2p = H-L;
    Xepma.measurement_uncertainty_mcbw3p = H-L;
    Xepma.ehlers_optimal_price1p = src_in;
    Xepma.ehlers_optimal_price2p = src_in;
    Xepma.ehlers_optimal_price3p = src_in;
end
varin_func = src_in;
trackinrat_func = trackinrat_01;kgain_func = kgain_01;
movement_uncertainty1 = ...
    trackinrat_func*(varin_func - Xepma.varin_funcp) + ...
    kgain_func*Xepma.movement_uncertainty1p;
measurement_uncertainty_mcbw1 = Xepma.Hp - Xepma.Lp + ...
    kgain_func*Xepma.measurement_uncertainty_mcbw1p;
lambda = abs(movement_uncertainty1./...
    measurement_uncertainty_mcbw1);
alpha = ...
    ( -power(lambda,2) + ...
    power( (power(lambda,4) + 16*power(lambda,2)),0.5))/ 8;
ehlers_optimal_price1 = alpha.*varin_func + ...
    (1-alpha).*Xepma.ehlers_optimal_price1p;
trackinrat_func = trackinrat_02;kgain_func = kgain_02;
movement_uncertainty2 = ...
    trackinrat_func*(varin_func - Xepma.varin_funcp) + ...
    kgain_func*Xepma.movement_uncertainty2p;
measurement_uncertainty_mcbw2 = Xepma.Hp - Xepma.Lp + ...
    kgain_func*Xepma.measurement_uncertainty_mcbw2p;
lambda = abs(movement_uncertainty2./...
    measurement_uncertainty_mcbw2);
alpha = ...
    ( -power(lambda,2) + ...
    power( (power(lambda,4) + 16*power(lambda,2)),0.5))/ 8;
ehlers_optimal_price2 = alpha.*varin_func + ...
    (1-alpha).*Xepma.ehlers_optimal_price2p;
trackinrat_func = trackinrat_03;kgain_func = kgain_03;
movement_uncertainty3 = ...
    trackinrat_func*(varin_func - Xepma.varin_funcp) + ...
    kgain_func*Xepma.movement_uncertainty3p;
measurement_uncertainty_mcbw3 = Xepma.Hp - Xepma.Lp + ...
    kgain_func*Xepma.measurement_uncertainty_mcbw3p;
lambda = abs(movement_uncertainty3./...
    measurement_uncertainty_mcbw3);
alpha = ...
    ( -power(lambda,2) + ...
    power( (power(lambda,4) + 16*power(lambda,2)),0.5))/ 8;
ehlers_optimal_price3 = alpha.*varin_func + ...
    (1-alpha).*Xepma.ehlers_optimal_price3p;
Xepma.varin_funcp = varin_func;
Xepma.movement_uncertainty1p = movement_uncertainty1;
Xepma.movement_uncertainty2p = movement_uncertainty2;
Xepma.movement_uncertainty3p = movement_uncertainty3;
Xepma.measurement_uncertainty_mcbw1p = measurement_uncertainty_mcbw1;
Xepma.measurement_uncertainty_mcbw2p = measurement_uncertainty_mcbw2;
Xepma.measurement_uncertainty_mcbw3p = measurement_uncertainty_mcbw3;
Xepma.Hp = H;
Xepma.Lp = L;
Xepma.ehlers_optimal_price1p = ehlers_optimal_price1;
Xepma.ehlers_optimal_price2p = ehlers_optimal_price2;
Xepma.ehlers_optimal_price3p = ehlers_optimal_price3;
out(1,:) = ehlers_optimal_price1;
out(2,:) = ehlers_optimal_price2;
out(3,:) = ehlers_optimal_price3;
out(4,:) = ehlers_optimal_price1-ehlers_optimal_price2;
out(5,:) = ehlers_optimal_price1-ehlers_optimal_price3;
end
%{
https://www.tradingview.com/script/YCkuD0nx-e2-Voss-Predictive-Filter/
study("Voss Predictive Filter", "VPF", false)
// Inputs {
src             = input(close,  "Source", input.source)
int     len     = input(20,	    "Length")
int     pre     = input(3,		"Predict")
float   band    = input(0.25,	"Bandwidth")
// }
// Voss Predictive Filter {
f_vpf(_len, _pre, _band, _src) =>
	float _filt = .0, float _sumC = .0, float _voss = .0
	_pi  = 2 * asin(1)
	_ord = 3 * _pre
	_f1  = cos(2 * _pi / _len)
	_g1  = cos(_band * 2 * _pi / _len)
	_s1  = 1 / _g1 - sqrt(1 / (_g1 * _g1) - 1)
	_s2  = 1 + _s1, _s3 = 1 - _s1
	_x1  = nz(_src) - nz(_src[2])
	_x2  = (3 + _ord) / 2
	for _i = 0 to (_ord - 1)
		_sumC := _sumC + ((_i + 1) / _ord) * _voss[_ord - _i]
	if bar_index <= _ord
		_filt := 0		
		_voss := 0		
	else			
		_filt := 0.5 * _s3 * _x1 + _f1 * _s2 * _filt[1] - _s1 * _filt[2]
		_voss := _x2 * _filt - _sumC
	[_voss, _filt]

[voss, filt] = f_vpf(len, pre, band, src)
%}
function out = EhlerVoss(C)
src     = C;
len     = 20;
pre     = 3;
band    = 0.25;
Z = zeros(1,length(src));
persistent XEVoss
if isempty(XEVoss)
    ord = 3 * pre;
    f1  = cos(2 * pi / len);
    g1  = cos(band * 2 * pi / len);
    s1  = 1 / g1 - sqrt(1 / (g1 * g1) - 1);
    s2  = 1 + s1;
    s3 = 1 - s1;
    XEVoss.ord = ord;
    XEVoss.f1 = f1;
    XEVoss.g1 = g1;
    XEVoss.s1 = s1;
    XEVoss.s2 = s2;
    XEVoss.s3 = s3;
    XEVoss.Cp = src;
    XEVoss.Cpp = src;
    XEVoss.filtp = Z;
    XEVoss.filtpp = Z;
    XEVoss.vosswin = repmat(Z,ord,1);
end
ord = XEVoss.ord;
f1 = XEVoss.f1;
g1 = XEVoss.g1;
s1 = XEVoss.s1;
s2 = XEVoss.s2;
s3 = XEVoss.s3;
x1  = src - XEVoss.Cpp;
x2  = (3 + ord) / 2;
sumC = Z;
for i = 1:ord
    sumC = sumC + ...
        ((i + 1) / ord) * XEVoss.vosswin(ord-i+1,:);
end
filt = 0.5 * s3 * x1 + ...
    f1 * s2 * XEVoss.filtp - s1 * XEVoss.filtp;
voss = x2 * filt - sumC;
XEVoss.vosswin = [voss;XEVoss.vosswin(1:end-1,:)];
XEVoss.Cpp = XEVoss.Cp;
XEVoss.Cp = src;
XEVoss.filtpp = XEVoss.filtp;
XEVoss.filtp = filt;
out(1,:) = filt;
out(2,:) = voss;
end
%{
https://www.tradingview.com/script/isdHhWfF-Ehlers-Hurst-Coefficient-CC/
study("Ehlers Hurst Coefficient [CC]", overlay=false)

inp = input(title="Source", type=input.source, defval=close)
src = security(syminfo.tickerid, res, inp[rep ? 0 : barstate.isrealtime ? 1 : 0])[rep ? 0 : barstate.isrealtime ? 0 : 1]
length = input(title="Length", type=input.integer, defval=30, minval=1)
ssfLength = input(title="SSFLength", type=input.integer, defval=20, minval=1)

pi = 2 * asin(1)
alpha = exp(-1.414 * pi / ssfLength)
beta = 2 * alpha * cos(1.414 * pi / ssfLength)
c2 = beta
c3 = -alpha * alpha
c1 = 1 - c2 - c3
hLength = ceil(length / 2)

n3 = (highest(src, length) - lowest(src, length)) / length
hh = src, ll = src
for i = 0 to hLength - 1
    price = nz(src[i])
    hh := price > hh ? price : hh
    ll := price < ll ? price : ll
    
n1 = (hh - ll) / hLength
hh := nz(src[hLength])
ll := nz(src[hLength])
for i = hLength to length - 1
    price = nz(src[i])
    hh := price > hh ? price : hh
    ll := price < ll ? price : ll
    
n2 = (hh - ll) / hLength
dimen = 0.0
dimen := n1 > 0 and n2 > 0 and n3 > 0 ? 0.5 * (((log(n1 + n2) - log(n3)) / log(2)) + dimen[1]) : 0
hurst = 2 - dimen

smoothHurst = 0.0
smoothHurst := (c1 * ((hurst + nz(hurst[1])) / 2)) + (c2 * nz(smoothHurst[1])) + (c3 * nz(smoothHurst[2]))

sig = smoothHurst > 0.5 ? 1 : smoothHurst < 0.5 ? -1 : 0
%}
function out = EhlersHurst(C)
src = C;
Length = 30;
ssfLength = 20;
hLength = ceil(Length / 2);
Z = zeros(1,length(src));
persistent XEHst
if isempty(XEHst)
    alpha = exp(-1.414 * pi / ssfLength);
    beta = 2 * alpha * cos(1.414 * pi / ssfLength);
    c2 = beta;
    c3 = -alpha * alpha;
    c1 = 1 - c2 - c3;
    XEHst.c1 = c1;
    XEHst.c2 = c2;
    XEHst.c3 = c3;
    XEHst.srcwin = repmat(src,Length,1);
    XEHst.dimenp = Z;
    XEHst.hurstp = ones(1,length(src));
    XEHst.smoothHurstp = Z;
    XEHst.smoothHurstpp = Z;
end
c1 = XEHst.c1;
c2 = XEHst.c2;
c3 = XEHst.c3;
XEHst.srcwin = [src;XEHst.srcwin(1:end-1,:)];
n3 = (max(XEHst.srcwin) - min(XEHst.srcwin)) / Length;
hh = src; ll = src;
for hi = 1:hLength
    price = XEHst.srcwin(hi,:);
    k = find(price > hh);
    hh(k) = price(k);
    k = find(price < ll);
    ll(k) = price(k);
end
n1 = (hh - ll) / hLength;
hh = XEHst.srcwin(hLength,:);
ll = XEHst.srcwin(hLength,:);
for i = hLength:Length
    price = XEHst.srcwin(i,:);
    k = find(price > hh);
    hh(k) = price(k);
    k = find(price < ll);
    ll(k) = price(k);
end
n2 = (hh - ll) / hLength;
dimen = Z;
k = find(n1 > 0 & n2 > 0 & n3 > 0);
dimen(k) = 0.5 * (((log(n1(k) + n2(k)) - log(n3(k))) / log(2))...
    + XEHst.dimenp(k));
hurst = 2 - dimen;
smoothHurst = c1 * (hurst + XEHst.hurstp) / 2 + ...
    (c2 * XEHst.smoothHurstp) + ...
    (c3 * XEHst.smoothHurstpp);
sig = Z;
sig(smoothHurst > 0.5) = 1;
sig(smoothHurst < 0.5) = -1;
XEHst.dimenp = dimen;
XEHst.hurstp = hurst;
XEHst.smoothHurstpp = XEHst.smoothHurstp;
XEHst.smoothHurstp = smoothHurst;
out(1,:) = hurst;
out(2,:) = smoothHurst;
end
%{
https://www.tradingview.com/script/6v0f0qnf-Trendflex-Another-new-Ehlers-indicator/
https://www.tradingview.com/script/qpFGRuYr-Reflex-A-new-Ehlers-indicator/
study("Reflex",overlay=false)
Length = input(40,"Reflex Period",input.integer)
Threshold = input(1,"Oscillator Range",input.float,step=0.1)
Source =input(close,"Source",input.source)
ATR = input(true,"Show ATR label",input.bool)
var atr_lbl = label.new(0, 0,"yolo", xloc.bar_index, yloc.price, color.black, label.style_label_left, color.white, size.large, text.align_center, "Average True Range of the previous 10 bars. \nUnits are in 'Min Tick' of current asset.")

//  int Length -> look back period
//  source Source -> series to perform Reflex computation
reflex(Source,Length)=>
    //Gently smooth the data in a SuperSmoother
    a1 := exp(-1.414*3.14159 / (.5*Length))
    b1 := 2*a1*cos(1.414*180 / (.5*Length))
    c2 := b1
    c3 := -a1*a1
    c1 := 1 - c2 - c3
    Filt := c1*(Source + Source[1]) / 2 + c2*nz(Filt[1]) + c3*nz(Filt[2])
    //Length is assumed cycle period
    Slope := (nz(Filt[Length]) - Filt) / Length
    //Sum the differences
    for count = 1 to Length 
        Sum := Sum + (Filt + count*Slope) - nz(Filt[count])
    Sum := Sum / Length
    //Normalize in terms of Standard Deviations
    MS := .04*Sum*Sum + .96*nz(MS[1])
    if(MS != 0)
        Reflex := Sum / sqrt(MS)
    Reflex
%}
function out = Reflex(C)
Source = C;
Length = 40;
Z = zeros(1,length(Source));
persistent Xrefl
if isempty(Xrefl)
    Xrefl.Sp = Source;
    Xrefl.filtp = Source;
    Xrefl.filtpp = Source;
    Xrefl.MSp = Source;
    Xrefl.MStfp = Source;
    Xrefl.filtwin = repmat(Source,Length,1);
end
a1 = exp(-1.414*3.14159 / (.5*Length));
b1 = 2*a1*cos(1.414*180 / (.5*Length));
c2 = b1;
c3 = -a1*a1;
c1 = 1 - c2 - c3;
Filt = c1*(Source + Xrefl.Sp) ./ 2 + ...
    c2*Xrefl.filtp + c3*Xrefl.filtpp;
Xrefl.filtwin = [Filt;Xrefl.filtwin(1:end-1,:)];
Slope = (Xrefl.filtwin(end,:) - Filt) / Length;
Sum = Z;Sumtf = Z;
for count = 1:Length 
    Sum = Sum + (Filt + count*Slope) - ...
        Xrefl.filtwin(count,:);
    Sumtf = Sumtf + Filt - ...
        Xrefl.filtwin(count,:);
end
Sum = Sum / Length;
Sumtf = Sumtf / Length;
MS = .04*Sum.*Sum + .96*Xrefl.MSp;
MStf = .04*Sumtf.*Sumtf + .96*Xrefl.MStfp;
Reflex = Sum ./ sqrt(MS);
Trendflex = Sumtf ./ sqrt(MStf);
Xrefl.Sp = Source;
Xrefl.filtpp = Xrefl.filtp;
Xrefl.filtp = Filt;
Xrefl.MSp = MS;
Xrefl.MStfp = MStf;
out(1,:) = Reflex;
out(2,:) = Trendflex;
out(3,:) = Filt;
end
%{
https://www.tradingview.com/script/ieFYbVdC-Ehlers-Universal-Oscillator-LazyBear/
study("Universal Oscillator [LazyBear]", shorttitle="UNIOSC_LB")
bandedge= input(20, title="BandEdge")
showHisto=input(true, type=bool, title="Show Histogram?")
showMA=input(false, type=bool, title="Show Signal?")
lengthMA=input(9, title="EMA signal length")
enableBarColors=input(false, title="Color Bars?")

whitenoise= (close - close[2])/2
a1= exp(-1.414 * 3.14159 / bandedge)
b1= 2.0*a1 * cos(1.414*180 /bandedge)
c2= b1
c3= -a1 * a1
c1= 1 - c2 - c3
filt= c1 * (whitenoise + nz(whitenoise[1]))/2 + c2*nz(filt[1]) + c3*nz(filt[2])
filt1= iff(cum(1) == 0, 0, iff(cum(1) == 2, c2*nz(filt1[1]),
	iff(cum(1) == 3, c2*nz(filt1[1]) + c3*nz(filt1[2]), filt)))

pk= iff(cum(1) == 2, .0000001,
	iff(abs(filt1) > nz(pk[1]), abs(filt1), 0.991 * nz(pk[1])))
denom= iff(pk==0, -1, pk)
euo=iff(denom == -1, nz(euo[1]), filt1/pk)
euoMA=ema(euo, lengthMA)
%}
function out = EhlersUO(C)
close = C;
bandedge = 20;
lengthMA = 9;
a = 2/(lengthMA+1);
Z = zeros(1,length(C));
persistent Xeuo
if isempty(Xeuo)
    Xeuo.Cp = close;
    Xeuo.whitenoisep = Z;
    Xeuo.filtp = Z;
    Xeuo.filtpp = Z;
    Xeuo.pkp = Z;
    Xeuo.euop = Z;
    Xeuo.euoMAp = Z;
end
whitenoise = (close - Xeuo.Cp)/2;
a1 = exp(-1.414 * 3.14159 / bandedge);
b1 = 2.0*a1 * cos(1.414*180 /bandedge);
c2 = b1;
c3 = -a1 * a1;
c1 = 1 - c2 - c3;
filt = c1 * (whitenoise + Xeuo.whitenoisep)/2 + ...
    c2*Xeuo.filtp + c3*Xeuo.filtpp;
filt1 = filt;
pk = abs(filt1);
k = find(abs(filt1) < Xeuo.pkp);
pk(k) = 0.991*Xeuo.pkp(k);
denom = pk;
denom(denom==0) = -1;
euo = filt1./pk;
k = find(denom==-1);
euo(k) = Xeuo.euop(k);
euoMA = (1-a)*Xeuo.euoMAp + a*euo;
Xeuo.Cp = close;
Xeuo.whitenoisep = whitenoise;
Xeuo.filtpp = Xeuo.filtp;
Xeuo.filtp = filt;
Xeuo.pkp = pk;
Xeuo.euop = euo;
Xeuo.euoMAp = euoMA;
out(1,:) = euo;
out(2,:) = euoMA;
out(3,:) = euo - euoMA;
end
%{
https://www.tradingview.com/script/XZyG5SOx-CCI-Stochastic-and-a-quick-lesson-on-Scalping-Trading-Systems/
study("CCI Stochastic", shorttitle="CCI_S", overlay=false)

source = input(close)
cci_period = input(28, "CCI Period")
stoch_period = input(28, "Stoch Period")
stoch_smooth_k = input(3, "Stoch Smooth K")
stoch_smooth_d = input(3, "Stoch Smooth D")
OB = input(80, "Overbought", type=input.integer)
OS = input(20, "Oversold", type=input.integer)

cci = cci(source, cci_period)
stoch_cci_k = sma(stoch(cci, cci, cci, stoch_period), stoch_smooth_k)
stoch_cci_d = sma(stoch_cci_k, stoch_smooth_d)
%}
function out = ScalpcciStoch(C)
source = C;
cci_period = 28;
stoch_period = 28;
stoch_smooth_k = 3;
stoch_smooth_d = 3;
Z = zeros(1,length(source));
persistent Xscci
if isempty(Xscci)
    Xscci.srcwin = repmat(source,cci_period,1);
    Xscci.stochsrcwin = repmat(source,stoch_period,1);
    Xscci.cciwin = repmat(Z,stoch_period,1);
    Xscci.ccikwin = repmat(Z,stoch_smooth_k,1);
    Xscci.ccidwin = repmat(Z,stoch_smooth_d,1);
end
Xscci.srcwin = [source;Xscci.srcwin(1:end-1,:)];
Xscci.stochsrcwin = [source;Xscci.stochsrcwin(1:end-1,:)];
tpsma = sum(Xscci.srcwin)/cci_period;
dev = sum(abs(Xscci.srcwin-tpsma))/cci_period;
cci = (source - tpsma)./(0.015*dev);
maxhigh = max(Xscci.stochsrcwin);
minlow = min(Xscci.stochsrcwin);
den = maxhigh - minlow;
den(den==0) = 1;
stoch = 100*(source-minlow)./den;
Xscci.ccikwin = [stoch;Xscci.ccikwin(1:end-1,:)];
stoch_cci_k = sum(abs(Xscci.ccikwin))/stoch_smooth_k;
Xscci.ccidwin = [stoch_cci_k;Xscci.ccidwin(1:end-1,:)];
stoch_cci_d = sum(abs(Xscci.ccidwin))/stoch_smooth_d;
out(1,:) = cci;
out(2,:) = stoch;
out(3,:) = stoch_cci_k;
out(4,:) = stoch_cci_d;
end
%{
https://www.tradingview.com/script/gjR35HwQ-ADD-for-SPX-intraday-NYSE-Adv-Decl-Tom1trader/
// This is the NYSE Advancers - decliners which the SPX pretty much has to follow. The level gives an idea of days move
//  but I follow the direction as when more advance (green) or decline (red) the index tends to track it pretty closely.

// On SPX and correlateds - very useful for intr-day trading (Scalping or 0DTE option trades) but not for higher time fromes at all.

// I left it at 5 minutes timeframe which displays well on any intraday chart. You can change it by changing the "5" in the security
//  function on line 13 to what you want or change it to timeframe.period (no quotes). 5 min displays better on higher i.e. 15min.

//@version=4
study("ADD", overlay=false)
a = security("USI:ADD", "5", hlc3)

dircol = a>a[1] ? color.green : color.red
plot(a, title="ADD", color=dircol, linewidth=4)
m10 = sma(a, 10)
plot(m10, color=color.black, linewidth=2)
%}
function out = ScalpADD(H,L,C)
a = (H+L+C)/3;
persistent Xscadd
if isempty(Xscadd)
    Xscadd.awin = repmat(a,10,1);
end
Xscadd.awin = [a;Xscadd.awin(1:end-1,:)];
m10 = sum(Xscadd.awin)/10;
out(1,:) = m10;
out(2,:) = a-m10;
end
%{
https://www.tradingview.com/script/z4kWhDYO-Urban-Towers/
study(title="Urban Towers Scalping Strategy", shorttitle="Urban Towers", overlay=true)

// ***
// EMA Criteria
// ***
src = close

ema37 = ema(src, 37)
ema39 = ema(src, 39)
ema41 = ema(src, 41)
ema44 = ema(src, 44)
ema47 = ema(src, 47)
ema50 = ema(src, 50)

// ***
// Candle Criteria
// ***
long = high[2] >= high[1] and high[1] >= high[0] and low < ema37 and close > ema50 and close > ema50
short = high[2] <= high[1] and high[1] <= high[0] and high > ema37 and close < ema50 and close < ema50
%}
function out = ScalpUrbanTow(H,L,C)
high = H;
low = L;
close = C;
a37 = 2/(37+1);
a39 = 2/(39+1);
a41 = 2/(41+1);
a44 = 2/(44+1);
a47 = 2/(47+1);
a50 = 2/(50+1);
persistent Xscut
if isempty(Xscut)
    Xscut.e37p = close;
    Xscut.e39p = close;
    Xscut.e41p = close;
    Xscut.e44p = close;
    Xscut.e47p = close;
    Xscut.e50p = close;
    Xscut.hip = high;
    Xscut.hipp = high;
end
ema37 = (1-a37)*Xscut.e37p + a37*close;
ema39 = (1-a39)*Xscut.e39p + a39*close;
ema41 = (1-a41)*Xscut.e41p + a41*close;
ema44 = (1-a44)*Xscut.e44p + a44*close;
ema47 = (1-a47)*Xscut.e47p + a47*close;
ema50 = (1-a50)*Xscut.e50p + a50*close;
long = Xscut.hipp >= Xscut.hip & Xscut.hip >= high & ...
    low < ema37 & close > ema50;
short = Xscut.hipp <= Xscut.hip & Xscut.hip <= high & ...
    high > ema37 & close < ema50;
Xscut.e37p = ema37;
Xscut.e39p = ema39;
Xscut.e41p = ema41;
Xscut.e44p = ema44;
Xscut.e47p = ema47;
Xscut.e50p = ema50;
Xscut.hipp = Xscut.hip;
Xscut.hip = high;
out(1,:) = ema37;
out(2,:) = ema39;
out(3,:) = ema41;
out(4,:) = ema44;
out(5,:) = ema47;
out(6,:) = ema50;
out(7,:) = long;
out(8,:) = short;
end
%{
https://www.youtube.com/watch?v=7vhIsk51_Ro
https://www.tradingview.com/script/2KE8wTuF-Indicator-WaveTrend-Oscillator-WT/
study(title="WaveTrend [LazyBear]", shorttitle="WT_LB")
n1 = input(10, "Channel Length")
n2 = input(21, "Average Length")
obLevel1 = input(60, "Over Bought Level 1")
obLevel2 = input(53, "Over Bought Level 2")
osLevel1 = input(-60, "Over Sold Level 1")
osLevel2 = input(-53, "Over Sold Level 2")
 
ap = hlc3 
esa = ema(ap, n1)
d = ema(abs(ap - esa), n1)
ci = (ap - esa) / (0.015 * d)
tci = ema(ci, n2)
 
wt1 = tci
wt2 = sma(wt1,4)
%}
function out = waveTrend(H,L,C)
n1 = 10;
n2  = 21;
a1 = 2/(n1+1);
a2 = 2/(n2+1);
ap = (H+L+C)/3;
Z = zeros(1,length(ap));
persistent Xwtr
if isempty(Xwtr)
    Xwtr.esap = ap;
    Xwtr.dp = Z;
    Xwtr.tcip = Z;
    Xwtr.wt2win = repmat(Z,4,1);
end
esa = (1-a1)*Xwtr.esap + a1*ap;
d = (1-a1)*Xwtr.dp + a1*abs(ap-esa);
ci = (ap - esa) ./ (0.015 * d);
Xwtr.tcip(isnan(Xwtr.tcip)) = 0;
tci = (1-a2)*Xwtr.tcip + a2*ci;
wt1 = tci;
Xwtr.wt2win = [wt1;Xwtr.wt2win(1:end-1,:)];
wt2 = sum(Xwtr.wt2win)/4;
Xwtr.esap = esa;
Xwtr.dp = d;
Xwtr.tcip = tci;
out(1,:) = wt1;
out(2,:) = wt2;
out(3,:) = wt1-wt2;
end
%{
https://www.tradingview.com/script/eM057Bu5-Indicators-Volume-Zone-Indicator-Price-Zone-Indicator/
Volume Zone Indicator (VZO) and Price Zone Indicator (PZO) are by Waleed Aly Khalil.
Volume Zone Indicator (VZO)
------------------------------------------------------------
VZO is a leading volume oscillator that evaluates volume in relation to the direction of the net price change on each bar.

A value of 40 or above shows bullish accumulation. Low values (< 40) are bearish . Near zero or between +/- 20, the market is either in consolidation or near a break out. When VZO is near +/- 60, an end to the bull/bear run should be expected soon. If that run has been opposite to the long term price trend direction, then a reversal often will occur.

Traditional way of looking at this also works:
* +/- 40 levels are overbought / oversold
* +/- 60 levels are extreme overbought / oversold

More info:
https://drive.google.com/file/d/0Bx48Du_2aPFncEM3dHhyaWtTdjA/edit

Price Zone Indicator (PZO)
------------------------------------------------------------
PZO is interpreted the same way as VZO (same formula with "close" substituted for "volume").
study("Volume Zone Oscillator [LazyBear]", shorttitle="VZO_LB")
length=input(20, title="MA Length")

dvol=sign(close-close[1]) * volume
dvma=ema(dvol, length)
vma=ema(volume, length)
vzo=iff(vma != 0, 100 * dvma / vma,0)
%}
function out = pzovzo(C,V)
Length = 20;
a = 2/(Length+1);
close = C;
volume = V;
Z = zeros(1,length(volume));
persistent Xzo
if isempty(Xzo)
    Xzo.Cp = close;
    Xzo.dvmap = Z;
    Xzo.dpmap = Z;
    Xzo.vmap = volume;
    Xzo.clmap = close;
end
dvol = sign(close-Xzo.Cp) .* volume;
dprice = sign(close-Xzo.Cp) .* close;
dvma = (1-a)*Xzo.dvmap + a*dvol;
dpma = (1-a)*Xzo.dpmap + a*dprice;
vma = (1-a)*Xzo.vmap + a*volume;
clma = (1-a)*Xzo.clmap + a*close;
vzo = 100 * dvma ./ vma;
pzo = 100 * dpma ./ clma;
Xzo.Cp = close;
Xzo.dvmap = dvma;
Xzo.dpmap = dpma;
Xzo.vmap = vma;
Xzo.clmap = clma;
out(1,:) = vzo;
out(2,:) = pzo;
end
%{
https://www.tradingview.com/script/egfSfN1y-TonyUX-EMA-Scalper-Buy-Sell/
study(title="Tony's EMA Scalper - Buy / Sell", shorttitle="TUX EMA Scalper", overlay=true)
len = input(20, minval=1, title="Length")
src = input(close, title="Source")
out = ema(src, len)
plot(out, title="EMA", color=blue)
last8h = highest(close, 8)
lastl8 = lowest(close, 8)
%}
function out = tonyema(C)
len = 20;
src = C;
lenwt = 8;
a = 2/(len+1);
persistent Xtema
if isempty(Xtema)
    Xtema.emap = src;
    Xtema.lastwin = repmat(src,lenwt,1);
end
Xtema.lastwin = [src;Xtema.lastwin(1:end-1,:)];
ema = (1-a)*Xtema.emap + a*src;
last8h = max(Xtema.lastwin);
lastl8 = min(Xtema.lastwin);
Xtema.emap = ema;
out(1,:) = ema;
out(2,:) = last8h;
out(3,:) = lastl8;
end
%{
https://www.tradingview.com/script/LTqZz3l9-Indicator-Zero-Lag-EMA-a-simple-trading-strategy/
study(title = "Almost Zero Lag EMA [LazyBear]", shorttitle="ZeroLagEMA_LB", overlay=true)
length=input(10)
src=close
ema1=ema(src, length)
ema2=ema(ema1, length)
d=ema1-ema2
zlema=ema1+d
plot(zlema)
%}
function out = ZLemaOsc(C)
src = C;
Length = 5;
a = 2/(Length+1);
persistent Xzle
if isempty(Xzle)
    Xzle.e1p = src;
    Xzle.e2p = src;
end
ema1 = (1-a)*Xzle.e1p + a*src;
ema2 = (1-a)*Xzle.e2p + a*ema1;
n = 1;
zlema = (n+1)*ema1 - n*ema2;
osc = zlema - ema2;
n = 2;
zlema2 = (n+1)*ema1 - n*ema2;
osc2 = zlema - ema2;
Xzle.e1p = ema1;
Xzle.e2p = ema2;
out(1,:) = zlema;
out(2,:) = osc;
out(3,:) = zlema2;
out(4,:) = osc2;
end
%{
https://www.tradingview.com/script/WubeYtxk-bill-williams-alligator-fractals-res-sup-combined-by-vlkvr/
study("Bill Williams. Alligator, Fractals & Res-Sup combined", shorttitle="🐲 AlFReSco", overlay=true)

// Alligator
smma(src, length) =>
    smma = 0.0
    smma := na(smma[1]) ? sma(src, length) : (smma[1] * (length - 1) + src) / length
lipsLength  = input(title=" Lips Length", defval=5)
teethLength = input(title=" Teeth Length", defval=8)
jawLength   = input(title=" Jaw Length", defval=13)
lipsOffset  = input(title=" Lips Offset", defval=3)
teethOffset = input(title=" Teeth Offset", defval=5)
jawOffset   = input(title=" Jaw Offset", defval=8)
lips        = smma(hl2, lipsLength)
teeth       = smma(hl2, teethLength)
jaw         = smma(hl2, jawLength)
%}
function out = Alligator(H,L)
src = (H+L)/2;
lipsLength  = 5;
teethLength = 8;
jawLength   = 13;
persistent Xallig
if isempty(Xallig)
    Xallig.sma1p = src;
    Xallig.sma2p = src;
    Xallig.sma3p = src;
end
smma1 = (Xallig.sma1p * (lipsLength - 1) + src) / lipsLength;
smma2 = (Xallig.sma2p * (teethLength - 1) + src) / teethLength;
smma3 = (Xallig.sma3p * (jawLength - 1) + src) / jawLength;
Xallig.sma1p = smma1;
Xallig.sma2p = smma2;
Xallig.sma3p = smma3;
out(1,:) = smma1;
out(2,:) = smma2;
out(3,:) = smma3;
out(4,:) = smma1-smma2;
out(5,:) = smma1-smma3;
end
%{
https://www.earnforex.com/metatrader-indicators/Traders-Dynamic-Index/
https://www.tradingview.com/script/sQKGbRRi-Indicators-Traders-Dynamic-Index-HLCTrends-and-Trix-Ribbon/
study("Traders Dynamic Index [LazyBear]", shorttitle="TDI_LB")
lengthrsi=input(13)
src=close
lengthband=input(34)
lengthrsipl=input(2)
lengthtradesl=input(7)

r=rsi(src, lengthrsi)
ma=sma(r,lengthband)
offs=(1.6185 * stdev(r, lengthband))
up=ma+offs
dn=ma-offs
mid=(up+dn)/2
mab=sma(r, lengthrsipl)
mbb=sma(r, lengthtradesl)
%}
function out = tradDI(C)
src = C;
lengthrsi = 13;
lengthband = 34;
lengthrsipl = 2;
lengthtradesl = 7;
Z = zeros(1,length(src));
persistent XtDI
if isempty(XtDI)
    XtDI.rsiwin = repmat(Z,lengthrsi,1);
    XtDI.rwin = repmat(Z,lengthband,1);
    XtDI.Cp = src;
    XtDI.avgUp = Z;
    XtDI.avgDp = Z;
end
XtDI.rsiwin = [src-XtDI.Cp;XtDI.rsiwin(1:end-1,:)];
% rsi calcs
tmpU = XtDI.rsiwin;
tmpU(tmpU<0)=0;
tmpD = XtDI.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (avgU-XtDI.avgUp)/lengthrsi + XtDI.avgUp;
emaavgD = (avgD-XtDI.avgDp)/lengthrsi + XtDI.avgDp;
tmp = emaavgD;
tmp(tmp==0) = 1;
rs = emaavgU./tmp;
r = 100 - (100 ./ (1 + rs));
XtDI.rwin = [r;XtDI.rwin(1:end-1,:)];
ma = sum(XtDI.rwin)/lengthband;
offs = (1.6185 * std(XtDI.rwin));
up = ma+offs;
dn = ma-offs;
mid = (up+dn)/2;
mab = sum(XtDI.rwin(1:lengthrsipl,:))/lengthrsipl;
mbab = sum(XtDI.rwin(1:lengthtradesl,:))/lengthtradesl;
XtDI.Cp = src;
XtDI.avgUp = emaavgU;
XtDI.avgDp = emaavgD;
out(1,:) = r;
out(2,:) = ma;
out(3,:) = up;
out(4,:) = dn;
out(5,:) = mid;
out(6,:) = mab;
out(7,:) = mbab;
end
%{
https://pastebin.com/aUEGnLqC
study(title="Elder's Force Index [LazyBear]", shorttitle="EFI_LB")
length = input(13, minval=1)
lengthMA=input(8)
efi = sma(change(close) * volume, length)
s=sma(efi, lengthMA)
 
hline(0, title="Zero")
plot(efi, color=green, title="EFI", linewidth=2)
plot(s, color=orange)
 
// Draw BB on indices
BBEnabled=input(false,title="BB Enabled?", type=bool)
mult=input(2.5)
length_bb=input(20, title="BB Length")
HighlightBreaches=input(false, type=bool)
 
bb_s = s
basis = sma(bb_s, length)
dev = (mult * stdev(bb_s, length))
upper = (basis + dev)
lower = (basis - dev)
%}
function out = EldForceIdx(C,V)
close = C;volume = V;
Length = 13;
lengthMA = 8;
mult = 2.5;
Z = zeros(1,length(close));
persistent Xefi
if isempty(Xefi)
    Xefi.Cp = close;
    Xefi.smawin = repmat(Z,Length,1);
    Xefi.volwin = repmat(volume,Length,1);
    Xefi.efiwin = repmat(Z,lengthMA,1);
    Xefi.bbswin = repmat(Z,Length,1);
end
Xefi.smawin = [(close-Xefi.Cp).*volume;Xefi.smawin(1:end-1,:)];
Xefi.volwin = [volume;Xefi.volwin(1:end-1,:)];
volavg = sum(Xefi.volwin)/Length;
efi = sum(Xefi.smawin)/Length./volavg;
Xefi.efiwin = [efi;Xefi.efiwin(1:end-1,:)];
s = sum(Xefi.efiwin)/lengthMA;
bb_s = s;
Xefi.bbswin = [bb_s;Xefi.bbswin(1:end-1,:)];
basis = sum(Xefi.bbswin)/Length;
dev = (mult * std(Xefi.bbswin));
upper = (basis + dev);
lower = (basis - dev);
Xefi.Cp = close;
out(1,:) = efi;
out(2,:) = s;
out(3,:) = basis;
out(4,:) = upper;
out(5,:) = lower;
end
%{
https://www.tradingview.com/script/ezHLOxrK-Indicators-AccSwingIndex-ASI-Oscillator-and-RangeExpansionInde/
study("Accumulation Swing Index [LazyBear]", shorttitle="ASI_LB")
limit = input(30, "Limit")
lengthMA=input(8, "SMA Length")
showMA=input(true, type=bool)

swingindex( limit ) =>
    r1 = abs( high - close[1] )
    r2 = abs( low - close[1] )
    r3 = abs( high - low )
    r4 = abs( close[1] - open[1] )
    k = max( r1, r2 )
    r = iff( r1 >= max( r2, r3 ), r1 - r2/2 + r4/4,
        iff( r2 >= max( r1, r3 ), r2 - r1/2 + r4/4,
            r3 + r4/4 ) )
    iff( r == 0, 0, 50 * ( ( close - close[1] + 0.5 * ( close - open ) + 0.25 * ( close[1] - open[1] ) ) / r ) * k/limit )

calc_asi( limit ) => 
    cum( swingindex( limit ) )

asi=calc_asi( limit )
s=sma(asi,lengthMA)
%}
function out = accSI(O,H,L,C)
open = O;high = H;low = L;close = C;
limit = 30;
lengthMA = 8;
Z = zeros(1,length(high));
persistent XaccSI
if isempty(XaccSI)
    XaccSI.Cp = close;
    XaccSI.Op = open;
    XaccSI.asiwin = repmat(Z,lengthMA,1);
    XaccSI.SIp = Z;
end
r1 = abs( high - XaccSI.Cp );
r2 = abs( low - XaccSI.Cp );
r3 = abs( high - low );
r4 = abs( XaccSI.Cp - XaccSI.Op );
k = max( r1, r2 );
tmp = r3 + r4/4;
m = find(r2 >= max( r1, r3 ));
tmp(m) = r2(m) - r1(m)/2 + r4(m)/4;
r = tmp;
m = find(r1 >= max( r2, r3 ));
r(m) = r1(m) - r2(m)/2 + r4(m)/4;
SI = 50 * ( ( close - XaccSI.Cp + 0.5 * ( close - open ) + ...
    0.25 * ( XaccSI.Cp - XaccSI.Op ) ) ./ r ) .* k/limit;
asi = XaccSI.SIp + SI;
XaccSI.asiwin = [asi;XaccSI.asiwin(1:end-1,:)];
s = sum(XaccSI.asiwin)/lengthMA;
XaccSI.Cp = close;
XaccSI.Op = open;
XaccSI.SIp = asi;
out(1,:) = asi;
out(2,:) = s;
out(3,:) = asi - s;
end
%{
https://www.tradingview.com/script/qcmM1Ocn-Indicators-Constance-Brown-Composite-Index-RSI-Avgs/
study(title="Constance Brown Composite Index [LazyBear]", shorttitle="CBIDX_LB")
src = close
rsi_length=input(14, title="RSI Length")
rsi_mom_length=input(9, title="RSI Momentum Length")
rsi_ma_length=input(3, title="RSI MA Length")
ma_length=input(3, title="SMA Length")
fastLength=input(13)
slowLength=input(33)

r=rsi(src, rsi_length)
rsidelta = mom(r, rsi_mom_length)
rsisma = sma(rsi(src, rsi_ma_length), ma_length)
s=rsidelta+rsisma

plot(s, color=red, linewidth=2)
plot(sma(s, fastLength), color=green)
plot(sma(s, slowLength), color=orange)
%}
function out = cbCompIdx(C)
src = C;
rsi_length = 14;
rsi_mom_length = 9;
rsi_ma_length = 3;
ma_length = 3;
fastLength = 13;
slowLength = 33;
Z = zeros(1,length(src));
persistent Xcbci
if isempty(Xcbci)
    Xcbci.srcwin = repmat(Z,rsi_length,1);
    Xcbci.momrwin = repmat(Z,rsi_mom_length,1);
    Xcbci.src2win = repmat(src,rsi_ma_length,1);
    Xcbci.smawin = repmat(Z,ma_length,1);
    Xcbci.sma2win = repmat(Z,slowLength,1);
    Xcbci.Cp = src;
    Xcbci.avgUp = Z;
    Xcbci.avgDp = Z;
    Xcbci.avgU2p = Z;
    Xcbci.avgD2p = Z;
    Xcbci.rp = Z;
end
Xcbci.srcwin = [src-Xcbci.Cp;Xcbci.srcwin(1:end-1,:)];
Xcbci.src2win = [src-Xcbci.Cp;Xcbci.src2win(1:end-1,:)];
% rsi calcs
tmpU = Xcbci.srcwin;
tmpU(tmpU<0)=0;
tmpD = Xcbci.srcwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (avgU-Xcbci.avgUp)/rsi_length + Xcbci.avgUp;
emaavgD = (avgD-Xcbci.avgDp)/rsi_length + Xcbci.avgDp;
tmp = emaavgD;
tmp(tmp==0) = 1;
rs = emaavgU./tmp;
r = 100 - (100 ./ (1 + rs));
Xcbci.momrwin = [r-Xcbci.rp;Xcbci.momrwin(1:end-1,:)];
rsidelta = Xcbci.momrwin(end,:);
% rsi calcs
tmpU = Xcbci.src2win;
tmpU(tmpU<0)=0;
tmpD = Xcbci.src2win;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU2 = (avgU-Xcbci.avgU2p)/rsi_ma_length + Xcbci.avgU2p;
emaavgD2 = (avgD-Xcbci.avgD2p)/rsi_ma_length + Xcbci.avgD2p;
tmp = emaavgD2;
tmp(tmp==0) = 1;
rs = emaavgU2./tmp;
r2 = 100 - (100 ./ (1 + rs));
Xcbci.smawin = [r2;Xcbci.smawin(1:end-1,:)];
rsisma = sum(Xcbci.smawin)/ma_length;
s = rsidelta + rsisma;
Xcbci.sma2win = [s;Xcbci.sma2win(1:end-1,:)];
sfast = sum(Xcbci.sma2win(1:fastLength,:))/fastLength;
sslow = sum(Xcbci.sma2win)/slowLength;
Xcbci.Cp = src;
Xcbci.rp = r;
Xcbci.avgUp = emaavgU;
Xcbci.avgDp = emaavgD;
Xcbci.avgU2p = emaavgU2;
Xcbci.avgD2p = emaavgD2;
out(1,:) = s;
out(2,:) = sfast;
out(3,:) = sslow;
end
%{
https://www.tradingview.com/script/Gmx3PwhE-Linda-Raschke-3-10-oscillator/
Linda Raschke - 3/10 oscillator
fast = 3, slow = 10, smoothing = 16
fastMA = sma(close, fast)
slowMA = sma(close, slow)
macd = fastMA - slowMA
hline(0,linestyle=solid)
signal = sma(macd, smoothing)
%}
function out = raschkeOsc(C)
fast = 3; slow = 10; smoothing = 16;
close = C;
Z = zeros(1,length(C));
persistent Xrosc
if isempty(Xrosc)
    Xrosc.Cwin = repmat(close,slow,1);
    Xrosc.macdwin = repmat(Z,smoothing,1);
end
Xrosc.Cwin = [close;Xrosc.Cwin(1:end-1,:)];
fastMA = sum(Xrosc.Cwin(1:fast,:))/fast;
slowMA = sum(Xrosc.Cwin(1:slow,:))/slow;
macd = fastMA - slowMA;
Xrosc.macdwin = [macd;Xrosc.macdwin(1:end-1,:)];
signal = sum(Xrosc.macdwin)/smoothing;
out(1,:) = fastMA;
out(2,:) = slowMA;
out(3,:) = macd;
out(4,:) = signal;
end
%{
https://www.investopedia.com/terms/g/guppy-multiple-moving-average.asp
Guppy Multiple Moving Average (GMMA)
The Guppy Multiple Moving Average (GMMA) is a technical 
indicator that identifies changing trends, breakouts, and 
trading opportunities in the price of an asset by 
combining two groups of moving averages (MA) with 
different time periods. There is a short-term group of MAs, 
and a long-term group of MA. Both contain six MAs, 
for a total of 12. The term gets its name from Daryl Guppy, 
an Australian trader who is credited with its development.
The Guppy is composed of 12 EMAs, so essentially 
the Guppy and an EMA are the same thing. 
The Guppy is a collection of EMAs that are believed 
to help isolate trades, spot opportunities, and warn 
about price reversals.
EMA=[Close price−EMA previous]∗M+EMA previous
​	 
or:
SMA= NSum of N closing prices
​	 
where:
EMA=exponential moving average
EMA previous =the exponential moving average from the 
    previous period
(The SMA can substitute for the EMA previous
​	  for the first calculation)
Multiplier M= 2/(N+1)
​	 
SMA=simple moving average
N=number of periods
​The Guppy Multiple Moving Average (GMMA) is applied 
as an overlay on the price chart of an asset.
The short-term MAs are typically set at 3, 5, 8, 10, 12, 
and 15 periods. The longer-term MAs are typically set at 
30, 35, 40, 45, 50, and 60.
The Guppy MMA Oscillator, developed by Leon Wilson, 
is an oscillator representation of difference between GMMA ribbons. 
Look for signal crosses for the triggers.
%}
function out = GMMAosc(C)
P = C;
Nshort = [3 5 8 10 12 15];
Nlong = [30 35 40 45 50 60];
ashort = 2./(Nshort+1);
along = 2./(Nlong+1);
am = 2/(9+1);
Z = zeros(1,length(C));
persistent Xgmma
if isempty(Xgmma)
    Xgmma.shortp = repmat(P,length(Nshort),1);
    Xgmma.longp = repmat(P,length(Nlong),1);
    Xgmma.macdP = repmat(Z,length(Nlong),1);
end
gshort = (P - Xgmma.shortp).*ashort' + Xgmma.shortp;
glong = (P - Xgmma.longp).*along' + Xgmma.longp;
osc = gshort - glong;
macd = (osc - Xgmma.macdP).*am + Xgmma.macdP;
Xgmma.shortp = gshort;
Xgmma.longp = glong;
Xgmma.macdP = macd;
out = [gshort;glong;osc;macd;osc-macd];
end
%{
https://www.tradingview.com/scripts/commoditychannelindex/
https://www.tradingview.com/script/oyfd86j2-Indicators-Three-included-IFT-on-CCI-Z-Score-and-R-Squared/
study("Inverse Fisher Transform CCI [LazyBear]", shorttitle="IFTCCI_LB")
length = input(title="CCI Length", type=integer, defval=20)
src = close
cc=cci(src, length)

// Calculate IFT on CCI
lengthwma=input(9, title="Smoothing length")
calc_ifish(series, lengthwma) =>
    v1=0.1*(series-50)
    v2=wma(v1,lengthwma)
    ifish=(exp(2*v2)-1)/(exp(2*v2)+1)
    ifish

plot(calc_ifish(cc, lengthwma), color=teal, linewidth=1)
CCI Calculation
There are several steps involved in calculating the Commodity Channel Index. The following example is for a typical 20 Period CCI:

CCI = (Typical Price  -  20 Period SMA of TP) / (.015 x Mean Deviation)
Typical Price (TP) = (High + Low + Close)/3
Constant = .015
The Constant is set at .015 for scaling purposes. By including the constant, the majority of CCI values will fall within the 100 to -100 range. There are three steps to calculating the Mean Deviation.

Subtract the most recent 20 Period Simple Moving from each typical price (TP) for the Period.
Sum these numbers strictly using absolute values.
Divide the value generated in step 3 by the total number of Periods (20 in this case).
%}
function out = ifishCCI(H,L,C)
tp = (H+L+C)/3;
Period = 20;
constant = 0.015;
Z = zeros(1,length(H));
lengthwma = 9;
bwma = lengthwma:-1:1;
bwma = bwma/sum(bwma);
persistent Xifcci
if isempty(Xifcci)
    Xifcci.devwin = repmat(Z,Period,1);
    Xifcci.tpwin = repmat(tp,Period,1);
    Xifcci.v1win = repmat(Z,lengthwma,1);
end
Xifcci.tpwin = [tp;Xifcci.tpwin(1:end-1,:)];
sma = sum(Xifcci.tpwin)/Period;
% compute deviation
Xifcci.devwin = [tp-sma;Xifcci.devwin(1:end-1,:)];
dev = sum(Xifcci.devwin)/Period;
cci = (tp - sma)./(constant*dev);
% Calculate IFT on CCI
v1=0.1*(cci-50);
Xifcci.v1win = [v1;Xifcci.v1win(1:end-1,:)];
v2 = sum(bwma'.*Xifcci.v1win);
ifish = (exp(2*v2)-1)./(exp(2*v2)+1);
out(1,:) = cci;
out(2,:) = ifish;
end
%{
http://fxcodebase.com/code/viewtopic.php?f=27&t=61074
study("Hurst Bands [LazyBear]", shorttitle="H%Bands_LB", overlay=true)
price = hl2
length = input(10, title="Displacement length")
InnerValue = input(1.6, title="Innerbands %")
OuterValue = input(2.6, title="Outerbands %")
ExtremeValue = input(4.2, title="Extremebands %")
showExtremeBands = input(false, type=bool, title="Display Extreme Bands?")
showClosingPriceLine = input(false, type=bool, title="Plot Close price?")
smooth = input(1, title="EMA Length for Close")

displacement = (length / 2) + 1
dPrice = price[displacement]

CMA = not na(dPrice) ?  sma(dPrice, abs(length)) : nz(CMA[1]) + (nz(CMA[1]) - nz(CMA[2]))
HO = MA - CMA[Period/2-1]
CenteredMA=plot(not na(dPrice) ? CMA : na, color=blue , linewidth=2)
CenterLine=plot(not na(price) ? CMA : na, linewidth=2, color=aqua)

ExtremeBand = CMA * ExtremeValue / 100
OuterBand   = CMA * OuterValue / 100
InnerBand   = CMA * InnerValue / 100

UpperExtremeBand=plot(showExtremeBands and (not na(price)) ? CMA + ExtremeBand : na)
LowerExtremeBand=plot(showExtremeBands and (not na(price)) ? CMA - ExtremeBand : na)
UpperOuterBand=  plot(not na(price) ? CMA + OuterBand : na)
LowerOuterBand=  plot(not na(price) ? CMA - OuterBand : na)
UpperInnerBand=  plot(not na(price) ? CMA + InnerBand : na)
LowerInnerBand=  plot(not na(price) ? CMA - InnerBand : na)

fill(UpperOuterBand, UpperInnerBand, color=red, transp=85)
fill(LowerInnerBand, LowerOuterBand, color=green, transp=85)

FlowValue = close > close[1] ? high : close < close[1] ? low : hl2
FlowPrice = plot(showClosingPriceLine ? sma(FlowValue, smooth) : na, linewidth=1)
%}
function out = hurstbnds(H,L)
price = (H+L)/2;
Length = 10;
InnerValue = 1.6;
OuterValue = 2.6;
ExtremeValue = 4.2;
smooth = 1;
displacement = (Length / 2) + 1;
persistent Xhb
if isempty(Xhb)
    Xhb.pwin = repmat(price,displacement,1);
    Xhb.CMAwin = repmat(price,displacement,1);
    Xhb.dpricewin = repmat(price,Length,1);
    Xhb.cmaP = price;
end
Xhb.pwin = [price;Xhb.pwin(1:end-1,:)];
dPrice = Xhb.pwin(end,:);
Xhb.dpricewin = [dPrice;Xhb.dpricewin(1:end-1,:)];
CMA = sum(Xhb.dpricewin)/Length;
Xhb.CMAwin = [CMA;Xhb.CMAwin(1:end-1,:)];
MA = sum(Xhb.pwin)/displacement;
HO = MA - Xhb.CMAwin(end,:);
ExtremeBand = CMA * ExtremeValue / 100;
OuterBand   = CMA * OuterValue / 100;
InnerBand   = CMA * InnerValue / 100;
UpperExtremeBand = CMA + ExtremeBand;
LowerExtremeBand = CMA - ExtremeBand;
UpperOuterBand =  CMA + OuterBand;
LowerOuterBand =  CMA - OuterBand;
UpperInnerBand =  CMA + InnerBand;
LowerInnerBand =  CMA - InnerBand;
Xhb.cmaP = CMA;
out(1,:) = CMA;
out(2,:) = UpperExtremeBand;
out(3,:) = LowerExtremeBand;
out(4,:) = UpperOuterBand;
out(5,:) = LowerOuterBand;
out(6,:) = UpperInnerBand;
out(7,:) = LowerInnerBand;
out(8,:) = HO;
end
%{
https://www.quantshare.com/item-1033-volatility-quality-index
https://www.tradingview.com/script/MbAO4zo0-Indicator-Volatility-Quality-Index-VQI/
study("Volatility Quality Index [LazyBear]", shorttitle="VQI_LB")
length_slow=input(9, title="Fast EMA Length")
length_fast=input(200, title="Slow EMA Length")
vqi_t=iff((tr != 0) and ((high - low) != 0) ,(((close-close[1])/tr)+((close-open)/(high-low)))*0.5,nz(vqi_t[1]))
vqi = abs(vqi_t) * ((close - close[1] + (close - open)) * 0.5)
vqi_sum=cum(vqi)
plot(vqi_sum, color=red, linewidth=2)
plot(sma(vqi_sum,length_slow), color=green, linewidth=2)
plot(sma(vqi_sum,length_fast),color=orange, linewidth=2)
%}
function out = volQualIdx(O,H,L,C)
length_fast = 9;
length_slow = 200;
af = 2/(length_fast+1);
as = 2/(length_slow+1);
close = C;
high = H;
low = L;
open = O;
Z = zeros(1,length(O));
persistent Xvqi
if isempty(Xvqi)
    Xvqi.Cp = C;
    Xvqi.vqi_tP = Z;
    Xvqi.sumSP = Z;
    Xvqi.sumFP = Z;
    Xvqi.vqisum = Z;
end
tr = max(H-L,max(H-Xvqi.Cp,abs(L-Xvqi.Cp)));
vqi_t = Xvqi.vqi_tP;
k = find((tr ~= 0) & ((high - low) ~= 0));
vqi_t(k) = (((close(k)-Xvqi.Cp(k))./tr(k))+...
    ((close(k)-open(k))./(high(k)-low(k))))*0.5;
vqi = abs(vqi_t) .* ((close - Xvqi.Cp + (close - open)) * 0.5);
vqi_sum = Xvqi.vqisum + vqi;
vqi_sumS = (1-as)*Xvqi.sumSP + as*vqi_sum;
vqi_sumF = (1-af)*Xvqi.sumFP + af*vqi_sum;
Xvqi.Cp = C;
Xvqi.vqi_tP = vqi_t;
Xvqi.vqisum = vqi_sum;
Xvqi.sumSP = vqi_sumS;
Xvqi.sumFP = vqi_sumF;
out(1,:) = vqi_t;
out(2,:) = vqi_sum;
out(3,:) = vqi_sumF;
out(4,:) = vqi_sumS;
end

