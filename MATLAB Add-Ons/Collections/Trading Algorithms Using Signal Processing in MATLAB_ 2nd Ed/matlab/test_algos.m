% test_algos.m
clc,clear all,close all,dbstop if error
clear SmoothAdapMomInd
clear EhlerCyberCyc
clear EhlerCenterofGrav
clear ITrend
clear FisherTForm
clear ElhStoch
clear EhlersRoofingFilter
clear rsiWilChan
clear WilsonRelPriceChan
clear UltOscLB
clear simpKeltnerChan
clear KeltChanEMA_ATR
clear SMA5_8_13
vars = whos;
vars = vars([vars.persistent]);
varName = {vars.name};
clear(varName{:});

load stkfiles.mat
nn = length(stk);
len = length(cl(:,1));

for i = 1:len
    out = ScalpEMAs(cl(i,:));
    SCemas1(i,:) = out(1,:);
    SCemas2(i,:) = out(2,:);
    SCemas3(i,:) = out(3,:);
    SCemas4(i,:) = out(4,:);
    SCemas5(i,:) = out(5,:);
    out = EVWMA(cl(i,:),vol(i,:));
    evwma(i,:) = out(1,:);
    out = vidya(cl(i,:)); 
    out = GMMA(cl(i,:));
    GUPs1(i,:) = out(1,:);
    GUPs2(i,:) = out(2,:);
    GUPs3(i,:) = out(3,:);
    GUPs4(i,:) = out(4,:);
    GUPs5(i,:) = out(5,:);
    GUPs6(i,:) = out(6,:);
    GUPl1(i,:) = out(7,:);
    GUPl2(i,:) = out(8,:);
    GUPl3(i,:) = out(9,:);
    GUPl4(i,:) = out(10,:);
    GUPl5(i,:) = out(11,:);
    GUPl6(i,:) = out(12,:);
    out = ESMA(cl(i,:));
    ESMAsma(i,:) = out(1,:);
    ESMAesma(i,:) = out(2,:);
    out = Movmed(cl(i,:));
    MMsmm(i,:) = out(1,:);
    out = TMA(cl(i,:));
    TMAsma(i,:) = out(1,:);
    TMAtma(i,:) = out(2,:);
    out = VWAP(hi(i,:),lo(i,:),cl(i,:),vol(i,:));
    vwap(i,:) = out(1,:);
    out = ScSuperBP(cl(i,:));
    SSBPpb(i,:) = out(1,:);
    SSBPrms(i,:) = out(2,:);
    out = ScalpEhlersBP(cl(i,:));
    SEBPsig(i,:) = out(1,:);
    SEBPtrig(i,:) = out(2,:);
    out = KAMA(cl(i,:));
    kama(i,:) = out(1,:);
    out = HullMA(cl(i,:));
    Hmavg(i,:) = out(1,:);
    out = T3Tillson(cl(i,:));
    TillT3(i,:) = out(1,:);
    out = FRAMA1(cl(i,:),16);
    frama1(i,:) = out(1,:);
    out = DEMA(op(i,:),hi(i,:),lo(i,:),cl(i,:));
    dema1(i,:) = out(1,:);
    dema2(i,:) = out(2,:);
    dema3(i,:) = out(3,:);
    out = ALMA(cl(i,:));
    ALMAalma(i,:) = out(1,:);
    out = EhlersDistCoefFilt(hi(i,:),lo(i,:));
    EDCFdcf(i,:) = out(1,:);
    out = ScalpChan(cl(i,:));
    scalper_line(i,:) = out(1,:);
    scalper_lineATR(i,:) = out(2,:);
    ScChanhi(i,:) = out(3,:);
    ScChanlo(i,:) = out(4,:);
    out = EMAPredictive(cl(i,:));
    EMAPredma1(i,:) = out(1,:);
    EMAPredma3(i,:) = out(2,:);
    EMAPredExtBuffer(i,:) = out(3,:);
    out = StochRSI(cl(i,:));
    STOCHRSI(i,:) = out(1,:);
    STOCHRSItrig(i,:) = out(2,:);
    out = LaguerreRSI(cl(i,:));
    LagRSI(i,:) = out(1,:);
    out = SmoothAdapMomStrat(hi(i,:),lo(i,:));
    SAMSfilt3(i,:) = out(1,:);
    SAMSbuy(i,:) = out(2,:);
    out = SmoothAdapMomInd(hi(i,:),lo(i,:));
    SAMIfilt3(i,:) = out(1,:);
    out = EhlersSWInd_v1(hi(i,:),lo(i,:));
    SWInd_v1Sine(i,:) = out(1,:);
    SWInd_v1LeadSine(i,:) = out(2,:);
    SWInd_v1Smooth(i,:) = out(3,:);  
    SWInd_v1Detrender(i,:) = out(4,:);  
    out = Laguerre(hi(i,:),lo(i,:));
    LaguerreFilt(i,:) = out(1,:);
    LaguerreFIR(i,:) = out(2,:);
    out = Ehlers3poleSS(hi(i,:),lo(i,:));
    superSm3pole(i,:) = out(1,:);
    out = Ehlers2polesuperSm(hi(i,:),lo(i,:));
    superSm2pole(i,:) = out(1,:);
    out = Ehlers3poleButter(hi(i,:),lo(i,:));
    Butter3pole(i,:) = out(1,:);
    out = Ehlers2poleButter(hi(i,:),lo(i,:));
    Butter2pole(i,:) = out(1,:);
    out = ElhSineWave(hi(i,:),lo(i,:));
    SWsmooth(i,:) = out(1,:);
    SWCycle(i,:) = out(2,:);
    SWSine(i,:) = out(3,:);
    SWLeadSine(i,:) = out(4,:);
    SWDeltaPhase(i,:) = out(5,:);
    SWDC(i,:) = out(6,:);
    SWDCPHase(i,:) = out(7,:);
    out = EhlersAdapRVI(cl(i,:),op(i,:),hi(i,:),lo(i,:));
    AdapRVISmooth(i,:) = out(1,:);
    AdapRVIQ1(i,:) = out(2,:);
    AdapRVII1(i,:) = out(3,:);
    AdapRVIInstPeriod(i,:) = out(4,:);
    AdapRVIRVI(i,:) = out(5,:);
    AdapRVITrig(i,:) = out(6,:);
    out = EhlersAdapCG(hi(i,:),lo(i,:));
    AdapCGSmooth(i,:) = out(1,:);
    AdapCGQ1(i,:) = out(2,:);
    AdapCGI1(i,:) = out(3,:);
    AdapCGInstPeriod(i,:) = out(4,:);
    AdapCGCG(i,:) = out(5,:);
    AdapCGTrig(i,:) = out(6,:);
    out = EhlersAdapCybCyc(hi(i,:),lo(i,:));
    AdapCybCycSmooth(i,:) = out(1,:);
    AdapCybCycQ1(i,:) = out(2,:);
    AdapCybCycI1(i,:) = out(3,:);
    AdapCybCycInstPeriod(i,:) = out(4,:);
    AdapCybCycPeriod(i,:) = out(5,:);
    AdapCybCycAC(i,:) = out(6,:);
    AdapCybCycTrig(i,:) = out(7,:);
    out = EhlersCycPerMeas(hi(i,:),lo(i,:));
    CycPerMeasSmooth(i,:) = out(1,:);
    CycPerMeasQ1(i,:) = out(2,:);
    CycPerMeasI1(i,:) = out(3,:);
    CycPerMeasInstPeriod(i,:) = out(4,:);
    CycPerMeasPeriod(i,:) = out(5,:);
    out = EhlersStochRVI(cl(i,:),op(i,:),hi(i,:),lo(i,:));
    stochRVI(i,:) = out(1,:);
    stochRVIValue3(i,:) = out(2,:);
    stochRVIValue4(i,:) = out(3,:);
    stochRVITrig(i,:) = out(4,:);
    out = EhlerStochCG(hi(i,:),lo(i,:));
    SCGValue1(i,:) = out(1,:);
    SCGValue2(i,:) = out(2,:);
    SCGCG(i,:) = out(3,:);
    SCGTrigger(i,:) = out(4,:);
    out = EhlersStoCybCyc(hi(i,:),lo(i,:));
    SCCValue1(i,:) = out(1,:);
    SCCValue2(i,:) = out(2,:);
    SCCTrigger(i,:) = out(3,:);
    out = EhlersStochCG(hi(i,:),lo(i,:));
    CGValue1(i,:) = out(1,:);
    CGValue2(i,:) = out(2,:);
    CGTrigger(i,:) = out(3,:);
    out = EhlRelVig(cl(i,:),op(i,:),hi(i,:),lo(i,:));
    RVIValue1(i,:) = out(1,:);
    RVIValue2(i,:) = out(2,:);
    RVI(i,:) = out(3,:);
    RVITrigger(i,:) = out(4,:);
    out = EhlersCycleEst(hi(i,:),lo(i,:));
    EhlSmooth(i,:) = out(1,:);
    EhlCycle(i,:) = out(2,:);
    EhlValue1(i,:) = out(3,:);
    EhlValue2(i,:) = out(4,:);
    EhlValue3(i,:) = out(5,:);
    out = EhlerCyberCyc(hi(i,:),lo(i,:));
    EhlSmooth2(i,:) = out(1,:);
    EhlCycle2(i,:) = out(2,:);
    out = EhlersMAMA(cl(i,:),hi(i,:),lo(i,:));
    MAMAsm(i,:) = out(1,:);
    MAMAdet(i,:) = out(2,:);
    MAMA(i,:) = out(3,:);
    FAMA(i,:) = out(4,:);
    out = EhlerCenterofGrav(hi(i,:),lo(i,:));
    EhlCOG(i,:) = out(1,:);
    out = ITrend(hi(i,:),lo(i,:));
    iTrend(i,:) = out(1,:);
    Trigger(i,:) = out(2,:);
    out = FisherTForm(hi(i,:),lo(i,:));
    Value(i,:) = out(1,:);
    Fisher(i,:) = out(2,:);
    out = UltOscLB(cl(i,:),hi(i,:),lo(i,:));
    UObars(i,:) = out(1,:);
    out = ElhStoch(cl(i,:));
    EhlRoofstoc(i,:) = out(1,:);
    Ehlstoc(i,:) = out(2,:);
    Ehlmystoc(i,:) = out(3,:);
    out = EhlersRoofingFilter(cl(i,:));
    EhlRoof(i,:) = out(1,:);
    out = EhlersSuperSmooth(cl(i,:));
    SuperSmooth(i,:) = out(1,:);
    EhlSSma(i,:) = out(2,:);
    out = WilsonRelPriceChan(cl(i,:));
    rsiWilRelPrice(i,:) = out(1,:);
    u1WilRelPrice(i,:) = out(2,:);
    s1WilRelPrice(i,:) = out(3,:);
    u2WilRelPrice(i,:) = out(4,:);
    s2WilRelPrice(i,:) = out(5,:);
    out = simpKeltnerChan(cl(i,:),hi(i,:),lo(i,:));
    simKC(i,:) = out(1,:);
    simKCup(i,:) = out(2,:);
    simKCdn(i,:) = out(3,:);
    out = KeltChanEMA_ATR(cl(i,:),hi(i,:),lo(i,:));
    emaKC(i,:) = out(1,:);
    emaKCup(i,:) = out(2,:);
    emaKCdn(i,:) = out(3,:);
    out = SMA5_8_13(cl(i,:),hi(i,:),lo(i,:));
    sma5(i,:) = out(1,:);
    sma8(i,:) = out(2,:);
    sma13(i,:) = out(3,:);
end
% data plots
k = 12;
%{
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Ultimate Oscillator of ',stk{k},' at 30 min in June 2020'])
ax(2) = subplot(212);
plot(ax(2),[UObars(:,k)]),grid on
yline(70)
yline(30)
legend('UO')
linkaxes(ax,'x')

figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),u1WilRelPrice(:,k),s1WilRelPrice(:,k),...
    u2WilRelPrice(:,k),s2WilRelPrice(:,k)]),hold on
legend('cl','u1','s1','u2','s2','Location','northwest')
x = 1:length(cl(:,k));
x2 = [x', fliplr(x')];
% inBetween = [u1WilRelPrice(:,k), fliplr(u2WilRelPrice(:,k))];
inBetween = [u1WilRelPrice(:,k), (u2WilRelPrice(:,k))];
% fill(x2, inBetween, 'g');
% patch(x2, inBetween, 'g')
% fill(u1WilRelPrice(:,k),u2WilRelPrice(:,k),'r')
grid on
title(['Wilson Channel of ',stk{k},' at 30 min in June 2020'])
ax(2) = subplot(212);
plot(ax(2),[rsiWilRelPrice(:,k)]),grid on
yline(70)
yline(30)
legend('rsi','Location','Best')
linkaxes(ax,'x')

figure,
plot([cl(:,k),simKC(:,k),simKCup(:,k),simKCdn(:,k)]),grid on
title(['Simple Keltner Channels of ',stk{k},' at 30 min in June 2020'])
legend('cl','KC','KCup','KCdn','Location','Best')

figure,
plot([cl(:,k),emaKC(:,k),emaKCup(:,k),emaKCdn(:,k)]),grid on
title(['EMA/ATR Keltner Channels of ',stk{k},' at 30 min in June 2020'])
legend('cl','KC','KCup','KCdn','Location','Best')

figure,
plot([cl(:,k),sma5(:,k),sma8(:,k),sma13(:,k)]),grid on
title(['sma 5, 8, & 13 of ',stk{k},' at 30 min in June 2020'])
legend('cl','5','8','13','Location','Best')

figure,
plot([cl(:,k),SuperSmooth(:,k),EhlSSma(:,k)]),grid on
title(['Super Smooth of ',stk{k},' at 30 min in June 2020'])
legend('cl','SM','ma','Location','Best')

figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),SuperSmooth(:,k)]),grid on
title(['Roofing Filter of ',stk{k},' at 30 min in June 2020'])
legend('cl','SM','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[EhlRoof(:,k)]),grid on
legend('roof')
linkaxes(ax,'x')

figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Stochastic Filter of ',stk{k},' at 30 min in June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[EhlRoofstoc(:,k),Ehlstoc(:,k),Ehlmystoc(:,k)]),grid on
legend('roof','stoc','stocfilt','Location','Best')
linkaxes(ax,'x')
%}
%{
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Fisher Transform of ',stk{k},' at 30 min in June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[Value(:,k),Fisher(:,k)]),grid on
legend('Val','Fish','Location','Best')
linkaxes(ax,'x')

figure,
plot([cl(:,k),iTrend(:,k),Trigger(:,k)]),grid on
title(['Instantaneous Trend of ',stk{k},' at 30 min in June 2020'])
legend('cl','iTrend','Trigger','Location','Best')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Center of Gravity of ',stk{k},' at 30 min in June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[EhlCOG(:,k)]),grid on
legend('cog','Location','Best')
linkaxes(ax,'x')
figure,
plot([cl(:,k),MAMA(:,k),FAMA(:,k)]),grid on
title(['mama/fama of ',stk{k},' at 30 min in June 2020'])
legend('cl','mama','fama','Location','Best')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),EhlSmooth2(:,k)]),grid on
title(['Cyber Cycle1 of ',stk{k},' at 30 min in June 2020'])
legend('cl','sm2','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[EhlCycle2(:,k)]),grid on
legend('cyc2','Location','Best')
linkaxes(ax,'x')

figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),EhlSmooth(:,k)]),grid on
title(['Cyber Cycle2 of ',stk{k},' at 30 min in June 2020'])
legend('cl','sm2','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[EhlValue1(:,k),EhlValue2(:,k),EhlValue3(:,k)]),grid on
legend('val1','val2','val3','Location','Best')
linkaxes(ax,'x')

figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Rel Vigor Index of ',stk{k},' at 30 min in June 2020'])
legend('cl','sm2','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[RVIValue1(:,k),RVIValue2(:,k),RVI(:,k),RVITrigger(:,k)]),grid on
legend('val1','val2','rvi','trig','Location','Best')
linkaxes(ax,'x')
%}
%{
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Stochastic CG of ',stk{k},' at 30 min in June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[CGValue1(:,k),CGValue2(:,k),CGTrigger(:,k)]),grid on
legend('val1','val2','trig','Location','Best')
linkaxes(ax,'x')

figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Stochastic Cyber Cycle of ',stk{k},' at 30 min in June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[SCCValue1(:,k),SCCValue2(:,k),SCCTrigger(:,k)]),grid on
legend('val1','val2','trig','Location','Best')
linkaxes(ax,'x')

figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Stochastic CG of ',stk{k},' at 30 min in June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[SCGValue1(:,k),SCGValue2(:,k),SCGCG(:,k),SCGTrigger(:,k)]),grid on
legend('val1','val2','CG','trig','Location','Best')
linkaxes(ax,'x')
%}
%{
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Stochastic RVI of ',stk{k},' at 30 min in June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[stochRVI(:,k),stochRVIValue3(:,k),...
    stochRVIValue4(:,k),stochRVITrig(:,k)]),grid on
legend('rvi','val3','val4','trig','Location','Best')
linkaxes(ax,'x')

figure,
ax(1) = subplot(311);
plot(ax(1),[cl(:,k),CycPerMeasSmooth(:,k)]),grid on
title(['Cycle Per Meas of ',stk{k},' at 30 min in June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(312);
plot(ax(2),[CycPerMeasQ1(:,k),CycPerMeasI1(:,k)]),grid on
legend('Q1','I1','Location','Best')
ax(3) = subplot(313);
plot(ax(3),[CycPerMeasInstPeriod(:,k),CycPerMeasPeriod(:,k)]),grid on
legend('IPer','Per','Location','Best')
linkaxes(ax,'x')

figure,
ax(1) = subplot(311);
plot(ax(1),[cl(:,k),AdapCybCycSmooth(:,k)]),grid on
title(['Adaptive Cyber Cycle of ',stk{k},' at 30 min in June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(312);
plot(ax(2),[AdapCybCycQ1(:,k),AdapCybCycI1(:,k)]),grid on
legend('Q1','I1','Location','Best')
ax(3) = subplot(313);
plot(ax(3),[AdapCybCycAC(:,k),AdapCybCycTrig(:,k)]),grid on
legend('IPer','Per','Location','Best')
linkaxes(ax,'x')

figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),AdapCGSmooth(:,k)]),grid on
title(['Adaptive Center of Gravity of ',stk{k},' at 30 min in June 2020'])
legend('cl','cl-sm','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[AdapCGQ1(:,k),AdapCGI1(:,k),...
    AdapCGCG(:,k),AdapCGTrig(:,k)]),grid on
ylim([-10 10])
legend('Q1','I1','CG','Trig','Location','Best')
linkaxes(ax,'x')

figure,
ax(1) = subplot(311);
plot(ax(1),[cl(:,k),AdapRVISmooth(:,k)]),grid on
title(['Adaptive Relative Vigor Index of ',stk{k},' at 30 min in June 2020'])
legend('cl','cl-sm','Location','Best')
ax(2) = subplot(312);
plot(ax(2),[AdapRVIInstPeriod(:,k)]),grid on
legend('Per','Location','Best')
ax(3) = subplot(313);
plot(ax(3),[AdapRVIQ1(:,k),AdapRVII1(:,k),...
    AdapRVIRVI(:,k),AdapRVITrig(:,k)]),grid on
legend('Q1','I1','CG','Trig','Location','Best')
linkaxes(ax,'x')

figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),SWsmooth(:,k)]),grid on
title(['Sine Wave Indicator of ',stk{k},' at 30 min in June 2020'])
legend('cl','cl-sm','Location','Best')
ax(2) = subplot(212);
% plot(ax(2),[SWCycle(:,k),SWSine(:,k),...
%     SWLeadSine(:,k),SWDeltaPhase(:,k),...
%     SWDC(:,k),SWDCPHase(:,k)]),grid on
% legend('cyc','sine','lead','DP','DC','DCph','Location','Best')
plot(ax(2),[SWCycle(:,k),SWSine(:,k),...
    SWLeadSine(:,k)]),grid on
legend('cyc','sine','lead','Location','Best')
linkaxes(ax,'x')

figure,
plot([cl(:,k),Butter2pole(:,k),Butter3pole(:,k),...
    superSm2pole(:,k),superSm3pole(:,k)]),grid on
title(['2-3 pole Butter, SS of ',stk{k},' at 30 min in June 2020'])
legend('cl','2pole','3pole','2pSS','3pSS','Location','Best')
figure,
plot([cl(:,k),LaguerreFilt(:,k),LaguerreFIR(:,k)]),grid on
title(['Laguerre Filter of ',stk{k},' at 30 min in June 2020'])
legend('cl','Lag','fir','Location','Best')
%}
%{
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),SWInd_v1Smooth(:,k)]),grid on
title(['Sine Wave Indicator V1 of ',stk{k},' at 30 min June 2020'])
legend('cl','cl-sm','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[SWInd_v1Sine(:,k),SWInd_v1LeadSine(:,k),...
    SWSine(:,k),SWLeadSine(:,k)]),grid on
legend('sinev1','leadv1','sine','lead','Location','Best')
linkaxes(ax,'x')

figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Smooth Adap Mom Indicator of ',stk{k},' at 30 min June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[SAMIfilt3(:,k)]),grid on
legend('smooth','lead','Location','Best')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Smooth Adap Mom Strategy of ',stk{k},' at 30 min June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[SAMSfilt3(:,k),SAMSbuy(:,k)]),grid on
legend('filt3','buy','Location','Best')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Smooth Adap Mom Strategy of ',stk{k},' at 30 min June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[LagRSI(:,k)]),grid on
legend('rsi','Location','Best')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Stochastic RSI of ',stk{k},' at 30 min June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[STOCHRSI(:,k),STOCHRSItrig(:,k)]),grid on
legend('rsi','trig','Location','Best')
linkaxes(ax,'x')
figure,
plot([cl(:,k),EMAPredma1(:,k),EMAPredma3(:,k),...
    EMAPredExtBuffer(:,k)]),grid on
title(['Predictive EMA of ',stk{k},' at 30 min June 2020'])
legend('cl','ma1','ma3','ExtBuff','Location','Best')

figure,
plot([cl(:,k),scalper_line(:,k),scalper_lineATR(:,k),ScChanhi(:,k),...
    ScChanlo(:,k)]),grid on
title(['Scalper Line of ',stk{k},' at 30 min June 2020'])
legend('cl','SCline','SCatr','hi','lo','Location','Best')
figure,
plot([cl(:,k),EDCFdcf(:,k)]),grid on
title(['Dist Coef Filter of ',stk{k},' at 30 min June 2020'])
legend('cl','dcf','Location','Best')
figure,
plot([cl(:,k),ALMAalma(:,k)]),grid on
title(['ALMA Filter of ',stk{k},' at 30 min June 2020'])
legend('cl','alma','Location','Best')
figure,
plot([cl(:,k),dema1(:,k),dema2(:,k),dema3(:,k)]),grid on
title(['DEMA Filter of ',stk{k},' at 30 min June 2020'])
legend('cl','1','2','3','Location','Best')
figure,
plot([cl(:,k),frama1(:,k),TillT3(:,k)]),grid on
title(['FRAMA Filter of ',stk{k},' at 30 min June 2020'])
legend('cl','1','T3','Location','Best')
figure,
plot([cl(:,k),TillT3(:,k)]),grid on
title(['T3 Filter of ',stk{k},' at 30 min June 2020'])
legend('cl','T3','Location','Best')
figure,
plot([cl(:,k),Hmavg(:,k)]),grid on
title(['Hull MA Filter of ',stk{k},' at 30 min June 2020'])
legend('cl','hma','Location','Best')
figure,
plot([cl(:,k),kama(:,k)]),grid on
title(['KAMA Filter of ',stk{k},' at 30 min June 2020'])
legend('cl','kama','Location','Best')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Scalp bandpass Filter of ',stk{k},' at 30 min June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[SEBPsig(:,k),SEBPtrig(:,k)]),grid on
legend('sig','trig','Location','Best')
linkaxes(ax,'x')

figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Scalp super bandpass Filter of ',stk{k},' at 30 min June 2020'])
legend('cl','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[SSBPpb(:,k),SSBPrms(:,k)]),grid on
legend('pb','rms','Location','Best')
linkaxes(ax,'x')
figure,
plot([cl(:,k),vwap(:,k)]),grid on
title(['VWAP of ',stk{k},' at 30 min June 2020'])
legend('cl','vwap','Location','Best')
figure,
plot([cl(:,k),tema3(:,k)]),grid on
title(['TEMA of ',stk{k},' at 30 min June 2020'])
legend('cl','tema','Location','Best')
figure,
plot([cl(:,k),TMAsma(:,k),TMAtma(:,k)]),grid on
title(['TMA of ',stk{k},' at 30 min June 2020'])
legend('cl','sma','tma','Location','Best')
figure,
plot([cl(:,k),MMsmm(:,k)]),grid on
title(['Simple Mov Med of ',stk{k},' at 30 min June 2020'])
legend('cl','smm','Location','Best')
figure,
plot([cl(:,k),ESMAsma(:,k),ESMAesma(:,k)]),grid on
title(['sma with error of ',stk{k},' at 30 min June 2020'])
legend('cl','sma','esma','Location','Best')
figure,
plot([cl(:,k),GUPs1(:,k),GUPs2(:,k),GUPs3(:,k),GUPs4(:,k),...
    GUPs5(:,k),GUPs6(:,k),GUPl1(:,k),GUPl2(:,k),GUPl3(:,k),GUPl4(:,k),...
    GUPl5(:,k),GUPl6(:,k)]),grid on
title(['Guppy for ',stk{k},' at 30 min June 2020'])
legend('cl','Location','Best')
figure,
plot([cl(:,k),GUPs1(:,k)]),grid on
title(['VIDYA of ',stk{k},' at 30 min June 2020'])
legend('cl','vidya','Location','Best')
figure,
plot([cl(:,k),evwma(:,k)]),grid on
title(['EVWMA of ',stk{k},' at 30 min June 2020'])
legend('cl','evwma','Location','Best')
figure,
plot([cl(:,k),SCemas1(:,k),SCemas2(:,k),SCemas3(:,k),...
    SCemas4(:,k),SCemas5(:,k)]),grid on
title(['Scalping emas of ',stk{k},' at 30 min June 2020'])
legend('cl','8','13','21','96','252','Location','Best')
%}
%{
study(title="CRUDE OIL BUY/SELL",shorttitle="CRUDE Scalp |3 Min",precision=2,overlay=true)

Rsi_value=input(14,title="RSI Length",step=1)
hl=input(75,title="Higher Value of RSI",step=1)
ll=input(25,title="Lower value of RSI",step=1)
rs=rsi(close,Rsi_value)

sma_value=input(50,title="SMA Length",step=1)
sma1=sma(close,sma_value)

dist_SMA=1
candle_length=1

mycolor= iff(rs>=hl or rs<=ll,color.yellow,iff(low> sma1,color.lime,iff(high<sma1,color.red,color.yellow)))
gaps=sma1+dist_SMA  //Gap between price and SMA for Sell
gapb=sma1-dist_SMA  //Gap between price and SMA for Buy
chartgap=gaps or gapb  //for both below or above the SMA 
gap1=sma1+5
gapvalue=(open/100)*candle_length     //setting % with its Share price
gapp=(high-low)>gapvalue //or rs<50     // Condition for Min candle size to be eligible for giving signal - Buy Calls
gapp2=(high-low)>gapvalue //or rs>55    // Condition for Min candle size to be eligible for giving signal - Sell Calls
bull=open<close and (high-low)>2*gapvalue and close>(high+open)/2
bear=open>close and (high-low)>2*gapvalue and close<(low+open)/2


rev1=rs>68 and open>close and open>gaps and (high-low)>gapvalue+0.5 and low!=close      //over red candles  "S" - uptrend
rev1a=rs>90 and open<close and close>gaps and high!=close and open!=low                             // over green candles"S" - uptrend
sellrev= rev1 or rev1a

rev2=rs<50 and open<close and open<gapb and open==low  //over green candles"B"
rev3=rs<30 and open>close and high>gapb and open!=high and barstate.isconfirmed!=bear  //over red candles"B"
rev4=rs<85 and close==high and (high-low)>gapvalue and open<close    //over green candle in both trends
hlrev_s=crossunder(rs,hl)
llrev_b=crossover(rs,ll) and open<close

buycall=open<close and open>sma1 and cross(close[1],sma1) and close>sma1
sellcall=cross(close,sma1) and open>close
BUY=crossover(close[1],sma1) and close[1]>open[1] and high[0]>high[1] and close[0]>open[0]  
SELL=crossunder(low[1],sma1) and close[1]<open[1] and low[0]<low[1] and close[0]<open[0]
%}
%{
study(title="Scalping EMAs", overlay = true)

len1 = input(8, minval=1, title="EMA 1 (8)")
src1 = input(close, title="Source One")
out1 = ema(src1, len1)
plot(out1, title="EMA 1 (8)", color=aqua, transp=40, linewidth=2)

len2 = input(13, minval=1, title="EMA 2 (13)")
src2 = input(close, title="Source Two")
out2 = ema(src2, len2)
plot(out2, title="EMA 2 (13)", color=fuchsia, transp=40, linewidth=2)

len3 = input(21, minval=1, title="EMA 3 (21)")
src3 = input(close, title="Source Three")
out3 = ema(src3, len3)
plot(out3, title="EMA 3 (21)", color=orange, transp=40, linewidth=2)

len4 = input(96, minval=1, title="EMA 4 (96)")
src4 = input(close, title="Source Four")
out4 = ema(src4, len4)
plot(out4, title="EMA 4 (96)", color=yellow, transp=30, linewidth=3)

len5 = input(252, minval=1, title="EMA 5 (252)")
src5 = input(close, title="Source Five")
out5 = ema(src5, len5)
%}
function out = ScalpEMAs(C)
P = C;
len = [8 13 21 96 252];
a = 2./(len+1);
persistent Xsema
if isempty(Xsema)
    Xsema.emap = repmat(P,length(len),1);
end
ema = (P - Xsema.emap).*a' + Xsema.emap;
Xsema.emap = ema;
out = ema;
end
%{
study("Elastic Volume Weighted Moving Average", 
shorttitle="EVWMA", overlay=true)

length = input(title="Length", type=integer, defval=14)
highlightMovements = input(title="Highlight Movements ?", 
type=bool, defval=true)
src = input(title="Source", type=source, defval=close)

volumeSum = sum(volume, length)

evwma = 0.0
evwma := ((volumeSum - volume) * nz(evwma[1]) + volume * src) / volumeSum
%}
function out = EVWMA(C,V)
Length = 14;
src = C;
persistent Xevwma
if isempty(Xevwma)
    Xevwma.volwin = repmat(V,Length,1);
    Xevwma.evwmap = C;
end
Xevwma.volwin = [V;Xevwma.volwin(1:end-1,:)];
volumeSum = sum(Xevwma.volwin);
evwma = ((volumeSum - V) .* Xevwma.evwmap + V .* src) ./ volumeSum;
Xevwma.evwmap = evwma;
out(1,:) = evwma;
end
%{
The Variable Moving Average (VMA) aka Volatility Index 
Dynamic Average (VIDYA) was developed by Tushar S. Chande 
and first presented in the March 1992 edition of 
Technical Analysis of Stocks & Commodities – Adapting Moving 
Averages To Market Volatility

Chande’s theory was that the performance of an 
exponential moving average could be improved by using a 
Volatility Index (VI) to adjust the smoothing period as
market conditions change.  The idea being that when 
prices are congested an average should slow down to avoid 
whipsaws but when prices are trending strongly an average 
should speed up to capture the major price moves.
study(title="Variable Index Dynamic Average", shorttitle="VIDYA", overlay=true)

length = input(title="Length", type=integer, defval=14)
highlightMovements = input(title="Highlight Movements ?", type=bool, defval=true)
src = input(title="Source", type=source, defval=close)

// Chande Momentum Oscillator
getCMO(src, length) =>
    mom = change(src)
    upSum = sum(max(mom, 0), length)
    downSum = sum(-min(mom, 0), length)
    out = (upSum - downSum) / (upSum + downSum)
    out

cmo = abs(getCMO(src, length))

alpha = 2 / (length + 1)

vidya = 0.0
vidya := src * alpha * cmo + nz(vidya[1]) * (1 - alpha * cmo)study(title="Variable Index Dynamic Average", shorttitle="VIDYA", overlay=true)

length = input(title="Length", type=integer, defval=14)
highlightMovements = input(title="Highlight Movements ?", type=bool, defval=true)
src = input(title="Source", type=source, defval=close)
%}
function out = vidya(C)
src = C;
Length = 14;
persistent Xvid
if isempty(Xvid)
    Xvid.srcp = src;
    Xvid.cmowin = zeros(Length,length(src));
    Xvid.vidyap = src;
end
Xvid.cmowin = [src-Xvid.srcp;Xvid.cmowin(1:end-1,:)];
upSum = sum(max(Xvid.cmowin, zeros(Length,length(src))));
downSum = sum(-min(Xvid.cmowin, zeros(Length,length(src))));
upSum(upSum==0) = 1;
downSum(downSum==0) = 1;
tmp = (upSum - downSum) ./ (upSum + downSum);
cmo = abs(tmp);
alpha = 2 / (Length + 1);
vidya = src * alpha .* cmo + Xvid.vidyap .* (1 - alpha * cmo);
Xvid.srcp = src;
Xvid.vidyap = vidya;
out(1,:) = vidya;
end
%{
https://www.investopedia.com/terms/g/guppy-multiple-moving-average.asp
Guppy Multiple Moving Average (GMMA)
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
%}
function out = GMMA(C)
P = C;
Nshort = [3 5 8 10 12 15];
Nlong = [30 35 40 45 50 60];
ashort = 2./(Nshort+1);
along = 2./(Nlong+1);
persistent Xgmma
if isempty(Xgmma)
    Xgmma.shortp = repmat(P,length(Nshort),1);
    Xgmma.longp = repmat(P,length(Nlong),1);
end
gshort = (P - Xgmma.shortp).*ashort' + Xgmma.shortp;
glong = (P - Xgmma.longp).*along' + Xgmma.longp;
Xgmma.shortp = gshort;
Xgmma.longp = glong;
out = [gshort;glong];
end
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
%{
https://www.thebalance.com/triangular-moving-average-tma-description-and-uses-1031203
The triangular moving average (TMA) is an average of an average, of the last N prices (P).
First, calculate the simple moving average (SMA):
    SMA = (P1 + P2 + P3 + P4 + ... + PN) / N
Then, take the average of all the SMA values to get TMA values.
    TMA = (SMA1 + SMA2 + SMA3 + SMA4 + ... SMAN) / N
The TMA can also be expressed as: TMA = SUM (SMA values) /
%}
function out = TMA(C)
P = C;
N = 10;
persistent Xtma
if isempty(Xtma)
    Xtma.Pwin = repmat(P,N,1);
    Xtma.tmawin = repmat(P,N,1);
end
Xtma.Pwin = [P;Xtma.Pwin(1:end-1,:)];
sma = sum(Xtma.Pwin)/N;
Xtma.tmawin = [sma;Xtma.tmawin(1:end-1,:)];
tma = sum(Xtma.tmawin)/N;
out(1,:) = sma;
out(2,:) = tma;
end
%{
https://www.tradingview.com/script/OQs2lVvr-Ultimate-Moving-Average-Multi-TimeFrame-7-MA-Types/
//TEMA definition
src = close
len = input(20, title="Moving Average Length - LookBack Period")
ema1 = ema(src, len)
ema2 = ema(ema1, len)
ema3 = ema(ema2, len)
tema = 3 * (ema1 - ema2) + ema3
%} 
function out = tema(C)
src = C;
len = 20;
n = 3;
alpha = 2/(len+1);
persistent Xtema
if isempty(Xtema)
    Xtema.ema1p = src;
    Xtema.ema2p = src;
    Xtema.ema3p = src;
end
ema1 = (1-alpha)*Xtema.ema1p + alpha*src;
ema2 = (1-alpha)*Xtema.ema2p + alpha*ema1;
ema3 = (1-alpha)*Xtema.ema3p + alpha*ema2;
tema = n * (ema1 - ema2) + ema3;
% updates
Xtema.ema1p = ema1;
Xtema.ema2p = ema2;
Xtema.ema3p = ema3;
out(1,:) = tema;
end
%{
Volume Weighted Average Price (VWAP) is
VWAP is calculated by adding up the dollars traded 
for every transaction (price multiplied by the number 
of shares traded) and then dividing by the total shares traded.
The volume weighted average price (VWAP) appears as a 
single line on intraday charts (1 minute, 15 minute, 
and so on), similar to how a moving average looks.
To calculate the VWAP yourself, follow these steps. 
Assume a 5-minute chart; the calculation is same 
regardless of what intraday time frame is used.


Find the average price the traded at over the first 
five-minute period of the day. To do this, add the high, 
low, and close, then divide by three. Multiply this by 
the volume for that period. Record the result in a 
spreadsheet, under column PV.
Divide PV by the volume for that period. This will give 
the VWAP value.
To maintain the VWAP value throughout the day, continue 
to add the PV value from each period to the prior values. 
Divide this total by total volume up to that point. 
To make this easier in a spreadsheet, create columns 
for cumulative PV and cumulative volume. Both these 
cumulative values are divided by each other to produce VWAP.
%}
function out = VWAP(H,L,C,V)
Price = (H+L+C)/3;
Len = 14;
persistent Xvwap
if isempty(Xvwap)
    Xvwap.vwapwin = repmat(Price.*V,Len,1);
    Xvwap.volwin = repmat(V,Len,1);
end
Xvwap.vwapwin = [Price.*V;Xvwap.vwapwin(1:end-1,:)];
Xvwap.volwin = [V;Xvwap.volwin(1:end-1,:)];
vwa = sum(Xvwap.vwapwin);
vol = sum(Xvwap.volwin);
vwap = vwa./vol;
out(1,:) = vwap;
end
%{
// Ehlers Super PassBand Filter [CC] 
study("Ehlers Super PassBand Filter [CC]", overlay=false)

inp = input(title="Source", type=input.source, defval=close)
res = input(title="Resolution", type=input.resolution, defval="")
rep = input(title="Allow Repainting?", type=input.bool, defval=false)
bar = input(title="Allow Bar Color Change?", type=input.bool, defval=true)
src = security(syminfo.tickerid, res, inp[rep ? 0 : barstate.isrealtime ? 1 : 0])[rep ? 0 : barstate.isrealtime ? 0 : 1]
length1 = input(title="Length1", type=input.integer, defval=40, minval=1)
length2 = input(title="Length2", type=input.integer, defval=60, minval=1)
rmsLength = input(title="RMSLength", type=input.integer, defval=50, minval=1)
pi = 2 * asin(1)
a1 = 5.0 / length1
a2 = 5.0 / length2
pb = 0.0
pb := ((a1 - a2) * src) + (((a2 * (1 - a1)) - (a1 * (1 - a2))) * nz(src[1])) + (((1 - a1) + (1 - a2)) * nz(pb[1])) - ((1 - a1) * (1 - a2) * nz(pb[2]))
rms = 0.0
for i = 0 to rmsLength - 1
    rms := rms + pow(nz(pb[i]), 2)
rms := sqrt(rms / rmsLength)
sig = pb > 0 ? 1 : pb < 0 ? -1 : 0
%}
function out = ScSuperBP(C)
src = C;
length1 = 40;
length2 = 60;
rmslength = 50;
a1 = 5/length1;
a2 = 5/length2;
persistent XSSBP
if isempty(XSSBP)
    XSSBP.srcp = src;
    XSSBP.pbp = zeros(1,length(src));
    XSSBP.pbpp = zeros(1,length(src));
    XSSBP.rmswin = zeros(rmslength,length(src));
end
pb = ((a1 - a2) * src) + ...
    (((a2 * (1 - a1)) - (a1 * (1 - a2))) * XSSBP.srcp) + ...
    (((1 - a1) + (1 - a2)) * XSSBP.pbp) - ...
    ((1 - a1) * (1 - a2) * XSSBP.pbpp);
XSSBP.rmswin = [pb;XSSBP.rmswin(1:end-1,:)];
rms = zeros(1,length(src));
for i = 1:rmslength
    rms = rms + XSSBP.rmswin(i,:).*XSSBP.rmswin(i,:);
end
rms = sqrt(rms / rmslength);
% updates
XSSBP.pbpp = XSSBP.pbp;
XSSBP.pbp = pb;
XSSBP.srcp = src;
out(1,:) = pb;
out(2,:) = rms;
end
%{
//@version=4
// Copyright (c) 2019-present, Franklin Moormann (cheatcountry)
// Ehlers BandPass Filter [CC] 
study("Ehlers BandPass Filter [CC]", overlay=false)

inp = input(title="Source", type=input.source, defval=close)
res = input(title="Resolution", type=input.resolution, defval="")
rep = input(title="Allow Repainting?", type=input.bool, defval=false)
bar = input(title="Allow Bar Color Change?", type=input.bool, defval=true)
src = security(syminfo.tickerid, res, inp[rep ? 0 : barstate.isrealtime ? 1 : 0])[rep ? 0 : barstate.isrealtime ? 0 : 1]
length = input(title="Length", type=input.integer, defval=20, minval=1)
bw = input(title="Bandwidth", type=input.float, defval=0.3, minval=0.01, step = 0.01)

pi = 2 * asin(1)
twoPiPrd1 = 0.25 * bw * 2 * pi / length
twoPiPrd2 = 1.5 * bw * 2 * pi / length
beta = cos(2 * pi / length)
gamma = 1.0 / cos(2 * pi * bw / length)
alpha1 = gamma - sqrt((gamma * gamma) - 1)
alpha2 = (cos(twoPiPrd1) + sin(twoPiPrd1) - 1) / cos(twoPiPrd1)
alpha3 = (cos(twoPiPrd2) + sin(twoPiPrd2) - 1) / cos(twoPiPrd2)

hp = 0.0
hp := ((1 + (alpha2 / 2)) * (src - nz(src[1]))) + 
    ((1 - alpha2) * nz(hp[1]))

bp = 0.0
bp := bar_index > 2 ? (0.5 * (1 - alpha1) * 
    (hp - nz(hp[2]))) + 
    (beta * (1 + alpha1) * nz(bp[1])) - (alpha1 * nz(bp[2])) : 0

peak = 0.0
peak := 0.991 * nz(peak[1])
peak := abs(bp) > peak ? abs(bp) : peak

signal = peak != 0 ? bp / peak : 0
trigger = 0.0
trigger := ((1 + (alpha3 / 2)) * 
    (signal - nz(signal[1]))) + ((1 - alpha3) * nz(trigger[1]))
%}
function out = ScalpEhlersBP(C)
src = C;
Length = 20;
bw = 0.3;
persistent XScEBP
if isempty(XScEBP)
    twoPiPrd1 = 0.25 * bw * 2 * pi / Length;
    twoPiPrd2 = 1.5 * bw * 2 * pi / Length;
    XScEBP.beta = cos(2 * pi / Length);
    gamma = 1.0 / cos(2 * pi * bw / Length);
    XScEBP.alpha1 = gamma - sqrt((gamma * gamma) - 1);
    XScEBP.alpha2 = (cos(twoPiPrd1) + sin(twoPiPrd1) - 1) / ...
        cos(twoPiPrd1);
    XScEBP.alpha3 = (cos(twoPiPrd2) + sin(twoPiPrd2) - 1) / ...
        cos(twoPiPrd2);
    XScEBP.srcp = src;
    XScEBP.hpp = zeros(1,length(src));
    XScEBP.hppp = zeros(1,length(src));
    XScEBP.bpp = zeros(1,length(src));
    XScEBP.bppp = zeros(1,length(src));
    XScEBP.peakp = zeros(1,length(src));
    XScEBP.sigp = zeros(1,length(src));
    XScEBP.trigp = zeros(1,length(src));
end
hp = ((1 + (XScEBP.alpha2 / 2)) * (src - XScEBP.srcp)) + ...
    ((1 - XScEBP.alpha2) * XScEBP.hpp);
bp = 0.5 * (1 - XScEBP.alpha1) * (hp - XScEBP.hppp) + ...
    XScEBP.beta * (1 + XScEBP.alpha1) * XScEBP.bpp - ...
    XScEBP.alpha1 * XScEBP.bppp;
peak = 0.991*XScEBP.peakp;
peak = max(abs(bp),peak);
signal = zeros(1,length(src));
k = find(peak~=0);
signal(k) = bp(k)./peak(k);
trigger = ((1 + (XScEBP.alpha3 / 2)) * ...
    (signal - XScEBP.sigp)) + ...
    ((1 - XScEBP.alpha3) * XScEBP.trigp);
% updates
XScEBP.srcp = src;
XScEBP.hppp = XScEBP.hpp;
XScEBP.hpp = hp;
XScEBP.bppp = XScEBP.bpp;
XScEBP.bpp = bp;
XScEBP.peakp = peak;
XScEBP.sigp = signal;
XScEBP.trigp = trigger;
out(1,:) = signal;
out(2,:) = trigger;
end
%{
Kaufman's Adaptive Moving Average (KAMA) is a moving average designed to 
account for market noise or volatility.
KAMA(10,2,30).
10 is the number of periods for the Efficiency Ratio (ER).
2 is the number of periods for the fastest EMA constant.
30 is the number of periods for the slowest EMA constant.
Efficiency Ratio (ER)
ER = Change/Volatility
Change = ABS(Close - Close (10 periods ago))
Volatility = Sum10(ABS(Close - Prior Close))
Volatility is the sum of the absolute value of the 
last ten price changes (Close - Prior Close). 
Smoothing Constant (SC)
SC = [ER x (fastest SC - slowest SC) + slowest SC]2
SC = [ER x (2/(2+1) - 2/(30+1)) + 2/(30+1)]2
Current KAMA = Prior KAMA + SC x (Price - Prior KAMA)
%}
function out = KAMA(C)
Price = C;
periodsER = 10;
periodsfast = 2;
periodsslow = 30;
SCfast = 2/(periodsfast+1);
SCslow = 2/(periodsslow+1);
persistent Xkama
if isempty(Xkama)
    Xkama.prwin = repmat(Price,periodsER,1);
    Xkama.difwin = repmat(zeros(1,length(Price)),periodsER,1);
    Xkama.kamap = Price;
end
Xkama.prwin = [Price;Xkama.prwin(1:end-1,:)];
Xkama.difwin = [Xkama.prwin(1,:)-Xkama.prwin(2,:);...
    Xkama.difwin(1:end-1,:)];
Change = abs(Xkama.prwin(1,:)-Xkama.prwin(end,:));
Volatility = sum(abs(Xkama.difwin));
ER = Change/Volatility;
SC = [ER * (SCfast - SCslow) + SCslow]^2;
kama = Xkama.kamap + SC * (Price - Xkama.kamap);
Xkama.kamap = kama;
out = kama;
end
%{
//INPUT
src = input(close, title="Source")
length = input(55, 
title="Length(180-200 for floating S/R , 55 for swing entry)")

//FUNCTIONS
//HMA
HMA(_src, _length) =>  wma(2 * wma(_src, _length / 2) - 
    wma(_src, _length), round(sqrt(_length)))
//EHMA    
EHMA(_src, _length) =>  ema(2 * ema(_src, _length / 2) - 
    ema(_src, _length), round(sqrt(_length)))
//THMA    
THMA(_src, _length) =>  wma(wma(_src,_length / 3) * 3 - 
    wma(_src, _length / 2) - wma(_src, _length), _length)
%}
function out = HullMA(C)
src = C;
Length = 55;
persistent XHma
if isempty(XHma)
    b55 = [Length:-1:1]/sum([Length:-1:1]);
    b27 = [round(Length/2):-1:1]/sum([round(Length/2):-1:1]);
    bsr = [round(sqrt(Length)):-1:1]/...
        sum([round(sqrt(Length)):-1:1]);
    XHma.b55 = b55;
    XHma.b27 = b27;
    XHma.bsr = bsr;
    XHma.Cwin = repmat(C,Length,1);
    XHma.Zwin = repmat(C,Length,1);
end
XHma.Cwin = [C;XHma.Cwin(1:end-1,:)];
b27 = XHma.b27;
b55 = XHma.b55;
bsr = XHma.bsr;
tmp = 2*sum(b27'.*XHma.Cwin(1:length(b27),:)) - ...
    sum(b55'.*XHma.Cwin(1:length(b55),:));
XHma.Zwin = [tmp;XHma.Zwin(1:end-1,:)];
HMA = sum(bsr'.*XHma.Zwin(1:length(bsr),:));
out = HMA;
end
%{
https://www.forexfactory.com/attachment.php/845855?attachmentid=845855&d=1322724313
 The general formula
(which is referred to as “generalized DEMA”) is:

GD(n,v) = EMA(n) * (1+v) - EMA(EMA(n)) * v

When v = 0, GD is just an EMA, and when v = 1, GD is DEMA. 
In between, GD is a less aggressive version of DEMA. 
By using a value for v less than 1, we cure the multiple 
DEMA overshoot problem but at the cost of accepting some 
additional phase delay. Now we can run GD through itself 
multiple times to define a new, smoother moving average 
(T3) that does not overshoot the data:
T3(n) = GD(GD(GD(n)))
If x stands for the action of running a time series through
an EMA, f is our formula for generalized DEMA with the
variable “a” standing for our volume factor:
f:= (1+ a) x – ax^2

Running the filter though itself three times is equivalent to
cubing f:
–a^3 + x^6 + (3a^2 + 3a^3)x^5 + (–6a^2–3a–3a^3)x^4
+ (1+3a+a^3+3a^2)x^3
Thus, the Meta6.5 code for T3 is:
periods:=Input(“Periods? “,1,63,5);
a:=Input(“Hot? “,0,2,.7);
e1:=Mov(P,periods,E);
e2:=Mov(e1,periods,E);
e3:=Mov(e2,periods,E);
e4:=Mov(e3,periods,E);
e5:=Mov(e4,periods,E);
e6:=Mov(e5,periods,E);
c1:=-a*a*a;
c2:=3*a*a+3*a*a*a;
c3:=-6*a*a-3*a-3*a*a*a;
c4:=1+3*a+a*a*a+3*a*a;
c1*e6+c2*e5+c3*e4+c4*e3;
%}
function out = T3Tillson(C)
a = 0.7;
P = C;
periods = 5;
alpha = 2/(periods+1);
persistent XT3
if isempty(XT3)
    XT3.e1p = P;
    XT3.e2p = P;
    XT3.e3p = P;
    XT3.e4p = P;
    XT3.e5p = P;
    XT3.e6p = P;
    XT3.c1 = -a*a*a;
    XT3.c2 = 3*a*a + 3*a*a*a;
    XT3.c3 = -6*a*a - 3*a - 3*a*a*a;
    XT3.c4 = 1 + 3*a + a*a*a + 3*a*a;
end
e1 = (1-alpha)*XT3.e1p + alpha*P;
e2 = (1-alpha)*XT3.e2p + alpha*e1;
e3 = (1-alpha)*XT3.e3p + alpha*e2;
e4 = (1-alpha)*XT3.e4p + alpha*e3;
e5 = (1-alpha)*XT3.e5p + alpha*e4;
e6 = (1-alpha)*XT3.e6p + alpha*e5;
T3 = XT3.c1*e6 + XT3.c2*e5 + XT3.c3*e4 + XT3.c4*e3;
XT3.e1p = e1;
XT3.e2p = e2;
XT3.e3p = e3;
XT3.e4p = e4;
XT3.e5p = e5;
XT3.e6p = e6;
out(1,:) = T3;
end
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
%{
https://www.tradingview.com/script/AbRhwDeX-Double-Exponential-Moving-Average-8-20-63-Strategy/
strategy("Double Exponential Moving Average 8-20-63 Strategy", 
short = input(8, minval=1)
srcShort = input(ohlc4, title="Source Dema 1")

long = input(20, minval=1)
srcLong = input(low, title="Source Dema 2")

long2 = input(63, minval=1)
srcLong2 = input(close, title="Source Dema 3")
e1 = ema(srcShort, short)
e2 = ema(e1, short)
dema1 = 2 * e1 - e2
plot(dema1, color=color.green, linewidth=2)

e3 = ema(srcLong, long)
e4 = ema(e3, long)
dema2 = 2 * e3 - e4
plot(dema2, color=color.blue, linewidth=2)

e5 = ema(srcLong2, long2)
e6 = ema(e5, long2)
dema3 = 2 * e5 - e6
%}
function out = DEMA(O,H,L,C)
srcShort = (O+H+L+C)/4;
srcLong = L;
srcLong2 = C;
short = 8;
long = 20;
long2 = 63;
a1 = 2/(short+1);
a2 = 2/(long+1);
a3 = 2/(long2+1);
persistent Xdema
if isempty(Xdema)
    Xdema.e1p = srcShort;
    Xdema.e2p = srcShort;
    Xdema.e3p = srcLong;
    Xdema.e4p = srcLong;
    Xdema.e5p = srcLong2;
    Xdema.e6p = srcLong2;
end
e1 = (1-a1)*Xdema.e1p + a1*srcShort;
e2 = (1-a1)*Xdema.e2p + a1*e1;
dema1 = 2*e1 - e2;
e3 = (1-a2)*Xdema.e3p + a2*srcLong;
e4 = (1-a2)*Xdema.e4p + a2*e3;
dema2 = 2*e3 - e4;
e5 = (1-a3)*Xdema.e5p + a3*srcLong2;
e6 = (1-a3)*Xdema.e6p + a3*e5;
dema3 = 2*e5 - e6;
% updates
Xdema.e1p = e1;
Xdema.e2p = e2;
Xdema.e3p = e3;
Xdema.e4p = e4;
Xdema.e5p = e5;
Xdema.e6p = e6;
out(1,:) = dema1;
out(2,:) = dema2;
out(3,:) = dema3;
end
%{
https://www.tradingview.com/script/rqxaTb6E-ALMA-Function-FN-Arnaud-Legoux-Moving-Average/
study("Alma Function", overlay = true)
ARNAUD LEGOUX MOVING AVERAGE (ALMA)
_alma(_series, _length, _offset, _sigma) =>
    length      = int(_length) // Floating point protection
    numerator   = 0.0
    denominator = 0.0 
    m = _offset * (length - 1)
    s = length / _sigma
    for i=0 to length-1
        weight       = exp(-((i-m)*(i-m)) / (2 * s * s))
        numerator   := numerator   + weight * _series[length - 1 - i]
        denominator := denominator + weight
    numerator / denominator

source = input(close, "ALMA Source", input.source )
length = input(   10, "ALMA Length", input.integer, minval=1)
sigma  = input(  6.0, "ALMA Sigma" , input.float  , minval=0.0, step=0.5)
offset = input( 0.85, "ALMA Offset", input.float  ,   step=0.05)
%}
function out = ALMA(C)
series = C;
Length = 10;
offset = 0.85;
sigma = 6;
numerator   = zeros(1,length(C));
denominator = zeros(1,length(C));
m = offset * Length;
s = Length / sigma;
persistent XALMA
if isempty(XALMA)
    XALMA.serieswin = repmat(series,Length,1);
end
XALMA.serieswin = [series;XALMA.serieswin(1:end-1,:)];
for i=1:Length
    weight = exp(-((i-m)*(i-m)) / (2 * s * s));
    numerator = numerator + weight * XALMA.serieswin(Length+1-i,:);
    denominator = denominator + weight;
end
ALMA = numerator ./ denominator;
out(1,:) = ALMA;
end
%{
// Copyright (c) 2018-present, Alex Orekhov (everget)
// Ehlers Distance Coefficient Filter script may be freely distributed under the MIT license.
study("Ehlers Distance Coefficient Filter", shorttitle="EDCF", overlay=true)
length = input(title="Length", type=integer, defval=14)
src = input(title="Source", type=source, defval=hl2)
srcSum = 0.0
coefSum = 0.0
for count = 0 to length - 1
	distance = 0.0

	for lookback = 1 to length - 1
		distance := distance + pow(src[count] - src[count + lookback], 2)

	srcSum := srcSum + distance * src[count]
	coefSum := coefSum + distance

dcf = coefSum != 0 ? srcSum / coefSum : 0.0
%}
function out = EhlersDistCoefFilt(H,L)
Length = 14;
src = (H+L)/2;
srcSum = 0.0;
coefSum = 0.0;
persistent XDCoefFil
if isempty(XDCoefFil)
    XDCoefFil.srcwin = repmat(src,2*Length,1);
end
XDCoefFil.srcwin = [src;XDCoefFil.srcwin(1:end-1,:)];
for count = 1:Length
    distance = 0;
    for lookback = 1:Length
        distance = distance + ...
            power(XDCoefFil.srcwin(count,:) - ...
            XDCoefFil.srcwin(count+lookback,:),2);
    end
    srcSum = srcSum + distance .* XDCoefFil.srcwin(count,:);
	coefSum = coefSum + distance;
end
coefSum(coefSum==0) = 1;
k = find(srcSum==0);
srcSum(k) = src(k);
dcf = srcSum ./ coefSum;
out = dcf;
end
%{
//
// @author LazyBear
// @credits http://freethinkscript.blogspot.com/2009/05/only-scalpers-channel-that-you-will.html
//
study(title = "Scalper's Channel [LazyBear]", 
shorttitle="weak_volume_dependency [LB]", overlay=true)
length = input(20)
factor = input(15)
pi = atan(1)*4
Average(x,y) => (sum(x,y) / y)
scalper_line= plot(Average(close, factor) - log(pi * (atr(factor))), color=blue, linewidth=3)
hi = plot (highest(length), color=fuchsia)
lo = plot (lowest(length), color=fuchsia)
%}
function out = ScalpChan(C)
Length = 20;
factor = 15;
b = ones(1,factor)/factor;
persistent XScCh
if isempty(XScCh)
    XScCh.lenwin = repmat(C,Length,1);
    XScCh.factwin = repmat(C,factor,1);
    XScCh.Cp = C;
end
XScCh.lenwin = [C;XScCh.lenwin(1:end-1,:)];
XScCh.factwin = [C;XScCh.factwin(1:end-1,:)];
maxC = max(XScCh.factwin);
minC = min(XScCh.factwin);
atr = max(maxC-minC,max(abs(maxC-XScCh.Cp),abs(minC-XScCh.Cp)));
scalper_line = mean(XScCh.factwin) - log(pi*atr);
scalper_line_atr = mean(XScCh.factwin) - atr;
hi = max(XScCh.lenwin);
lo = min(XScCh.lenwin);
XScCh.Cp = C;
out(1,:) = scalper_line;
out(2,:) = scalper_line_atr;
out(3,:) = hi;
out(4,:) = lo;
end
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
%{
//// STOCHASTIC RSI STRATEGY ////
Var {Inputs}: Delimiter(80), MA(0), MAlength(1{144}), 
Var{Input}: RSILength(8), StocLength(8), WMALength(8), 
StoRSI1(0), StoRSI2(0),StoRSI3(0),StoRSI4(0),StoRSI5(0);
MA=(Average(C, MAlength));
StoRSI1=RSI (Close, RSILength) - 
Lowest(RSI(Close, RSILength), StocLength);
StoRSI2 = Highest(RSI(Close, RSILength), StocLength) - 
Lowest(RSI(Close, RSILength), StocLength);
If StoRSI2<> 0 then StoRSI3 = StoRSI1/StoRSI2;
StoRSI4 = 2*(WAverage(StoRSI3, WMALength) - .5);
StoRSI5 = StoRSI4[1]; //define trigger
//Plot1(StoRSI4, "StocRSI",blue); 
Plot2(StoRSI5, "Trig",green); 
Plot3(0,"Zero",yellow); 
Plot4(.6,"",black);
Plot5(-.6,"",black);
%}
function out = StochRSI(C)
Delimiter = 80;
MAlength = 144;
RSILength = 8;
StocLength = 8;
WMALength = 8;
persistent Xstrsi
if isempty(Xstrsi)
    % weighted ave calculations
    Xstrsi.wnum = (WMALength + 1)*ones(1,WMALength) - [1:WMALength];
    Xstrsi.wden = WMALength*(WMALength+1) - sum(1:WMALength);
    Xstrsi.MAwin = repmat(C,MAlength,1);
    Xstrsi.RSIwin = repmat(zeros(1,length(C)),RSILength+1,1);
    Xstrsi.RSIlenwin = repmat(zeros(1,length(C)),StocLength,1);
    Xstrsi.StoRSI3win = repmat(zeros(1,length(C)),WMALength,1);
    Xstrsi.StoRSI4p = zeros(1,length(C));
end
Xstrsi.MAwin = [C;Xstrsi.MAwin(1:end-1,:)];
MA = mean(Xstrsi.MAwin);
tmpdif = diff(Xstrsi.MAwin(1:RSILength+1,:));
tmpU = tmpdif>0;
tmpD = tmpdif<0;
URS = sum(tmpU.*tmpdif);
DRS = sum(abs(tmpD.*tmpdif));
if isempty(find(DRS,1))|isempty(find(URS,1))
    rsi = zeros(1,length(C));
else
    DRS(DRS==0) = 1;
    rsi = 100*(1-1./(1+URS./DRS));
end
Xstrsi.RSIwin = [rsi;Xstrsi.RSIwin(1:end-1,:)];
Xstrsi.RSIlenwin = [rsi;Xstrsi.RSIlenwin(1:end-1,:)];
StoRSI1 = rsi - min(Xstrsi.RSIlenwin);
StoRSI2 = max(Xstrsi.RSIlenwin) - min(Xstrsi.RSIlenwin);
StoRSI2(StoRSI2==0) = 1;
StoRSI3 = StoRSI1./StoRSI2;
Xstrsi.StoRSI3win = [StoRSI3;Xstrsi.StoRSI3win(1:end-1,:)];
StoRSI4 = 2*sum(Xstrsi.wnum'.*Xstrsi.StoRSI3win - .5)/Xstrsi.wden;
StoRSI5 = Xstrsi.StoRSI4p; % define trigger
Xstrsi.StoRSI4p = StoRSI4;
out(1,:) = StoRSI4;
out(2,:) = StoRSI5;
end
%{
{Laguerre RSI (four elements) - 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 

Input: Dampen(.5);
Var: L0(0), L1(0), L2(0), L3(0), CU(0), CD(0), RSI(0);

L0=(1-Dampen)*Close+Dampen*L0[1];
L1=-Dampen*L0+L0[1]+Dampen*L1[1];
L2=-Dampen*L1+L1[1]+Dampen*L2[1];
L3=-Dampen*L2+L2[1]+Dampen*L3[1];
CU=0; CD=0;
If L0>=L1 then CU = L0-L1 Else CD = L1-L0;
If L1>=L2 then CU=CU+L1-L2 Else CD=CD+L2-L1;
If L2>=L3 then CU=CU+L2-L3 Else CD=CD+L3-L2;
If CU+CD<>0 then RSI=CU/(CU+CD);
Plot1(RSI,"RSI",Blue); Plot2(.8,"UpperLine",yellow); Plot3(.2,"LowerLine",yellow);

{Note: This RSI is calculated over Laguerre time rather than regular time.
This is a time-warped RSI which causes the excursions typically to be lock to lock
Time-warped indicators react faster because a shorter amount data is used.
The Laguerre filter can also be used to decrease the reaction time of other indicators.
The "Dampen" factor - suggested setting .5 - can be adjusted to suit your data.
}
%}
function out = LaguerreRSI(C)
Price = C;
% gamma = 0.8;
Dampen = 0.5;
b = [1 2 2 1]/6;
persistent XLag
if isempty(XLag)
    XLag.L0p = Price;
    XLag.L1p = Price;
    XLag.L2p = Price;
    XLag.L3p = Price;
    XLag.prwin = repmat(Price,length(b),1);
end
L0 = (1-Dampen)*Price + Dampen*XLag.L1p;
L1 = -Dampen*L0 + XLag.L0p + Dampen*XLag.L1p;
L2 = -Dampen*L1 + XLag.L1p + Dampen*XLag.L2p;
L3 = -Dampen*L2 + XLag.L2p + Dampen*XLag.L3p;
CU=zeros(1,length(C)); 
CD=zeros(1,length(C)); 
RSI=zeros(1,length(C));
k = find(L0>=L1);
CU(k) = L0(k)-L1(k);
k = find(L0<L1);
CD(k) = L1(k)-L0(k);
k = find(L1>=L2);
CU(k) = CU(k)+L1(k)-L2(k);
k = find(L1<L2);
CD(k) = CD(k)+L2(k)-L1(k);
k = find(L2>=L3);
CU(k) = CU(k)+L2(k)-L3(k);
k = find(L2<L3);
CD(k) = CD(k)+L3(k)-L2(k);
k = find(CU+CD~=0);
RSI(k)=CU(k)./(CU(k)+CD(k));
% updates
XLag.L0p = L0;
XLag.L1p = L1;
XLag.L2p = L2;
XLag.L3p = L3;
out(1,:) = RSI;
end

%{
{Smoothed Adaptive Momentum Strategy - 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 

Inputs: Price((H+L)/2), alpha(.07), Cutoff(8);
Vars: Smooth(0),Cycle(0),Q1(0),I1(0),DeltaPhase(0),MedianDelta(0),DC(0),InstPeriod(0),Period(0),
Num(0),Denom(0),a1(0),b1(0),c1(0),coef1(0),coef2(0),coef3(0),coef4(0),Filt3(0);

Smooth = (Price+2*Price[1]+2*Price[2]+Price[3])/6;
Cycle = (1-.5*alpha)*(1-.5*alpha)*(Smooth-2*Smooth[1]+Smooth[2])+2*(1-alpha)*Cycle[1]-(1-alpha)*(1-alpha)*Cycle[2];
If CurrentBar <7 then Cycle=(Price-2*Price[1]+Price[2])/4;
Q1=(.0962*Cycle+.5769*Cycle[2]-.5769*Cycle[4]-.0962*Cycle[6])*(.5+.08*InstPeriod[1]);
I1 = Cycle[3];
If Q1<>0 and Q1[1]<>0 then DeltaPhase=(I1/Q1-I1[1]/Q1[1])/(1+I1*I1[1]/(Q1*Q1[1]));
If DeltaPhase <0.1 then DeltaPhase=0.1;
If DeltaPhase > 1.1 then DeltaPhase = 1.1;
MedianDelta = Median(DeltaPhase,5);
If MedianDelta =0 then DC=15 else DC=6.28318/MedianDelta+.5;
InstPeriod=.33*DC+.67*InstPeriod[1];
Period=.15*InstPeriod+.85*Period[1];
Value1 = Price-Price[IntPortion(Period-1)];
a1=expvalue(-3.14159/Cutoff);
b1=2*a1*Cosine(1.738*189/Cutoff);
c1=a1*a1;
coef2=b1+c1;
coef3=-(c1+b1*c1);coef4=c1*c1;
coef1=1-coef2-coef3-coef4;
Filt3=coef1*Value1+coef2*Filt3[1]+coef3*Filt3[2]+coef4*Filt3[3];
If CurrentBar<4 then Filt3 = Value1;
If Filt3 Crosses Over 0 then Buy Next Bar on open;
If Filt3 Crosses Under 0 then Sell Next Bar on open;
%}
function out = SmoothAdapMomStrat(H,L)
Price = (H+L)/2;
alpha = 0.07;
Cutoff = 8;
b = [1 2 2 1]/6;
bhp = [0.0962 0 0.5769 0 -0.5769 0 -0.0962];
persistent XSAMom
if isempty(XSAMom)
    XSAMom.prwin = repmat(Price,length(b),1);
    XSAMom.pricewin = repmat(Price,70,1);
    XSAMom.cycwin = repmat(zeros(1,length(H)),length(bhp),1);
    XSAMom.DelPhasewin = repmat(0.5*ones(1,length(H)),5,1);
    XSAMom.smp = Price;
    XSAMom.smpp = Price;
    XSAMom.cycp = zeros(1,length(H));
    XSAMom.cycpp = zeros(1,length(H));
    XSAMom.Q1p = ones(1,length(H));
    XSAMom.I1p = ones(1,length(H));
    XSAMom.a1 = exp(-pi/Cutoff);
    XSAMom.b1 = 2*XSAMom.a1*cos(1.738*pi/180*189/Cutoff);
    XSAMom.Filtp = zeros(1,length(H));
    XSAMom.Filtpp = zeros(1,length(H));
    XSAMom.Filtppp = zeros(1,length(H));
    XSAMom.InstPeriodp = zeros(1,length(H));
    XSAMom.Periodp = zeros(1,length(H));
end
XSAMom.prwin = [Price;XSAMom.prwin(1:end-1,:)];
XSAMom.pricewin = [Price;XSAMom.pricewin(1:end-1,:)];
Smooth = sum(b'.*XSAMom.prwin);
Cycle = (1-.5*alpha)*(1-.5*alpha)*...
    (Smooth-2*XSAMom.smp+XSAMom.smpp)+...
    2*(1-alpha)*XSAMom.cycp -...
    (1-alpha)*(1-alpha)*XSAMom.cycpp;
% XSAMom.smwin = [smooth;XSAMom.smwin(1:end-1,:)];
tmp = 0.5+ 0.08*XSAMom.InstPeriodp;
XSAMom.cycwin = [Cycle;XSAMom.cycwin(1:end-1,:)];
Q1 = sum(bhp'.*XSAMom.cycwin(1:length(bhp),:).*tmp);
I1 = XSAMom.cycwin(4,:);
Q1(Q1==0) = 1;
XSAMom.Q1p(XSAMom.Q1p==0) = 1;
DeltaPhase=(I1./Q1-XSAMom.I1p./XSAMom.Q1p)./...
    (1+I1.*XSAMom.I1p./(Q1.*XSAMom.Q1p));
DeltaPhase = max(0.1*ones(1,length(H)),DeltaPhase);
DeltaPhase = min(1.1*ones(1,length(H)),DeltaPhase);
XSAMom.DelPhasewin = [DeltaPhase;XSAMom.DelPhasewin(1:end-1,:)];
MedianDelta = median(XSAMom.DelPhasewin);
DC = 2*pi./MedianDelta + 0.5;
DC(MedianDelta==0) = 15;
InstPeriod=.33*DC+.67*XSAMom.InstPeriodp;
Period = 0.15*InstPeriod + 0.85*XSAMom.Periodp;
Period(Period<2) = 2;
[nr, nc] = size(XSAMom.pricewin);
rows = floor(Period-1);
tmpVV = XSAMom.pricewin(sub2ind([nr, nc], rows, 1:nc));
Value1 = Price - tmpVV;
c1 = XSAMom.a1*XSAMom.a1;
coef2 = XSAMom.b1 + c1;
coef3 = -(c1 + XSAMom.b1*c1);
coef4 = c1*c1;
coef1 = 1 - coef2 - coef3 - coef4;
Filt3 = coef1*Value1 + ...
    coef2*XSAMom.Filtp+...
    coef3*XSAMom.Filtpp+...
    coef4*XSAMom.Filtppp;
buysell = zeros(1,length(H));
buysell(Filt3>0) = 1; % buy when Filt3>0
buysell(Filt3<0) = -1; % sell when Filt3<0
% updates
XSAMom.smpp = XSAMom.smp;
XSAMom.smp = Smooth;
XSAMom.cycpp = XSAMom.cycp;
XSAMom.cycp = Cycle;
XSAMom.InstPeriodp = InstPeriod;
XSAMom.Periodp = Period;
XSAMom.Filtppp = XSAMom.Filtpp;
XSAMom.Filtpp = XSAMom.Filtp;
XSAMom.Filtp = Filt3;
out(1,:) = Filt3;
out(2,:) = buysell;
end

%{
{Smoothed Adaptive Momentum indicator - 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 

Inputs: Price((H+L)/2), alpha(.07), Cutoff(8);
Smooth = (Price+2*Price[1]+2*Price[2]+Price[3])/6;
Cycle = (1-.5*alpha)*(1-.5*alpha)*(Smooth-2*Smooth[1]+Smooth[2])+2*(1-alpha)*Cycle[1]-(1-alpha)*(1-alpha)*Cycle[2];
If CurrentBar <7 then Cycle=(Price-2*Price[1]+Price[2])/4;
Q1=(.0962*Cycle+.5769*Cycle[2]-.5769*Cycle[4]-.0962*Cycle[6])*(.5+.08*InstPeriod[1]);
I1 = Cycle[3];
If Q1<>0 and Q1[1]<>0 then DeltaPhase=(I1/Q1-I1[1]/Q1[1])/(1+I1*I1[1]/(Q1*Q1[1]));
If DeltaPhase <0.1 then DeltaPhase=0.1;
If DeltaPhase > 1.1 then DeltaPhase = 1.1;
MedianDelta = Median(DeltaPhase,5);
If MedianDelta =0 then DC=15 else DC=6.28318/MedianDelta+.5;
InstPeriod=.33*DC+.67*InstPeriod[1];
Period=.15*InstPeriod+.85*Period[1];
Value1 = Price-Price[IntPortion(Period-1)];
a1=expvalue(-3.14159/Cutoff);
b1=2*a1*Cosine(1.738*189/Cutoff);
c1=a1*a1;
coef2=b1+c1;
coef3=-(c1+b1*c1);coef4=c1*c1;
coef1=1-coef2-coef3-coef4;
Filt3=coef1*Value1+coef2*Filt3[1]+coef3*Filt3[2]+coef4*Filt3[3];
%}
function out = SmoothAdapMomInd(H,L)
Price = (H+L)/2;
alpha = 0.07;
Cutoff = 8;
b = [1 2 2 1]/6;
bhp = [0.0962 0 0.5769 0 -0.5769 0 -0.0962];
persistent XSAMom
if isempty(XSAMom)
    XSAMom.prwin = repmat(Price,length(b),1);
    XSAMom.pricewin = repmat(Price,70,1);
    XSAMom.cycwin = repmat(zeros(1,length(H)),length(bhp),1);
    XSAMom.DelPhasewin = repmat(0.5*ones(1,length(H)),5,1);
    XSAMom.smp = Price;
    XSAMom.smpp = Price;
    XSAMom.cycp = zeros(1,length(H));
    XSAMom.cycpp = zeros(1,length(H));
    XSAMom.Q1p = ones(1,length(H));
    XSAMom.I1p = ones(1,length(H));
    XSAMom.a1 = exp(-pi/Cutoff);
    XSAMom.b1 = 2*XSAMom.a1*cos(1.738*pi/180*189/Cutoff);
    XSAMom.Filtp = zeros(1,length(H));
    XSAMom.Filtpp = zeros(1,length(H));
    XSAMom.Filtppp = zeros(1,length(H));
    XSAMom.InstPeriodp = zeros(1,length(H));
    XSAMom.Periodp = zeros(1,length(H));
end
XSAMom.prwin = [Price;XSAMom.prwin(1:end-1,:)];
XSAMom.pricewin = [Price;XSAMom.pricewin(1:end-1,:)];
Smooth = sum(b'.*XSAMom.prwin);
Cycle = (1-.5*alpha)*(1-.5*alpha)*...
    (Smooth-2*XSAMom.smp+XSAMom.smpp)+...
    2*(1-alpha)*XSAMom.cycp-...
    (1-alpha)*(1-alpha)*XSAMom.cycpp;
% XSAMom.smwin = [smooth;XSAMom.smwin(1:end-1,:)];
tmp = 0.5+ 0.08*XSAMom.InstPeriodp;
XSAMom.cycwin = [Cycle;XSAMom.cycwin(1:end-1,:)];
Q1 = sum(bhp'.*XSAMom.cycwin(1:length(bhp),:).*tmp);
I1 = XSAMom.cycwin(4,:);
Q1(Q1==0) = 1;
XSAMom.Q1p(XSAMom.Q1p==0) = 1;
DeltaPhase=(I1./Q1-XSAMom.I1p./XSAMom.Q1p)./...
    (1+I1.*XSAMom.I1p./(Q1.*XSAMom.Q1p));
DeltaPhase = max(0.1*ones(1,length(H)),DeltaPhase);
DeltaPhase = min(1.1*ones(1,length(H)),DeltaPhase);
XSAMom.DelPhasewin = [DeltaPhase;XSAMom.DelPhasewin(1:end-1,:)];
MedianDelta = median(XSAMom.DelPhasewin);
DC = 2*pi./MedianDelta + 0.5;
DC(MedianDelta==0) = 15;
InstPeriod=.33*DC+.67*XSAMom.InstPeriodp;
Period = 0.15*InstPeriod + 0.85*XSAMom.Periodp;
Period(Period<2) = 2;
[nr, nc] = size(XSAMom.pricewin);
rows = floor(Period-1);
tmpVV = XSAMom.pricewin(sub2ind([nr, nc], rows, 1:nc));
Value1 = Price - tmpVV;
c1 = XSAMom.a1*XSAMom.a1;
coef2 = XSAMom.b1 + c1;
coef3 = -(c1 + XSAMom.b1*c1);
coef4 = c1*c1;
coef1 = 1 - coef2 - coef3 - coef4;
Filt3 = coef1*Value1 + ...
    coef2*XSAMom.Filtp+...
    coef3*XSAMom.Filtpp+...
    coef4*XSAMom.Filtppp;
% updates
XSAMom.smpp = XSAMom.smp;
XSAMom.smp = Smooth;
XSAMom.cycpp = XSAMom.cycp;
XSAMom.cycp = Cycle;
XSAMom.InstPeriodp = InstPeriod;
XSAMom.Periodp = Period;
XSAMom.Filtppp = XSAMom.Filtpp;
XSAMom.Filtpp = XSAMom.Filtp;
XSAMom.Filtp = Filt3;
out(1,:) = Filt3;
end
%{
Ehlers - Rocket Science for Traders
Sinewave Indicator (Figure 9.3)

Inputs:
Price((H+L)/2);

If CurrentBar > 5 Then Begin
Smooth = (4*Price + 3*Price[1] + 2*Price[2] + Price[3]) / 10;
Detrender = (.0962*Smooth + .5769*Smooth[2] - .5769*Smooth[4]
- .0962*Smooth[6])*(.075*Period[1] + .54);

{Compute InPhase and Quadrature components}
Q1 = (.0962*Detrender + .5769*Detrender[2] - .5769*Detrender[4]
- .0962*Detrender[6])*(.075*Period[1] + .54);
I1 = Detrender[3];

{Advance the phase of I1 and Q1 by 90 degrees}
jI = (.0962*I1 + .5769*I1[2] - .5769*I1[4] - .0962*I1[6])*(.075*Period[1] + .54);
JQ = (.0962*Q1 + .5769*Q1[2] - .5769*Q1[4] - .0962*Q1[6])*(.075*Period[1] + .54);

{Phasor addition for 3 bar averaging}
I2 = I1 - JQ;
Q2 = Q1 + jI;

{Smooth the I and Q components before applying the discriminator}
I2 = .2*I2 + .8*I2[1];
Q2 = .2*Q2 + .8*Q2[1];

{Homodyne Discriminator}
Re = I2*I2[1] + Q2*Q2[1];
Im = I2*Q2[1] - Q2*I2[1];
Re = .2*Re + .8*Re[1];
Im = .2*Im + .8*Im[1];

If Im <> 0 And Re <> 0 Then Period = 360/ArcTangent(Im/Re);
If Period > 1.5*Period[1] Then Period = 1.5*Period[1];
If Period < .67*Period[1] Then Period = .67*Period[1];
If Period < 6 Then Period = 6;
If Period > 50 Then Period = 50;
Period = .2*Period + .8*Period[1];
SmoothPeriod = .33*Period + .67*SmoothPeriod[1];

{Compute Dominant Cycle Phase}
SmoothPrice = (4*price + 3*Price[1] + 2*Price[2] + Price[3]) / 10;
DCPeriod = IntPortion(SmoothPeriod + .5);
RealPart = 0;
ImagPart = 0;

For count = 0 To DCPeriod - 1 Begin
RealPart = RealPart + Sine(360*count/DCPeriod)*(SmoothPrice[count]);
ImagPart = ImagPart + CoSine(360*count/DCPeriod)*(SmoothPrice[count]);
End;

If AbsValue(ImagPart) > 0 Then DCPhase = Arctangent(RealPart/ImagPart);
If AbsValue(ImagPart) <= .001 Then DCPhase = DCPhase + 90*Sign(RealPart);
DCPhase = DCPhase + 90;

{Compensate for one bar lag of the Weighted Moving Average}
DCPhase = DCPhase + 360 / SmoothPeriod;

If ImagPart < 0 Then DCPhase = DCPhase + 180;
If DCPhase > 315 Then DCPhase = DCPhase - 360;

Plot1(Sine(DCPhase), "Sine");
Plot2(Sine(DCPhase + 45), "LeadSine");
%}
function out = EhlersSWInd_v1(H,L)
Price = (H+L)/2;
b = [4 3 2 1]/10;
bhp = [0.0962 0 0.5769 0 -0.5769 0 -0.0962];
persistent XSWindV1
if isempty(XSWindV1)
    XSWindV1.prwin = repmat(Price,length(b),1);
    XSWindV1.smwin = repmat(Price,length(bhp),1);
    XSWindV1.smprwin = repmat(Price,70,1);
    XSWindV1.detrendwin = repmat(zeros(1,length(H)),length(bhp),1);
    XSWindV1.I1win = repmat(zeros(1,length(H)),length(bhp),1);
    XSWindV1.Q1win = repmat(zeros(1,length(H)),length(bhp),1);
    XSWindV1.Periodp = 15*ones(1,length(H));
    XSWindV1.smPeriodp = 15*ones(1,length(H));
    XSWindV1.I2p = zeros(1,length(H));
    XSWindV1.Q2p = zeros(1,length(H));
    XSWindV1.Rep = zeros(1,length(H));
    XSWindV1.Imp = zeros(1,length(H));
end
XSWindV1.prwin = [Price;XSWindV1.prwin(1:end-1,:)];
Smooth = sum(b'.*XSWindV1.prwin);
XSWindV1.smwin = [Smooth;XSWindV1.smwin(1:end-1,:)];
tmp = 0.075*XSWindV1.Periodp + 0.54;
Detrender = sum(bhp'.*XSWindV1.smwin.*tmp);
XSWindV1.detrendwin = [Detrender;XSWindV1.detrendwin(1:end-1,:)];
% Compute InPhase and Quadrature components
Q1 = sum(bhp'.*XSWindV1.detrendwin.*tmp);
I1 = XSWindV1.detrendwin(4,:);
XSWindV1.Q1win = [Q1;XSWindV1.Q1win(1:end-1,:)];
XSWindV1.I1win = [I1;XSWindV1.I1win(1:end-1,:)];
% Advance the phase of I1 and Q1 by 90 degrees
JI = sum(bhp'.*XSWindV1.I1win.*tmp);
JQ = sum(bhp'.*XSWindV1.Q1win.*tmp);
% Phasor addition for 3 bar averaging
I2 = I1 - JQ;
Q2 = Q1 + JI;
% Smooth the I and Q components before applying the discriminator
I2 = .2*I2 + .8*XSWindV1.I2p;
Q2 = .2*Q2 + .8*XSWindV1.Q2p;
% {Homodyne Discriminator}
Re = I2.*XSWindV1.I2p + Q2.*XSWindV1.Q2p;
Im = I2.*XSWindV1.Q2p - Q2.*XSWindV1.I2p;
Re = .2*Re + .8*XSWindV1.Rep;
Im = .2*Im + .8*XSWindV1.Imp;

Im(Im==0) = 0.1;
Re(Re==0) = 0.1;
Period = 2*pi./atan(Im./Re);
% If Im <> 0 And Re <> 0 Then Period = 360/ArcTangent(Im/Re);
Period = min(1.5*XSWindV1.Periodp,Period);
Period = max(0.67*XSWindV1.Periodp,Period);
Period = max(6,Period);
Period = min(50,Period);
Period = .2*Period + .8*XSWindV1.Periodp;
SmoothPeriod = .33*Period + .67*XSWindV1.smPeriodp;
% {Compute Dominant Cycle Phase}
SmoothPrice = sum(b'.*XSWindV1.prwin);
XSWindV1.smprwin = [SmoothPrice;XSWindV1.smprwin(1:end-1,:)];
DCPeriod = floor(SmoothPeriod + .5);
RealPart = zeros(1,length(H));
ImagPart = zeros(1,length(H));
for count = 1:DCPeriod
    RealPart = RealPart + ...
        sin(2*pi*count./DCPeriod).*XSWindV1.smprwin(count,:);
    ImagPart = ImagPart + ...
        cos(2*pi*count./DCPeriod).*XSWindV1.smprwin(count,:);
end
idxIPlarge = find(abs(ImagPart)>0.001);
idxIPsmall = find(abs(ImagPart)<=0.001);
DCPHase(idxIPlarge) = ...
    atan(RealPart(idxIPlarge) ./ ImagPart(idxIPlarge));
DCPHase(idxIPsmall) = pi/2*sign(RealPart(idxIPsmall));
DCPHase = DCPHase + pi/2;
% {Compensate for one bar lag of the Weighted Moving Average}
DCPHase = DCPHase + 2*pi./ SmoothPeriod;
idxIP_0 = find(ImagPart<0.0);
idxIP_315 = find(DCPHase>315/180*pi);
DCPHase(idxIP_0) = DCPHase(idxIP_0) + pi;
DCPHase(idxIP_315) = DCPHase(idxIP_315) - 2*pi;
Sine = sin(DCPHase);
LeadSine = sin(DCPHase+pi/4);

% updates
XSWindV1.Periodp = Period;
XSWindV1.smPeriodp = SmoothPeriod;
XSWindV1.Q2p = Q2;
XSWindV1.I2p = I2;
out(1,:) = Sine;
out(2,:) = LeadSine; 
out(3,:) = SmoothPrice; 
out(4,:) = Detrender; 
end
%{
{Laguerre Filter (four elements) with FIR filter for comparison -
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 

Input: Price((H+L)/2), gamma(.8);
Var: L0(0), L1(0), L2(0), L3(0), Filt(0), FIR(0);
L0=(1-gamma)*Price+gamma*L0[1];
L1=-gamma*L0+L0[1]+gamma*L1[1];
L2=-gamma*L1+L1[1]+gamma*L2[1];
L3=-gamma*L2+L2[1]+gamma*L3[1];
FIlt=(L0+2*L1+2*L1+L3)/6;
FIR=(Price+2*Price[1]+2*Price[2]+Price[3])/6;

{The green generalized finite impulse response filter (FIR) has very little lag but is very whippy.
The Laguerre filter (same length) has virtually the same crossing signals but is much smoother due
to the introduction of the dampening factor (gamma).
If you set gamma to 0 Laguerre will be identical to the FIR filter.
This filter can be used to dampen other indicators with similar results.}
%}
function out = Laguerre(H,L)
Price = (H+L)/2;
gamma = 0.8;
b = [1 2 2 1]/6;
persistent XLag
if isempty(XLag)
    XLag.L0p = Price;
    XLag.L1p = Price;
    XLag.L2p = Price;
    XLag.L3p = Price;
    XLag.prwin = repmat(Price,length(b),1);
end
L0 = (1-gamma)*Price + gamma*XLag.L1p;
L1 = -gamma*L0 + XLag.L0p + gamma*XLag.L1p;
L2 = -gamma*L1 + XLag.L1p + gamma*XLag.L2p;
L3 = -gamma*L2 + XLag.L2p + gamma*XLag.L3p;
Filt = (L0+2*L1+2*L1+L3)/6;
XLag.prwin = [Price;XLag.prwin(1:end-1,:)];
FIR = sum(b'.*XLag.prwin);
% FIR=(Price+2*Price[1]+2*Price[2]+Price[3])/6;
% updates
XLag.L0p = L0;
XLag.L1p = L1;
XLag.L2p = L2;
XLag.L3p = L3;
out(1,:) = Filt;
out(2,:) = FIR;
end
%{
{3 Pole Super Smoother - 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 

Input: Price((H+L)/2), Period(15);
Var: a1(0), b1(0), c1(0), coef1(0), coef2(0), coef3(0), coef4(0), Filt3(0);
a1=expvalue(-3.14159/Period);
b1=2*a1*Cosine(1.738*180/Period);
c1=a1*a1;
coef2=b1+c1;
coef3=-(c1+b1*c1);
coef4=c1*c1;
coef1=1-coef2-coef3-coef4;
Filt3 = coef1*Price+coef2*Filt3[1]+coef3*Filt3[2]+coef4*Filt3[3];
%}
function out = Ehlers3poleSS(H,L)
Price = (H+L)/2;
Period = 15;

persistent X3poleSS
if isempty(X3poleSS)
    X3poleSS.filtp = Price;
    X3poleSS.filtpp = Price;
    X3poleSS.filtppp = Price;
    X3poleSS.a1 = exp(-pi/Period);
    X3poleSS.b1 = 2*X3poleSS.a1*cos(1.738*pi/2/Period);
    X3poleSS.c1 = X3poleSS.a1*X3poleSS.a1;
end
coef2 = X3poleSS.b1 + X3poleSS.c1;
coef3 = -(X3poleSS.c1 + X3poleSS.b1*X3poleSS.c1);
coef4 = X3poleSS.c1*X3poleSS.c1;
coef1 = 1 - coef2 - coef3 - coef4;
Filt = coef1*Price+...
    coef2*X3poleSS.filtp+coef3*X3poleSS.filtpp+...
    coef4*X3poleSS.filtppp;
% updates
X3poleSS.filtppp = X3poleSS.filtpp;
X3poleSS.filtpp = X3poleSS.filtp;
X3poleSS.filtp = Filt;
out = Filt;
end

%{
{2 Pole Super Smoother - 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 
} 

Input: Price((H+L)/2), Period(15);
Var: a1(0), b1(0), coef1(0), coef2(0), coef3(0), Filt2(0);

a1=expvalue(-1.414*3.14159/Period);
b1=2*a1*Cosine(1.414*180/Period);
coef2=b1;
coef3=-a1*a1;
coef1=1-coef2-coef3;;
Filt2 = coef1*Price+coef2*Filt2[1]+coef3*Filt2[2];
%}
function out = Ehlers2polesuperSm(H,L)
Price = (H+L)/2;
Period = 15;

persistent X2pole
if isempty(X2pole)
    X2pole.filtp = Price;
    X2pole.filtpp = Price;
    X2pole.a1 = exp(-1.414*pi/Period);
    X2pole.b1 = 2*X2pole.a1*cos(1.414*pi/2/Period);
end
coef2 = X2pole.b1;
coef3 = -X2pole.a1*X2pole.a1;
coef1=1 - coef2 - coef3;
Filt2 = coef1*Price + ...
    coef2*X2pole.filtp + coef3*X2pole.filtpp;
% updates
X2pole.filtpp = X2pole.filtp;
X2pole.filtp = Filt2;
out = Filt2;
end
%{
{3 Pole Butterworth Filter - //// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers //// code compiled by dn
} // plot on a subgraph separate from the price region.

Input: Price((H+L)/2), Period(15);
Var: a1(0), b1(0), c1(0), coef1(0), coef2(0), coef3(0), coef4(0), Butter(0);

a1=expvalue(-3.14159/Period);
b1=2*a1*Cosine(1.738*180/Period);
c1=a1*a1;
coef2=b1+c1;
coef3=-(c1+b1*c1);
coef4=c1*c1;
coef1=(1-b1+c1)*(1-c1)/8;

Butter = coef1*(Price+3*Price[1]+3*Price[2]+Price[3])+coef2*Butter[1]+coef3*Butter[2]+coef4*Butter[3];
If CurrentBar<4 then Butter=Price;
Plot1(Butter,"Butter",blue);
%}
function out = Ehlers3poleButter(H,L)
Price = (H+L)/2;
Period = 15;

persistent X3pole
if isempty(X3pole)
    X3pole.prp = Price;
    X3pole.prpp = Price;
    X3pole.prppp = Price;
    X3pole.Butterp = Price;
    X3pole.Butterpp = Price;
    X3pole.Butterppp = Price;
    X3pole.a1 = exp(-pi/Period);
    X3pole.b1 = 2*X3pole.a1*cos(1.738*pi/2/Period);
    X3pole.c1 = X3pole.a1*X3pole.a1;
end
coef2 = X3pole.b1 + X3pole.c1;
coef3 = -(X3pole.c1 + X3pole.b1*X3pole.c1);
coef4 = X3pole.c1*X3pole.c1;
coef1 = (1-X3pole.b1+X3pole.c1)*(1-X3pole.c1)/8;
Butter = coef1*(Price+3*X3pole.prp+3*X3pole.prpp+X3pole.prppp)+...
    coef2*X3pole.Butterp+coef3*X3pole.Butterpp+...
    coef4*X3pole.Butterppp;
% updates
X3pole.prppp = X3pole.prpp;
X3pole.prpp = X3pole.prp;
X3pole.prp = Price;
X3pole.Butterppp = X3pole.Butterpp;
X3pole.Butterpp = X3pole.Butterp;
X3pole.Butterp = Butter;
out = Butter;
end
%{
{2 Pole Butterworth Filter - 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 
} 

Input: Price((H+L)/2), Period(15);
Var: a1(0), b1(0), coef1(0), coef2(0), coef3(0), Butter(0);

a1=expvalue(-1.414*3.14159/Period);
b1=2*a1*Cosine(1.414*180/Period);
coef2=b1;
coef3=-a1*a1;
coef1=(1-b1+a1*a1)/4;
Butter = coef1*(Price+2*Price[1]+Price[2])+ coef2*Butter[1] + coef3*Butter[2];
If CurrentBar<3 then Butter=Price;
Plot1(Butter,"Butter");
%}
function out = Ehlers2poleButter(H,L)
Price = (H+L)/2;
Period = 15;

persistent X2pole
if isempty(X2pole)
    X2pole.prp = Price;
    X2pole.prpp = Price;
    X2pole.Butterp = Price;
    X2pole.Butterpp = Price;
    X2pole.a1 = exp(-1.414*3.14159/Period);
    X2pole.b1 = 2*X2pole.a1*cos(1.414*pi/2/Period);
end
coef2 = X2pole.b1;
coef3 = -X2pole.a1*X2pole.a1;
coef1=(1-X2pole.b1+X2pole.a1*X2pole.a1)/4;
Butter = coef1*(Price+2*X2pole.prp+X2pole.prpp)+ ...
    coef2*X2pole.Butterp + coef3*X2pole.Butterpp;
% updates
X2pole.prpp = X2pole.prp;
X2pole.prp = Price;
X2pole.Butterpp = X2pole.Butterp;
X2pole.Butterp = Butter;
out = Butter;
end

%{
{Sine Wave indicator - //// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers //// code compiled by dn
} // plot on a subgraph separate from the price region.

Inputs: Price((H+L)/2), alpha(.07);

Vars: Smooth(0),Cycle(0),I1(0),Q1(0),I2(0),Q2(0),DeltaPhase(0),MedianDelta(0),MaxAmp(0),AmpFix(0),Re(0),Im(0),DC(0),
alpha1(0),InstPeriod(0),DCPeriod(0),count(0),SmoothCycle(0),RealPart(0),ImagPart(0),DCPhase(0);

Smooth = (Price+2*Price[1]+2*Price[2]+Price[3])/6;
Cycle = (1-.5*alpha)*(1-.5*alpha)*(Smooth-2*Smooth[1]+Smooth[2])+2*(1-alpha)*Cycle[1]-(1-alpha)*(1-alpha)*Cycle[2];
If CurrentBar <7 then Cycle=(Price-2*Price[1]+Price[2])/4;
Q1=(.0962*Cycle+.5769*Cycle[2]-.5769*Cycle[4]-.0962*Cycle[6])*(.5+.08*InstPeriod[1]);
I1 = Cycle[3];
If Q1<>0 and Q1[1]<>0 then DeltaPhase=(I1/Q1-I1[1]/Q1[1])/(1+I1*I1[1]/(Q1*Q1[1]));
If DeltaPhase <0.1 then DeltaPhase=0.1;
If DeltaPhase > 1.1 then DeltaPhase = 1.1;
MedianDelta = Median(DeltaPhase,5);
If MedianDelta =0 then DC=15 else DC=6.28318/MedianDelta+.5;
InstPeriod=.33*DC+.67*InstPeriod[1];
Value1 = .15*InstPeriod+.85*Value1[1];
DCPeriod = IntPortion(Value1);
RealPart = 0;
ImagPart = 0;
For count = 0 To DCPeriod - 1 begin
RealPart = RealPart + Sine(360 * count / DCPeriod) * (Cycle[count]);
ImagPart = ImagPart + Cosine(360 * count / DCPeriod) * (Cycle[count]);
End;
If AbsValue(ImagPart) > 0.001 then DCPhase = Arctangent(RealPart / ImagPart);
If AbsValue(ImagPart) <= 0.001 then DCPhase = 90 * Sign(RealPart);

DCPhase = DCPhase + 90;
If ImagPart < 0 then DCPhase = DCPhase + 180;
If DCPhase > 315 then DCPhase = DCPhase - 360;

Plot1(Sine(DCPhase), "Sine",blue);
Plot2(Sine(DCPhase + 45), "LeadSine",green);

{Note: This indicator tries to determine the current phase of the cycles you are in. A sinewave indicator has an advantage over
other oscillators such as RSI and Stochastic because it predicts rather than waits for confirmation. This assumes that the measured
phase has existed at least briefly in the past and will continue at least briefly into the future.
The phase languishes when the market is in a trend mode, and can even have a negative rate of change.
This indicator gives entry and exit signals 1/16th of a cycle period in advance of the cycle turning point
and seldom gives false whipsaw signals when the market is in a trend mode.}
%}
function out = ElhSineWave(H,L)
persistent XehlSW
bhp = [0.0962 0 0.5769 0 -0.5769 0 -0.0962];
bs = [1 2 2 1]/6;
tp = (H+L)/2;
alpha = 0.07;
if isempty(XehlSW)
    XehlSW.prwin = repmat(tp,7,1);
    XehlSW.ITrendwin = repmat(tp,7,1);
    XehlSW.smwin = repmat(tp,7,1);
    XehlSW.smPricewin = repmat(tp,50,1);
    XehlSW.Pricewin = repmat(tp,50,1);
    XehlSW.cycwin = zeros(70,length(H));
    XehlSW.DelPhasewin = ones(5,length(H));
    XehlSW.I1win = zeros(7,length(H));
    XehlSW.Q1win = zeros(7,length(H));
    XehlSW.smp = tp;
    XehlSW.smpp = tp;
    XehlSW.cycp = 0*tp;
    XehlSW.cycpp = 0*tp;
    XehlSW.I1p = ones(1,length(H));
    XehlSW.Q1p = ones(1,length(H));
    XehlSW.I2p = ones(1,length(H));
    XehlSW.Q2p = ones(1,length(H));
    XehlSW.Rep = ones(1,length(H));
    XehlSW.Imp = ones(1,length(H));
    XehlSW.InstPeriodp = 15*ones(1,length(H));
    XehlSW.Val1p = 15*ones(1,length(H));
    XehlSW.Periodp = 15*ones(1,length(H));
    XehlSW.smPeriodp = 15*ones(1,length(H));
    XehlSW.Value1p = 15*ones(1,length(H));
    XehlSW.DCPhasep = 1*ones(1,length(H));
end
XehlSW.prwin = [tp;XehlSW.prwin(1:end-1,:)];
smooth = sum(bs'.*XehlSW.prwin(1:4,:));
Cycle = (1-.5*alpha)*(1-.5*alpha)*...
    (smooth-2*XehlSW.smp+XehlSW.smpp)+...
    2*(1-alpha)*XehlSW.cycp-...
    (1-alpha)*(1-alpha)*XehlSW.cycpp;
XehlSW.smwin = [smooth;XehlSW.smwin(1:end-1,:)];
tmp = 0.5+ 0.08*XehlSW.InstPeriodp;
XehlSW.cycwin = [Cycle;XehlSW.cycwin(1:end-1,:)];
Q1 = sum(bhp'.*XehlSW.cycwin(1:length(bhp),:).*tmp);
I1 = XehlSW.cycwin(4,:);
Q1(Q1==0) = 1;
XehlSW.Q1p(XehlSW.Q1p==0) = 1;
DeltaPhase=(I1./Q1-XehlSW.I1p./XehlSW.Q1p)./...
    (1+I1.*XehlSW.I1p./(Q1.*XehlSW.Q1p));
DeltaPhase = max(0.1*ones(1,length(H)),DeltaPhase);
DeltaPhase = min(1.1*ones(1,length(H)),DeltaPhase);
XehlSW.DelPhasewin = [DeltaPhase;XehlSW.DelPhasewin(1:end-1,:)];
MedianDelta = median(XehlSW.DelPhasewin);
DC = 2*pi./MedianDelta + 0.5;
DC(MedianDelta==0) = 15;
InstPeriod=.33*DC+.67*XehlSW.InstPeriodp;
Value1 = 0.15*InstPeriod + 0.85*XehlSW.Val1p;
DCPeriod = floor(Value1);
RealPart = zeros(1,length(H));
ImagPart = zeros(1,length(H));
for count = 1:max(DCPeriod)
    RealPart = RealPart + ...
        sin(2*pi * count ./ DCPeriod).*XehlSW.cycwin(count,:);
    ImagPart = ImagPart + ...
        cos(2*pi * count ./ DCPeriod).*XehlSW.cycwin(count,:);
end
idxIPlarge = find(abs(ImagPart)>0.001);
idxIPsmall = find(abs(ImagPart)<=0.001);
DCPHase(idxIPlarge) = ...
    atan(RealPart(idxIPlarge) ./ ImagPart(idxIPlarge));
DCPHase(idxIPsmall) = pi/2*sign(RealPart(idxIPsmall));
DCPHase = DCPHase + pi/2;
idxIP_0 = find(ImagPart<0.0);
idxIP_315 = find(DCPHase>315/180*pi);
DCPHase(idxIP_0) = DCPHase(idxIP_0) + pi;
DCPHase(idxIP_315) = DCPHase(idxIP_315) - 2*pi;
Sine = sin(DCPHase);
LeadSine = sin(DCPHase+pi/4);

% updates
XehlSW.cycpp = XehlSW.cycp;
XehlSW.cycp = Cycle;
XehlSW.smpp = XehlSW.smp;
XehlSW.smp = smooth;
XehlSW.InstPeriodp = InstPeriod;
XehlSW.Val1p = Value1;
XehlSW.I1p = I1;
XehlSW.Q1p = Q1;
XehlSW.DCPhasep = DCPHase;

out(1,:) = smooth;
out(2,:) = Cycle;
out(3,:) = Sine;
out(4,:) = LeadSine;
out(5,:) = DeltaPhase;
out(6,:) = DC;
out(7,:) = DCPHase;
end

%{
{Adaptive RVI indicator - //// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers //// code compiled by dn
} // plot on a subgraph separate from the price region

Inputs: Price((H+L)/2), alpha(.07);
Vars: Smooth(0),Cycle(0),Q1(0),I1(0),DeltaPhase(0),MedianDelta(0),DC(0),InstPeriod(0),Period(0),
Count(0),Length(0),Num(0),Denom(0),RVI(0),MaxRVI(0),MinRVI(0);

Smooth = (Price + 2*Price[1] + 2*Price[2] + Price[3])/6;
Cycle=(1-.5*alpha)*(1-.5*alpha)*(Smooth-2*Smooth[1]+Smooth[2])+2*(1-alpha)*Cycle[1]-(1-alpha)*(1-alpha)*Cycle[2];
If currentbar<7 then Cycle = (Price-2*Price[1]+Price[2])/4;
Q1=(.0962*Cycle+.5769*Cycle[2]-.5769*Cycle[4]-.0962*Cycle[6])*(.5+.08*InstPeriod[1]);
I1 = Cycle[3];
If Q1<>0 and Q1[1]<>0 then DeltaPhase=(I1/Q1-I1[1]/Q1[1])/(1+I1*I1[1]/(Q1*Q1[1]));
If DeltaPhase <0.1 then Deltaphase = 0.1;
If DeltaPhase >1.1 then Deltaphase = 1.1;
MedianDelta = Median(DeltaPhase,5);
If MedianDelta = 0 then DC = 15 else DC = 6.28318/MedianDelta + .5;
InstPeriod = .33*DC + .67*InstPeriod[1];
Period = .15*InstPeriod+.85*Period[1];
Length = intportion((4*Period+3*Period[1]+2*Period[3]+Period[4])/20);
Value1=((Close-Open)+2*(Close[1]-Open[1])+2*(Close[2]-Open[2])+(Close[3]-Open[3]))/6;
Value2=((High-Low)+2*(High[1]-Low[1])+2*(High[2]-Low[2])+(High[3]-Low[3]))/6;
Num = 0;
Denom = 0;
For Count = 0 to Length - 1 begin
Num = Num + Value1[count];
Denom = Denom + Value2[count]; End;
If Denom <> 0 then RVI = Num/Denom;
Plot1(RVI,"RVI",blue);
Plot2(RVI[1],"Trigger",green);
%}
function out = EhlersAdapRVI(C,O,H,L)
Price = (H+L)/2;
alpha = 0.07;
b = [1 2 2 1]/6;
b20 = [4 3 2 1]/20;
bhp = [0.0962 0 0.5769 0 -0.5769 0 0.0962];
persistent XAdapRVI
if isempty(XAdapRVI)
    XAdapRVI.prwin = repmat(Price,50,1);
    XAdapRVI.cyc1win = repmat(zeros(1,length(H)),length(bhp),1);
    XAdapRVI.DelPhase = repmat(0.5*ones(1,length(H)),5,1);
    XAdapRVI.smp = Price;
    XAdapRVI.smpp = Price;
    XAdapRVI.Q1p = ones(1,length(H));
    XAdapRVI.I1p = ones(1,length(H));
    XAdapRVI.InstPeriodp = 15*ones(1,length(H));
    XAdapRVI.Periodwin = repmat(15*ones(1,length(H)),length(b20),1);
    XAdapRVI.Val1p = 15*ones(1,length(H));
    XAdapRVI.RVIp = 0*ones(1,length(H));
    XAdapRVI.cowin = repmat(C-O,length(b),1);
    XAdapRVI.hlwin = repmat(H-L,length(b),1);
    XAdapRVI.Val1win = repmat(C-O,50,1);
    XAdapRVI.Val2win = repmat(H-L,50,1);
end
XAdapRVI.prwin = [Price;XAdapRVI.prwin(1:end-1,:)];
XAdapRVI.cowin = [C-O;XAdapRVI.cowin(1:end-1,:)];
XAdapRVI.hlwin = [H-L;XAdapRVI.hlwin(1:end-1,:)];
Smooth = sum(b'.*XAdapRVI.prwin(1:length(b),:));
Cycle = (1 - .5*alpha)*(1 - .5*alpha)*...
    (Smooth - 2*XAdapRVI.smp + XAdapRVI.smpp) ...
    + 2*(1-alpha)*XAdapRVI.cyc1win(1,:) - ...
    (1 - alpha)*(1-alpha)*XAdapRVI.cyc1win(2,:);
XAdapRVI.cyc1win = [Cycle;XAdapRVI.cyc1win(1:end-1,:)];
tmp = (.5+.08*XAdapRVI.InstPeriodp);
Q1 = sum(bhp'.*XAdapRVI.cyc1win.*tmp);
I1 = XAdapRVI.cyc1win(3,:);
Q1(Q1==0) = 0.1;
XAdapRVI.Q1p(XAdapRVI.Q1p==0) = 0.1;
DeltaPhase = (I1./Q1 - XAdapRVI.I1p./XAdapRVI.Q1p) ./ ...
    (1 + I1.*XAdapRVI.I1p./(Q1.*XAdapRVI.Q1p));
DeltaPhase(DeltaPhase<0.1) = 0.1;
DeltaPhase(DeltaPhase>1.1) = 1.1;
XAdapRVI.DelPhase = [DeltaPhase;XAdapRVI.DelPhase(1:end-1,:)];
MedianDelta = median(XAdapRVI.DelPhase);
DC(MedianDelta==0) = 15;
DC(MedianDelta~=0) = 6.28318 ./ MedianDelta + .5;
InstPeriod = .33*DC + .67*XAdapRVI.InstPeriodp;
Period = .15*InstPeriod+.85*XAdapRVI.Periodwin(1,:);
XAdapRVI.Periodwin = [Period;XAdapRVI.Periodwin(1:end-1,:)];
Length = floor(sum(b20'.*XAdapRVI.Periodwin));
Value1 = sum(b'.*XAdapRVI.cowin);
Value2 = sum(b'.*XAdapRVI.hlwin);
XAdapRVI.Val1win = [Value1;XAdapRVI.Val1win(1:end-1,:)];
XAdapRVI.Val2win = [Value2;XAdapRVI.Val2win(1:end-1,:)];

Num = zeros(1,length(H));
Denom = ones(1,length(H));
for count = 1:Length
    Num = Num + (0+count)*XAdapRVI.Val1win(count,:);
    Denom = Denom + XAdapRVI.Val2win(count,:);
end
RVI(Denom~=0) = -Num./Denom;
Trigger = XAdapRVI.RVIp;
% updates
XAdapRVI.smpp = XAdapRVI.smp;
XAdapRVI.smp = Smooth;
XAdapRVI.Q1p = Q1;
XAdapRVI.I1p = I1;
XAdapRVI.InstPeriodp = InstPeriod;
XAdapRVI.Val1p = Value1;
XAdapRVI.RVIp = RVI;
out(1,:) = Smooth;
out(2,:) = Q1;
out(3,:) = I1;
out(4,:) = InstPeriod;
out(5,:) = RVI;
out(6,:) = Trigger;
end

%{
{Adaptive Center of Gravity indicator - 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers 
}
Inputs: Price((H+L)/2), alpha(.07);
Vars: Smooth(0),Cycle(0),Q1(0),I1(0),DeltaPhase(0),MedianDelta(0),DC(0),InstPeriod(0),Period(0),
Count(0),Num(0),Denom(0),CG(0),IntPeriod(0);

Smooth = (Price + 2*Price[1] + 2*Price[2] + Price[3])/6;
Cycle=(1-.5*alpha)*(1-.5*alpha)*(Smooth-2*Smooth[1]+Smooth[2])+2*(1-alpha)*Cycle[1]-(1-alpha)*(1-alpha)*Cycle[2];
If currentbar<7 then Cycle = (Price-2*Price[1]+Price[2])/4;
Q1=(.0962*Cycle+.5769*Cycle[2]-.5769*Cycle[4]-.0962*Cycle[6])*(.5+.08*InstPeriod[1]);
I1 = Cycle[3];
If Q1<>0 and Q1[1]<>0 then DeltaPhase=(I1/Q1-I1[1]/Q1[1])/(1+I1*I1[1]/(Q1*Q1[1]));
If DeltaPhase <0.1 then Deltaphase = 0.1;
If DeltaPhase >1.1 then Deltaphase = 1.1;
MedianDelta = Median(DeltaPhase,5);
If MedianDelta = 0 then DC = 15 else DC = 6.28318/MedianDelta + .5;
InstPeriod = .33*DC + .67*InstPeriod[1];
Value1 = .15*InstPeriod + .85*Value1[1];
IntPeriod = intportion(Value1/2);
Num = 0;
Denom = 0;
For Count = 0 to IntPeriod - 1 begin
Num = Num + (1+Count)*(Price[count]);
Denom = Denom + (Price[count]); End;
If Denom <> 0 then CG = -Num/Denom + (IntPeriod + 1)/2;
Plot2(CG[1],"Trigger",green);
%}
function out = EhlersAdapCG(H,L)
Price = (H+L)/2;
alpha = 0.07;
b = [1 2 2 1]/6;
bhp = [0.0962 0 0.5769 0 -0.5769 0 0.0962];
persistent XAdapCG
if isempty(XAdapCG)
    XAdapCG.prwin = repmat(Price,50,1);
    XAdapCG.cyc1win = repmat(zeros(1,length(H)),length(bhp),1);
    XAdapCG.DelPhase = repmat(0.5*ones(1,length(H)),5,1);
    XAdapCG.smp = Price;
    XAdapCG.smpp = Price;
    XAdapCG.Q1p = ones(1,length(H));
    XAdapCG.I1p = ones(1,length(H));
    XAdapCG.InstPeriodp = 15*ones(1,length(H));
    XAdapCG.Val1p = 15*ones(1,length(H));
    XAdapCG.CGp = 15*ones(1,length(H));
end
XAdapCG.prwin = [Price;XAdapCG.prwin(1:end-1,:)];
Smooth = sum(b'.*XAdapCG.prwin(1:length(b),:));
Cycle = (1 - .5*alpha)*(1 - .5*alpha)*...
    (Smooth - 2*XAdapCG.smp + XAdapCG.smpp) ...
    + 2*(1-alpha)*XAdapCG.cyc1win(1,:) - ...
    (1 - alpha)*(1-alpha)*XAdapCG.cyc1win(2,:);
XAdapCG.cyc1win = [Cycle;XAdapCG.cyc1win(1:end-1,:)];
tmp = (.5+.08*XAdapCG.InstPeriodp);
Q1 = sum(bhp'.*XAdapCG.cyc1win.*tmp);
I1 = XAdapCG.cyc1win(3,:);
Q1(Q1==0) = 0.1;
XAdapCG.Q1p(XAdapCG.Q1p==0) = 0.1;
DeltaPhase = (I1./Q1 - XAdapCG.I1p./XAdapCG.Q1p) ./ ...
    (1 + I1.*XAdapCG.I1p./(Q1.*XAdapCG.Q1p));
DeltaPhase(DeltaPhase<0.1) = 0.1;
DeltaPhase(DeltaPhase>1.1) = 1.1;
XAdapCG.DelPhase = [DeltaPhase;XAdapCG.DelPhase(1:end-1,:)];
MedianDelta = median(XAdapCG.DelPhase);
DC(MedianDelta==0) = 15;
DC(MedianDelta~=0) = 6.28318 ./ MedianDelta + .5;
InstPeriod = .33*DC + .67*XAdapCG.InstPeriodp;
Value1 = .15*InstPeriod + .85*XAdapCG.Val1p;
IntPeriod = floor(Value1/2);
Num = zeros(1,length(H));
Denom = ones(1,length(H));
for count = 1:IntPeriod
    Num = Num + (0+count)*XAdapCG.prwin(count,:);
    Denom = Denom + XAdapCG.prwin(count,:);
end
CG(Denom~=0) = -Num./Denom + (IntPeriod + 1)/2;
Trigger = XAdapCG.CGp;
% updates
XAdapCG.smpp = XAdapCG.smp;
XAdapCG.smp = Smooth;
XAdapCG.Q1p = Q1;
XAdapCG.I1p = I1;
XAdapCG.InstPeriodp = InstPeriod;
XAdapCG.Val1p = Value1;
XAdapCG.CGp = CG;
out(1,:) = Smooth;
out(2,:) = Q1;
out(3,:) = I1;
out(4,:) = InstPeriod;
out(5,:) = CG;
out(6,:) = Trigger;
end

%{
{Adaptive Cyber Cycle indicator - //// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers //// code compiled by dn
} // plot on a subgraph separate from the price region

Inputs: Price((H+L)/2), alpha(.07);
Vars: Smooth(0),Cycle(0),Q1(0),I1(0),DeltaPhase(0),MedianDelta(0),DC(0),InstPeriod(0),Period(0),
Length(0),Num(0),Denom(0),alpha1(0),AdaptCycle(0);

Smooth = (Price + 2*Price[1] + 2*Price[2] + Price[3])/6;

Cycle = (1 - .5*alpha)*(1 - .5*alpha)*(Smooth - 2*Smooth[1] + Smooth[2]) + 2*(1-alpha)*Cycle[1] - (1 - alpha)*(1-alpha)*Cycle[2];
If currentbar < 7 then Cycle = (Price - 2*Price[1] + Price[2])/4;
Q1 = (.0962*Cycle + .5769*Cycle[2] - .5769*Cycle[4] - .0962*Cycle[6])*(.5+.08*InstPeriod[1]);
I1 = Cycle[3];
If Q1 <> 0 and Q1[1] <> 0 then DeltaPhase = (I1/Q1 - I1[1]/Q1[1]) / (1 + I1*I1[1]/(Q1*Q1[1]));
If DeltaPhase < 0.1 then DeltaPhase = 0.1;
If DeltaPhase > 1.1 then DeltaPhase = 1.1;
MedianDelta = Median(DeltaPhase,5);
If MedianDelta = 0 then DC = 15 else DC = 6.28318 / MedianDelta + .5;
InstPeriod = .33*DC + .67*Instperiod[1];
Period = .15*InstPeriod + .85*Period[1];

alpha1 = 2/(Period + 1);
AdaptCycle=(1-.5*alpha1)*(1-.5*alpha)*(Smooth-2*Smooth[1]+Smooth[2])+2*(1-alpha1)*AdaptCycle[1]-(1-alpha1)*(1-alpha1)*AdaptCycle[2];
If currentbar <7 then AdaptCycle=(Price-2*Price[1]+Price[2])/4;
Plot1(AdaptCycle,"AdaptCycle",blue);
Plot2(AdaptCycle[1],"Trigger",green);
%}
function out = EhlersAdapCybCyc(H,L)
Price = (H+L)/2;
alpha = 0.07;
b = [1 2 2 1]/6;
bhp = [0.0962 0 0.5769 0 -0.5769 0 0.0962];
persistent XAdapCybCyc
if isempty(XAdapCybCyc)
    XAdapCybCyc.prwin = repmat(Price,length(b),1);
    XAdapCybCyc.cyc1win = repmat(zeros(1,length(H)),length(bhp),1);
    XAdapCybCyc.DelPhase = repmat(0.5*ones(1,length(H)),5,1);
    XAdapCybCyc.smp = Price;
    XAdapCybCyc.smpp = Price;
    XAdapCybCyc.Q1p = ones(1,length(H));
    XAdapCybCyc.I1p = ones(1,length(H));
    XAdapCybCyc.InstPeriodp = 15*ones(1,length(H));
    XAdapCybCyc.Periodp = 15*ones(1,length(H));
    XAdapCybCyc.ACp = zeros(1,length(H));
    XAdapCybCyc.ACpp = zeros(1,length(H));
end
XAdapCybCyc.prwin = [Price;XAdapCybCyc.prwin(1:end-1,:)];
Smooth = sum(b'.*XAdapCybCyc.prwin);
Cycle = (1 - .5*alpha)*(1 - .5*alpha)*...
    (Smooth - 2*XAdapCybCyc.smp + XAdapCybCyc.smpp) ...
    + 2*(1-alpha)*XAdapCybCyc.cyc1win(1,:) - ...
    (1 - alpha)*(1-alpha)*XAdapCybCyc.cyc1win(2,:);
XAdapCybCyc.cyc1win = [Cycle;XAdapCybCyc.cyc1win(1:end-1,:)];
tmp = (.5+.08*XAdapCybCyc.InstPeriodp);
Q1 = sum(bhp'.*XAdapCybCyc.cyc1win.*tmp);
I1 = XAdapCybCyc.cyc1win(3,:);
Q1(Q1==0) = 0.1;
XAdapCybCyc.Q1p(XAdapCybCyc.Q1p==0) = 0.1;
DeltaPhase = (I1./Q1 - XAdapCybCyc.I1p./XAdapCybCyc.Q1p) ./ ...
    (1 + I1.*XAdapCybCyc.I1p./(Q1.*XAdapCybCyc.Q1p));
DeltaPhase(DeltaPhase<0.1) = 0.1;
DeltaPhase(DeltaPhase>1.1) = 1.1;
XAdapCybCyc.DelPhase = [DeltaPhase;XAdapCybCyc.DelPhase(1:end-1,:)];
MedianDelta = median(XAdapCybCyc.DelPhase);
DC(MedianDelta==0) = 15;
DC(MedianDelta~=0) = 6.28318 ./ MedianDelta + .5;
InstPeriod = .33*DC + .67*XAdapCybCyc.InstPeriodp;
Period = .15*InstPeriod + .85*XAdapCybCyc.Periodp;
alpha1 = 2./(Period + 1);
AdaptCycle=(1-.5*alpha1).*(1-.5*alpha1).*...
    (Smooth - 2*XAdapCybCyc.smp + XAdapCybCyc.smpp)+...
    2*(1-alpha1).*XAdapCybCyc.ACp-...
    (1-alpha1).*(1-alpha1).*XAdapCybCyc.ACp;
Trigger = XAdapCybCyc.ACp;
% updates
XAdapCybCyc.smpp = XAdapCybCyc.smp;
XAdapCybCyc.smp = Smooth;
XAdapCybCyc.Q1p = Q1;
XAdapCybCyc.I1p = I1;
XAdapCybCyc.InstPeriodp = InstPeriod;
XAdapCybCyc.Periodp = Period;
XAdapCybCyc.ACpp = XAdapCybCyc.ACp;
XAdapCybCyc.ACp = AdaptCycle;
out(1,:) = Smooth;
out(2,:) = Q1;
out(3,:) = I1;
out(4,:) = InstPeriod;
out(5,:) = Period;
out(6,:) = AdaptCycle;
out(7,:) = Trigger;
end
%{
{Cycle Period Measurement from Cybernetic Analysis for Stocks and Futures by John Ehlers - code compiled by dn}
Inputs: Price((H+L)/2), alpha(.07);
Vars: Smooth(0),Cycle(0),Q1(0),I1(0),DeltaPhase(0),MedianDelta(0),DC(0),InstPeriod(0),Period(0),I2(0),Q2(0);
Smooth = (Price + 2*Price[1] + 2*Price[2] + Price[3])/6;
Cycle = (1 - .5*alpha)*(1 - .5*alpha)*(Smooth - 2*Smooth[1] + Smooth[2]) + 2*(1-alpha)*Cycle[1] - (1 - alpha)*(1-alpha)*Cycle[2];
If currentbar < 7 then Cycle = (Price - 2*Price[1] + Price[2])/4;
Q1 = (.0962*Cycle + .5769*Cycle[2] - .5769*Cycle[4] - .0962*Cycle[6])*(.5+.08*InstPeriod[1]);
I1 = Cycle[3];
If Q1 <> 0 and Q1[1] <> 0 then DeltaPhase = (I1/Q1 - I1[1]/Q1[1]) / (1 + I1*I1[1]/(Q1*Q1[1]));
If DeltaPhase < 0.1 then DeltaPhase = 0.1;
If DeltaPhase > 1.1 then DeltaPhase = 1.1;
MedianDelta = Median(DeltaPhase,5);
If MedianDelta = 0 then DC = 15 else DC = 6.28318 / MedianDelta + .5;
InstPeriod = .33*DC + .67*Instperiod[1];
Period = .15*InstPeriod + .85*Period[1];
Plot1 (Period,"Period",blue);
{This indicator allows the cycle measurement to be determined in very few bars.
It sums the cycle phases until it reaches 360 degrees - a full circle.
The lag in measuring the Dominant Cycle Period is about 8 bars.}
%}
function out = EhlersCycPerMeas(H,L)
Price = (H+L)/2;
alpha = 0.07;
b = [1 2 2 1]/6;
bhp = [0.0962 0 0.5769 0 -0.5769 0 0.0962];
persistent XCycPerMeas
if isempty(XCycPerMeas)
    XCycPerMeas.prwin = repmat(Price,length(b),1);
    XCycPerMeas.cyc1win = repmat(zeros(1,length(H)),length(bhp),1);
    XCycPerMeas.DelPhase = repmat(0.5*ones(1,length(H)),5,1);
    XCycPerMeas.smp = Price;
    XCycPerMeas.smpp = Price;
    XCycPerMeas.Q1p = ones(1,length(H));
    XCycPerMeas.I1p = ones(1,length(H));
    XCycPerMeas.InstPeriodp = 15*ones(1,length(H));
    XCycPerMeas.Periodp = 15*ones(1,length(H));
end
XCycPerMeas.prwin = [Price;XCycPerMeas.prwin(1:end-1,:)];
Smooth = sum(b'.*XCycPerMeas.prwin);
Cycle = (1 - .5*alpha)*(1 - .5*alpha)*...
    (Smooth - 2*XCycPerMeas.smp + XCycPerMeas.smpp) ...
    + 2*(1-alpha)*XCycPerMeas.cyc1win(1,:) - ...
    (1 - alpha)*(1-alpha)*XCycPerMeas.cyc1win(2,:);
XCycPerMeas.cyc1win = [Cycle;XCycPerMeas.cyc1win(1:end-1,:)];
tmp = (.5+.08*XCycPerMeas.InstPeriodp);
Q1 = sum(bhp'.*XCycPerMeas.cyc1win.*tmp);
I1 = XCycPerMeas.cyc1win(3,:);
Q1(Q1==0) = 0.1;
XCycPerMeas.Q1p(XCycPerMeas.Q1p==0) = 0.1;
DeltaPhase = (I1./Q1 - XCycPerMeas.I1p./XCycPerMeas.Q1p) ./ ...
    (1 + I1.*XCycPerMeas.I1p./(Q1.*XCycPerMeas.Q1p));
DeltaPhase(DeltaPhase<0.1) = 0.1;
DeltaPhase(DeltaPhase>1.1) = 1.1;
XCycPerMeas.DelPhase = [DeltaPhase;XCycPerMeas.DelPhase(1:end-1,:)];
MedianDelta = median(XCycPerMeas.DelPhase);
DC(MedianDelta==0) = 15;
DC(MedianDelta~=0) = 6.28318 ./ MedianDelta + .5;
InstPeriod = .33*DC + .67*XCycPerMeas.InstPeriodp;
Period = .15*InstPeriod + .85*XCycPerMeas.Periodp;
% updates
XCycPerMeas.smpp = XCycPerMeas.smp;
XCycPerMeas.smp = Smooth;
XCycPerMeas.Q1p = Q1;
XCycPerMeas.I1p = I1;
XCycPerMeas.InstPeriodp = InstPeriod;
XCycPerMeas.Periodp = Period;
out(1,:) = Smooth;
out(2,:) = Q1;
out(3,:) = I1;
out(4,:) = InstPeriod;
out(5,:) = Period;
end
%{
//// Ehlers Stochastic RVI Index - coded by dn -From Cybernetic Analysis for Stocks and Futures - plots same as code below
Var {Inputs}: Length(7),delimiter(80);
Vars: Num(0),Denom(0),count(0),RVI(0),MaxRVI(0),MinRVI(0);
Value1 = ((Close - Open) + 2*(Close[1] - Open[1]) + 2*(Close[2] - Open[2]) + (Close[3] - Open[3]))/6;
Value2 = ((High - Low) + 2*(High[1] - Low[1]) + 2*(High[2] - Low[2]) + (High[3] - Low[3]))/6;
Num = 0; Denom = 0;
For count = 0 to Length - 1 begin
Num = Num + Value1[count];
Denom = Denom + Value2[count];
End;
If Denom <> 0 then RVI = Num / Denom;
MaxRVI = Highest(RVI, Length);
MinRVI = Lowest(RVI, Length);
If MaxRVI <> MinRVI then Value3 = (RVI - MinRvi) / (MaxRVI - MinRVI);
Value4 = (4*Value3 + 3*Value3[1] + 2*value3[2] + Value3[3]) / 10;
Value4 = 2*(Value4 - .5);
Plot1(Value4, "RVI");
Plot2(.96*(Value4[1] + .02), "Trigger", blue);
%}
function out = EhlersStochRVI(C,O,H,L)
Len = 7;
bsm = [1 2 2 1]/6;
b = [4 3 2 1]/10;
persistent XStochRVI
if isempty(XStochRVI)
    XStochRVI.cowin = repmat(C-O,length(bsm),1);
    XStochRVI.hlwin = repmat(H-L,length(bsm),1);
    XStochRVI.Val1win = repmat(ones(1,length(H)),Len,1);
    XStochRVI.Val2win = repmat(ones(1,length(H)),Len,1);
    XStochRVI.rviwin = repmat(ones(1,length(H)),Len,1);
    XStochRVI.Val3win = repmat(zeros(1,length(H)),length(bsm),1);
    XStochRVI.Val4p = zeros(1,length(H));
end
XStochRVI.cowin = [C-O;XStochRVI.cowin(1:end-1,:)];
XStochRVI.hlwin = [H-L;XStochRVI.hlwin(1:end-1,:)];
Value1 = sum(bsm'.*XStochRVI.cowin);
Value2 = sum(bsm'.*XStochRVI.hlwin);
XStochRVI.Val1win = [Value1;XStochRVI.Val1win(1:end-1,:)];
XStochRVI.Val2win = [Value2;XStochRVI.Val2win(1:end-1,:)];
Num = zeros(1,length(H)); 
Denom = zeros(1,length(H));
for count = 1:Len
    Num = Num + XStochRVI.Val1win(count,:);
    Denom = Denom + XStochRVI.Val2win(count,:);
end
Denom(Denom==0) = 1;
RVI = Num ./ Denom;
XStochRVI.rviwin = [RVI;XStochRVI.rviwin(1:end-1,:)];
MaxRVI = max(XStochRVI.rviwin);
MinRVI = min(XStochRVI.rviwin);
tmp = MaxRVI - MinRVI;
tmp(tmp==0) = 1;
Value3 = (RVI - MinRVI) ./ tmp;
XStochRVI.Val3win = [Value3;XStochRVI.Val3win(1:end-1,:)];
Value4 = sum(b'.*XStochRVI.Val3win);
Value4 = 2*(Value4 - .5);
Trigger = 0.96*(XStochRVI.Val4p + .02);
XStochRVI.Val4p = Value4;
out(1,:) = RVI;
out(2,:) = Value3;
out(3,:) = Value4;
out(4,:) = Trigger;
end
%{
///// Ehlers Stochastic RSI - code compiled by dn
{From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers
RSILength - set the length of the RSI
StocLength - set the length of the Stochastic
WMALength - set the length of the Weighted Moving Average
}
Inputs: RSILength(8), StocLength(8), WMALength(8);
Value1=RSI (Close, RSILength) - Lowest(RSI(Close, RSILength), StocLength);
Value2 = Highest(RSI(Close, RSILength), StocLength) - 
  Lowest(RSI(Close, RSILength), StocLength);
If Value2<> 0 then Value3 = Value1/Value2;
Value4 = 2*(WAverage(Value3, WMALength) - .5);
Plot1(Value4, "StocRSI",blue);
Plot2(Value4[1], "Trig",green);
%}
% function out = 
%{
//// Ehlers Fisher Stochastic CG (Center of Gravity) indicator/oscillator
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers
//// code compiled by dn

Inputs: Price((H+L)/2),
Length(8);
Vars: count(0),
Num(0),
Denom(0),
CG(0),
MaxCG(0),
MinCG(0);
Num = 0;
Denom = 0;
For count = 0 to Length - 1 begin
Num = Num + (1 + count)*(Price[count]);
Denom = Denom + (Price[count]);
End;
If Denom <> 0 then CG = -Num/Denom + (Length + 1) / 2;
MaxCG = Highest(CG, Length);
MinCG = Lowest(CG, Length);
If MaxCG <> MinCG then Value1 = (CG - MinCG) / (MaxCG - MinCG);
Value2 = (4*Value1 + 3*Value1[1] + 2*Value1[2] + Value1[3]) / 10;

Value3 = .5*Log((1+1.98*(Value2-.5))/(1-1.98*(Value2-.5)));

Plot1 (Value3, "CG");
Plot2(Value3[1], "Trigger");
%}
function out = EhlerStochCG(H,L)
Price = (H+L)/2;
Len = 8;
b = [4 3 2 1]/10;
persistent XStochCG
if isempty(XStochCG)
    XStochCG.prwin = repmat(Price,Len,1);
    XStochCG.CGwin = repmat(ones(1,length(H)),Len,1);
    XStochCG.Val1win = repmat(ones(1,length(H)),length(b),1);
    XStochCG.Val3p = ones(1,length(H));
end
Num = zeros(1,length(H));
Denom = zeros(1,length(H));
XStochCG.prwin = [Price;XStochCG.prwin(1:end-1,:)];
for count = 1:Len
    Num = Num + (0 + count)*XStochCG.prwin(count,:);
    Denom = Denom + XStochCG.prwin(count,:);
end
Denom(Denom==0) = 1;
CG = -Num./Denom + (Len + 1) / 2;
XStochCG.CGwin = [CG;XStochCG.CGwin(1:end-1,:)];
MaxCG = max(XStochCG.CGwin);
MinCG = min(XStochCG.CGwin);
tmp = MaxCG - MinCG;
tmp(tmp==0) = 1;
Value1 = (CG - MinCG) ./ tmp;
XStochCG.Val1win = [Value1;XStochCG.Val1win(1:end-1,:)];
Value2 = sum(b'.*XStochCG.Val1win);
Value3 = .5*log((1+1.98*(Value2-.5))./...
    (1-1.98*(Value2-.5)));
Trigger = XStochCG.Val3p;
XStochCG.Val3p = Value3;
out(1,:) = Value1;
out(2,:) = Value2;
out(3,:) = CG;
out(4,:) = Trigger;
end
%{
//// Ehl Stochastic Cyber Cycle
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers

Inputs: Price((H+L)/2);
Var{Inputs}: alpha(.07),Len(8),CCdelimiter(80);
vars: Smooth(0),Cycle(0),MaxCycle(0),MinCycle(0);
Smooth=(Price+2*Price[1]+2*Price[2]+Price[3])/6;
Cycle=(1-.5*alpha)*(1-.5*alpha)*(Smooth-2*Smooth[1]+Smooth[2])+2*(1-alpha)*Cycle[1]-(1-alpha)*(1-alpha)*Cycle[1];
If currentbar <7 then Cycle=(Price-2*Price[1]+Price[2])/4;
MaxCycle = Highest (Cycle, Len);
MinCycle = Lowest (Cycle, Len);
If MaxCycle <> MinCycle then Value1 = (Cycle - MinCycle) / (MaxCycle - MinCycle);
Value2 = (4*Value1 + 3*Value1[1] + 2*Value1[2] + Value1[3]) / 10;
Value2 = 2*(Value2 - .5);
Plot2 (.96*(Value2[1] + .02), "Trigger",green);
%}
function out = EhlersStoCybCyc(H,L)
persistent XStoCybCyc
Len = 8;
Price = (H+L)/2;
alpha = 0.07;
CCdelimiter = 80;
bsm = [1 2 2 1]/6;
b = [4 3 2 1]/10;
if isempty(XStoCybCyc)
    XStoCybCyc.smp = Price;
    XStoCybCyc.smpp = Price;
    XStoCybCyc.cycp = zeros(1,length(H));
    XStoCybCyc.cycpp = zeros(1,length(H));
    XStoCybCyc.prwin = repmat(Price,length(bsm),1);
    XStoCybCyc.cycwin = repmat(zeros(1,length(H)),Len,1);
    XStoCybCyc.Val1win = repmat(zeros(1,length(H)),length(b),1);
    XStoCybCyc.Val2p = zeros(1,length(H));
end
XStoCybCyc.prwin = [Price;XStoCybCyc.prwin(1:end-1,:)];
Smooth = sum(bsm'.*XStoCybCyc.prwin);
Cycle=(1-.5*alpha)*(1-.5*alpha)*...
    (Smooth-2*XStoCybCyc.smp+XStoCybCyc.smpp)...
    +2*(1-alpha)*XStoCybCyc.cycp...
    -(1-alpha)*(1-alpha)*XStoCybCyc.cycpp;
XStoCybCyc.cycwin = [Cycle;XStoCybCyc.cycwin(1:end-1,:)];
MaxCycle = max(XStoCybCyc.cycwin);
MinCycle = min(XStoCybCyc.cycwin);
tmp = MaxCycle - MinCycle;
tmp(tmp==0) = 1;
Value1 = (Cycle - MinCycle) ./ tmp;
XStoCybCyc.Val1win = [Value1;XStoCybCyc.Val1win(1:end-1,:)];
Value2 = sum(b'.*XStoCybCyc.Val1win);
Value2 = 2*(Value2 - .5);
Trigger = 0.96*(XStoCybCyc.Val2p + .02);
% updates
XStoCybCyc.smpp = XStoCybCyc.smp;
XStoCybCyc.smp = Smooth;
XStoCybCyc.cycpp = XStoCybCyc.cycp;
XStoCybCyc.cycp = Cycle;
XStoCybCyc.Val2p = Value2;
out(1,:) = Value1;
out(2,:) = Value2;
out(3,:) = Trigger;
end
%{
//// Ehlers Stochastic CG (Center of Gravity) indicator/oscillator 
//// From 'Cybernetic Analysis for Stocks and Futures' by John Ehlers

Inputs: Price((H+L)/2);
Var{Inputs}:Length(8),SCGdelimiter(80);
Vars: count(0),Num(0),Denom(0),CG(0),MaxCG(0),MinCG(0);
Num = 0; Denom = 0;
For count = 0 to Length - 1 begin
Num = Num + (1 + count)*(Price[count]);
Denom = Denom + (Price[count]);
End;
If Denom <> 0 then CG = -Num/Denom + (Length + 1) / 2;
MaxCG = Highest(CG, Length);
MinCG = Lowest(CG, Length);
If MaxCG <> MinCG then Value1 = (CG - MinCG) / (MaxCG - MinCG);
Value2 = (4*Value1 + 3*Value1[1] + 2*Value1[2] + Value1[3]) / 10;
Value2 = 2*(Value2 - .5);
Plot2(.96*(Value2[1] + .02), "Trigger",green);
%}
function out = EhlersStochCG(H,L)
persistent XEhlStochCG
Len = 8;
SGdelimiter = 80;
Price = (H + L)/2;
b = [4 3 2 1]/10;
if isempty(XEhlStochCG)
    XEhlStochCG.prwin = repmat(Price,Len,1);
    XEhlStochCG.CGwin = repmat(ones(1,length(H)),Len,1);
    XEhlStochCG.Val2win = repmat(zeros(1,length(H)),length(b),1);
    XEhlStochCG.Value2p = zeros(1,length(H));
end
Num = zeros(1,length(H));
Denom = zeros(1,length(H));
XEhlStochCG.prwin = [Price;XEhlStochCG.prwin(1:end-1,:)];
for count = 1:Len
    Num = Num + (1+count)*XEhlStochCG.prwin(count,:);
    Denom = Denom + XEhlStochCG.prwin(count,:);
end
Denom(Denom==0) = 1;
CG = -Num./Denom + (Len + 1) / 2;
XEhlStochCG.CGwin = [CG;XEhlStochCG.CGwin(1:end-1,:)];
MaxCG = max(XEhlStochCG.CGwin);
MinCG = min(XEhlStochCG.CGwin);
tmp = MaxCG - MinCG;
tmp(tmp==0) = 1;
Value1 = (CG - MinCG) ./ tmp;
XEhlStochCG.Val2win = [Value1;XEhlStochCG.Val2win(1:end-1,:)];
Value2 = sum(b'.*XEhlStochCG.Val2win);
Value2 = 2*(Value2 - .5);
Trigger = 0.96*(XEhlStochCG.Value2p + .02);
XEhlStochCG.Value2p = Value2;
out(1,:) = Value1;
out(2,:) = Value2;
out(3,:) = Trigger;
end
%{
//// Ehlers Relative Vigor Index - coded by dn
//// From Cybernetic Analysis for Stocks and Futures

Inputs: Length(10);
Vars: Num(0),
Denom(0),
Count(0),
RVI(0),
Trigger(0);
Value1 = ((Close - Open) + 
2*(Close[1] - Open[1]) + 2*(Close[2] - Open[2])
+ (Close[3] - Open[3]))/6;
Value2 = ((High - Low) + 2 * (High[1]
- Low[1]) + 2 * (High[2] - Low[2]) + (High[3] - Low[3]))/6;
Num = 0;
Denom = 0;
For count = 0 to Length -1 begin
Num = Num + Value1 [count];
Denom = Denom + Value2[count];
End;
If Denom <> 0 then RVI = Num / Denom;
Trigger = RVI[1];
%}
function out = EhlRelVig(C,O,H,L)
persistent XEhlRelVig
Len = 10;
b = [1 2 2 1]/6;
if isempty(XEhlRelVig)
    XEhlRelVig.clopwin = repmat(C-O,length(b),1);
    XEhlRelVig.hilowin = repmat(H-L,length(b),1);
    XEhlRelVig.Val1win = ones(Len,length(H));
    XEhlRelVig.Val2win = ones(Len,length(H));
    XEhlRelVig.RVIp = zeros(1,length(H));
end
XEhlRelVig.clopwin = [C-O;XEhlRelVig.clopwin(1:end-1,:)];
XEhlRelVig.hilowin = [H-L;XEhlRelVig.hilowin(1:end-1,:)];
Value1 = sum(b'.*XEhlRelVig.clopwin);
Value2 = sum(b'.*XEhlRelVig.hilowin);
XEhlRelVig.Val1win = [Value1;XEhlRelVig.Val1win(1:end-1,:)];
XEhlRelVig.Val2win = [Value2;XEhlRelVig.Val2win(1:end-1,:)];
Num = zeros(1,length(H));
DeNum = zeros(1,length(H));
for i = 1:Len
    Num = Num + XEhlRelVig.Val1win(i,:);
    DeNum = DeNum + XEhlRelVig.Val2win(i,:);
end
DeNum(DeNum==0) = 1;
RVI = Num ./ DeNum;
Trigger = XEhlRelVig.RVIp;
XEhlRelVig.RVIp = RVI;
out(1,:) = Value1;
out(2,:) = Value2;
out(3,:) = RVI;
out(4,:) = Trigger;
end
%{
//// Ehlers Fisher Cyber Cycle - coded by dn
//// From Cybernetic Analysis for Stocks and Futures
Inputs: Price((H+L)/2),
alpha(.07),
Len(8);
Vars: Smooth(0),
Cycle(0),
MaxCycle(0),
MinCycle(0),
Lead(0);
Smooth = (Price + 2*Price[1] + 2*Price[2] + Price[3])/6;
Cycle=(1-.5*alpha)*(1-.5*alpha)*(Smooth-2*Smooth[1]+Smooth[2])+2*(1-alpha)*Cycle[1]-(1-alpha)*(1-alpha)*Cycle[2];
If currentBar <7 then Cycle=(Price-2*Price[1]+Price[2])/4;
MaxCycle = Highest(Cycle,Len);
MinCycle = Lowest(Cycle,Len);
If MaxCycle <> MinCycle then Value1=(Cycle-MinCycle)/(MaxCycle-MinCycle);
Value2 = (4*Value1+3*Value1[1]+2*Value1[2]+Value1[3])/10;
Value3 = .5*Log((1+1.98*(Value2-.5))/(1-1.98*(Value2-.5)));
%}
function out = EhlersCycleEst(H,L)
Price = (H+L)/2;
bsm = [1 2 2 1]/6;
bsm2 = [4 3 2 1]/10;
alpha2 = 0.07;
Len = 8;
persistent XehlCycEst
if isempty(XehlCycEst)
    XehlCycEst.prwin = repmat(Price,length(bsm),1);
    XehlCycEst.Valwin = repmat(zeros(1,length(H)),length(bsm2),1);
    XehlCycEst.Cycwin = zeros(Len,length(H));
    XehlCycEst.Smoothp = Price;
    XehlCycEst.Smoothpp = Price;
    XehlCycEst.Cyclep = zeros(1,length(H));
    XehlCycEst.Cyclepp = zeros(1,length(H));
end
XehlCycEst.prwin = [Price;XehlCycEst.prwin(1:end-1,:)];
Smooth = sum(bsm'.*XehlCycEst.prwin);
Cycle=(1-0.5*alpha2)*(1-0.5*alpha2)*...
    (Smooth-2*XehlCycEst.Smoothp+XehlCycEst.Smoothpp)+...
    2*(1-alpha2)*XehlCycEst.Cyclep-(1-alpha2)*(1-alpha2)*XehlCycEst.Cyclepp;
XehlCycEst.Cycwin = [Cycle;XehlCycEst.Cycwin(1:end-1,:)];
MaxCycle = max(Cycle);
MinCycle = min(Cycle);
tmp = MaxCycle-MinCycle;
tmp(tmp==0) = 1;
Value1 = (Cycle-MinCycle)./tmp;
XehlCycEst.Valwin = [Value1;XehlCycEst.Valwin(1:end-1,:)];
Value2 = sum(bsm2'.*XehlCycEst.Valwin);
Value3 = .5*log((1+1.98*(Value2-.5))./(1-1.98*(Value2-.5)));
% updates
XehlCycEst.Smoothpp = XehlCycEst.Smoothp;
XehlCycEst.Smoothp = Smooth;
XehlCycEst.Cyclepp = XehlCycEst.Cyclep;
XehlCycEst.Cyclep = Cycle;
out(1,:) = Smooth;
out(2,:) = Cycle;
out(3,:) = Value1;
out(4,:) = Value2;
out(5,:) = Value3;
end
%{
//// Ehlers Cyber Cycle indicator - coded by dn
//// From Cybernetic Analysis for Stocks and Futures
Inputs: Price2((H+L)/2), alpha2(.07);
Vars: smooth2(0), Cycle2(0);
Smooth2 = (Price2 + 2*Price2[1] + 2*Price2[2] + Price2[3])/6;
Cycle2=(1-0.5*alpha2)*(1-0.5*alpha2)*(Smooth2-2*Smooth2[1]+Smooth2[2])+
2*(1-alpha2)*Cycle2[1]-(1-alpha2)*(1-alpha2)*Cycle2[2];
If currentbar < 7 then Cycle2 = (Price2 - 2*Price2[1] +Price2[2])/4;
%}
function out = EhlerCyberCyc(H,L)
Price = (H+L)/2;
bsm = [1 2 2 1]/6;
alpha2 = 0.07;
persistent XehlCyb
if isempty(XehlCyb)
    XehlCyb.prwin = repmat(Price,length(bsm),1);
    XehlCyb.Smooth2p = Price;
    XehlCyb.Smooth2pp = Price;
    XehlCyb.Cycle2p = zeros(1,length(H));
    XehlCyb.Cycle2pp = zeros(1,length(H));
end
XehlCyb.prwin = [Price;XehlCyb.prwin(1:end-1,:)];
Smooth2 = sum(bsm'.*XehlCyb.prwin);
Cycle2=(1-0.5*alpha2)*(1-0.5*alpha2)*...
    (Smooth2-2*XehlCyb.Smooth2p+XehlCyb.Smooth2pp)+...
    2*(1-alpha2)*XehlCyb.Cycle2p-(1-alpha2)*(1-alpha2)*XehlCyb.Cycle2pp;

% updates
XehlCyb.Smooth2pp = XehlCyb.Smooth2p;
XehlCyb.Smooth2p = Smooth2;
XehlCyb.Cycle2pp = XehlCyb.Cycle2p;
XehlCyb.Cycle2p = Cycle2;
out(1,:) = Smooth2;
out(2,:) = Cycle2;
end

function out = EhlersMAMA(C,H,L)
persistent XehlMAMA
bhp = [0.0962 0 0.5769 0 -0.5769 0 -0.0962];a = 1;
bsm = [4 3 2 1]/10;
Price = (H+L)/2;
FastLimit = 0.5;
SlowLimit = .05;
if isempty(XehlMAMA)
    XehlMAMA.prwin = repmat(Price,7,1);
    XehlMAMA.ITrendwin = repmat(Price,7,1);
    XehlMAMA.smwin = repmat(Price,7,1);
    XehlMAMA.smPricewin = repmat(Price,50,1);
    XehlMAMA.Pricewin = repmat(Price,50,1);
    XehlMAMA.cycwin = zeros(20,length(C));
    XehlMAMA.Detrendwin = repmat(Price,7,1);
    XehlMAMA.I1win = zeros(7,length(C));
    XehlMAMA.Q1win = zeros(7,length(C));
    XehlMAMA.smp = Price;
    XehlMAMA.smpp = Price;
    XehlMAMA.I2p = ones(1,length(C));
    XehlMAMA.Q2p = ones(1,length(C));
    XehlMAMA.Rep = ones(1,length(C));
    XehlMAMA.Imp = ones(1,length(C));
    XehlMAMA.Phasep = 0.1*ones(1,length(C));
    XehlMAMA.InstPeriodp = 15*ones(1,length(C));
    XehlMAMA.Periodp = 15*ones(1,length(C));
    XehlMAMA.smPeriodp = 15*ones(1,length(C));
    XehlMAMA.Trendp = ones(1,length(C));
    XehlMAMA.buysellp = zeros(1,length(C));
    XehlMAMA.MAMAp = Price;
    XehlMAMA.FAMAp = Price;
end
XehlMAMA.prwin = [Price;XehlMAMA.prwin(1:end-1,:)];
smooth = sum(bsm'.*XehlMAMA.prwin(1:4,:));
XehlMAMA.smwin = [smooth;XehlMAMA.smwin(1:end-1,:)];
tmp = 0.075*XehlMAMA.Periodp + 0.54;
Detrender = sum(bhp'.*XehlMAMA.smwin.*tmp);
XehlMAMA.Detrendwin = [Detrender;XehlMAMA.Detrendwin(1:end-1,:)];
% Compute InPhase and Quadrature components
Q1 = sum(bhp'.*XehlMAMA.Detrendwin.*tmp);
I1 = XehlMAMA.Detrendwin(4,:);
XehlMAMA.Q1win = [XehlMAMA.Q1win(2:end,:);Q1];
XehlMAMA.I1win = [XehlMAMA.I1win(2:end,:);I1];
% Advance the phase of I1 and Q1 by 90 degrees
jI = sum(bhp'.*XehlMAMA.I1win.*tmp);
jQ = sum(bhp'.*XehlMAMA.Q1win.*tmp);
% Phasor addition for 3-bar averaging
I2 = I1 - jQ;
Q2 = Q1 + jI;
% Smooth the I and Q components before applying the discriminator
I2 = 0.8*XehlMAMA.I2p + 0.2*I2;
Q2 = 0.8*XehlMAMA.Q2p + 0.2*Q2;
% Homodyne Discriminator
Re = I2.*XehlMAMA.I2p + Q2.*XehlMAMA.Q2p;
Im = I2.*XehlMAMA.Q2p - Q2.*XehlMAMA.I2p;
Re = 0.8*XehlMAMA.Rep + 0.2*Re;
Im = 0.8*XehlMAMA.Imp + 0.2*Im;
Im(Im==0) = 0.1;
Re(Re==0) = 0.1;
Period = 2*pi./atan(Im./Re);
Period = min(Period,1.5*XehlMAMA.Periodp);
Period = max(Period,0.67*XehlMAMA.Periodp);
Period = max(Period,6);
Period = min(Period,50);
Period = 0.8*XehlMAMA.Periodp + 0.2*Period;
smPeriod = 0.67*XehlMAMA.smPeriodp + 0.33*Period;
XehlMAMA.smPricewin = [smooth;XehlMAMA.smPricewin(1:end-1,:)];
XehlMAMA.Pricewin = [Price;XehlMAMA.Pricewin(1:end-1,:)];
Phase = XehlMAMA.Phasep;
I1(I1==0) = 0.1;
Phase(I1~=0) = atan(Q1./I1);
DeltaPhase = XehlMAMA.Phasep - Phase;
DeltaPhase(DeltaPhase<1) = 1;
alpha = FastLimit ./ DeltaPhase;
alpha = max(alpha,SlowLimit*ones(size(alpha)));
alpha = min(alpha,FastLimit*ones(size(alpha)));
MAMA = alpha.*Price + (1 - alpha).*XehlMAMA.MAMAp;
FAMA = .5*alpha.*MAMA + (1 - .5*alpha).*XehlMAMA.FAMAp;

% updates
XehlMAMA.Periodp = Period;
XehlMAMA.smPeriodp = smPeriod;
XehlMAMA.I2p = I2;
XehlMAMA.Q2p = Q2;
XehlMAMA.Phasep = Phase;
XehlMAMA.MAMAp = MAMA;
XehlMAMA.FAMAp = FAMA;

out(1,:) = smooth;
out(2,:) = Detrender;
out(3,:) = MAMA;
out(4,:) = FAMA;
end

%{
//// Ehlers Center of Gravity Oscillator - coded by dn
//// From Cybernetic Analysis for Stocks and Futures

Inputs: Price((H+L)/2),
Length(10);

Vars: Count(0),
Num(0),
Denom(0),
CG(0);

Num = 0;Denom = 0;For count = 0 to length - 1 begin
Num = Num + (1+count)*Price[count];

Denom = Denom + (Price[count]);
End;

If Denom <> 0 then CG = -Num/Denom + (Length + 1)/2;
%}
function out = EhlerCenterofGrav(H,L)
persistent XehlCOG
Price = (H+L)/2;
Leng = 10;
Num = zeros(1,length(H));
Denom = zeros(1,length(H));
if isempty(XehlCOG)
    XehlCOG.Pricewin = repmat(Price,Leng,1);
end
XehlCOG.Pricewin = [Price;XehlCOG.Pricewin(1:end-1,:)];
for count = 1:Leng
    Num = Num + (0+count)*XehlCOG.Pricewin(count,:);
    Denom = Denom + XehlCOG.Pricewin(count,:);
end
CG = -Num./Denom + (Leng + 1)/2;
out = CG;
end
%{
///// EHLERS INSTANTANEOUS TREND INDICATOR /////
Inputs: Price ((H+L)/2), alpha(.07);
Vars: Smooth(0),
iTrend(0),
Trigger(0);

iTrend = (alpha- alpha*alpha/4)*price
+ .5* alpha * alpha * Price[1] -
(alpha - .75 * alpha*alpha) * Price[2] + 2
*(1 - alpha) * iTrend[1] -(1 - alpha)
*(1-alpha)*iTrend[2];
If currentBar < 7 then iTrend = Price + 2*price[1]
+ Price[2]/4;

Trigger = 2*iTrend - iTrend[2];
%}
function out = ITrend(H,L)
Price = (H + L)/2;
alpha = 0.07;
persistent XITrend
if isempty(XITrend)
    XITrend.Pricep = Price;
    XITrend.Pricepp = Price;
    XITrend.iTrendp = Price;
    XITrend.iTrendpp = Price;
end
iTrend = (alpha- alpha*alpha/4)*Price ...
    + .5* alpha * alpha * XITrend.Pricep - ...
    (alpha - .75 * alpha*alpha) * XITrend.Pricepp + 2 ...
    *(1 - alpha) * XITrend.iTrendp -(1 - alpha) ...
    *(1-alpha)*XITrend.iTrendpp;
Trigger = 2*iTrend - XITrend.iTrendpp;
% updates
XITrend.Pricepp = XITrend.Pricep;
XITrend.Pricep = Price;
XITrend.iTrendpp = XITrend.iTrendp;
XITrend.iTrendp = iTrend;
out(1,:) = iTrend;
out(2,:) = Trigger;
end

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
%{
Price = (High+Low)/2

if(barindex>5) then
Value1 = .2*(Price - Price[1]) + .8*Value1[1]
Value2 = .1*(High - Low) + .8*Value2[1]
if (Value2 <>0) then
lambda = Abs(Value1 / Value2)
endif

alpha = ( -lambda*lambda + SQRT(lambda*lambda*lambda*lambda + 16*lambda*lambda)) /8
Value3 = alpha*Price + (1-alpha)*Value3[1]
endif

RETURN Value3 as "Tracking filter"
%}
function out = EhlersTrackFilter(H,L)
persistent XEhlTF
if isempty(XEhlTF)
    
end
end
%{
{
My Stochastic Indicator
© 2013 John F. Ehlers
}
Inputs: Length(20);
Vars: alpha1(0), HP(0), a1(0), b1(0), c1(0), c2(0), c3(0), Filt(0),
HighestC(0), LowestC(0), count(0), Stoc(0), MyStochastic(0);
//Highpass filter cyclic components whose periods are shorter than 48 bars
alpha1 = (Cosine(.707*360 / 48) + Sine (.707*360 / 48) - 1) / Cosine(.707*360 / 48);
HP = (1 - alpha1 / 2)*(1 - alpha1 / 2)*(Close - 2*Close[1] + Close[2]) + 2*(1 -
alpha1)*HP[1] - (1 - alpha1)*(1 - alpha1)*HP[2];
//Smooth with a Super Smoother Filter
a1 = expvalue(-1.414*3.14159 / 10);
b1 = 2*a1*Cosine(1.414*180 / 10);
c2 = b1;
c3 = -a1*a1;
c1 = 1 - c2 - c3;
Filt = c1*(HP + HP[1]) / 2 + c2*Filt[1] + c3*Filt[2];
HighestC = Filt;
LowestC = Filt;
For count = 0 to Length - 1 Begin
If Filt[count] > HighestC then HighestC = Filt[count];
If Filt[count] < LowestC then LowestC = Filt[count];
End;
Stoc = (Filt - LowestC) / (HighestC - LowestC);
MyStochastic = c1*(Stoc + Stoc[1]) / 2 + c2*MyStochastic[1] + c3*MyStochastic[2];
%}
function out = ElhStoch(C)
persistent XElhStoch
if isempty(XElhStoch)
    XElhStoch.alpha1 = (cos(.707*2*pi / 48) + ...
        sin (.707*2*pi / 48) - 1) / cos(.707*2*pi / 48);
    a1 = exp(-1.414*pi / 10);
    b1 = 2*a1*cos(1.414*pi / 10);
    XElhStoch.c2 = b1;
    XElhStoch.c3 = -a1*a1;
    XElhStoch.c1 = 1 - XElhStoch.c2 - XElhStoch.c3;
    XElhStoch.HPp = zeros(1,length(C));
    XElhStoch.HPpp = zeros(1,length(C));
    XElhStoch.Filtp = zeros(1,length(C));
    XElhStoch.Filtpp = zeros(1,length(C));
    XElhStoch.Cp = C;
    XElhStoch.Cpp = C;
    XElhStoch.stochp = zeros(1,length(C));
    XElhStoch.mystochasticp = zeros(1,length(C));
    XElhStoch.mystochasticpp = zeros(1,length(C));
    XElhStoch.Filtwin = zeros(20,length(C));
end
HP = (1 - XElhStoch.alpha1 / 2)*(1 - XElhStoch.alpha1 / 2)*...
    (C - 2*XElhStoch.Cp + XElhStoch.Cpp) + ...
    2*(1 - XElhStoch.alpha1)*XElhStoch.HPp - ...
    (1 - XElhStoch.alpha1)*(1 - XElhStoch.alpha1)*XElhStoch.HPpp;
Filt = XElhStoch.c1*(XElhStoch.HPp + XElhStoch.HPpp) / 2 + ...
    XElhStoch.c2*XElhStoch.Filtp + ...
    XElhStoch.c3*XElhStoch.Filtpp;
XElhStoch.Filtwin = [Filt;XElhStoch.Filtwin(1:end-1,:)];
HighestC = max(XElhStoch.Filtwin);
LowestC = min(XElhStoch.Filtwin);
Stoc = (Filt - LowestC)./(HighestC - LowestC);
Stoc((HighestC - LowestC)==0) = 0;
MyStochastic = XElhStoch.c1*(Stoc + XElhStoch.stochp) / 2 + ...
    XElhStoch.c2*XElhStoch.mystochasticp + ...
    XElhStoch.c3*XElhStoch.mystochasticpp;

% updates
XElhStoch.HPpp = XElhStoch.HPp;
XElhStoch.HPp = HP;
XElhStoch.Cpp = XElhStoch.Cp;
XElhStoch.Cp = C;
XElhStoch.Filtpp = XElhStoch.Filtp;
XElhStoch.Filtp = Filt;
XElhStoch.mystochasticpp = XElhStoch.mystochasticp;
XElhStoch.mystochasticp = MyStochastic;
XElhStoch.stochp = Stoc;
out(1,:) = Filt;
out(2,:) = Stoc;
out(3,:) = MyStochastic;
end

%{
{
Roofing filter
© 2013 John F. Ehlers
}
Vars: alpha1(0), HP(0), a1(0), b1(0), c1(0), c2(0), c3(0), Filt(0), Filt2(0);
//Highpass filter cyclic components whose periods are shorter than 48 bars
alpha1 = (Cosine(.707*360 / 48) + Sine (.707*360 / 48) - 1) / Cosine(.707*360 / 48);
HP = (1 - alpha1 / 2)*(1 - alpha1 / 2)*(Close - 2*Close[1] + Close[2]) + 2*(1 -
alpha1)*HP[1] - (1 - alpha1)*(1 - alpha1)*HP[2];
//Smooth with a Super Smoother Filter
a1 = expvalue(-1.414*3.14159 / 10);
b1 = 2*a1*Cosine(1.414*180 / 10);
c2 = b1;
c3 = -a1*a1;
c1 = 1 - c2 - c3;
Filt = c1*(HP + HP[1]) / 2 + c2*Filt[1] + c3*Filt[2];
%}
function out = EhlersRoofingFilter(C)
persistent XEhlRoofFilt
if isempty(XEhlRoofFilt)
    XEhlRoofFilt.alpha1 = (cos(.707*2*pi / 48) + ...
        sin (.707*2*pi / 48) - 1) / cos(.707*2*pi / 48);
    a1 = exp(-1.414*pi / 10);
    b1 = 2*a1*cos(1.414*pi / 10);
    XEhlRoofFilt.c2 = b1;
    XEhlRoofFilt.c3 = -a1*a1;
    XEhlRoofFilt.c1 = 1 - XEhlRoofFilt.c2 - XEhlRoofFilt.c3;
    XEhlRoofFilt.HPp = zeros(1,length(C));
    XEhlRoofFilt.HPpp = zeros(1,length(C));
    XEhlRoofFilt.Filtp = zeros(1,length(C));
    XEhlRoofFilt.Filtpp = zeros(1,length(C));
    XEhlRoofFilt.Cp = C;
    XEhlRoofFilt.Cpp = C;
end
HP = (1 - XEhlRoofFilt.alpha1 / 2)*(1 - XEhlRoofFilt.alpha1 / 2)*...
    (C - 2*XEhlRoofFilt.Cp + XEhlRoofFilt.Cpp) + ...
    2*(1 - XEhlRoofFilt.alpha1)*XEhlRoofFilt.HPp - ...
    (1 - XEhlRoofFilt.alpha1)*(1 - XEhlRoofFilt.alpha1)*XEhlRoofFilt.HPpp;
Filt = XEhlRoofFilt.c1*(XEhlRoofFilt.HPp + XEhlRoofFilt.HPpp) / 2 + ...
    XEhlRoofFilt.c2*XEhlRoofFilt.Filtp + ...
    XEhlRoofFilt.c3*XEhlRoofFilt.Filtpp;
% updates
XEhlRoofFilt.HPpp = XEhlRoofFilt.HPp;
XEhlRoofFilt.HPp = HP;
XEhlRoofFilt.Cpp = XEhlRoofFilt.Cp;
XEhlRoofFilt.Cp = C;
XEhlRoofFilt.Filtpp = XEhlRoofFilt.Filtp;
XEhlRoofFilt.Filtp = Filt;
out = Filt;
end
%{
{ SuperSmoother filter © 2013 John F. Ehlers }
Vars: a1(0), b1(0), c1(0), c2(0), c3(0), Filt(0);
a1 = expvalue(-1.414*3.14159 / 10);
b1 = 2*a1*Cosine(1.414*180 / 10);
c2 = b1;
c3 = -a1*a1;
c1 = 1 - c2 - c3;
Filt = c1*(Close + Close[1]) / 2 + c2*Filt[1] + c3*Filt[2];
%}
function out = EhlersSuperSmooth(C)
persistent XEhlSM
b = ones(1,10)/10;
if isempty(XEhlSM)
    s2 = sqrt(2);
    a1 = exp(-s2*pi / 10);
    b1 = 2*a1*cos(s2*pi / 10);
    XEhlSM.cp = C;
    XEhlSM.filtp = C;
    XEhlSM.filtpp = C;
    XEhlSM.c2 = b1;
    XEhlSM.c3 = -a1*a1;
    XEhlSM.c1 = 1 - XEhlSM.c2 - XEhlSM.c3;
    XEhlSM.clwin = repmat(C,10,1);
end
XEhlSM.clwin = [C;XEhlSM.clwin(1:end-1,:)];
ma = sum(b'.*XEhlSM.clwin);
Filt = XEhlSM.c1*(C + XEhlSM.cp) / 2 + ...
    XEhlSM.c2*XEhlSM.filtp + XEhlSM.c3*XEhlSM.filtpp;
% updates
XEhlSM.filtpp = XEhlSM.filtp;
XEhlSM.filtp = Filt;
XEhlSM.cp = C;
out(1,:) = Filt;
out(2,:) = ma;
end
%{
Scalper 5-8-13 simple moving average (SMA) consisting of
3 SMA's at varying lengths.
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
%{
Keltner Channel with ema & ATR
Middle Line: 20-period Exponential Moving Average (EMA)
Upper Channel Line: 20 EMA + (2 * Average True Range)
Lower Channel Line: 20 EMA – (2 * Average True Range)
%}
function out = KeltChanEMA_ATR(C,H,L)
lengthMiddle  = 20;
channelATR  = 10;
channelWidth = 2;
persistent XsimpKC
if isempty(XsimpKC)
    XsimpKC.alph = 2/(lengthMiddle+1);
    XsimpKC.emap = C;
    XsimpKC.Cp = C;
    Cp = C;
    atr = max(H-C,max(abs(H-Cp),abs(L-Cp)));
    XsimpKC.atrwin = repmat(atr,channelATR,1);
end
emaVal = (1-XsimpKC.alph)*XsimpKC.emap + XsimpKC.alph*C;
atr = max(H-C,max(abs(H-XsimpKC.Cp),abs(L-XsimpKC.Cp)));
XsimpKC.atrwin = [atr;XsimpKC.atrwin(1:end-1,:)];
atravg = sum(XsimpKC.atrwin);
upperVal = emaVal + channelWidth * atravg;
lowerVal = emaVal - channelWidth * atravg;
% updates
XsimpKC.emap = emaVal;
XsimpKC.Cp = C;
out(1,:) = emaVal;
out(2,:) = upperVal;
out(3,:) = lowerVal;
end

%{
simple Keltner Channel
The 10-Day Moving Average:
MOV( (H+L+C)/3, 10, Simple )
Upper Keltner Band
MOV((H+L+C)/3,10,S) + MOV((H-L),10,S)
Lower Keltner Band
MOV((H+L+C)/3,10,S) - MOV((H-L),10,S)
H – high, L – low, C – close, MOV – moving average
%}
function out = simpKeltnerChan(C,H,L)
winlen = 10;
persistent XsimpKC
if isempty(XsimpKC)
    XsimpKC.kcwin = repmat((C+H+L)/3,winlen,1);
    XsimpKC.kcbandwin = repmat((H-L),winlen,1);
end
XsimpKC.kcwin = [(C+H+L)/3;XsimpKC.kcwin(1:end-1,:)];
XsimpKC.kcbandwin = [H-L;XsimpKC.kcbandwin(1:end-1,:)];
mov = sum(XsimpKC.kcwin)/winlen;
band = sum(XsimpKC.kcbandwin)/winlen;
up = mov + band;
dn = mov - band;
out(1,:) = mov;
out(2,:) = up;
out(3,:) = dn;
end

%{
Wilson Relative Price Channel
%}
function out = WilsonRelPriceChan(close)
periods = 34;
% smoothing = 1;
smoothing = 5;
overbought = 70;
oversold = 30;
upperNeutralZone = 55;
lowerNeutralZone = 45;
alph = 2/(smoothing+1);
rsi = rsiWilChan(close,periods);
persistent Xwilchan
if isempty(Xwilchan)
    %Xwilchan.obp = rsi - overbought;
    %Xwilchan.osp = rsi - oversold;
    %Xwilchan.nzup = rsi - upperNeutralZone;
    %Xwilchan.nzlp = rsi - lowerNeutralZone;
    Xwilchan.obp = close;
    Xwilchan.osp = close;
    Xwilchan.nzup = close;
    Xwilchan.nzlp = close;
end
ob = (1-alph)*Xwilchan.obp + alph*(rsi - overbought);
os = (1-alph)*Xwilchan.osp + alph*(rsi - oversold);
nzu = (1-alph)*Xwilchan.nzup + alph*(rsi - upperNeutralZone);
nzl = (1-alph)*Xwilchan.nzlp + alph*(rsi - lowerNeutralZone);
out(1,:) = rsi;
out(2,:) = close.*(1 - ob/100);
out(3,:) = close.*(1 - os/100);
out(4,:) = close.*(1 - nzu/100);
out(5,:) = close.*(1 - nzl/100);
% updates
Xwilchan.obp = ob;
Xwilchan.osp = os;
Xwilchan.nzup = nzu;
Xwilchan.nzlp = nzl;
end

function out = rsiWilChan(close,periods)
persistent Xrsi
if isempty(Xrsi)
    Xrsi.win = zeros(periods,length(close));
    Xrsi.clp = close;
    Xrsi.avgUp = ones(1,length(close));
    Xrsi.avgDp = zeros(1,length(close));
end
alph = 2/(periods+1);
Xrsi.win = [close-Xrsi.clp;Xrsi.win(1:end-1,:)];
tmpU = Xrsi.win;
tmpU(tmpU<0)=0;
tmpD = Xrsi.win;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*Xrsi.avgUp + alph*avgU;
emaavgD = (1-alph)*Xrsi.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
out = 100*(1 - 1./(1+RS));
% updates
Xrsi.avgUp = emaavgU;
Xrsi.avgDp = emaavgD;
Xrsi.clp = close;
end
%{
Ultimate Oscillator = 100 x [(4 x Average7) + (2 x Average14) + Average28]
    / (4 + 2 + 1)
Buying Pressure (BP) = Current Close – Minimum (Current Low or Previous Close).
True Range (TR) = Maximum (Current High or Previous Close) –
    Minimum (Current Low or Previous Close)
Average7 = Sum of BP for the past 7 days / Sum of TR for the past 7 days
Average14 = Sum of BP for the past 14 days / Sum of TR for the past 14 days
Average28 = Sum of BP for the past 28 days / Sum of TR for the past 28 days
%}
function out = UltOscLB(cl,hi,lo)
persistent XUO
len7 = 7;
len14 = 14;
len28 = 28;
if isempty(XUO)
    XUO.winbp = ones(len28,length(cl));
    XUO.wintr = ones(len28,length(cl));
    XUO.clp = cl;
end
high_ = max(hi,XUO.clp);
low_ = min(lo,XUO.clp);
bp = cl - low_;
tr_ = high_ - low_;
XUO.winbp = [bp;XUO.winbp(1:end-1,:)];
XUO.wintr = [tr_;XUO.wintr(1:end-1,:)];
avg7 = sum(XUO.winbp(1:len7,:))./sum(XUO.wintr(1:len7,:));
avg14 = sum(XUO.winbp(1:len14,:))./sum(XUO.wintr(1:len14,:));
avg28 = sum(XUO.winbp(1:len28,:))./sum(XUO.wintr(1:len28,:));
out = 100*(4*avg7 + 2*avg14 + avg28)/7;
XUO.clp = cl;
end