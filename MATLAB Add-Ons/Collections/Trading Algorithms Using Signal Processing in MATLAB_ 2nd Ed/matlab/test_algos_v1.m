% test_algos.m
clc,clear all,close all,dbstop if error
clear obv_adx
clear RDX_Score
clear Scalpsnr
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

    out = twiggMF(hi(i,:),lo(i,:),cl(i,:),vol(i,:));
    tmfadv(i,:) = out(1,:);
    tmfwv(i,:) = out(2,:);
    tmfwmV(i,:) = out(3,:);
    tmfwmA(i,:) = out(4,:);
    tmftmf(i,:) = out(5,:);
 %%{
    out = ifishrsimfi(cl(i,:),vol(i,:));
    ifishrsi(i,:) = out(1,:);
    ifishmfi(i,:) = out(2,:);
    ifishrsifish(i,:) = out(3,:);
    ifishmfifish(i,:) = out(4,:);
    out = ChandeCMO(cl(i,:));
    Chcmo(i,:) = out(1,:);
   out = pgo3(hi(i,:),lo(i,:),cl(i,:));
    pgopgo(i,:) = out(1,:);
    pgoravi(i,:) = out(2,:);
    pgotii(i,:) = out(3,:);
    out = starc(hi(i,:),lo(i,:),cl(i,:));
    starcbasis(i,:) = out(1,:);
    starcul(i,:) = out(2,:);
    starcll(i,:) = out(3,:);
    out = Schaff(cl(i,:));
    sctpff(i,:) = out(1,:);
    sctm(i,:) = out(2,:);
    sctfastMA(i,:) = out(3,:);
    sctslowMA(i,:) = out(4,:);
    out = kairiIdx(cl(i,:));
    kairi(i,:) = out(1,:);
    out = OBVosc(cl(i,:),vol(i,:));
    obvos(i,:) = out(1,:);
    obvema(i,:) = out(2,:);
    obvobv_osc(i,:) = out(3,:);
    out = ulcerIndex(cl(i,:));
    uiui(i,:) = out(1,:);
    uico(i,:) = out(2,:);
    out = forOsc(cl(i,:));
    FOpf(i,:) = out(1,:);
    FOpfma(i,:) = out(2,:);
    out = FRAMA(hi(i,:),lo(i,:));
    frama(i,:) = out(1,:);
    out = TSQstick(op(i,:),cl(i,:));
    tsqs2(i,:) = out(1,:);
    out = BOP(op(i,:),hi(i,:),lo(i,:),cl(i,:));
    bop(i,:) = out(1,:);
    bopsm(i,:) = out(2,:);
    out = TSI(cl(i,:));
    tsiidx(i,:) = out(1,:);
    out = RahMohWsc(cl(i,:));
    rmwrmo(i,:) = out(1,:);
    rmwSwingTrd2(i,:) = out(2,:);
    rmwSwingTrd3(i,:) = out(3,:);
    rmwbuy(i,:) = out(4,:);
    rmwsell(i,:) = out(5,:);
    out = kamabinwav(cl(i,:));
    kbwama(i,:) = out(1,:);
    kbwamalow(i,:) = out(2,:);
    kbwamahigh(i,:) = out(3,:);
    kbwbw(i,:) = out(4,:);
    out = ZeroLagema(cl(i,:));
    ZLE(i,:) = out(1,:);
    out = BearsBulls(hi(i,:),lo(i,:),cl(i,:));
    BeBus_ma(i,:) = out(1,:);
    BeBus_bulls(i,:) = out(2,:);
    BeBus_bears(i,:) = out(3,:);
    out = mfiBollBnd(hi(i,:),lo(i,:),cl(i,:),vol(i,:));
    mfbbb_s(i,:) = out(1,:);
    mfbbasis(i,:) = out(2,:);
    mfbupper(i,:) = out(3,:);
    mfblower(i,:) = out(4,:);
    out = rsiBollBnd(hi(i,:),lo(i,:),cl(i,:));
    rbbbb_s(i,:) = out(1,:);
    rbbbasis(i,:) = out(2,:);
    rbbupper(i,:) = out(3,:);
    rbblower(i,:) = out(4,:);
    out = derosc(cl(i,:));
    derrsi(i,:) = out(1,:);
    dere1(i,:) = out(2,:);
    ders1(i,:) = out(3,:);
    ders2(i,:) = out(4,:);
    out = Tirone(hi(i,:),lo(i,:),cl(i,:));
    Tirtlh(i,:) = out(1,:);
    Tirclh(i,:) = out(2,:);
    Tirblh(i,:) = out(3,:);
    Tireh(i,:) = out(4,:);
    Tirel(i,:) = out(5,:);
    Tirrh(i,:) = out(6,:);
    Tirrl(i,:) = out(7,:);
    out = macd4(cl(i,:));
    macd4e5(i,:) = out(1,:);
    macd4Blue(i,:) = out(7,:);
    macd4Red(i,:) = out(8,:);
    macd4Yellow(i,:) = out(9,:);
    macd4Green(i,:) = out(10,:);
    out = VHF(cl(i,:));
    vhf(i,:) = out(1,:);
    out = VolROC(vol(i,:));
    vroc(i,:) = out(1,:);
    out = tsicciHull(cl(i,:));
    tsicciTSI1(i,:) = out(1,:);
    tsiccicci(i,:) = out(2,:);
    tsiccibbuy(i,:) = out(3,:);
    tsiccissell(i,:) = out(4,:);
    out = EMAenvelope(hi(i,:),lo(i,:),cl(i,:));
    EMAenve(i,:) = out(1,:);
    EMAenveu(i,:) = out(2,:);
    EMAenvel(i,:) = out(3,:);
    EMAenvbull_f(i,:) = out(4,:);
    EMAenvbear_f(i,:) = out(5,:);
    EMAenvsidewise_f(i,:) = out(6,:);
    out = emarsi(cl(i,:));
    ERout_ema(i,:) = out(1,:);
    ERout_emaRsi(i,:) = out(2,:);
    out = Reflex(hi(i,:),lo(i,:),cl(i,:));
    refFilt(i,:) = out(1,:);
    refReflex(i,:) = out(2,:);
    refatr(i,:) = out(3,:);
    out = RDX_Score(hi(i,:),lo(i,:),cl(i,:));
    rdxadx(i,:) = out(1,:);
    rdxrsi(i,:) = out(2,:);
    rdxm5(i,:) = out(3,:);
    rdxm4(i,:) = out(4,:);
    rdxm3(i,:) = out(5,:);
    rdxm2(i,:) = out(6,:);
    rdxm1(i,:) = out(7,:);
    rdxm0(i,:) = out(8,:);
    rdxp3(i,:) = out(9,:);
    rdxp4(i,:) = out(10,:);
    rdxp5(i,:) = out(11,:);
    out = rsibuysell(cl(i,:));
    rsiBSbb(i,:) = out(1,:);
    rsiBScc(i,:) = out(2,:);
    rsiBSavg(i,:) = out(3,:);
    out = StochPlusRSI(hi(i,:),lo(i,:),cl(i,:));
    SPrsibnd(i,:) = out(1,:);
    SPrsirrfxrsi(i,:) = out(2,:);
    out = AvgSentOsc(op(i,:),hi(i,:),lo(i,:),cl(i,:));
    ASObulls(i,:) = out(1,:);
    ASObears(i,:) = out(2,:);
    out = AMA(hi(i,:),lo(i,:),cl(i,:));
    AMAarsi(i,:) = out(1,:);
    AMAkama(i,:) = out(2,:);
    AMAMAMA(i,:) = out(3,:);
    AMAFAMA(i,:) = out(4,:);
    out = ScalpBigSnapper(hi(i,:),lo(i,:),cl(i,:),vol(i,:));
    SBSSTrendUp(i,:) = out(1,:);
    SBSSTrendDown(i,:) = out(2,:);
    SBSma_fast(i,:) = out(3,:);
    SBSma_medium(i,:) = out(4,:);
    SBSma_slow(i,:) = out(5,:);
    SBSma_coloured(i,:) = out(6,:);
    SBSbasis(i,:) = out(7,:);
    SBSupper(i,:) = out(8,:);
    SBSlower(i,:) = out(9,:);
    out = Scalpatrvwap(hi(i,:),lo(i,:),cl(i,:),vol(i,:));
    Scatrvwaprsi(i,:) = out(1,:);
    Scatrvwapvol(i,:) = out(2,:);
    Scatrvwapvwap(i,:) = out(3,:);
    Scatrvwapma1(i,:) = out(4,:);
    Scatrvwapma2(i,:) = out(5,:);
    out = Scalptma(hi(i,:),lo(i,:),cl(i,:));
    Scrtmassi(i,:) = out(1,:);
    Scrtmatma(i,:) = out(2,:);
    Scrtmatmah(i,:) = out(3,:);
    Scrtmatmal(i,:) = out(4,:);
    out = ScalpBollAwe(hi(i,:),lo(i,:),cl(i,:));
    ScrBollAwebb_basis(i,:) = out(1,:);
    ScrBollAwefast_ma(i,:) = out(2,:);
    ScrBollAwebb_upper(i,:) = out(3,:);
    ScrBollAwebb_lower(i,:) = out(4,:);
    ScrBollAwexSMA1_SMA2(i,:) = out(5,:);
    ScrBollAwebb_sqz_upper(i,:) = out(4,:);
    ScrBollAwebb_sqz_lower(i,:) = out(5,:);
    out = Scalprsimacd(cl(i,:));
    Scrsimacdosc(i,:) = out(1,:);
    Scrsimacdfast_ma(i,:) = out(2,:);
    Scrsimacdslow_ma(i,:) = out(3,:);
    Scrsimacdsignal(i,:) = out(4,:);
    Scrsimacdhist(i,:) = out(5,:);
    Scrsimacdmacd(i,:) = out(6,:);
    out = ScalpNSDTmidline(hi(i,:),lo(i,:));
    Scnsdtday_high(i,:) = out(1,:);
    Scnsdtday_low(i,:) = out(2,:);
    ScnsdtMidlineValue(i,:) = out(3,:);
    out = ScalpAttrition(hi(i,:),lo(i,:),cl(i,:));
    ScAttsma(i,:) = out(1,:);
    ScAtttop1(i,:) = out(2,:);
    ScAtttop2(i,:) = out(3,:);
    ScAtttop3(i,:) = out(4,:);
    ScAttbott1(i,:) = out(5,:);
    ScAttbott2(i,:) = out(6,:);
    ScAttbott3(i,:) = out(7,:);
    ScAttvidya(i,:) = out(8,:);
    out = Scalpsnr(hi(i,:),lo(i,:),cl(i,:));
    Scsnrsmooth(i,:) = out(1,:);
    Scsnrdetrender(i,:) = out(2,:);
    Scsnrsnr(i,:) = out(3,:);
    Scsnrper(i,:) = out(4,:);
    Scsnrsre(i,:) = out(5,:);
    Scsnrpim(i,:) = out(6,:);
    Scsnrprange(i,:) = out(7,:);
    out = ScalpSupBP(cl(i,:));
    ScSbppb(i,:) = out(1,:);
    ScSbprms(i,:) = out(2,:);
    ScSbpsig(i,:) = out(3,:);
    out = ScalpSSLema(hi(i,:),lo(i,:),cl(i,:));
    ScSSLmaFast(i,:) = out(1,:);
    ScSSLmaSlow(i,:) = out(2,:);
    ScSSLmaTurtle(i,:) = out(3,:);
    ScSSLsmaHigh(i,:) = out(4,:);
    ScSSLsmaLow(i,:) = out(5,:);
    ScSSLsslDown(i,:) = out(6,:);
    ScSSLsslUp(i,:) = out(7,:);
    out = ScalpBollB(op(i,:),hi(i,:),lo(i,:),cl(i,:));
    Scbolbasis(i,:) = out(1,:);
    Scbolupper(i,:) = out(2,:);
    Scbollower(i,:) = out(3,:);
    Scbolrsi(i,:) = out(4,:);
    Scbolupshadow(i,:) = out(5,:);
    Scboldownshadow(i,:) = out(6,:);
    Scbolpinbar_h(i,:) = out(7,:);
    Scbolpinbar_l(i,:) = out(8,:);
	out = ScalpSniper(hi(i,:),lo(i,:),cl(i,:)); 
	entryMovingAverage(i,:) = out(1,:);
    trendMovingAverage(i,:) = out(2,:);
    maStop1(i,:) = out(3,:);
    maStop2(i,:) = out(4,:);
    resistanceTop(i,:) = out(5,:);
    stopZoneTop1(i,:) = out(6,:);
    stopZoneTop2(i,:) = out(7,:);
    resistanceBottom(i,:) = out(8,:);
    stopZoneBottom1(i,:) = out(9,:);
    stopZoneBottom2(i,:) = out(10,:);
    out = ScalpKelt(hi(i,:),lo(i,:),cl(i,:));
    ScKelma(i,:) = out(1,:);
	ScKelup(i,:) = out(2,:);
    ScKellow(i,:) = out(3,:);
	ScKel1(i,:) = out(4,:);
    ScKel2(i,:) = out(5,:);
    out = ScalpIntra(cl(i,:));
    ScIntsma1(i,:) = out(1,:);
	ScIntrsi(i,:) = out(2,:);
%}
end
% data plots
k = 12;
%{
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),ScIntsma1(:,k)]),grid on
title(['Scalp Intraday of ',stk{k},' at 30 min June 2020'])
ax(2) = subplot(212);
plot(ax(2),[ScIntrsi(:,k)]),grid on
yline(75)
yline(25)
legend('rsi')
linkaxes(ax,'x')
figure,
plot([cl(:,k),ScKelma(:,k),ScKelup(:,k),ScKellow(:,k),...
    ScKel1(:,k),ScKel2(:,k)]),grid on
title(['Scalp Keltner of ',stk{k},' at 30 min June 2020'])
legend('cl','ma','up','lo','1','2','Location','Best')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),entryMovingAverage(:,k),...
    trendMovingAverage(:,k),maStop1(:,k),...
    maStop2(:,k),resistanceTop(:,k),...
    stopZoneTop1(:,k),stopZoneTop2(:,k)...
    ]),grid on
title(['Scalp ema sys of ',stk{k},' at 30 min June 2020'])
legend('C','mae','mat','stop1','stop2','rtop',...
    'ztop1','ztop2','rbot','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[cl(:,k),resistanceBottom(:,k),stopZoneBottom1(:,k),...
    stopZoneBottom2(:,k)...
]),grid on
legend('C','rbot1','zbot1','zbot2','Location','Best')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),Scbolbasis(:,k),Scbolupper(:,k),...
    Scbollower(:,k)]),grid on
title(['Scalp Bollinger of ',stk{k},' at 30 min June 2020'])
ax(2) = subplot(212);
plot(ax(2),[Scbolrsi(:,k),Scbolpinbar_h(:,k),Scbolpinbar_l(:,k)...
]),grid on
legend('rsi','H','L','Location','Best')
linkaxes(ax,'x')
figure,
plot([cl(:,k),ScSSLmaFast(:,k),ScSSLmaSlow(:,k),...
    ScSSLmaTurtle(:,k),ScSSLsmaHigh(:,k),ScSSLsmaLow(:,k),...
    ScSSLsslDown(:,k),ScSSLsslUp(:,k)]),grid on
title(['Scalp SSL of ',stk{k},' at 30 min June 2020'])
legend('C','F','S','T','H','L','sslD','sslU','Location','Best')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Scalp SSL of ',stk{k},' at 30 min June 2020'])
legend('C','sslD','sslU','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[ScSbppb(:,k),ScSbprms(:,k),...
    ScSbpsig(:,k)]),grid on
legend('pb','rms','sig','Location','Best')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),Scsnrsmooth(:,k)]),grid on
title(['Scalp Ehlers snr of ',stk{k},' at 30 min June 2020'])
legend('C','sm','Location','Best')
ax(2) = subplot(212);
% plot(ax(2),[Scsnrsnr(:,k)]),grid on
plot(ax(2),[Scsnrsnr(:,k),Scsnrper(:,k)]),grid on
% legend('det','per','re','im','rng','Location','Best')
legend('snr','per','Location','Best')
linkaxes(ax,'x')
figure,
plot([cl(:,k),ScAttsma(:,k),ScAttvidya(:,k),ScAtttop1(:,k),...
    ScAtttop2(:,k),ScAtttop3(:,k),ScAttbott1(:,k),...
    ScAttbott2(:,k),ScAttbott3(:,k)]),grid on
title(['Scalp SSL of ',stk{k},' at 30 min June 2020'])
legend('C','sma','vidya','t1','t2','t3','b1','b2','b3','Location','Best')
figure,
plot([cl(:,k),Scnsdtday_high(:,k),Scnsdtday_low(:,k),...
    ScnsdtMidlineValue(:,k)]),grid on
title(['Scalp NSDT of ',stk{k},' at 30 min June 2020'])
legend('C','hi','lo','mid','Location','Best')
figure,
ax(1) = subplot(311);
plot(ax(1),[cl(:,k),Scrsimacdfast_ma(:,k),Scrsimacdslow_ma(:,k)]),grid on
title(['Scalp rsi macd of ',stk{k},' at 30 min June 2020'])
legend('C','F','S','Location','Best')
ax(2) = subplot(312);
plot(ax(2),[Scrsimacdmacd(:,k),Scrsimacdsignal(:,k),Scrsimacdhist(:,k)]),grid on
legend('macd','sig','hist','Location','Best')
ax(3) = subplot(313);
plot(ax(3),[Scrsimacdosc(:,k)]),grid on
legend('osc','Location','Best')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),ScrBollAwebb_basis(:,k),...
    ScrBollAwefast_ma(:,k),ScrBollAwebb_upper(:,k),...
    ScrBollAwebb_lower(:,k),...
    ]),grid on
title(['Scalp Intraday of ',stk{k},' at 30 min June 2020'])
legend('C','basis','fast','up','lo','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[ScrBollAwexSMA1_SMA2(:,k)]),grid on
legend('osc')
linkaxes(ax,'x')
figure,
plot([cl(:,k),Scrtmassi(:,k),Scrtmatma(:,k),Scrtmatmah(:,k),...
    Scrtmatmal(:,k)]),grid on
title(['Scalp TMA Bands of ',stk{k},' at 30 min June 2020'])
legend('cl','ssi','tma','tmaH','tmaL','Location','Best')
%}
%{
figure,
ax(1) = subplot(311);
plot(ax(1),[cl(:,k),Scatrvwapvwap(:,k),...
    Scatrvwapma1(:,k),Scatrvwapma2(:,k),...
    ]),grid on
title(['Scalp rsi VWAP of ',stk{k},' at 30 min June 2020'])
legend('C','vwap','ma1','ma2','Location','Best')
ax(2) = subplot(312);
plot(ax(2),[Scatrvwaprsi(:,k)]),grid on
legend('rsi')
ax(3) = subplot(313);
plot(ax(3),[Scatrvwapvol(:,k)]),grid on
legend('atr')
linkaxes(ax,'x')
figure,
plot([cl(:,k),AMAarsi(:,k),AMAkama(:,k),...
    AMAMAMA(:,k),AMAFAMA(:,k)]),grid on
title(['Adaptive MA of ',stk{k},' at 30 min June 2020'])
legend('close','arsi','kama','mama','fama','Location','Best')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Avg Sent Osc of ',stk{k},' at 30 min June 2020'])
ax(2) = subplot(212);
plot(ax(2),[ASObulls(:,k),ASObears(:,k)]),grid on
legend('bull','bear')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Stoch+RSI of ',stk{k},' at 30 min June 2020'])
ax(2) = subplot(212);
plot(ax(2),[SPrsibnd(:,k),SPrsirrfxrsi(:,k)]),grid on
legend('stoch','rsi')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['RSI buysell of ',stk{k},' at 30 min June 2020'])
ax(2) = subplot(212);
plot(ax(2),[rsiBSbb(:,k),rsiBScc(:,k),rsiBSavg(:,k)]),grid on
legend('bb','cc','avg')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),refFilt(:,k)]),grid on
title(['Reflex Ind of ',stk{k},' at 30 min June 2020'])
legend('cl','Filt','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[refReflex(:,k),refatr(:,k)]),grid on
legend('reflex','atr','Location','Best')
linkaxes(ax,'x')
figure,
plot([cl(:,k),ERout_ema(:,k),ERout_emaRsi(:,k)]),grid on
title(['ema + rsi ema of ',stk{k},' at 30 min June 2020'])
legend('C','ema','rsi','Location','Best')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),EMAenve(:,k),EMAenveu(:,k),EMAenvel(:,k)]),grid on
title(['ema Envelope of ',stk{k},' at 30 min June 2020'])
legend('C','ema','up','lo','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[EMAenvbull_f(:,k),EMAenvbear_f(:,k),EMAenvsidewise_f(:,k)]),grid on
legend('bull','bear','side','Location','Best')
ylim([-0.1 1.1])
linkaxes(ax,'x')

figure,
ax(1) = subplot(311);
plot(ax(1),[cl(:,k),tsicciTSI1(:,k)]),grid on
title(['TSI CCI of ',stk{k},' at 30 min June 2020'])
legend('C','n1','Location','Best')
ax(2) = subplot(312);
plot(ax(2),[tsiccibbuy(:,k),tsiccissell(:,k)]),grid on
legend('buy','sell','Location','Best')
ylim([-0.1 1.1])
ax(3) = subplot(313);
plot(ax(3),[tsiccicci(:,k)]),grid on
legend('cci','Location','Best')
linkaxes(ax,'x')

figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Volume ROC of ',stk{k},' at 30 min June 2020'])
legend('C','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[vroc(:,k)]),grid on
legend('vroc','Location','Best')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['VHF of ',stk{k},' at 30 min June 2020'])
ax(2) = subplot(212);
plot(ax(2),[vhf(:,k)]),grid on
legend('vhf')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),macd4e5(:,k)]),grid on
title(['MACD 4 of ',stk{k},' at 30 min June 2020'])
legend('vhf','e5')
ax(2) = subplot(212);
plot(ax(2),[macd4Blue(:,k),macd4Red(:,k),...
    macd4Yellow(:,k),macd4Green(:,k)]),grid on
legend('blue','red','yell','grn')
linkaxes(ax,'x')
%}
%{
figure,
plot([cl(:,k),Tirtlh(:,k),Tirclh(:,k),Tirblh(:,k),Tireh(:,k),...
    Tirel(:,k),Tirrh(:,k),Tirrl(:,k)]),grid on
title(['Tirone S/R of ',stk{k},' at 30 min June 2020'])
legend('cl','tlh','clh','blh','eh','el','rh','rl','Location','Best')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Deriv Osc of ',stk{k},' at 30 min June 2020'])
legend('cl')
ax(2) = subplot(212);
plot(ax(2),[derrsi(:,k),ders2(:,k)]),grid on
legend('rsi','s2','Location','Best')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['RSI enclosed by Bollinger of ',stk{k},' at 30 min June 2020'])
legend('C','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[rbbbb_s(:,k),rbbbasis(:,k),...
    rbbupper(:,k),rbblower(:,k)]),grid on
legend('rsi','basis','up','lo','Location','Best')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['MFI enclosed by Bollinger of ',stk{k},' at 30 min June 2020'])
legend('C','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[mfbbb_s(:,k),mfbbasis(:,k),...
    mfbupper(:,k),mfblower(:,k)]),grid on
legend('mfi','basis','up','lo','Location','Best')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),BeBus_ma(:,k)]),grid on
title(['Bulls/Bears Strength of ',stk{k},' at 30 min June 2020'])
legend('C','BBma','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[BeBus_bulls(:,k),BeBus_bears(:,k)]),grid on
legend('bull','bear','Location','Best')
linkaxes(ax,'x')
figure,
plot([cl(:,k),ZLE(:,k)]),grid on
title(['Almost Zero Lag of ',stk{k},' at 30 min June 2020'])
legend('C','zle','Location','Best')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k),kbwama(:,k),kbwamalow(:,k),...
    kbwamahigh(:,k)]),grid on
title(['kama binary wave of ',stk{k},' at 30 min June 2020'])
legend('bw','kama','lo','hi','Location','Best')
ax(2) = subplot(212);
plot(ax(2),[kbwbw(:,k)...
]),grid on
ylim([-1.1 1.1])
legend('bw','Location','Best')
linkaxes(ax,'x')
figure,
ax(1) = subplot(311);
plot(ax(1),[cl(:,k)]),grid on
title(['RM Oscillator of ',stk{k},' at 30 min June 2020'])
legend('C','Location','Best')
ax(2) = subplot(312);
plot(ax(2),[rmwrmo(:,k),rmwSwingTrd2(:,k),rmwSwingTrd3(:,k)...
]),grid on
% ylim([-1.1 1.1])
legend('rmo','ST2','ST3','Location','Best')
ax(3) = subplot(313);
plot(ax(3),[rmwbuy(:,k),rmwsell(:,k)...
]),grid on
ylim([-0.1 1.1])
legend('buy','sell','Location','Best')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['true strength index of ',stk{k},' at 30 min June 2020'])
legend('close')
ax(2) = subplot(212);
plot(ax(2),[tsiidx(:,k)]),grid on
yline(25)
yline(-25)
legend('tsi')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Balance of Power of ',stk{k},' at 30 min June 2020'])
legend('close')
ax(2) = subplot(212);
plot(ax(2),[bop(:,k),bopsm(:,k)]),grid on
legend('bop','smbop')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Tushar Chande Qstick of ',stk{k},' at 30 min June 2020'])
legend('close')
legend('cl')
ax(2) = subplot(212);
plot(ax(2),[tsqs2(:,k)]),grid on
legend('s2')
linkaxes(ax,'x')
%}
%{
figure,
plot([cl(:,k),frama(:,k)]),grid on
title(['FRAMA of ',stk{k},' at 30 min June 2020'])
legend('cl','frama')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Forecast Oscillator of ',stk{k},' at 30 min June 2020'])
ax(2) = subplot(212);
plot(ax(2),[FOpf(:,k),FOpfma(:,k)]),grid on
legend('pf','pfma')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Ulcer Index of ',stk{k},' at 30 min June 2020'])
ax(2) = subplot(212);
plot(ax(2),[uiui(:,k),uico(:,k)]),grid on
legend('ui','cutoff')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['On Balance Vol of ',stk{k},' at 30 min June 2020'])
ax(2) = subplot(212);
plot(ax(2),[obvobv_osc(:,k)]),grid on
legend('osOsc')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Kairi Index of ',stk{k},' at 30 min June 2020'])
ax(2) = subplot(212);
plot(ax(2),[kairi(:,k)]),grid on
legend('kairi')
linkaxes(ax,'x')
figure,
ax(1) = subplot(311);
plot(ax(1),[cl(:,k),sctfastMA(:,k),sctslowMA(:,k)]),grid on
title(['Schaff Trend Cycle of ',stk{k},' at 30 min June 2020'])
legend('C','fast','slow')
ax(2) = subplot(312);
plot(ax(2),[sctm(:,k)]),grid on
legend('macd')
ax(3) = subplot(313);
plot(ax(3),[sctpff(:,k)]),grid on
legend('sct')
linkaxes(ax,'x')
figure,
plot([cl(:,k),starcbasis(:,k),...
    starcul(:,k),starcll(:,k)]),grid on
title(['STARC Bands of ',stk{k},' at 30 min June 2020'])
legend('C','basis','ul','ll')
figure,
ax(1) = subplot(411);
plot(ax(1),[cl(:,k)]),grid on
title(['Pretty Good Oscillator of ',stk{k},' at 30 min June 2020'])
legend('C')
ax(2) = subplot(412);
plot(ax(2),[pgopgo(:,k)]),grid on
legend('pgo','Location','Best')
ax(3) = subplot(413);
plot(ax(3),[pgoravi(:,k)]),grid on
legend('ravi','Location','Best')
ax(4) = subplot(414);
plot(ax(4),[pgotii(:,k)]),grid on
legend('tii','Location','Best')
linkaxes(ax,'x')
figure,
ax(1) = subplot(211);
plot(ax(1),[cl(:,k)]),grid on
title(['Chande Momentum Osc of ',stk{k},' at 30 min June 2020'])
ax(2) = subplot(212);
plot(ax(2),[Chcmo(:,k)]),grid on
legend('cmo')
linkaxes(ax,'x')
figure,
ax(1) = subplot(311);
plot(ax(1),[cl(:,k)]),grid on
title(['Inverse Fisher of ',stk{k},' at 30 min June 2020'])
legend('close')
ax(2) = subplot(312);
plot(ax(2),[ifishrsi(:,k),ifishmfi(:,k)]),grid on
legend('rsi','mfi','Location','Best')
ax(3) = subplot(313);
plot(ax(3),[ifishrsifish(:,k),ifishmfifish(:,k)]),grid on
legend('rsiIF','mfiIF','Location','Best')
linkaxes(ax,'x')
figure,
ax(1) = subplot(311);
plot(ax(1),[cl(:,k)]),grid on
title(['Twiggs Money Flow of ',stk{k},' at 30 min June 2020'])
legend('close')
ax(2) = subplot(312);
plot(ax(2),[tmfadv(:,k),tmfwv(:,k),...
    tmfwmV(:,k),tmfwmA(:,k)]),grid on
legend('adv','wv','wmV','wmA','Location','Best')
ax(3) = subplot(313);
plot(ax(3),[tmftmf(:,k)]),grid on
legend('tmf','Location','Best')
linkaxes(ax,'x')
%}

%{
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

%{
http://www.incrediblecharts.com/indicators/twiggs_money_flow.php
https://www.tradingview.com/script/Jccjg8CR-Indicators-Twiggs-Money-Flow-TMF-Wilder-s-MA-WiMA/#tc73426
study("Twiggs Money Flow [LazyBear]", shorttitle="TMF_LB")
length = input( 21, "Period")
WiMA(src, length) => 
    MA_s=(src + nz(MA_s[1] * (length-1)))/length
    MA_s
    
hline(0)
tr_h=max(close[1],high)
tr_l=min(close[1],low)
tr_c=tr_h-tr_l
adv=volume*((close-tr_l)-(tr_h-close))/ iff(tr_c==0,9999999,tr_c)
wv=volume+(volume[1]*0)
wmV= WiMA(wv,length)
wmA= WiMA(adv,length)
tmf= iff(wmV==0,0,wmA/wmV)
%}
function out = twiggMF(H,L,C,V)
close = C;
high = H;
low = L;
volume = V;
Length = 21;
Z = zeros(1,length(high));
persistent Xtwmf
if isempty(Xtwmf)
    Xtwmf.Cp = close;
    Xtwmf.Vp = volume;
    Xtwmf.wmVp = volume;
    Xtwmf.wmAp = Z;
end
tr_h = max(Xtwmf.Cp,high);
tr_l = min(Xtwmf.Cp,low);
tr_c = tr_h - tr_l;
tmp = tr_c;
tmp(tr_c==0) = 9999999;
adv = volume.*((close-tr_l)-(tr_h-close))./tmp;
wv = volume+(Xtwmf.Vp.*0);
wmV = (wv + Xtwmf.wmVp*(Length-1))/Length;
wmA = (adv + Xtwmf.wmAp*(Length-1))/Length;
tmf = wmA./wmV;
tmf(wmV==0) = 0;
Xtwmf.Cp = close;
Xtwmf.Vp = volume;
Xtwmf.wmVp = wmV;
Xtwmf.wmAp = wmA;
out(1,:) = adv;
out(2,:) = wv;
out(3,:) = wmV;
out(4,:) = wmA;
out(5,:) = tmf;
end
%{
study("Inverse Fisher Transform RSI [LazyBear]", shorttitle="IFTRSI_LB")
s=close
length=input(14, "RSI length")
lengthwma=input(9, title="Smoothing length")
RSI Calculation
RSI = 100 – 100/ (1 + RS)
RS = Average Gain of n days UP  / Average Loss of n days DOWN

change = change(close)
gain = change >= 0 ? change : 0.0
loss = change < 0 ? (-1) * change : 0.0
avgGain = rma(gain, 14)
avgLoss = rma(loss, 14)
rs = avgGain / avgLoss
rsi = 100 - (100 / (1 + rs))

MFI Calculation
There are four separate steps to calculate the Money Flow Index. The following example is for a 14 Period MFI:

1. Calculate the Typical Price

(High + Low + Close) / 3 = Typical Price
2. Calculate the Raw Money Flow

Typical Price x Volume = Raw Money Flow
3. Calculate the Money Flow Ratio

(14 Period Positive Money Flow) / (14 Period Negative Money Flow)
Positive Money Flow is calculated by summing the Money Flow of all of the days in the period where Typical Price is higher than the previous period Typical Price.

Negative Money Flow is calculated by summing the Money Flow of all of the days in the period where Typical Price is lower than the previous period Typical Price.
4. Calculate the Money Flow Index.

100 - 100/(1 + Money Flow Ratio) = Money Flow Index)

The following inverse Fisher (calc_ifish) is applied to the input.
calc_ifish(series, lengthwma) =>
    v1=0.1*(series-50)
    v2=wma(v1,lengthwma)
    ifish=(exp(2*v2)-1)/(exp(2*v2)+1)
    ifish

plot(calc_ifish(rsi(s, length), lengthwma), color=orange, linewidth=2)
%}
function out = ifishrsimfi(C,V)
s = C;
Length = 14;
alph = 1/Length;
lengthwma = 9;
Z = zeros(1,length(s));
bwma = lengthwma:-1:1;
bwma = bwma/sum(bwma);
persistent Xifish
if isempty(Xifish)
    Xifish.rsiwin = repmat(Z,Length,1);
    Xifish.rsiv1win = repmat(Z,Length,1);
    Xifish.mfiwin = repmat(Z,Length,1);
    Xifish.mfiv1win = repmat(Z,Length,1);
    Xifish.volwin = repmat(V,Length,1);
    Xifish.sP = s;
    Xifish.gainP = s;
    Xifish.lossP = s;
    Xifish.avgUp = Z;
    Xifish.avgDp = Z;
    Xifish.avgmfiUp = Z;
    Xifish.avgmfiDp = Z;
end
change = s - Xifish.sP;
Xifish.rsiwin = [change;Xifish.rsiwin(1:end-1,:)];
Xifish.volwin = [V;Xifish.volwin(1:end-1,:)];
Xifish.mfiwin = [V.*change;Xifish.mfiwin(1:end-1,:)];
% rsi calcs
tmpU = Xifish.rsiwin;
tmpU(tmpU<0)=0;
tmpD = Xifish.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*Xifish.avgUp + alph*avgU;
emaavgD = (1-alph)*Xifish.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
rs = emaavgU./tmp;
rsi = 100 - (100 ./ (1 + rs));
v1 = 0.1*(rsi - 50);
Xifish.rsiv1win = [v1;Xifish.rsiv1win(1:end-1,:)];
v2 = sum(bwma'.*Xifish.rsiv1win(1:lengthwma,:));
ifishrsi = (exp(2*v2)-1)./(exp(2*v2)+1);
% mfi calcs
tmp = Xifish.mfiwin./sum(Xifish.volwin);
tmpU = tmp;
tmpU(tmpU<0)=0;
tmpD = tmp;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgmfU = (1-alph)*Xifish.avgmfiUp + alph*avgU;
emaavgmfD = (1-alph)*Xifish.avgmfiDp + alph*avgD;
tmp = emaavgmfD;
tmp(tmp==0) = 1;
mf = emaavgmfU./tmp;
mfi = 100 - (100 ./ (1 + mf));
v1 = 0.1*(mfi - 50);
Xifish.mfiv1win = [v1;Xifish.mfiv1win(1:end-1,:)];
v2 = sum(bwma'.*Xifish.mfiv1win(1:lengthwma,:));
ifishmfi = (exp(2*v2)-1)./(exp(2*v2)+1);
Xifish.sP = s;
Xifish.avgUp = emaavgU;
Xifish.avgDp = emaavgD;
Xifish.avgmfiUp = emaavgmfU;
Xifish.avgmfiDp = emaavgmfD;
out(1,:) = rsi;
out(2,:) = mfi;
out(3,:) = ifishrsi;
out(4,:) = ifishmfi;
end
%{
https://www.tradingview.com/script/ogmWth5h-Chande-Momentum-Oscillator/
https://www.tradingview.com/scripts/chandemo/
study("Chande Momentum Oscillator", shorttitle="CMO")
This indicator was developed and described by Tushar S. Chande and Stanley Kroll in their book "The New Technical Trader" (1994, Chapter 5: New Momentum Oscillators).length = input(title="Length", type=integer, defval=9)
obLevel = input(title="Overbought Level", type=integer, defval=50)
osLevel = input(title="Oversold Level", type=integer, defval=-50)
highlightBreakouts = input(title="Highlight Overbought/Oversold Breakouts ?", type=bool, defval=true)
src = input(title="Source", type=source, defval=close)

mom = change(src)

upSum = sum(max(mom, 0), length)
downSum = sum(-min(mom, 0), length)

cmo = 100 * (upSum - downSum) / (upSum + downSum)
%}
function out = ChandeCMO(C)
Length = 9;
src = C;
Z = zeros(1,length(src));
persistent Xcmo
if isempty(Xcmo)
    Xcmo.momwin = repmat(Z,Length,1);
    Xcmo.srcP = src;
end
Xcmo.momwin = [src-Xcmo.srcP;Xcmo.momwin(1:end-1,:)];
mom = Xcmo.momwin;
upSum = sum(max(mom, 0));
downSum = sum(-min(mom, 0));
den = upSum + downSum;
den(den==0) = 1;
cmo = 100 * (upSum - downSum) ./ den;
Xcmo.srcP = src;
out(1,:) = cmo;
end
%{
https://www.tradingview.com/script/GhxOzF0z-3-new-Indicators-PGO-RAVI-TII/
study(title="Pretty Good Oscillator [LazyBear]", shorttitle="PGO_LB")
length=input(89)
pgo = (close - sma(close, length))/ema(tr, length)
https://www.tradingview.com/script/pZkdfat6-Range-Action-Verification-Index-RAVI/fastLength = input(title="Fast MA Length", type=integer, defval=7, minval=1)
study("Range Action Verification Index (RAVI)", shorttitle="RAVI")
fastMAInput = input(title="Fast MA", defval="SMA", options=["EMA", "SMA", "VWMA", "WMA"])
slowLength = input(title="Slow MA Length", type=integer, defval=65, minval=1)
slowMAInput = input(title="Slow MA", defval="SMA", options=["EMA", "SMA", "VWMA", "WMA"])
breakoutLevel = input(title="Breakout Level", type=float, minval=0, step=0.1, defval=3)
src = input(title="Source", type=source, defval=close)
highlightMovements = input(title="Highlight Movements ?", type=bool, defval=true)
highlightBreakouts = input(title="Highlight Level Breakouts ?", type=bool, defval=true)

fastMA = iff(fastMAInput == "EMA", ema(src, fastLength),
	 iff(fastMAInput == "SMA", sma(src, fastLength),
	 iff(fastMAInput == "VWMA", vwma(src, fastLength),
	 iff(fastMAInput == "WMA", wma(src, fastLength),
	 na))))

slowMA = iff(slowMAInput == "EMA", ema(src, slowLength),
	 iff(slowMAInput == "SMA", sma(src, slowLength),
	 iff(slowMAInput == "VWMA", vwma(src, slowLength),
	 iff(slowMAInput == "WMA", wma(src, slowLength),
	 na))))

ravi = 100 * abs(fastMA - slowMA) / slowMA
https://www.tradingview.com/script/KYZOCAsk-Trend-Intensity-Index/
study("Trend Intensity Index", shorttitle="TII")
majorLength = input(title="Major Length", type=integer, defval=60)
minorLength = input(title="Minor Length", type=integer, defval=30)
upperLevel = input(title="Upper Level", type=integer, defval=80)
lowerLevel = input(title="Lower Level", type=integer, defval=20)
highlightBreakouts = input(title="Highlight Overbought/Oversold Breakouts ?", type=bool, defval=true)
src = input(title="Source", type=source, defval=close)

sma = sma(src, majorLength)

positiveSum = 0.0
negativeSum = 0.0

for i = 0 to minorLength - 1
    price = nz(src[i])
    avg = nz(sma[i])
    positiveSum := positiveSum + (price > avg ? price - avg : 0)
    negativeSum := negativeSum + (price > avg ? 0 : avg - price)

tii = 100 * positiveSum / (positiveSum + negativeSum)
%}
function out = pgo3(H,L,C)
src = C;
Lenpgo = 89;
fastLength = 7;
slowLength = 65;
majorLength = 60;
minorLength = 30;
ap = 2/(Lenpgo+1);
persistent Xpgo3
if isempty(Xpgo3)
    Xpgo3.srcwin = repmat(src,Lenpgo,1);
    Xpgo3.smatiiwin = repmat(src,minorLength,1);
    tr = max(H-L,max(abs(H-C),abs(L-C)));
    Xpgo3.epgop = tr;
    Xpgo3.Cp = C;
end
Xpgo3.srcwin = [src;Xpgo3.srcwin(1:end-1,:)];
% pgo
tr = max(H-L,max(abs(H-Xpgo3.Cp),abs(L-Xpgo3.Cp)));
ema = (1-ap)*Xpgo3.epgop + ap*tr;
sma = sum(Xpgo3.srcwin)/Lenpgo;
pgo = (src - sma)./ema;
% ravi
fastMA = sum(Xpgo3.srcwin(1:fastLength,:))/fastLength;
slowMA = sum(Xpgo3.srcwin(1:slowLength,:))/slowLength;
ravi = 100 * abs(fastMA - slowMA) ./ slowMA;
% trend intensity index
smatii = sum(Xpgo3.srcwin(1:majorLength,:))/majorLength;
Xpgo3.smatiiwin = [smatii;Xpgo3.smatiiwin(1:end-1,:)];
positiveSum = 0.0;
negativeSum = 0.0;
for i = 1:minorLength
    price = Xpgo3.srcwin(i,:);
    avg = Xpgo3.smatiiwin(i,:);
    tmp1 = price - avg;
    tmp1(price < avg) = 0;
    positiveSum = positiveSum + tmp1;
    tmp1 = avg - price;
    tmp1(price > avg) = 0;
    negativeSum = negativeSum + tmp1;
end
tii = 100 * positiveSum ./ (positiveSum + negativeSum);
Xpgo3.Cp = C;
Xpgo3.epgop = ema;
out(1,:) = pgo;
out(2,:) = ravi;
out(3,:) = tii;
end
%{
https://www.tradingview.com/script/yTMOV9NM-Indicator-STARC-Bands/
study(title = "STARC Bands [LazyBear]", shorttitle="StarcBands_LB", overlay=true)
src = close
length=input(15)
tr_custom() => 
    x1=high-low
    x2=abs(high-close[1])
    x3=abs(low-close[1])
    max(x1, max(x2,x3))
    
atr_custom(x,y) => 
    sma(x,y)
    
tr_v = tr_custom()
basis=sma(src, 6)
acustom=(2*atr_custom(tr_v, length))
ul=basis+acustom
ll=basis-acustom
%}
function out = starc(H,L,C)
high = H;
low = L;
close = C;
Length = 15;
Lbas = 6;
persistent Xstarc
if isempty(Xstarc)
    Xstarc.Cwin = repmat(close,Lbas,1);
    Xstarc.tr_vwin = repmat(high-low,Length,1);
    Xstarc.Cp = close;
end
Xstarc.Cwin = [close;Xstarc.Cwin(1:end-1,:)];
x1 = high - low;
x2 = abs(high - Xstarc.Cp);
x3 = abs(low - Xstarc.Cp);
tr_v = max(x1,max(x2,x3));
Xstarc.tr_vwin = [tr_v;Xstarc.tr_vwin(1:end-1,:)];
basis = sum(Xstarc.Cwin)/Lbas;
atr_custom = sum(Xstarc.tr_vwin)/Length;
acustom = 2*atr_custom;
ul=basis+acustom;
ll=basis-acustom;
Xstarc.Cp = close;
out(1,:) = basis;
out(2,:) = ul;
out(3,:) = ll;
end
%{
https://www.tradingview.com/script/dbxXeuw2-Indicator-Schaff-Trend-Cycle-STC/
study(title="Schaff Trend Cycle [LazyBear]", shorttitle="STC_LB", overlay=true)
length=input(10)
fastLength=input(23)
slowLength=input(50)
macd(source, fastLength, slowLength) =>
    fastMA = ema(source, fastLength)
    slowMA = ema(source, slowLength)
    macd = fastMA - slowMA
    macd
stc(length, fastLength, slowLength) => 
    factor=input(0.5)  
    m = macd(close,fastLength,slowLength)     
    v1 = lowest(m, length)
    v2 = highest(m, length) - v1    
    f1 = (v2 > 0 ? ((m - v1) / v2) * 100 : nz(f1[1])) 
    pf = (na(pf[1]) ? f1 : pf[1] + (factor * (f1 - pf[1]))) 
    v3 = lowest(pf, length) 
    v4 = highest(pf, length) - v3     
    f2 = (v4 > 0 ? ((pf - v3) / v4) * 100 : nz(f2[1])) 
    pff = (na(pff[1]) ? f2 : pff[1] + (factor * (f2 - pff[1])))
    pff
%}
function out = Schaff(C)
Length = 10;
fastLength = 23;
slowLength = 50;
af = 2/(fastLength+1);
as = 2/(slowLength+1);
factor = 0.5;
Z = zeros(1,length(C));
persistent Xsch
if isempty(Xsch)
    Xsch.fmap = C;
    Xsch.smap = C;
    Xsch.macdwin = repmat(Z,Length,1);
    Xsch.pfwin = repmat(Z,Length,1);
    Xsch.f1p = Z;
    Xsch.pfp = Z;
    Xsch.f2p = Z;
    Xsch.pffp = Z;
end
fastMA = (1-af)*Xsch.fmap + af*C;
slowMA = (1-as)*Xsch.smap + as*C;
m = fastMA - slowMA; % MACD
Xsch.macdwin = [m;Xsch.macdwin(1:end-1,:)];
v1 = min(Xsch.macdwin);
v2 = max(Xsch.macdwin) - v1;
f1 = Xsch.f1p;
k = find(v2>0);
f1(k) = (m(k) - v1(k)) ./ v2(k) * 100;
pf = Xsch.pfp + factor * (f1 - Xsch.pfp);
k = find(Xsch.pfp);
pf(k) = f1(k);
Xsch.pfwin = [pf;Xsch.pfwin(1:end-1,:)];
v3 = min(Xsch.pfwin);
v4 = max(Xsch.pfwin) - v3;
f2 = Xsch.f2p;
k = find(v4>0);
f2(k) = (pf(k) - v3(k)) ./ v4(k) * 100;
pff = Xsch.pffp + factor * (f2 - Xsch.pffp);
k = find(Xsch.pffp);
pff(k) = f2(k);
Xsch.fmap = fastMA;
Xsch.smap = slowMA;
Xsch.f1p = f1;
Xsch.pfp = pf;
out(1,:) = pff;
out(2,:) = m;
out(3,:) = fastMA;
out(4,:) = slowMA;
end
%{
https://www.tradingview.com/script/xzRPAboO-Indicator-Kairi-Relative-Index-KRI/
// http://www.investopedia.com/articles/forex/09/kairi-relative-strength-index.asp
// The Kairi Relative Index is considered an oscillator as well as a leading indicator.
//

study("Kairi Relative Index [LazyBear]", shorttitle="KAIRI_LB")
length=input(14)
ki(src)=>
    ((src - sma(src, length))/sma(src, length)) * 100
plot(ki(close), color=red, linewidth=2)
%}
function out = kairiIdx(C)
Length = 14;
src = C;
persistent Xkairi
if isempty(Xkairi)
    Xkairi.srcwin = repmat(src,Length,1);
end
Xkairi.srcwin = [src;Xkairi.srcwin(1:end-1,:)];
tmp = sum(Xkairi.srcwin)/Length;
ki = (src - tmp)./tmp*100;
out = ki;
end
%{
https://www.tradingview.com/script/Ox9gyUFA-Indicator-OBV-Oscillator/
study(title="On Balance Volume Oscillator [LazyBear]", shorttitle="OBVOSC_LB")
src = close
length=input(20)
obv(src) => cum(change(src) > 0 ? volume : change(src) < 0 ? -volume : 0*volume)
os=obv(src)
obv_osc = (os - ema(os,length))
obc_color=obv_osc > 0 ? green : red
%}
function out = OBVosc(C,V)
src = C;
Length = 20;
a = 2/(Length+1);
Z = zeros(1,length(src));
persistent Xobvosc
if isempty(Xobvosc)
    Xobvosc.Cp = src;
    Xobvosc.obvp = Z;
    Xobvosc.osp = Z;
end
tmp = src - Xobvosc.Cp;
Up = find(tmp>0);
Dn = find(tmp<0);
obv = Xobvosc.obvp;
obv(Up) = obv(Up) + V(Up);
obv(Dn) = obv(Dn) + V(Dn);
os = obv;
ema = (1-a)*Xobvosc.osp + a*os;
obv_osc = os - ema;
Xobvosc.Cp = src;
Xobvosc.osp = ema;
out(1,:) = os;
out(2,:) = ema;
out(3,:) = obv_osc;
end
%{
https://www.tradingview.com/script/QuqgdJgF-Indicator-Ulcer-Index/
study(title = "Ulcer Index [LazyBear]", shorttitle="UlcerIndex_LB")
length=input(10)
cutoff=input(5)
hcl=highest(close,length)
r=100.0*((close-hcl)/hcl)
ui=sqrt(sum(pow(r,2), length)/length)
%}
function out = ulcerIndex(C)
Length = 10;
cutoff = 5;
persistent Xuidx
if isempty(Xuidx)
    Xuidx.Cwin = repmat(C,Length,1);
    Xuidx.r2win = repmat(C,Length,1);
end
Xuidx.Cwin = [C;Xuidx.Cwin(1:end-1,:)];
hcl = max(Xuidx.Cwin);
r = 100*(C-hcl)./hcl;
Xuidx.r2win = [power(r,2);Xuidx.r2win(1:end-1,:)];
ui = sqrt(sum(Xuidx.r2win)/Length);
out(1,:) = ui;
out(2,:) = cutoff;
end
%{
https://www.tradingview.com/script/CMSQGuGP-Indicator-Forecast-Oscillator-a-BB-extrapolation-experiment/
study(title = "Forecast Oscillator [LazyBear]", shorttitle="ForecastOsc_LB")
pf=100*((close[0]-close[1])/close[0])
//plot(pf, color=green)
plot(sma(pf,3), color=orange)
%}
function out = forOsc(C)
t = 3;
persistent Xfosc
if isempty(Xfosc)
    Xfosc.Cp = C;
    Xfosc.pfwin = repmat(zeros(1,length(C)),t,1);
end
pf = 100*(C - Xfosc.Cp)./C;
Xfosc.pfwin = [pf;Xfosc.pfwin(1:end-1,:)];
pfma = sum(Xfosc.pfwin)/t;
Xfosc.Cp = C;
out(1,:) = pf;
out(2,:) = pfma;
end
%{
https://pastebin.com/6xyjP2ST
https://www.tradingview.com/chart/BTCUSD/dGX0ADIk-Indicator-Fractal-Adaptive-Moving-Average-FRAMA/
study(title = "Fractal Adaptive Moving Average [LazyBear]", shorttitle="FRAMA_LB", overlay=true)
length=input(16, title="Period of Fractal AMA (even #)",minval=4,maxval=60)
w=input(-4.6, title="W", type=float)
src=hl2
n3=(highest(high,length)-lowest(low,length))/length
hd2=highest(high,length/2)
ld2=lowest(low,length/2)
n2=(hd2-ld2)/(length/2)
n1=(nz(hd2[round(length/2)])-nz(ld2[round(length/2)]))/round(length/2)
dimen=(n1>0 and n2>0 and n3>0 ? (log(n1+n2)-log(n3))/log(2) : 0)
alpha=exp(w*(dimen-1))
sc=(alpha<.01 ? .01 : (alpha>1 ? 1 : alpha))
//prev(x) => not na(x[1]) ? x[1] : 0
frama=(cum(1)<=2*length ? src : src*sc+nz(frama[1])*(1-sc))
%}
function out = FRAMA(H,L)
src = (H+L)/2;
Length = 16;
w = -4.6;
persistent Xframa
if isempty(Xframa)
    Xframa.hiwin = repmat(H,Length,1);
    Xframa.lowin = repmat(L,Length,1);
    Xframa.hd2win = repmat(H,Length/2,1);
    Xframa.ld2win = repmat(L,Length/2,1);
    Xframa.framap = src;
end
Xframa.hiwin = [H;Xframa.hiwin(1:end-1,:)];
Xframa.lowin = [L;Xframa.lowin(1:end-1,:)];
n3 = (max(Xframa.hiwin)-min(Xframa.lowin))/Length;
hd2 = max(Xframa.hiwin(1:Length/2,:));
ld2 = min(Xframa.lowin(1:Length/2,:));
Xframa.hd2win = [hd2;Xframa.hd2win(1:end-1,:)];
Xframa.ld2win = [ld2;Xframa.ld2win(1:end-1,:)];
n2 = (hd2-ld2)/(Length/2);
n1 = (Xframa.hd2win(end,:)-Xframa.ld2win(end,:))./...
    round(Length/2);
dimen = (log(n1+n2)-log(n3))/log(2);
dimen(~(n1>0 & n2>0 & n3>0)) = 0;
alpha = exp(w*(dimen-1));
tmp = alpha;
tmp(alpha>1) = 1;
sc = tmp;
sc(alpha<.01) = 0.01;
frama = src.*sc + Xframa.framap.*(1-sc);
Xframa.framap = frama;
out(1,:) = frama;
end
%{
https://www.tradingview.com/script/ssL68jQu-Indicator-Chande-s-QStick-Indicator/
study(title = "Tushar Chande's QStick [LazyBear]", 
shorttitle="QStick_LB")
length=input(8)
hline(0)
s2=sma((close-open),length)
c_color=s2 < 0 ? (s2 < s2[1] ? red : lime) : (s2 >= 0 ? (s2 > s2[1] ? lime : red) : na)
%}
function out = TSQstick(O,C)
Length = 8;
close = C;
open = O;
persistent Xtsqs
if isempty(Xtsqs)
    Xtsqs.win = repmat(close-open,Length,1);
end
Xtsqs.win = [close-open;Xtsqs.win(1:end-1,:)];
s2 = sum(Xtsqs.win)/Length;
out = s2;
end
%{
https://www.tradingview.com/script/tzZx7dTy-Indicator-Balance-Of-Power/
study(title = "Balance of Power [LazyBear]",shorttitle="BOP_LB")
PlotEMA=input(true, "Plot SMA?", type=bool)
PlotOuterLine=input(false, "Plot Outer line?", type=bool )
length=input(14, title="MA length")
BOP=(close - open) / (high - low)
b_color=(BOP>=0 ? (BOP>=BOP[1] ? green : orange) : (BOP>=BOP[1] ? orange : red))
hline(0)
plot(BOP, color=b_color, style=columns, linewidth=3)
plot(PlotOuterLine?BOP:na, color=gray, style=line, linewidth=2)
plot(PlotEMA?sma(BOP, length):na, color=navy, linewidth=2)
%}
function out = BOP(O,H,L,C)
Length = 14;
bop = (C - O)./(H - L);
persistent Xbop
if isempty(Xbop)
    Xbop.win = repmat(bop,Length,1);
end
Xbop.win = [bop;Xbop.win(1:end-1,:)];
smbop = sum(Xbop.win)/Length;
out(1,:) = bop;
out(2,:) = smbop;
end
%{
https://www.tradingview.com/script/UQjj3yax-Indicator-True-Strength-Index/
// @credits http://en.wikipedia.org/wiki/True_strength_index
// 
study(title = "True Strength Index [LazyBear]", shorttitle="LB_TSI", overlay=false)
r=input(25, title="Momentum Smoothing 1")
s=input(13, title="Momentum Smoothing 2")
src=close
m=src-src[1]
tsi=100*(ema(ema(m,r),s)/ema(ema(abs(m), r),s))
ul=hline(25)
ll=hline(-25)
%}
function out = TSI(C)
src = C;
r = 25;
s = 13;
ar = 2/(r+1);
as = 2/(s+1);
Z = zeros(1,length(src));
ONE = ones(1,length(src));
persistent Xtsi
if isempty(Xtsi)
    Xtsi.srcp = src;
    Xtsi.em1p = Z;
    Xtsi.em2p = Z;
    Xtsi.emab1p = ONE;
    Xtsi.emab2p = ONE;
end
m = src - Xtsi.srcp;
ema1 = (1-ar)*Xtsi.em1p + ar*m;
ema2 = (1-as)*Xtsi.em2p + as*ema1;
emab1 = (1-ar)*Xtsi.emab1p + ar*abs(m);
emab2 = (1-as)*Xtsi.emab2p + as*emab1;
tsi = 100*ema1./emab2;
Xtsi.srcp = src;
Xtsi.em1p = ema1;
Xtsi.em2p = ema2;
Xtsi.emab1p = emab1;
Xtsi.emab2p = emab2;
out = tsi;
end
%{
https://www.tradingview.com/script/efHJsedw-Indicator-Rahul-Mohindar-Oscillator-RMO/
study(title = "Rahul Mohinder Oscillator [LazyBear]", shorttitle="RMO_LB")
C=close
cm2(x) => sma(x,2)
ma1=cm2(C)
ma2=cm2(ma1)
ma3=cm2(ma2)
ma4=cm2(ma3)
ma5=cm2(ma4)
ma6=cm2(ma5)
ma7=cm2(ma6)
ma8=cm2(ma7)
ma9=cm2(ma8)
ma10=cm2(ma9)
SwingTrd1 = 100 * (close - (ma1+ma2+ma3+ma4+ma5+ma6+ma7+ma8+ma9+ma10)/10)/(highest(C,10)-lowest(C,10))
SwingTrd2=ema(SwingTrd1,30)
SwingTrd3=ema(SwingTrd2,30)
RMO= ema(SwingTrd1,81)
Buy=cross(SwingTrd2,SwingTrd3)
Sell=cross(SwingTrd3,SwingTrd2)
Bull_Trend=ema(SwingTrd1,81)>0
Bear_Trend=ema(SwingTrd1,81)<0
Ribbon_kol=Bull_Trend ? green : (Bear_Trend ? red : blue)
%}
function out = RahMohWsc(close)
C = close;
a2 = 2/(30+1);
a3 = 2/(30+1);
aST = 2/(81+1);
Len = 10;
persistent Xrmw
if isempty(Xrmw)
    Cmat = zeros(Len,Len);
    ma = [.5 .5];
    Cmat(1,1:2) = ma;
    for i=2:Len
        Cmat(i,1:i+1) = conv(ma,Cmat(i-1,1:i));
    end
    Xrmw.Cmat = Cmat;
    Xrmw.Cwin = repmat(C,Len+1,1);
    Xrmw.est2p = C;
    Xrmw.est3p = C;
    Xrmw.ermop = C;
end
Xrmw.Cwin = [C;Xrmw.Cwin(1:end-1,:)];
for i = 1:Len
    mamat(i,:) = sum(Xrmw.Cmat(i,:)'.*Xrmw.Cwin);
end
den = max(Xrmw.Cwin)-min(Xrmw.Cwin);
den(den==0) = 1;
SwingTrd1 = 100 * (C - sum(mamat)/Len)./...
    den;
Xrmw.est2p(isnan(Xrmw.est2p)) = 0;
Xrmw.est2p(isinf(Xrmw.est2p)) = 0;
Xrmw.est3p(isnan(Xrmw.est3p)) = 0;
Xrmw.est3p(isinf(Xrmw.est3p)) = 0;
Xrmw.est3p(isnan(Xrmw.ermop)) = 0;
Xrmw.est3p(isinf(Xrmw.ermop)) = 0;
SwingTrd2 = (1-a2)*Xrmw.est2p + a2*SwingTrd1;
SwingTrd3 = (1-a3)*Xrmw.est3p + a3*SwingTrd2;
RMO = (1-aST)*Xrmw.ermop + aST*SwingTrd1;
Buy = SwingTrd2>SwingTrd3;
Sell = SwingTrd2<SwingTrd3;
Xrmw.est2p = SwingTrd2;
Xrmw.est3p = SwingTrd3;
Xrmw.ermop = RMO;
out(1,:) = RMO;
out(2,:) = SwingTrd2;
out(3,:) = SwingTrd3;
out(4,:) = Buy;
out(5,:) = Sell;
end
%{
https://www.tradingview.com/chart/BTCUSD/UFv7wX1B-Indicator-Kaufman-AMA-Binary-Wave/
https://pastebin.com/aUkLWDaw
study(title = "Kaufman Binary Wave [LazyBear]", shorttitle="AMAWave_LB", overlay=true)
src=close
length=input(20)
filterp = input(10, title="Filter %", type=integer)
cf=input(true, "Color Buy/Sell safe areas?", type=bool)
dw=input(true, "Draw Wave?", type=bool)
 
d=abs(src-src[1])
s=abs(src-src[length])
noise=sum(d, length)
efratio=s/noise
fastsc=0.6022
slowsc=0.0645 
 
smooth=pow(efratio*fastsc+slowsc, 2)
ama=nz(ama[1], close)+smooth*(src-nz(ama[1], close))
filter=filterp/100 * stdev(ama-nz(ama), length)
amalow=ama < nz(ama[1]) ? ama : nz(amalow[1])
amahigh=ama > nz(ama[1]) ? ama : nz(amahigh[1])
bw=(ama-amalow) > filter ? 1 : (amahigh-ama > filter ? -1 : 0)
%}
function out = kamabinwav(C)
src = C;
Length = 20;
filterp = 10;
fastsc = 0.6022;
slowsc = 0.0645;
Z = zeros(1,length(C));
persistent Xkbw
if isempty(Xkbw)
    Xkbw.srcp = src;
    Xkbw.amap = src;
    Xkbw.amalowp = src;
    Xkbw.amahighp = src;
    Xkbw.srcwin = repmat(src,Length,1);
    Xkbw.noisewin = repmat(Z,Length,1);
end
Xkbw.srcwin = [src;Xkbw.srcwin(1:end-1,:)];
d=abs(src-Xkbw.srcp);
Xkbw.noisewin = [d;Xkbw.noisewin(1:end-1,:)];
s = abs(src-Xkbw.srcwin(end,:));
noise = sum(Xkbw.noisewin);
efratio = s/noise;
smooth = power(efratio*fastsc+slowsc, 2);
ama = Xkbw.amap+smooth.*(src-Xkbw.amap);
filter = filterp/100 * std(ama-Xkbw.amap);
amalow = ama;
k = find(ama > Xkbw.amap);
amalow(k) = Xkbw.amalowp(k);
amahigh = ama;
k = find(ama < Xkbw.amap);
amahigh(k) = Xkbw.amahighp(k);
tmp = Z;
tmp(amahigh-ama > filter) = -1;
bw = tmp;
bw((ama-amalow) > filter) = 1;
Xkbw.srcp = src;
Xkbw.amap = ama;
Xkbw.amalowp = amalow;
Xkbw.amahighp = amahigh;
out(1,:) = ama;
out(2,:) = amalow;
out(3,:) = amahigh;
out(4,:) = bw;
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
%}
function out = ZeroLagema(C)
src = C;
Length = 10;
a = 2/(Length+1);
persistent Xzle
if isempty(Xzle)
    Xzle.e1p = src;
    Xzle.e2p = src;
end
ema1 = (1-a)*Xzle.e1p + a*src;
ema2 = (1-a)*Xzle.e2p + a*ema1;
d = ema1-ema2;
zlema = ema1+d;
Xzle.e1p = ema1;
Xzle.e2p = ema2;
out(1,:) = zlema;
end
%{
https://www.tradingview.com/script/0t5z9xe2-Indicator-Bears-Bulls-power/
study(title = "Bears/Bulls [LazyBear]", shorttitle="BearsBulls_LB")
length=input(13)
src=close

s_ma = sma(src, length)
s_bulls = high - s_ma
s_bears = low - s_ma
%}
function out = BearsBulls(H,L,C)
src = C;
high = H;
low = L;
Length = 13;
persistent Xbebull
if isempty(Xbebull)
    Xbebull.srcwin = repmat(src,Length,1);
end
Xbebull.srcwin = [src;Xbebull.srcwin(1:end-1,:)];
s_ma = sum(Xbebull.srcwin)/Length;
s_bulls = high - s_ma;
s_bears = low - s_ma;
out(1,:) = s_ma;
out(2,:) = s_bulls;
out(3,:) = s_bears;
end
%{
https://www.tradingview.com/script/4hhFyZwm-Indicator-MFI-or-RSI-enclosed-by-Bollinger-Bands/
// RSI/MFI with Bollinger Bands. Dynamic Oversold/Overbought levels, yayy!
// 
study(title = "RSI/MFI with Volatility Bands [LazyBear]", shorttitle="SI+Bands [LB]")
source = hlc3
length = input(14, minval=1), mult = input(2.0, minval=0.001, maxval=50)
DrawRSI_f=input(false, title="Draw RSI?", type=bool)
DrawMFI_f=input(true, title="Draw MFI?", type=bool)
HighlightBreaches=input(true, title="Highlight Oversold/Overbought?", type=bool)

DrawMFI = (not DrawMFI_f) and (not DrawRSI_f) ? true : DrawMFI_f
DrawRSI = (DrawMFI_f and DrawRSI_f) ? false : DrawRSI_f
// RSI
rsi_s = DrawRSI ? rsi(source, length) : na
plot(DrawRSI ? rsi_s : na, color=maroon, linewidth=2)

// MFI
upper_s = DrawMFI ? sum(volume * (change(source) <= 0 ? 0 : source), length) : na
lower_s = DrawMFI ? sum(volume * (change(source) >= 0 ? 0 : source), length) : na
mf = DrawMFI ? rsi(upper_s, lower_s) : na
plot(DrawMFI ? mf : na, color=green, linewidth=2)
%}
function out = mfiBollBnd(H,L,C,V)
source = (H+L+C)/3;
volume = V;
Length = 14;
alph = 1/Length;
mult = 2;
Z = zeros(1,length(C));
persistent Xrbb
if isempty(Xrbb)
    Xrbb.Cp = source;
    Xrbb.rsiwin = repmat(Z,Length,1);
    Xrbb.bbswin = repmat(Z,Length,1);
    Xrbb.avgUp = Z;
    Xrbb.avgDp = Z;
end
Xrbb.rsiwin = [volume.*(source-Xrbb.Cp);...
    Xrbb.rsiwin(1:end-1,:)];
tmpU = Xrbb.rsiwin;
tmpU(tmpU<0)=0;
tmpD = Xrbb.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*Xrbb.avgUp + alph*avgU;
emaavgD = (1-alph)*Xrbb.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
mf = 100*(1 - 1./(1+RS));
bb_s = mf;
Xrbb.bbswin = [bb_s;Xrbb.bbswin(1:end-1,:)];
basis = sum(Xrbb.bbswin)/Length;
dev = mult * std(Xrbb.bbswin);
upper = basis + dev;
lower = basis - dev;
Xrbb.Cp = source;
Xrbb.avgUp = emaavgU;
Xrbb.avgDp = emaavgD;
out(1,:) = bb_s;
out(2,:) = basis;
out(3,:) = upper;
out(4,:) = lower;
end
%{
https://www.tradingview.com/script/4hhFyZwm-Indicator-MFI-or-RSI-enclosed-by-Bollinger-Bands/
study(title = "RSI/MFI with Volatility Bands [LazyBear]", shorttitle="SI+Bands [LB]")
source = hlc3
length = input(14, minval=1), mult = input(2.0, minval=0.001, maxval=50)
DrawRSI_f=input(false, title="Draw RSI?", type=bool)
DrawMFI_f=input(true, title="Draw MFI?", type=bool)
HighlightBreaches=input(true, title="Highlight Oversold/Overbought?", type=bool)

DrawMFI = (not DrawMFI_f) and (not DrawRSI_f) ? true : DrawMFI_f
DrawRSI = (DrawMFI_f and DrawRSI_f) ? false : DrawRSI_f
// RSI
rsi_s = DrawRSI ? rsi(source, length) : na
plot(DrawRSI ? rsi_s : na, color=maroon, linewidth=2)

// MFI
upper_s = DrawMFI ? sum(volume * (change(source) <= 0 ? 0 : source), length) : na
lower_s = DrawMFI ? sum(volume * (change(source) >= 0 ? 0 : source), length) : na
mf = DrawMFI ? rsi(upper_s, lower_s) : na
plot(DrawMFI ? mf : na, color=green, linewidth=2)

// Draw BB on indices
bb_s = DrawRSI ? rsi_s : DrawMFI ? mf : na
basis = sma(bb_s, length)
dev = mult * stdev(bb_s, length)
upper = basis + dev
lower = basis - dev
%}
function out = rsiBollBnd(H,L,C)
source = (H+L+C)/3;
Length = 14;
alph = 1/Length;
mult = 2;
Z = zeros(1,length(C));
persistent Xrbb
if isempty(Xrbb)
    Xrbb.Cp = source;
    Xrbb.rsiwin = repmat(Z,Length,1);
    Xrbb.bbswin = repmat(Z,Length,1);
    Xrbb.avgUp = Z;
    Xrbb.avgDp = Z;
end
Xrbb.rsiwin = [source-Xrbb.Cp;Xrbb.rsiwin(1:end-1,:)];
tmpU = Xrbb.rsiwin;
tmpU(tmpU<0)=0;
tmpD = Xrbb.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*Xrbb.avgUp + alph*avgU;
emaavgD = (1-alph)*Xrbb.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
rsi_s = 100*(1 - 1./(1+RS));
% emaavgU = (1-alph)*Xrbb.avgUp + alph*rsi;
bb_s = rsi_s;
Xrbb.bbswin = [bb_s;Xrbb.bbswin(1:end-1,:)];
basis = sum(Xrbb.bbswin)/Length;
dev = mult * std(Xrbb.bbswin);
upper = basis + dev;
lower = basis - dev;
Xrbb.Cp = source;
Xrbb.avgUp = emaavgU;
Xrbb.avgDp = emaavgD;
out(1,:) = bb_s;
out(2,:) = basis;
out(3,:) = upper;
out(4,:) = lower;
end
%{
https://www.tradingview.com/script/6wfwJ6To-Indicator-Derivative-Oscillator/
// @credits Constance Brown
// 
study(title = "Derivative Oscillator [LazyBear]", shorttitle="DO_LB")
length=input(14, title="RSI Length")
p=input(9,title="SMA length")
ema1=input(5,title="EMA1 length")
ema2=input(3,title="EMA2 length")

s1=ema(ema(rsi(close, length), ema1),ema2)
s2=s1 - sma(s1,p)
%}
function out = derosc(C)
close = C;
Length = 14;
alph = 1/Length;
p = 9;
a1 = 2/(5+1);
a2 = 2/(3+1);
Z = zeros(1,length(C));
persistent Xder
if isempty(Xder)
    Xder.Cp = close;
    Xder.rsiwin = repmat(Z,Length,1);
    Xder.s1win = repmat(Z,p,1);
    Xder.avgUp = Z;
    Xder.avgDp = Z;
    Xder.e1p = Z;
    Xder.e2p = Z;
end
Xder.rsiwin = [C-Xder.Cp;Xder.rsiwin(1:end-1,:)];
tmpU = Xder.rsiwin;
tmpU(tmpU<0)=0;
tmpD = Xder.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*Xder.avgUp + alph*avgU;
emaavgD = (1-alph)*Xder.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
rsi = 100*(1 - 1./(1+RS));
e1 = (1-a1)*Xder.e1p + a1*rsi;
s1 = (1-a2)*Xder.e2p + a2*e1;
Xder.s1win = [s1;Xder.s1win(1:end-1,:)];
s2 = s1 - sum(Xder.s1win)/p;
Xder.Cp = close;
Xder.avgUp = emaavgU;
Xder.avgDp = emaavgD;
Xder.e1p = e1;
Xder.e2p = s1;
out(1,:) = rsi;
out(2,:) = e1;
out(3,:) = s1;
out(4,:) = s2;
end
%{
https://www.tradingview.com/script/ZdbzUf9B-Indicator-Tirone-Levels/
study(title = "Tirone Levels [LazyBear]", shorttitle="TironeLvl_LB", overlay=true)
length=input(20)
method_mp=input(false, title="Midpoint Method?", type=bool)
method_mm=input(true, title="Mean Method?", type=bool)

ll=lowest(low, length)
hh=highest(high, length)

// Midpoint method
tlh = hh - ((hh-ll)/3)
clh = ll + ((hh-ll)/2)
blh = ll + ((hh-ll)/3)
tl = plot(method_mp ? tlh : na, color = red)
cl = plot(method_mp ? clh : na)
bl = plot(method_mp ? blh : na, color = green)

// Mean method
am  = (hh+ll+close)/3
eh = am + (hh-ll)
el = am - (hh-ll)
rh = 2*am - ll
rl = 2*am - hh
%}
function out = Tirone(H,L,C)
high = H;
low = L;
close = C;
Length = 20;
persistent Xtir
if isempty(Xtir)
    Xtir.lowwin = repmat(low,Length,1);
    Xtir.highwin = repmat(high,Length,1);
end
Xtir.lowwin = [low;Xtir.lowwin(1:end-1,:)];
Xtir.highwin = [high;Xtir.highwin(1:end-1,:)];
ll = min(Xtir.lowwin);
hh = max(Xtir.highwin);
%  Midpoint method
tlh = hh - ((hh-ll)/3);
clh = ll + ((hh-ll)/2);
blh = ll + ((hh-ll)/3);
%  Mean method
am  = (hh+ll+close)/3;
eh = am + (hh-ll);
el = am - (hh-ll);
rh = 2*am - ll;
rl = 2*am - hh;
out(1,:) = tlh;
out(2,:) = clh;
out(3,:) = blh;
out(4,:) = eh;
out(5,:) = el;
out(6,:) = rh;
out(7,:) = rl;
end
%{
https://www.tradingview.com/script/nbx4UFZ6-Indicator-4MACD/
study(title = "4MACD [LazyBear]", shorttitle="4MACD_LB")

source=close
mult_b=input(4.3, title="Blue multiplier")
mult_y=input(1.4, title="Yellow multiplier")

ema5=ema(close,5)
ema8=ema(close,8)
ema10=ema(close,10)
ema17=ema(source,17)
ema14=ema(source,14)
ema16=ema(close,16)
ema17_14 = ema17-ema14
ema17_8=ema17-ema8
ema10_16=ema10-ema16
ema5_10=ema5-ema10

MACDBlue=mult_b*(ema17_14-ema(ema17_14,5))
MACDRed=ema17_8-ema(ema17_8,5)
MACDYellow=mult_y*(ema10_16-ema(ema10_16,5))
MACDGreen=ema5_10-ema(ema5_10,5)
%}
function out = macd4(C)
source=C;
mult_b=4.3;
mult_y=1.4;
a5 = 2/(5+1);
a8 = 2/(8+1);
a10 = 2/(10+1);
a14 = 2/(14+1);
a16 = 2/(16+1);
a17 = 2/(17+1);
Z = zeros(1,length(C));
persistent X4macd
if isempty(X4macd)
    X4macd.e5p = source;
    X4macd.e8p = source;
    X4macd.e10p = source;
    X4macd.e14p = source;
    X4macd.e16p = source;
    X4macd.e17p = source;
    X4macd.e17_14p = Z;
    X4macd.e17_8p = Z;
    X4macd.e10_16p = Z;
    X4macd.e5_10p = Z;
end
ema5 = (1-a5)*X4macd.e5p + a5*source;
ema8 = (1-a8)*X4macd.e8p + a8*source;
ema10 = (1-a10)*X4macd.e10p + a10*source;
ema14 = (1-a14)*X4macd.e14p + a14*source;
ema16 = (1-a16)*X4macd.e16p + a16*source;
ema17 = (1-a17)*X4macd.e17p + a17*source;
ema17_14 = ema17-ema14;
ema17_8 = ema17-ema8;
ema10_16 = ema10-ema16;
ema5_10 = ema5-ema10;
Mema17_14 = (1-a5)*X4macd.e17_14p + a5*ema17_14;
Mema17_8 = (1-a5)*X4macd.e17_8p + a5*ema17_8;
Mema10_16 = (1-a5)*X4macd.e10_16p + a5*ema10_16;
Mema5_10 = (1-a5)*X4macd.e5_10p + a5*ema5_10;
MACDBlue = mult_b*(ema17_14-Mema17_14);
MACDRed = ema17_8-Mema17_8;
MACDYellow = mult_y*(ema10_16-Mema10_16);
MACDGreen = ema5_10-Mema5_10;
X4macd.e5p = ema5;
X4macd.e8p = ema8;
X4macd.e10p = ema10;
X4macd.e14p = ema14;
X4macd.e16p = ema16;
X4macd.e17p = ema17;
X4macd.e17_14p = Mema17_14;
X4macd.e17_8p = Mema17_8;
X4macd.e10_16p = Mema10_16;
X4macd.e5_10p = Mema5_10;
out(1,:) = ema5;
out(2,:) = ema8;
out(3,:) = ema10;
out(4,:) = ema14;
out(5,:) = ema16;
out(6,:) = ema17;
out(7,:) = MACDBlue;
out(8,:) = MACDRed;
out(9,:) = MACDYellow;
out(10,:) = MACDGreen;
end
%{
https://www.tradingview.com/script/cGtwC2C9-Indicator-Vertical-Horizontal-Filter-VHF/
// VHF determines whether prices are in trneding or congestion phase. 
// 
study(title = "Vertical Horizontal Filter [LazyBear]", shorttitle="VHF_LB")
src=close
length=input(28, title="VHF Period")
showEma=input(false, title="Show EMA?", type=bool)

hcp=highest(src, length)
lcp=lowest(src, length)
cdiff=abs(close-close[1])

N=abs(hcp-lcp)
D=sum(cdiff, length)
vhf=N/D
%}
function out = VHF(C)
src = C;
Length = 28;
Z = zeros(1,length(src));
persistent Xvhf
if isempty(Xvhf)
    Xvhf.Cwin = repmat(src,Length,1);
    Xvhf.cdiffwin = repmat(Z,Length,1);
    Xvhf.Cp = src;
end
Xvhf.Cwin = [src;Xvhf.Cwin(1:end-1,:)];
hcp=max(Xvhf.Cwin);
lcp=min(Xvhf.Cwin);
cdiff=abs(src-Xvhf.Cp);
Xvhf.cdiffwin = [cdiff;Xvhf.cdiffwin(1:end-1,:)];
N=abs(hcp-lcp);
D=sum(Xvhf.cdiffwin);
vhf=N./D;
Xvhf.Cp = src;
out = vhf;
end
%{
https://www.tradingview.com/script/dB56X9AU-Indicator-Volume-ROC/
// Volume ROC is calculated by dividing the amount the volume changed over the last
// "n" days by volume "n" days ago. The result is the % volume change. 
//
// If volume today is higher than "n" days ago, VROC will be positive, else negative. 
//
study(title = "Volume ROC [LazyBear]", shorttitle="VolumeROC[LB]")
length=input(12)
vroc = ((volume - volume[length]) / (volume[length])) * 100
%}
function out = VolROC(V)
Length = 12;
persistent Xvroc
if isempty(Xvroc)
    Xvroc.vrocwin = repmat(V,Length,1);
end
Xvroc.vrocwin = [V;Xvroc.vrocwin(1:end-1,:)];
vroc = ((V - Xvroc.vrocwin(end,:)) ./ ...
    Xvroc.vrocwin(end,:)) * 100;
out = vroc;
end
%{
https://www.tradingview.com/script/Ch8xB1Fc-TSI-CCI-Hull-with-profit-Alert-version/
study(title="TSI CCI Hull", shorttitle="TSICCIHULL", overlay=true)
long = input(title="Long Length", type=input.integer, defval=50)
short = input(title="Short Length", type=input.integer, defval=52)
signal = input(title="Signal Length", type=input.integer, defval=24)
price=input(title="Source",type=input.source,defval=close)
Period=input(26, minval=1)
lineupper = input(title="Upper Line", type=input.integer, defval=100)
linelower = input(title="Lower Line", type=input.integer, defval=-100)
p=price
length= Period
double_smooth(src, long, short) =>
    fist_smooth = ema(src, long)
    ema(fist_smooth, short)
pc = change(price)
double_smoothed_pc = double_smooth(pc, long, short)
double_smoothed_abs_pc = double_smooth(abs(pc), long, short)
tsi_value = 100 * (double_smoothed_pc / double_smoothed_abs_pc)
keh = tsi_value*5 > linelower ? color.red : color.lime
teh = ema(tsi_value*5, signal*5) > lineupper ? color.red : color.lime
meh = ema(tsi_value*5, signal*5) > tsi_value*5 ? color.red : color.lime
n2ma = 2 * wma(p, round(length / 2))
nma = wma(p, length)
diff = n2ma - nma
sqn = round(sqrt(length))
n1 = wma(diff, sqn)
cci = (p - n1) / (0.015 * dev(p, length))
c = cci > 0 ? color.lime : color.red
c1 = cci > 20 ? color.lime : color.silver
c2 = cci < -20 ? color.red : color.silver
TSI1=ema(tsi_value*5, signal*5)
TSI2=ema(tsi_value*5, signal*5)[2]

hullma_smoothed = wma(2*wma(n1, Period/2)-wma(n1, Period), round(sqrt(Period)))

longCondition = TSI1>TSI2 and hullma_smoothed<price and cci>0

shortCondition = TSI1<TSI2 and hullma_smoothed>price and cci<0
    
bbuy = longCondition and cci>cci[1] and cci > 0 and n1>n1[1]
ssell = shortCondition and cci<cci[1] and cci < 0 and n1<n1[1]
%}
function out = tsicciHull(C)
long = 50;
short = 52;
signal = 24;
alo = 2/(long+1);
ash = 2/(short+1);
asig = 2/(signal*5+1);
p=C;
Period=26;
Length = Period;
Z = zeros(1,length(C));
tmp = Length:-1:1;
bwma = tmp/sum(tmp);
tmp = Length/2:-1:1;
bwma2 = tmp/sum(tmp);
weirdLen = round(sqrt(Length));
tmp = weirdLen:-1:1;
bw = tmp/sum(tmp);
persistent Xtsicci
if isempty(Xtsicci)
    Xtsicci.Cp = p;
    Xtsicci.pclop = Z;
    Xtsicci.pcshp = Z;
    Xtsicci.pcalop = Z;
    Xtsicci.pcashp = Z;
    Xtsicci.tsip = Z;
    Xtsicci.tsipp = Z;
    Xtsicci.pwin = repmat(p,Length,1);
    Xtsicci.diffwin = repmat(p,round(sqrt(Length)),1);
    Xtsicci.n1win = repmat(p,Period,1);
    Xtsicci.hullwin = repmat(p,round(sqrt(Length)),1);
    Xtsicci.devwin = repmat(p,Length,1);
    Xtsicci.n1p = p;
    Xtsicci.ccip = Z;
end
Xtsicci.pwin = [p;Xtsicci.pwin(1:end-1,:)];
pc = p - Xtsicci.Cp;
tmp1 = (1-alo)*Xtsicci.pclop + alo*pc;
double_smoothed_pc = (1-ash)*Xtsicci.pcshp + ash*tmp1;
tmp2 = (1-alo)*Xtsicci.pcalop + alo*abs(pc);
double_smoothed_abs_pc = (1-ash)*Xtsicci.pcashp + ash*tmp2;
double_smoothed_abs_pc(double_smoothed_abs_pc==0) = 1;
tsi_value = 100 * (double_smoothed_pc ./ ...
	double_smoothed_abs_pc);
tsi_value_5 = (1-asig)*Xtsicci.tsip + asig*tsi_value*5;
diff = 2*sum(bwma2'.*Xtsicci.pwin(1:length(bwma2),:)) - ...
    sum(bwma'.*Xtsicci.pwin);
Xtsicci.diffwin = [diff;Xtsicci.diffwin(1:end-1,:)];
n1 = sum(bw'.*Xtsicci.diffwin);
Xtsicci.n1win = [n1;Xtsicci.n1win(1:end-1,:)];
Xtsicci.devwin = [abs(p - sum(Xtsicci.pwin)/Length);...
    Xtsicci.devwin(1:end-1,:)];
tmpdev = sum(Xtsicci.devwin)/Length;
cci = (p - n1) ./ (0.015 * tmpdev);
TSI1 = tsi_value_5;
TSI2 = Xtsicci.tsipp;
tmph = 2*sum(bwma2'.*Xtsicci.n1win(1:length(bwma2),:)) - ...
    sum(bwma'.*Xtsicci.n1win);
Xtsicci.hullwin = [tmph;Xtsicci.hullwin(1:end-1,:)];
hullma_smoothed = sum(bw'.*Xtsicci.hullwin);
longCondition = TSI1>TSI2 & hullma_smoothed<p & cci>0;
shortCondition = TSI1<TSI2 & hullma_smoothed>p & cci<0;
bbuy = longCondition & cci>Xtsicci.ccip & cci > 0 & n1>Xtsicci.n1p;
ssell = shortCondition & cci<Xtsicci.ccip & cci < 0 & n1<Xtsicci.n1p;
Xtsicci.pclop = tmp1;
Xtsicci.pcshp = double_smoothed_pc;
Xtsicci.pcalop = tmp2;
Xtsicci.pcashp = double_smoothed_abs_pc;
Xtsicci.tsipp = Xtsicci.tsip;
Xtsicci.tsip = tsi_value_5;
Xtsicci.n1p = n1;
Xtsicci.ccip = cci;
out(1,:) = hullma_smoothed;
out(2,:) = cci;
out(3,:) = bbuy;
out(4,:) = ssell;
end
%{
https://www.tradingview.com/script/jRrLUjPJ-EMA-Enveloper-Indicator-a-crazy-prediction/
study(title = "EMAEnvelope [LazyBear]", shorttitle="EMAEnvelope[LB]", overlay=true)
src = close
length=input(20)
HighlightColors = input(true, title="Bull/Bear highlights?", type=bool)

e=ema(close, length)
eu = ema(high, length)
el = ema(low, length)

plot(e, style=cross, color=aqua)
plot(eu, color=red, linewidth=2)
plot(el, color=lime, linewidth=2)
%}
function out = EMAenvelope(H,L,C)
Length = 20;
src = C;
high = H;
low = L;
a = 2/(Length+1);
persistent Xenv
if isempty(Xenv)
    Xenv.ep = src;
    Xenv.eup = high;
    Xenv.elp = low;
end
e = (1-a)*Xenv.ep + a*src;
eu = (1-a)*Xenv.eup + a*high;
el = (1-a)*Xenv.elp + a*low;
bull_f = (high > eu & low > el);
bear_f = (high < eu & low < el);
sidewise_f = (~ bull_f) & (~ bear_f);
Xenv.ep = e;
Xenv.eup = eu;
Xenv.elp = el;
out(1,:) = e;
out(2,:) = eu;
out(3,:) = el;
out(4,:) = bull_f;
out(5,:) = bear_f;
out(6,:) = sidewise_f;
end
%{
https://www.tradingview.com/script/lPQylz1E-EMARSI-New-Moving-Average/
study(title="EMA + RSI", shorttitle="EMARSI", overlay=true, resolution="")
len = input(20, minval=1, title="Length")
src = input(close, title="Source")
offset = input(title="Offset", type=input.integer, defval=0, minval=-500, maxval=500)
smooth_emaRsi = input(false, title="Smooth ?")
RSIEffect = input(10, title="RSI Effect to Price 1-100, Not Smooth", minval=1, maxval=100) * 0.01

//Formula
emaRsi(src,len) =>
    rsiA = rsi(src,len)
    rsiWeight = smooth_emaRsi ? change(rsiA)/nz(avg(rsiA,rsiA[1]), 0.0000000001) * (src / 100) : avg(rsiA,rsiA[1]) * RSIEffect * (src / 100) 
    emaRsi = smooth_emaRsi ? src + rsiWeight : src + rsiWeight - rsiWeight[1]
    ema(emaRsi,len)
    
//
out_ema = ema(src, len)
out_emaRsi = emaRsi(src, len)
%}
function out = emarsi(C)
len = 20;
arsi = 1/len;
aema = 2/(len+1);
src = C;
RSIEffect = 1;
Z = zeros(1,length(C));
persistent Xemarsi
if isempty(Xemarsi)
    Xemarsi.emap = src;
    Xemarsi.Cp = src;
    Xemarsi.rsiwin = repmat(Z,len,1);
    Xemarsi.rsiupP = Z;
    Xemarsi.rsidownP = Z;
    Xemarsi.adxP = Z;
    Xemarsi.rsiAP = Z;
    Xemarsi.rsiWeightP = Z;
    Xemarsi.emarsip = src;
end
Xemarsi.rsiwin = [src-Xemarsi.Cp;Xemarsi.rsiwin(1:end-1,:)];
rsiup = max(Xemarsi.rsiwin);
rsiup(rsiup<0) = 0;
rsidown = min(Xemarsi.rsiwin);
rsidown(rsidown>0) = 0;
rsidown = abs(rsidown);
rsiup = (1-arsi)*Xemarsi.rsiupP + arsi*rsiup;
rsidown = (1-arsi)*Xemarsi.rsidownP + arsi*rsidown;
vrsi(rsidown == 0) = 100;
k = find(rsidown ~= 0);
vrsi(k) = 100 - (100 ./ (1 + rsiup(k) ./ rsidown(k)));
rsiA = vrsi;
rsiWeight = (rsiA+Xemarsi.rsiAP)/2 .* RSIEffect .* (src / 100);
emaRsi = src + rsiWeight - Xemarsi.rsiWeightP;
out_emaRsi = (1-aema)*Xemarsi.emarsip + aema*emaRsi;
out_ema = (1-aema)*Xemarsi.emap + aema*src;
Xemarsi.rsiupP = rsiup;
Xemarsi.rsidownP = rsidown;
Xemarsi.rsiAP = rsiA;
Xemarsi.rsiWeightP = rsiWeight;
Xemarsi.emarsip = out_emaRsi;
Xemarsi.emap = out_ema;
Xemarsi.Cp = src;
out(1,:) = out_ema;
out(2,:) = out_emaRsi;
end
%{
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
    Slope=0.0
    Sum=0.0
    a1=0.0
    b1=0.0
    c1=0.0
    c2=0.0
    c3=0.0
    Filt=0.0
    MS=0.0
    Reflex=0.0
    
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
function out = Reflex(H,L,C)
Length = 40;
Threshold = 1;
aSPd = 2/(10+1);
Source = C;
Z = zeros(1,length(C));
persistent Xref
if isempty(Xref)
    a1 = exp(-1.414*3.14159 / (.5*Length));
    b1 = 2*a1*cos(1.414*180 / (.5*Length));
    Xref.c2 = b1;
    Xref.c3 = -a1*a1;
    Xref.c1 = 1 - Xref.c2 - Xref.c3;
    Xref.Cp = Source;
    Xref.Filtp = Source;
    Xref.Filtpp = Source;
    Xref.Filtwin = repmat(Source,Length,1);
    Xref.MSp = Source;
    atr = max(H-L,max(H-Source,...
        abs(L-Source)));
    Xref.atrp = atr;
end
Filt = Xref.c1*(Source + Xref.Cp) / 2 + ...
    Xref.c2*Xref.Filtp + Xref.c3*Xref.Filtpp;
Xref.Filtwin = [Filt;Xref.Filtwin(1:end-1,:)];
Slope = (Xref.Filtwin(end,:) - Filt) / Length;
Sum = Z;
for count = 1:Length 
    Sum = Sum + (Filt + count*Slope) - ...
        Xref.Filtwin(count,:);
end
Sum = Sum / Length;
MS = .04*Sum.*Sum + .96*Xref.MSp;
Reflex = Sum ./ sqrt(MS);
k = find(MS==0);
Reflex(k) = Z(k);
atr = max(H-L,max(H-Xref.Cp,...
    abs(L-Xref.Cp)));
atrSPd = (1-aSPd)*Xref.atrp + aSPd*atr;
% Xref.atrwin = [atr;Xref.atrwin(1:end-1,:)];
Xref.Cp = Source;
Xref.Filtp = Source;
Xref.Filtpp = Source;
Xref.MSp = MS;
Xref.atrp = atrSPd;
out(1,:) = Filt;
out(2,:) = Reflex;
out(3,:) = atrSPd;
end
%{
study("RDX Score", overlay=true)
len = input(title="length_ADX", type=integer, defval=14)
th = input(title="threshold_ADX", type=integer, defval=14)

TrueRange = max(max(high-low, abs(high-nz(close[1]))), abs(low-nz(close[1])))
DirectionalMovementPlus = high-nz(high[1]) > nz(low[1])-low ? max(high-nz(high[1]), 0): 0
DirectionalMovementMinus = nz(low[1])-low > high-nz(high[1]) ? max(nz(low[1])-low, 0): 0

SmoothedTrueRange = nz(SmoothedTrueRange[1]) - (nz(SmoothedTrueRange[1])/len) + TrueRange
SmoothedDirectionalMovementPlus = nz(SmoothedDirectionalMovementPlus[1]) - (nz(SmoothedDirectionalMovementPlus[1])/len) + DirectionalMovementPlus
SmoothedDirectionalMovementMinus = nz(SmoothedDirectionalMovementMinus[1]) - (nz(SmoothedDirectionalMovementMinus[1])/len) + DirectionalMovementMinus

DIPlus = SmoothedDirectionalMovementPlus / SmoothedTrueRange * 100
DIMinus = SmoothedDirectionalMovementMinus / SmoothedTrueRange * 100
DX = abs(DIPlus-DIMinus) / (DIPlus+DIMinus)*100
ADX = sma(DX, len)


length_RSI = input(14 )
priceRSI = close
vrsi = rsi(priceRSI, length_RSI)

m5 = ADX[1]<ADX and vrsi<30
plotshape(m5, title="SCORE -5", text="-5", textcolor=white, style=shape.labeldown, location=location.abovebar, color=red, transp=0, size=size.tiny)

m4 = (ADX[1]>ADX and vrsi<30) or (ADX[1]<ADX and vrsi<35 and vrsi>30)
plotshape(m4, title="SCORE -4", text="-4", textcolor=white, style=shape.labeldown, location=location.abovebar, color=red, transp=0, size=size.tiny)

m3 = (ADX[1]>ADX and vrsi<35 and vrsi>30) or (ADX[1]<ADX and vrsi<40 and vrsi>35)
plotshape(m3, title="SCORE -3", text="-3", textcolor=white, style=shape.labeldown, location=location.abovebar, color=red, transp=0, size=size.tiny)

m2 = (ADX[1]>ADX and vrsi<40 and vrsi>35) or (ADX[1]<ADX and vrsi<45 and vrsi>40)
plotshape(m2, title="SCORE -2", text="-2", textcolor=white, style=shape.labeldown, location=location.abovebar, color=red, transp=0, size=size.tiny)

m1 = ADX[1]>ADX and vrsi<45 and vrsi>40
plotshape(m1, title="SCORE -1", text="-1", textcolor=white, style=shape.labeldown, location=location.abovebar, color=red, transp=0, size=size.tiny)

m0 = vrsi<55 and vrsi>45
//plotshape(m0, title="QQE short", text="0", textcolor=black, style=shape.labeldown, location=location.abovebar, color=yellow, transp=0, size=size.tiny)
plotshape(m0, title="QQE long", text="0", textcolor=black, style=shape.labelup, location=location.belowbar, color=yellow, transp=0, size=size.tiny)

p1 = ADX[1]>ADX and vrsi>55 and vrsi<60
plotshape(p1, title="SCORE 1", text="1", textcolor=white, style=shape.labelup, location=location.belowbar, color=green, transp=0, size=size.tiny)

p2 = (ADX[1]>ADX and vrsi>60 and vrsi<65) or (ADX[1]<ADX and vrsi>55 and vrsi<60)
plotshape(p2, title="SCORE 2", text="2", textcolor=white, style=shape.labelup, location=location.belowbar, color=green, transp=0, size=size.tiny)

p3 = (ADX[1]>ADX and vrsi>65 and vrsi<70) or (ADX[1]<ADX and vrsi>60 and vrsi<65)
plotshape(p3, title="SCORE 3", text="3", textcolor=white, style=shape.labelup, location=location.belowbar, color=green, transp=0, size=size.tiny)

p4 = (ADX[1]>ADX and vrsi>70) or (ADX[1]<ADX and vrsi>65 and vrsi<70)
plotshape(p4, title="SCORE 4", text="4", textcolor=white, style=shape.labelup, location=location.belowbar, color=green, transp=0, size=size.tiny)

p5 = ADX[1]<ADX and vrsi>70
plotshape(p5, title="SCORE 5", text="5", textcolor=white, style=shape.labelup, location=location.belowbar, color=green, transp=0, size=size.tiny)
%}
function out = RDX_Score(H,L,C)
len = 14;
th = 14;
length_RSI = 14;
arsi = 1/length_RSI;
priceRSI = C;
high = H;
low = L;
Z = zeros(1,length(C));
persistent Xrdx
if isempty(Xrdx)
    Xrdx.Cp = priceRSI;
    Xrdx.Hp = high;
    Xrdx.Lp = low;
    Xrdx.SmoothedTrueRangeP = Z;
    Xrdx.SmoothedDirectionalMovementPlusP = Z;
    Xrdx.SmoothedDirectionalMovementMinusP = Z;
    Xrdx.DXwin = repmat(Z,len,1);
    Xrdx.rsiwin = repmat(Z,length_RSI,1);
    Xrdx.rsiupP = Z;
    Xrdx.rsidownP = Z;
    Xrdx.adxP = Z;
end
Xrdx.rsiwin = [priceRSI-Xrdx.Cp;Xrdx.rsiwin(1:end-1,:)];
TrueRange = max(max(high-low, abs(high-Xrdx.Cp)), ...
    abs(low-Xrdx.Cp));
DirectionalMovementPlus = max(high-Xrdx.Hp, 0);
DirectionalMovementPlus(high-Xrdx.Hp < Xrdx.Lp-low) = 0;
DirectionalMovementMinus = max(Xrdx.Lp-low, 0);
DirectionalMovementMinus(Xrdx.Lp-low < high-Xrdx.Hp) = 0;
SmoothedTrueRange = Xrdx.SmoothedTrueRangeP - ...
    (Xrdx.SmoothedTrueRangeP/len) + TrueRange;
SmoothedDirectionalMovementPlus = Xrdx.SmoothedDirectionalMovementPlusP - ...
    Xrdx.SmoothedDirectionalMovementPlusP/len +...
    DirectionalMovementPlus;
SmoothedDirectionalMovementMinus = Xrdx.SmoothedDirectionalMovementMinusP - ...
    (Xrdx.SmoothedDirectionalMovementMinusP/len) + ...
    DirectionalMovementMinus;
DIPlus = SmoothedDirectionalMovementPlus ./ ...
    SmoothedTrueRange * 100;
DIMinus = SmoothedDirectionalMovementMinus ./ ...
    SmoothedTrueRange * 100;
DX = abs(DIPlus-DIMinus) ./ (DIPlus+DIMinus)*100;
Xrdx.DXwin = [DX;Xrdx.DXwin(1:end-1,:)];
ADX = sum(Xrdx.DXwin)/len;
rsiup = max(Xrdx.rsiwin);
rsiup(rsiup<0) = 0;
rsidown = min(Xrdx.rsiwin);
rsidown(rsidown>0) = 0;
rsidown = abs(rsidown);
rsiup = (1-arsi)*Xrdx.rsiupP + arsi*rsiup;
rsidown = (1-arsi)*Xrdx.rsidownP + arsi*rsidown;
vrsi(rsidown == 0) = 100;
k = find(rsidown ~= 0);
vrsi(k) = 100 - (100 ./ (1 + rsiup(k) ./ rsidown(k)));
m5 = Xrdx.adxP<ADX & vrsi<30;
m4 = (Xrdx.adxP>ADX & vrsi<30) | (Xrdx.adxP<ADX & vrsi<35 & vrsi>30);
m3 = (Xrdx.adxP>ADX & vrsi<35 & vrsi>30) | ...
    (Xrdx.adxP<ADX & vrsi<40 & vrsi>35);
m2 = (Xrdx.adxP>ADX & vrsi<40 & vrsi>35) | ...
    (Xrdx.adxP<ADX & vrsi<45 & vrsi>40);
m1 = Xrdx.adxP>ADX & vrsi<45 & vrsi>40;
m0 = vrsi<55 & vrsi>45;
p3 = (Xrdx.adxP>ADX & vrsi>65 & vrsi<70) | ...
    (Xrdx.adxP<ADX & vrsi>60 & vrsi<65);
p4 = (Xrdx.adxP>ADX & vrsi>70) | ...
    (Xrdx.adxP<ADX & vrsi>65 & vrsi<70);
p5 = Xrdx.adxP<ADX & vrsi>70;
% updates
Xrdx.Cp = priceRSI;
Xrdx.Hp = high;
Xrdx.Lp = low;
Xrdx.SmoothedTrueRangeP = SmoothedTrueRange;
Xrdx.SmoothedDirectionalMovementPlusP = SmoothedDirectionalMovementPlus;
Xrdx.SmoothedDirectionalMovementMinusP = SmoothedDirectionalMovementMinus;
Xrdx.rsiupP = rsiup;
Xrdx.rsidownP = rsidown;
Xrdx.adxP = ADX;
out(1,:) = ADX;
out(2,:) = vrsi;
out(3,:) = m5;
out(4,:) = m4;
out(5,:) = m3;
out(6,:) = m2;
out(7,:) = m1;
out(8,:) = m0;
out(9,:) = p3;
out(10,:) = p4;
out(11,:) = p5;
end
%{
https://www.tradingview.com/script/Et8ou2hJ-RSI-buy-sell-force/
study(title = "RSI buy sell force ", overlay = false)
length=input(14)
p=input(close)

min =input(1440,   title = 'Length time distance')
len = timeframe.isintraday and timeframe.multiplier >= 1 ? 
   min / timeframe.multiplier * 7 : 
   timeframe.isintraday and timeframe.multiplier < 60 ? 
   60 / timeframe.multiplier * 24 * 7 : 7

vrsi = rsi(p, length)
pp=ema(vrsi,len)

d=(vrsi-pp)*5
bb=(vrsi-d+pp)/2
cc=(vrsi+d+pp)/2

avg=(cc+bb)/2
%}
function out = rsibuysell(C)
Length = 14;
arsi = 1/Length;
len = 7;
a = 1/7;
p = C;
Z = zeros(1,length(p));
persistent Xrsibs
if isempty(Xrsibs)
    Xrsibs.rsiwin = repmat(Z,Length+1,1);
    Xrsibs.Cp = p;
    Xrsibs.vrsip = Z;
    Xrsibs.rrfxupP = Z;
    Xrsibs.rrfxdownP = Z;
end
Xrsibs.rsiwin = [p-Xrsibs.Cp;Xrsibs.rsiwin(1:end-1,:)];
rrfxup = max(Xrsibs.rsiwin);
rrfxup(rrfxup<0) = 0;
rrfxdown = min(Xrsibs.rsiwin);
rrfxdown(rrfxdown>0) = 0;
rrfxdown = abs(rrfxdown);
rrfxup = (1-arsi)*Xrsibs.rrfxupP + arsi*rrfxup;
rrfxdown = (1-arsi)*Xrsibs.rrfxdownP + arsi*rrfxdown;
vrsi(rrfxdown == 0) = 100;
k = find(rrfxdown ~= 0);
vrsi(k) = 100 - (100 ./ (1 + rrfxup(k) ./ rrfxdown(k)));
pp = (1-a)*Xrsibs.vrsip + a*vrsi;
d=(vrsi-pp)*5;
bb=(vrsi-d+pp)/2;
cc=(vrsi+d+pp)/2;
cc = max(min(cc,100),0);
bb = max(min(bb,100),0);
avg=(cc+bb)/2;
Xrsibs.Cp = p;
Xrsibs.rrfxupP = rrfxup;
Xrsibs.rrfxdownP = rrfxdown;
Xrsibs.vrsip = pp;
out(1,:) = bb;
out(2,:) = cc;
out(3,:) = avg;
end
%{
https://www.tradingview.com/script/5gmbUNQV-Stoch-RSI-With-Color-Combination/
study(title="Stoch+RSI With Color Combination. ", shorttitle="Stoch+RSI By RRanjanFX", format=format.price, precision=2, resolution="")
odk = input(21, title="K", minval=1)
dP = input(7, title="D", minval=1)
sK = input(7, title="Smooth", minval=1)
lK = sma(stoch(close, high, low, odk), sK)
bnd = sma(lK, dP)
plot(bnd, title="%D", color=#FF6A00)

//RSI
rrfxlen = input(10, minval=1, title="Length")
rrfxsrc = input(close, "Source", type = input.source)
rrfxup = rma(max(change(rrfxsrc), 0), rrfxlen)
rrfxdown = rma(-min(change(rrfxsrc), 0), rrfxlen)
rrfxrsi = rrfxdown == 0 ? 100 : rrfxup == 0 ? 0 : 100 - (100 / (1 + rrfxup / rrfxdown))
%}
function out = StochPlusRSI(H,L,C)
odk = 21;
dP = 7;
sK = 7;
rrfxlen = 10;
arsi = 1/rrfxlen;
close = C;
high = H;
low = L;
rrfxsrc = close;
Z = zeros(1,length(close));
persistent Xsprsi
if isempty(Xsprsi)
    Xsprsi.lowwin = repmat(low,odk,1);
    Xsprsi.highwin = repmat(high,odk,1);
    Xsprsi.stochwin = repmat(50*ones(1,length(H)),sK,1);
    Xsprsi.bndwin = repmat(50*ones(1,length(H)),dP,1);
    Xsprsi.rsiwin = repmat(Z,rrfxlen+1,1);
    Xsprsi.Cp = close;
    Xsprsi.rrfxupP = Z;
    Xsprsi.rrfxdownP = Z;
end
Xsprsi.lowwin = [low;Xsprsi.lowwin(1:end-1,:)];
Xsprsi.highwin = [high;Xsprsi.highwin(1:end-1,:)];
Xsprsi.rsiwin = [close-Xsprsi.Cp;Xsprsi.rsiwin(1:end-1,:)];
stoch = 100*(close - min(Xsprsi.lowwin))./...
    (max(Xsprsi.highwin) - min(Xsprsi.lowwin));
Xsprsi.stochwin = [stoch;Xsprsi.stochwin(1:end-1,:)];
lk = sum(Xsprsi.stochwin)/sK;
Xsprsi.bndwin = [lk;Xsprsi.bndwin(1:end-1,:)];
bnd = sum(Xsprsi.bndwin)/dP;
rrfxup = max(Xsprsi.rsiwin);
rrfxup(rrfxup<0) = 0;
rrfxdown = min(Xsprsi.rsiwin);
rrfxdown(rrfxdown>0) = 0;
rrfxdown = abs(rrfxdown);
rrfxup = (1-arsi)*Xsprsi.rrfxupP + arsi*rrfxup;
rrfxdown = (1-arsi)*Xsprsi.rrfxdownP + arsi*rrfxdown;
rrfxrsi(rrfxdown == 0) = 100;
k = find(rrfxdown ~= 0);
rrfxrsi(k) = 100 - (100 ./ (1 + rrfxup(k) ./ rrfxdown(k)));
Xsprsi.Cp = close;
Xsprsi.rrfxupP = rrfxup;
Xsprsi.rrfxdownP = rrfxdown;
out(1,:) = bnd;
out(2,:) = rrfxrsi;
end
%{
https://www.tradingview.com/script/hz1PKu3G/
study("Average Sentiment Oscillator", shorttitle="ASO")
length=input(10,"Period?",minval=1,maxval=100)
mode=input(0,"Calculation Method:",minval=0,maxval=2)
intrarange=high-low
grouplow=lowest(low,length)
grouphigh=highest(high,length)
groupopen=open[length-1]
grouprange=grouphigh-grouplow
K1=intrarange==0 ? 1 : intrarange
K2=grouprange==0 ? 1 : grouprange
intrabarbulls=((((close-low)+(high-open))/2)*100)/K1
groupbulls=((((close-grouplow)+(grouphigh-open))/2)*100)/K2
intrabarbears=((((high-close)+(open-low))/2)*100)/K1
groupbears=((((grouphigh-close)+(open-grouplow))/2)*100)/K2
TempBufferBulls= mode==0 ? (intrabarbulls+groupbulls)/2 : mode==1 ? intrabarbulls : groupbulls
TempBufferBears= mode==0 ? (intrabarbears+groupbears)/2 : mode==1 ? intrabarbears : groupbears
ASOBulls=sma(TempBufferBulls,length)
ASOBears=sma(TempBufferBears,length)
plot(ASOBulls,color=color.blue,linewidth=2)
plot(ASOBears,color=color.red,linewidth=2)
%}
function out = AvgSentOsc(O,H,L,C)
open = O;
high = H;
low = L;
close = C;
Length = 10;
intrarange=high-low;
Z = zeros(1,Length);
persistent Xasosc
if isempty(Xasosc)
    Xasosc.lowwin = repmat(low,Length,1);
    Xasosc.highwin = repmat(high,Length,1);
    Xasosc.openwin = repmat(open,Length,1);
    Xasosc.Bearswin = repmat(low,Length,1);
    Xasosc.Bullswin = repmat(high,Length,1);
end
Xasosc.lowwin = [low;Xasosc.lowwin(1:end-1,:)];
Xasosc.highwin = [high;Xasosc.highwin(1:end-1,:)];
Xasosc.openwin = [open;Xasosc.openwin(1:end-1,:)];
grouplow=min(Xasosc.lowwin);
grouphigh=max(Xasosc.highwin);
groupopen=Xasosc.openwin(end,:);
grouprange=grouphigh-grouplow;
K1=intrarange;
K2=grouprange;
K1(intrarange==0)=1;
K2(grouprange==0)=1;
intrabarbulls=((((close-low)+(high-open))/2)*100)./K1;
groupbulls=((((close-grouplow)+(grouphigh-open))/2)*100)./K2;
intrabarbears=((((high-close)+(open-low))/2)*100)./K1;
groupbears=((((grouphigh-close)+(open-grouplow))/2)*100)./K2;
TempBufferBulls=(intrabarbulls+groupbulls)/2;
TempBufferBears=(intrabarbears+groupbears)/2;
Xasosc.Bullswin = [TempBufferBulls;Xasosc.Bullswin(1:end-1,:)];
Xasosc.Bearswin = [TempBufferBears;Xasosc.Bearswin(1:end-1,:)];
ASOBulls=sum(Xasosc.Bullswin)/Length;
ASOBears=sum(Xasosc.Bearswin)/Length;
Xasosc.Bullswin = [ASOBulls;Xasosc.Bullswin(1:end-1,:)];
Xasosc.Bearswin = [ASOBears;Xasosc.Bearswin(1:end-1,:)];
out(1,:) = ASOBulls;
out(2,:) = ASOBears;
end
%{
study("MavW Ort", overlay=true)
mavilimold = input(false, title="Show MavilimW?")
fmal=input(3,"First Moving Average length")
smal=input(5,"Second Moving Average length")
tmal=fmal+smal
Fmal=smal+tmal
Ftmal=tmal+Fmal
Smal=Fmal+Ftmal

M10= wma(close, fmal)
M20= wma(M10, smal)
M30= wma(M20, tmal)
M40= wma(M30, Fmal)
M50= wma(M40, Ftmal)
MAVW= wma(M50, Smal)
col10= MAVW>MAVW[1]
col30= MAVW<MAVW[1]
color0 = col10 ? blue : col30 ? red : yellow

M1= wma(max(close[1],high), fmal)
M2= wma(M1, smal)
M3= wma(M2, tmal)
M4= wma(M3, Fmal)
M5= wma(M4, Ftmal)
UBYZ= wma(M5, Smal)
col1= UBYZ>UBYZ[1]
col3= UBYZ<UBYZ[1]
color = col1 ? blue : col3 ? red : yellow

M11= wma(min(close[1],low), fmal)
M21= wma(M11, smal)
M31= wma(M21, tmal)
M41= wma(M31, Fmal)
M51= wma(M41, Ftmal)
ABYZ= wma(M51, Smal)
col11= ABYZ>ABYZ[1]
col31= ABYZ<ABYZ[1]
color1 = col11 ? blue : col31 ? red : yellow

M12= wma(close, 3)
M22= wma(M12, 5)
M32= wma(M22, 8)
M42= wma(M32, 13)
M52= wma(M42, 21)
MAVW2= wma(M52, 34)
%}
function out = MavilimW(H,L,C)
close = C;
high = H;
low = L;
fmal=3;
smal=5;
tmal=fmal+smal;
Fmal=smal+tmal;
Ftmal=tmal+Fmal;
Smal=Fmal+Ftmal;
persistent Xmlimw
if isempty(Xmlimw)
    Xmlimw.Cwin = repmat(close,Smal,1);
    Xmlimw.CHp = repmat(max(H,C),Smal,1);
    Xmlimw.CLp = repmat(min(L,C),Smal,1);
end
end
%{
https://www.tradingview.com/script/RsdQHpdq-Kaufman-Moving-Average-Adaptive-KAMA/
https://www.tradingview.com/script/OexuoYG3-MAMA-by-EHLERS/
Adaptive Momentum Smoothing Filters
Adaptive RSI: Adaptive Relative Strength Indicator
Smoothing function based on RSI
input: period(20);
    
if currentbar <= period then ARSI = close
else begin
    sc = (absvalue(RSI(close, period)/100);
    ARSI = ARSI[1] + sc*(close - ARSI[1]);
    end;
This indicator, an adaptive moving
average (AMA), moves very slowly when markets are 
moving sideways but moves swiftly when the markets also 
move swiftly, change directions or break out of
a trading range.

study(title="Kaufman Moving Average Adaptive (KAMA)", shorttitle="Kaufman Moving Average Adaptive (KAMA)", overlay = true)
Length = input(21, minval=1)
xPrice = close
xvnoise = abs(xPrice - xPrice[1])
nfastend = 0.666
nslowend = 0.0645
nsignal = abs(xPrice - xPrice[Length])
nnoise = sum(xvnoise, Length)
nefratio = iff(nnoise != 0, nsignal / nnoise, 0)
nsmooth = pow(nefratio * (nfastend - nslowend) + nslowend, 2) 
nAMA = nz(nAMA[1]) + nsmooth * (xPrice - nz(nAMA[1]))
study("MAMA by EHLERS", shorttitle="MAMA", overlay=true)
Price=input(hl2, title="Source")
fastlimit=input(0.5, title="Fast Limit")
slowlimit=input(0.05, title="Slow Limit")

smooth = (4*Price + 3*Price[1] + 2*Price[2] + Price[3])/10
detrender = (0.0962*smooth + 0.5769*nz(smooth[2]) - 0.5769*nz(smooth[4])- 0.0962*nz(smooth[6]))*(0.075*nz(Period[1]) + 0.54)
q1 = (0.0962*detrender + 0.5769*nz(detrender[2]) - 0.5769*nz(detrender[4])- 0.0962*nz(detrender[6]))*(0.075*nz(Period[1]) + 0.54)
i1 = nz(detrender[3])
jI = (0.0962*i1 + 0.5769*nz(i1[2]) - 0.5769*nz(i1[4])- 0.0962*nz(i1[6]))*(0.075*nz(Period[1]) + 0.54)
jq = (0.0962*q1 + 0.5769*nz(q1[2]) - 0.5769*nz(q1[4])- 0.0962*nz(q1[6]))*(0.075*nz(Period[1]) + 0.54)
i21 = i1 - jq
q21 = q1 + jI
i2 = 0.2*i21 + 0.8*nz(i2[1])
q2 = 0.2*q21 + 0.8*nz(q2[1])
re1 = i2*nz(i2[1]) + q2*nz(q2[1])
im1 = i2*nz(q2[1]) - q2*nz(i2[1])
re = 0.2*re1 + 0.8*nz(re[1])
im = 0.2*im1 + 0.8*nz(im[1])
p1 = iff(im!=0 and re!=0, 2* 4 * atan(1)/atan(im/re), nz(Period[1]))
p2 = iff(p1 > 1.5*nz(p1[1]), 1.5*nz(p1[1]), iff(p1 < 0.67*nz(p1[1]), 0.67*nz(p1[1]), p1))
p3 = iff(p2<6, 6, iff (p2 > 50, 50, p2))
Period = 0.2*p3 + 0.8*nz(p3[1])
SmoothPeriod = 0.33*Period + 0.67*nz(SmoothPeriod[1])
Phase = 180/(4 * atan(1))*atan(q1 / i1)
DeltaPhase1 = nz(Phase[1]) - Phase
DeltaPhase = iff(DeltaPhase1< 1, 1, DeltaPhase1)
alpha1 = fastlimit / DeltaPhase
alpha = iff(alpha1 < slowlimit, slowlimit, iff(alpha1 > fastlimit, fastlimit, alpha1))
MAMA = alpha*Price + (1 - alpha)*nz(MAMA[1])
FAMA = 0.5*alpha*MAMA + (1 - 0.5*alpha)*nz(FAMA[1])
%}
function out = AMA(H,L,C)
Len = 21;
xPrice = C;
nfastend = 0.666;
nslowend = 0.0645;
Period = 20;
rsilen = 14;
alph = 1/rsilen;
Z = zeros(1,length(C));
Price = (H+L)/2;
fastlimit = 0.5;
slowlimit = 0.05;
bsm = [4 3 2 1]/10;
bdet = [0.0962 0 0.5769 0 -0.5769 0 -0.0962];
persistent Xama
if isempty(Xama)
    Xama.rsiwin = repmat(Z,rsilen,1);
    Xama.xvnoisewin = repmat(Z,Len,1);
    Xama.xPwin = repmat(xPrice,Len,1);
    Xama.Pwin = repmat(Price,length(bsm),1);
    Xama.smwin = repmat(Price,length(bdet),1);
    Xama.detwin = repmat(Z,length(bdet),1);
    Xama.i1win = repmat(Z,length(bdet),1);
    Xama.q1win = repmat(Z,length(bdet),1);
    Xama.Cp = C;
    Xama.arsip = C;
    Xama.KAMAp = C;
    Xama.MAMAp = Price;
    Xama.FAMAp = Price;
    Xama.avgUp = Z;
    Xama.avgDp = Z;
    Xama.Periodp = Z;
    Xama.i2p = Z;
    Xama.q2p = Z;
    Xama.rep = Z;
    Xama.imp = Z;
    Xama.p1p = Z;
    Xama.p2p = Z; 
    Xama.p3p = Z;
    Xama.Phasep = Z;
    Xama.SmoothPeriodp = Z; 
end
Xama.rsiwin = [C-Xama.Cp;Xama.rsiwin(1:end-1,:)];
Xama.xPwin = [xPrice;Xama.xPwin(1:end-1,:)];
Xama.Pwin = [Price;Xama.Pwin(1:end-1,:)];
tmpU = Xama.rsiwin;
tmpU(tmpU<0)=0;
tmpD = Xama.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*Xama.avgUp + alph*avgU;
emaavgD = (1-alph)*Xama.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
rsi = 100*(1 - 1./(1+RS));
sc = abs(rsi)/100;
arsi = Xama.arsip + sc.*(xPrice - Xama.arsip);
xvnoise = abs(xPrice - Xama.Cp);
Xama.xvnoisewin = [xvnoise;Xama.xvnoisewin(1:end-1,:)];
nsignal = abs(xPrice - Xama.xPwin(end,:));
nnoise = sum(Xama.xvnoisewin);
nefratio = Z;
k = find(nnoise ~= 0);
nefratio(k) = nsignal(k) ./ nnoise(k);
nsmooth = power(nefratio .* (nfastend - nslowend) + nslowend, 2);
KAMA = Xama.KAMAp + nsmooth .* (xPrice - Xama.KAMAp);
smooth = sum(bsm'.*Xama.Pwin);
Xama.smwin = [smooth;Xama.smwin(1:end-1,:)];
tmpD = 0.075*Xama.Periodp + 0.54;
detrender = sum(bdet'.*Xama.smwin).*tmpD;
Xama.detwin = [detrender;Xama.detwin(1:end-1,:)];
q1 = sum(bdet'.*Xama.detwin).*tmpD;
i1 = Xama.detwin(4,:);
Xama.q1win = [q1;Xama.q1win(1:end-1,:)];
Xama.i1win = [i1;Xama.i1win(1:end-1,:)];
jI = sum(bdet'.*Xama.i1win).*tmpD;
jq = sum(bdet'.*Xama.q1win).*tmpD;
i21 = i1 - jq;
q21 = q1 + jI;
i2 = 0.2*i21 + 0.8*Xama.i2p;
q2 = 0.2*q21 + 0.8*Xama.q2p;
re1 = i2.*Xama.i2p + q2.*Xama.q2p;
im1 = i2.*Xama.q2p - q2.*Xama.i2p;
re = 0.2*re1 + 0.8*Xama.rep;
im = 0.2*im1 + 0.8*Xama.imp;
p1 = Xama.Periodp;
k = find(im~=0 & re~=0);
p1(k) = 2 * 4 * atan(1)./atan(im(k)./re(k));
p1tmp = max(0.67*Xama.p1p, p1);
p2 = min(1.5*Xama.p1p,p1tmp);
p3 = min(50,p2);
p3 = max(6,p3);
Period = 0.2*p3 + 0.8*Xama.p3p;
SmoothPeriod = 0.33*Period + 0.67*Xama.SmoothPeriodp;
Phase = 180/(4 * atan(1))*atan(q1 ./ i1);
DeltaPhase1 = Xama.Phasep - Phase;
DeltaPhase = max(1, DeltaPhase1);
alpha1 = fastlimit ./ DeltaPhase;
tmpA = min(fastlimit, alpha1);
alpha = max(alpha1 , slowlimit);
MAMA = alpha.*Price + (1 - alpha).*Xama.MAMAp;
FAMA = 0.5*alpha.*MAMA + (1 - 0.5*alpha).*Xama.FAMAp;

% updates
Xama.Cp = C;
Xama.avgUp = avgU;
Xama.avgDp = avgD;
Xama.arsip = arsi;
Xama.KAMAp = KAMA;
Xama.MAMAp = MAMA;
Xama.FAMAp = FAMA;
Xama.Periodp = Period;
Xama.i2p = i2;
Xama.q2p = q2;
Xama.rep = re;
Xama.imp = im;
Xama.p1p = p1;
Xama.p2p = p2;
Xama.p3p = p3;
Xama.SmoothPeriodp = SmoothPeriod;
Xama.Phasep = Phase;
out(1,:) = arsi;
out(2,:) = KAMA;
out(3,:) = MAMA;
out(4,:) = FAMA;
end
%{
https://www.tradingview.com/script/56tr3OzQ-Big-Snapper-Alerts-R2-0-by-JustUncleL/
lenFast        = input(defval=21, title="Fast MA - Length", minval=1)
// Medium MA - type, length
typeMedium     = input(defval="EMA", title="Medium MA Type: ", options=["SMA", "EMA", "WMA", "VWMA", "SMMA", "DEMA", "TEMA", "HullMA", "ZEMA", "TMA", "SSMA"], type=string)
lenMedium      = input(defval=55, title="Medium MA - Length", minval=1)
// Slow MA - type, length
typeSlow       = input(defval="EMA", title="Slow MA Type: ", options=["SMA", "EMA", "WMA", "VWMA", "SMMA", "DEMA", "TEMA", "HullMA", "ZEMA", "TMA", "SSMA"], type=string)
lenSlow        = input(defval=89, title="Slow MA Length", minval=1)
// 3xMA source
ma_src         = input(close)
uKC             = false // input(false,title="Use Keltner Channel (KC) instead of Bollinger")
bbLength        = input(20,minval=2,step=1,title="Bollinge Bands Length")
bbStddev        = input(2.0,minval=0.5,step=0.1,title="Bollinger Bands StdDevs")
oiLength        = input(8, title="Bollinger Outside In LookBack")
//
SFactor         = input(3.618, minval=1.0, title="SuperTrend Factor")
SPd             = input(5, minval=1, title="SuperTrend Length")
// Returns MA input selection variant, default to SMA if blank or typo.
variant(type, src, len) =>
    v1 = sma(src, len)                                                  // Simple
    v2 = ema(src, len)                                                  // Exponential
    v3 = wma(src, len)                                                  // Weighted
    v4 = vwma(src, len)                                                 // Volume Weighted
    v5 = 0.0
    v5 := na(v5[1]) ? sma(src, len) : (v5[1] * (len - 1) + src) / len    // Smoothed
    v6 = 2 * v2 - ema(v2, len)                                          // Double Exponential
    v7 = 3 * (v2 - ema(v2, len)) + ema(ema(v2, len), len)               // Triple Exponential
    v8 = wma(2 * wma(src, len / 2) - wma(src, len), round(sqrt(len)))   // Hull WMA = (2*WMA (n/2) − WMA (n)), sqrt (n))
    v11 = sma(sma(src,len),len)                                         // Triangular
    // SuperSmoother filter
    // © 2013  John F. Ehlers
    a1 = exp(-1.414*3.14159 / len)
    b1 = 2*a1*cos(1.414*3.14159 / len)
    c2 = b1
    c3 = (-a1)*a1
    c1 = 1 - c2 - c3
    v9 = 0.0
    v9 := c1*(src + nz(src[1])) / 2 + c2*nz(v9[1]) + c3*nz(v9[2])
    // Zero Lag Exponential
    e = ema(v1, len)
    v10 = v1+(v1-e)
    // return variant, defaults to SMA if input invalid.
    type=="EMA"?v2 : type=="WMA"?v3 : type=="VWMA"?v4 : type=="SMMA"?v5 : type=="DEMA"?v6 : type=="TEMA"?v7 : type=="HullMA"?v8 : type=="SSMA"?v9 : type=="ZEMA"?v10 : type=="TMA"? v11: v1
// === /FUNCTIONS ===

// === SERIES VARIABLES ===
// MA's
ma_fast     = variant(typeFast, ma_src, lenFast)
ma_medium   = variant(typeMedium, ma_src, lenMedium)
ma_slow     = variant(typeSlow, ma_src, lenSlow)
ma_coloured = variant(typeColoured, srcColoured, lenColoured)

// Get Direction of Coloured Moving Average
clrdirection = 1
clrdirection := rising(ma_coloured,2) ? 1 : falling(ma_coloured,2)? -1  : nz(clrdirection[1],1)

// get 3xMA trend direction based on selections.
madirection  =  ma_fast>ma_medium and ma_medium>ma_slow? 1 : ma_fast<ma_medium and ma_medium<ma_slow? -1 : 0
madirection  := disableSlowMAFilter?  ma_fast>ma_medium? 1 : ma_fast<ma_medium? -1 : 0 : madirection
madirection  := disableMediumMAFilter?  ma_fast>ma_slow? 1 : ma_fast<ma_slow? -1 : 0 : madirection
madirection  := disableFastMAFilter?  ma_medium>ma_slow? 1 : ma_medium<ma_slow? -1 : 0 : madirection
madirection  := disableFastMAFilter and disableMediumMAFilter?  ma_coloured>ma_slow? 1 : -1 : madirection
madirection  := disableFastMAFilter and disableSlowMAFilter?    ma_coloured>ma_medium? 1 : -1 : madirection
madirection  := disableSlowMAFilter and disableMediumMAFilter?  ma_coloured>ma_fast? 1 : -1 : madirection
// Supertrend Calculations
SUp=hl2-(SFactor*atr(SPd))
SDn=hl2+(SFactor*atr(SPd))

STrendUp   = 0.0
STrendDown = 0.0
STrendUp   := close[1]>STrendUp[1]? max(SUp,STrendUp[1]) : SUp
STrendDown := close[1]<STrendDown[1]? min(SDn,STrendDown[1]) : SDn
STrend = 0
STrend := close > STrendDown[1] ? 1: close< STrendUp[1]? -1: nz(STrend[1],1)
Tsl = STrend==1? STrendUp: STrendDown

// Standard Bollinger or KC Bands
basis = sma(ma_src, bbLength)
rangema = sma(tr, bbLength)
dev =   uKC? bbStddev*rangema : bbStddev * stdev(ma_src, bbLength)

// Calculate Bollinger or KC Channel
upper = basis + dev
lower = basis - dev
%}
function out = ScalpBigSnapper(H,L,C,V)
lenColoured    = 18;
lenFast        = 21;
lenMedium      = 55;
lenSlow        = 89;
ma_src         = C;
bbLength        = 20;
bbStddev        = 2.0;
oiLength        = 8;
SFactor         = 3.618;
SPd             = 5;
aSPd               = 1/SPd;
HL2             = (H+L)/2;
Z = zeros(1,length(H));
persistent XBigSnap
if isempty(XBigSnap)
    XBigSnap.VCwin = repmat(V.*C,lenSlow,1);
    XBigSnap.Vwin = repmat(V,lenSlow,1);
    XBigSnap.Cwin = repmat(C,lenSlow,1);
    tmp = max(H-L,max(H-C,abs(L-C)));
    XBigSnap.atrwin = repmat(tmp,bbLength,1);
    XBigSnap.atrp = tmp;
    XBigSnap.STrendUpp   = Z;
    XBigSnap.STrendDownp = Z;
    XBigSnap.Cp = C;
end
XBigSnap.VCwin = [V.*C;XBigSnap.VCwin(1:end-1,:)];
XBigSnap.Vwin = [V;XBigSnap.Vwin(1:end-1,:)];
XBigSnap.Cwin = [C;XBigSnap.Cwin(1:end-1,:)];
ma_fast     = sum(XBigSnap.VCwin(1:lenFast,:))./...
    sum(XBigSnap.Vwin(1:lenFast,:));
ma_medium     = sum(XBigSnap.VCwin(1:lenMedium,:))./...
    sum(XBigSnap.Vwin(1:lenMedium,:));
ma_slow     = sum(XBigSnap.VCwin(1:lenSlow,:))./...
    sum(XBigSnap.Vwin(1:lenSlow,:));
ma_coloured     = sum(XBigSnap.VCwin(1:lenColoured,:))./...
    sum(XBigSnap.Vwin(1:lenColoured,:));
atr = max(H-L,max(H-XBigSnap.Cwin(2,:),...
    abs(L-XBigSnap.Cwin(2,:))));
atrSPd = (1-aSPd)*XBigSnap.atrp + aSPd*atr;
XBigSnap.atrwin = [atr;XBigSnap.atrwin(1:end-1,:)];
SUp = HL2 - SFactor*atrSPd;
SDn = HL2 + SFactor*atrSPd;
STrendUp   = SUp;
STrendDown = SDn;
k = find(XBigSnap.Cp>XBigSnap.STrendUpp);
STrendUp(k) = max(SUp(k),XBigSnap.STrendUpp(k));
k = find(XBigSnap.Cp<XBigSnap.STrendDownp);
STrendDown(k) = min(SDn(k),XBigSnap.STrendDownp(k));
tmp = Z;
tmp(C<XBigSnap.STrendDownp) = -1;
STrend = tmp;
STrend(C > XBigSnap.STrendDownp) = 1;
Tsl = STrendDown;
k = find(STrend==1);
Tsl(k) = STrendUp(k);
basis = sum(XBigSnap.Cwin(1:bbLength,:))/bbLength;
% rangema = sum(XBigSnap.atrwin(1:bbLength,:))/bbLength;
dev = bbStddev * std(XBigSnap.Cwin(1:bbLength,:));
upper = basis + dev;
lower = basis - dev;
XBigSnap.atrp = atr;
XBigSnap.Cp = C;
XBigSnap.STrendUpp = STrendUp;
XBigSnap.STrendDownp = STrendDown;
out(1,:) = STrendUp;
out(2,:) = STrendDown;
out(3,:) = ma_fast;
out(4,:) = ma_medium;
out(5,:) = ma_slow;
out(6,:) = ma_coloured;
out(7,:) = basis;
out(8,:) = upper;
out(9,:) = lower;
end
%{
https://www.tradingview.com/script/LjT0cZUy-ATR-VWAP-Alert/
study('ATR+VWAP Alert', overlay=true)
// data series for RSI with length 14
rsi = rsi(close, 14)
// data series for ATR with length 14
vol = atr(14)
// data series for VWAP
VWAP = vwap(0)
// data series for VWMAs, length 13 and 62
ma1 = vwma(close, 13)
ma2 = vwma(close, 62)
%}
function out = Scalpatrvwap(H,L,C,V)
P = (H+L+C)/3;
rsilen = 14;
len1 = 13;
len2 = 62;
alph = 1/rsilen;
atrL = alph;
Z = zeros(1,length(H));
persistent Xscatrvwap
if isempty(Xscatrvwap)
    Xscatrvwap.rsiwin = repmat(Z,rsilen,1);
    Xscatrvwap.Cp = C;
    Xscatrvwap.avgUp = ones(1,length(H));
    Xscatrvwap.avgDp = Z;
    Xscatrvwap.atrp = max(H-L,max(H-C,abs(L-C)));
    Xscatrvwap.vwmap = repmat(V.*C,len2,1);
    Xscatrvwap.Vwin = repmat(V,len2,1);
    Xscatrvwap.Cwin = repmat(C,len2,1);
    Xscatrvwap.VWAP = repmat(V.*P,len2,1);
end
Xscatrvwap.rsiwin = [C-Xscatrvwap.Cp;Xscatrvwap.rsiwin(1:end-1,:)];
Xscatrvwap.vwmap = [V.*C;Xscatrvwap.vwmap(1:end-1,:)];
Xscatrvwap.Vwin = [V;Xscatrvwap.Vwin(1:end-1,:)];
Xscatrvwap.Cwin = [C;Xscatrvwap.Cwin(1:end-1,:)];
Xscatrvwap.VWAP = [V.*P;Xscatrvwap.VWAP(1:end-1,:)];
tmpU = Xscatrvwap.rsiwin;
tmpU(tmpU<0)=0;
tmpD = Xscatrvwap.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*Xscatrvwap.avgUp + alph*avgU;
emaavgD = (1-alph)*Xscatrvwap.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
rsi = 100*(1 - 1./(1+RS));
atr = max(H-L,max(H-Xscatrvwap.Cwin(2,:),...
    abs(L-Xscatrvwap.Cwin(2,:))));
vol = (1-atrL)*Xscatrvwap.atrp + atrL*atr;
vwap = sum(Xscatrvwap.VWAP(1:len1,:))./sum(Xscatrvwap.Vwin(1:len1,:));
ma1 = sum(Xscatrvwap.vwmap(1:len1,:))./sum(Xscatrvwap.Vwin(1:len1,:));
ma2 = sum(Xscatrvwap.vwmap)./sum(Xscatrvwap.Vwin);
Xscatrvwap.avgUp = emaavgU;
Xscatrvwap.avgDp = emaavgD;
Xscatrvwap.atrp = vol;
Xscatrvwap.Cp = C;
out(1,:) = rsi;
out(2,:) = vol;
out(3,:) = vwap;
out(4,:) = ma1;
out(5,:) = ma2;
end
%{
https://www.tradingview.com/script/kPV0Kl8w-Triangular-Moving-Average-TMA-bands/
Triangular Moving Average (TMA) bands
study("TMA bands", shorttitle="TMA bands", overlay=true)
TMAPeriodBack = input(defval=35, title="TMA number of bars back")
ATRPeriodBack = input(defval=75, title="ATR number of bars back")
ATRMultiplier = input(defval=4.0, title="ATR Multiplier")
src = input(close, title="Price")

ssi=wma(src,TMAPeriodBack)
tma = swma(ssi)
range = atr(ATRPeriodBack)*ATRMultiplier
tmah = tma+range
tmal = tma-range 
%}
function out = Scalptma(H,L,C)
TMAPeriodBack = 35;
ATRPeriodBack = 75;
ATRMultiplier = 4.0;
src = C;
tmp = [TMAPeriodBack:-1:1];
bwma = tmp/sum(tmp);
bsm = [1 2 2 1]/6;
atrlen = ATRPeriodBack;
atrL = 1/atrlen;

persistent XSctma
if isempty(XSctma)
    XSctma.Cwin = repmat(C,TMAPeriodBack,1);
    XSctma.smCwin = repmat(C,length(bsm),1);
    XSctma.atrp = max(H-L,max(H-C,abs(L-C)));
end
XSctma.Cwin = [C;XSctma.Cwin(1:end-1,:)];
ssi = sum(bwma'.*XSctma.Cwin);
XSctma.smCwin = [ssi;XSctma.smCwin(1:end-1,:)];
tma = sum(bsm'.*XSctma.smCwin);
atr = max(H-L,max(H-XSctma.Cwin(2,:),...
    abs(L-XSctma.Cwin(2,:))));
atr = (1-atrL)*XSctma.atrp + atrL*atr;
range = atr*ATRMultiplier;
tmah = tma+range;
tmal = tma-range;
XSctma.atrp = atr;
out(1,:) = ssi;
out(2,:) = tma;
out(3,:) = tmah;
out(4,:) = tmal;
end
%{
// - https://www.forexstrategiesresources.com/scalping-forex-strategies-iii/337-bollinger-bands-and-chaos-awesome-scalping-system
// - "Squeeze Momentum Indicator [LazyBear]"
// Bollinger Bands Inputs
bb_use_ema = input(false, title="Use EMA for Bollinger Band")
bb_filter = input(false, title="Filter Buy/Sell with Bollinger Bands")
sqz_filter = input(false, title="Flter Buy/Sell with BB squeeze")
bb_length = input(20, minval=1, title="Bollinger Length")
bb_source = input(close, title="Bollinger Source")
bb_mult = input(2.0, title="Base Multiplier", minval=0.5, maxval=10)
// EMA inputs
fast_ma_len = input(3, title="Fast EMA length", minval=2)
// Awesome Inputs
nLengthSlow = input(34, minval=1, title="Awesome Length Slow")
nLengthFast = input(5, minval=1, title="Awesome Length Fast")

// === /INPUTS ===

sqz_length      = input(100, "BB Relative Squeeze Length", minval = 5)
sqz_threshold   = input(50,  "BB Squeeze Threshold %", maxval=99, step = 5)



// === SERIES ===

// Breakout Indicator Inputs
bb_basis = bb_use_ema ? ema(bb_source, bb_length) : sma(bb_source, bb_length)
fast_ma  = ema(bb_source, fast_ma_len)

// Deviation
// * I'm sure there's a way I could write some of this cleaner, but meh.
dev = stdev(bb_source, bb_length)
bb_dev = bb_mult * dev

// Upper bands
bb_upper = bb_basis + bb_dev
// Lower Bands
bb_lower = bb_basis - bb_dev

// Calculate Awesome Oscillator
xSMA1_hl2 = sma(hl2, nLengthFast)
xSMA2_hl2 = sma(hl2, nLengthSlow)
xSMA1_SMA2 = xSMA1_hl2 - xSMA2_hl2
// Calculate direction of AO
AO = xSMA1_SMA2>=0? xSMA1_SMA2 > xSMA1_SMA2[1] ? 1 : 2 : xSMA1_SMA2 > xSMA1_SMA2[1] ? -1 : -2

// Calculate BB spread and average spread
spread    = bb_upper-bb_lower
avgspread = sma(spread,sqz_length) 

// Calculate BB relative %width for Squeeze indication
bb_squeeze   = (spread/avgspread)*100

// Calculate Upper and Lower band painting offsets based on 50% of atr.
bb_offset    = atr(14)*0.5
bb_sqz_upper = bb_upper + bb_offset
bb_sqz_lower = bb_lower - bb_offset

// === /SERIES ===

// === PLOTTING ===

// plot BB basis
plot(bb_basis, title="Basis Line", color=red, transp=10, linewidth=2)
// plot BB upper and lower bands
ubi = plot(bb_upper, title="Upper Band Inner", color=blue, transp=10, linewidth=1)
lbi = plot(bb_lower, title="Lower Band Inner", color=blue, transp=10, linewidth=1)
// center BB channel fill
fill(ubi, lbi, title="Center Channel Fill", color=silver, transp=90)

//Indicate BB squeeze based on threshold.
usqzi = plot(bb_sqz_upper, "Hide Sqz Upper", transp=100)
lsqzi = plot(bb_sqz_lower, "Hide Sqz Lower", transp=100)
fill(ubi,usqzi, color = bb_squeeze>sqz_threshold ? white:blue, transp = 50)
fill(lbi,lsqzi, color = bb_squeeze>sqz_threshold ? white:blue, transp = 50)

// plot fast ma
plot(fast_ma, title="Fast EMA", color=black, transp=10, linewidth=2)

// Calc breakouts
break_down =   crossunder(fast_ma, bb_basis) and close < bb_basis and abs(AO)==2 and (not bb_filter or close >bb_lower) and (not sqz_filter or bb_squeeze>sqz_threshold)
break_up   =  crossover(fast_ma, bb_basis) and close > bb_basis and abs(AO)==1 and (not bb_filter or close<bb_upper) and (not sqz_filter or bb_squeeze>sqz_threshold)
%}
function out = ScalpBollAwe(H,L,C)
bb_length = 20;
bb_source = C;
bb_mult = 2.0;
% EMA inputs
fast_ma_len = 3;
atrlen = 14;
alen = 2/(bb_length+1);
aF = 2/(fast_ma_len+1);
atrL = 1/atrlen;
% Awesome Inputs
nLengthSlow = 34;
nLengthFast = 5;
sqz_length      = 100;
sqz_threshold   = 50;
HL2 = (H+L)/2;
Z = zeros(1,length(L));
persistent XSbolaw
if isempty(XSbolaw)
    XSbolaw.basisp = bb_source;
    XSbolaw.fastp = bb_source;
    XSbolaw.devp = bb_source;
    XSbolaw.HL2win = repmat(HL2,nLengthSlow,1);
    XSbolaw.bbwin = repmat(bb_source,nLengthSlow,1);
    XSbolaw.spreadwin = repmat(Z,sqz_length,1);
    XSbolaw.atrp = max(H-L,max(H-C,abs(L-C)));
end
XSbolaw.bbwin = [bb_source;XSbolaw.bbwin(1:end-1,:)];
XSbolaw.HL2win = [HL2;XSbolaw.HL2win(1:end-1,:)];
bb_basis = (1-alen)*XSbolaw.basisp + alen*bb_source;
fast_ma = (1-aF)*XSbolaw.fastp + aF*bb_source;
% Bands
dev = std(XSbolaw.bbwin(1:bb_length,:));
bb_dev = bb_mult * dev;
bb_upper = bb_basis + bb_dev;
bb_lower = bb_basis - bb_dev;
% Awesome Oscillator
xSMA1_hl2 = sum(XSbolaw.HL2win(1:nLengthFast,:))/nLengthFast;
xSMA2_hl2 = sum(XSbolaw.HL2win)/nLengthSlow;
xSMA1_SMA2 = xSMA1_hl2 - xSMA2_hl2;
% Calculate BB spread and average spread
spread    = bb_upper-bb_lower;
XSbolaw.spreadwin = [spread;XSbolaw.spreadwin(1:end-1,:)];
avgspread = sum(XSbolaw.spreadwin)/sqz_length; 
bb_squeeze   = (spread/avgspread)*100;
atr = max(H-L,max(H-XSbolaw.bbwin(2,:),...
    abs(L-XSbolaw.bbwin(2,:))));
bb_offset = (1-atrL)*XSbolaw.atrp + atrL*atr;
bb_sqz_upper = bb_upper + bb_offset;
bb_sqz_lower = bb_lower;
% bb_sqz_lower = bb_lower - bb_offset;
XSbolaw.basisp = bb_basis;
XSbolaw.fastp = fast_ma;
XSbolaw.atrp = bb_offset;
out(1,:) = bb_basis;
out(2,:) = fast_ma;
out(3,:) = bb_upper;
out(4,:) = bb_lower;
out(5,:) = xSMA1_SMA2;
out(6,:) = bb_sqz_upper;
out(7,:) = bb_sqz_lower;
end
%{
https://www.tradingview.com/script/b2aAujaw-INDYAN-RSI-MACD/
study(title="{INDYAN} RSI + MACD", shorttitle="{INDYAN} RSI+MACD Divergence")
len = input(title="RSI Period", minval=1, defval=7)
src = input(title="RSI Source", defval=close)
osc = rsi(src, len)
fast_length = input(title="Fast Length", type=input.integer, defval=5)
slow_length = input(title="Slow Length", type=input.integer, defval=8)
srcd = input(title="Source", type=input.source, defval=close)
signal_length = input(title="Signal Smoothing", type=input.integer, minval = 1, maxval = 50, defval = 3)
sma_source = input(title="Simple MA(Oscillator)", type=input.bool, defval=false)
sma_signal = input(title="Simple MA(Signal Line)", type=input.bool, defval=false)

// Plot colors
col_grow_above = #26A69A
col_grow_below = #FFC1D5
col_fall_above = #B2DFDB
col_fall_below = #EF5550
col_macd = #0094ff
col_signal = #ff6a00

// Calculating
fast_ma = sma_source ? sma(src, fast_length) : ema(src, fast_length)
slow_ma = sma_source ? sma(src, slow_length) : ema(src, slow_length)
macd = fast_ma - slow_ma
signal = sma_signal ? sma(macd, signal_length) : ema(macd, signal_length)
hist = macd - signal
%}
function out = Scalprsimacd(C)
len = 14;
fast_length = 5;
slow_length = 8;
signal_length = 50;
aF = 2/(fast_length+1);
aS = 2/(slow_length+1);
aSL = 2/(signal_length+1);
Z = zeros(1,length(C));
persistent XSrsimacd
if isempty(XSrsimacd)
    XSrsimacd.rsip = Z;
    XSrsimacd.avgUp = Z;
    XSrsimacd.avgDp = Z;
    XSrsimacd.rsiwin = repmat(50*ones(1,length(C)),len,1);
    XSrsimacd.fast_lengthp = C;
    XSrsimacd.slow_lengthp = C;
    XSrsimacd.signal_lengthp = Z;
    XSrsimacd.Cp = C;
end
XSrsimacd.rsiwin = [C-XSrsimacd.Cp;XSrsimacd.rsiwin(1:end-1,:)];
alph = 1/len;
tmpU = XSrsimacd.rsiwin;
tmpU(tmpU<0)=0;
tmpD = XSrsimacd.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*XSrsimacd.avgUp + alph*avgU;
emaavgD = (1-alph)*XSrsimacd.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
rsi = 100*(1 - 1./(1+RS));
osc = rsi;
fast_ma = (1-aF)*XSrsimacd.fast_lengthp + aF*C;
slow_ma = (1-aS)*XSrsimacd.slow_lengthp + aS*C;
macd = fast_ma - slow_ma;
signal = (1-aSL)*XSrsimacd.signal_lengthp + aSL*macd;
hist = macd - signal;
% updates
XSrsimacd.fast_lengthp = fast_ma;
XSrsimacd.slow_lengthp = slow_ma;
XSrsimacd.signal_lengthp = signal;
XSrsimacd.avgUp = emaavgU;
XSrsimacd.avgDp = emaavgD;
XSrsimacd.Cp = C;
out(1,:) = osc;
out(2,:) = fast_ma;
out(3,:) = slow_ma;
out(4,:) = signal;
out(5,:) = hist;
out(6,:) = macd;
end
%{
study(title="NSDT Midline", overlay=true)

t = time("1440", session.extended)

is_first = na(t[1]) and not na(t) or t[1] < t

day_high = float(na)
day_low = float(na)

if is_first and barstate.isnew
    day_high := high
    day_low := low
    day_low
else
    day_high := day_high[1]
    day_low := day_low[1]
    day_low

if high > day_high
    day_high := high
    day_high

if low < day_low
    day_low := low
    day_low

MidLine = input(title="Show Mid Line", type=input.bool, defval=true)
MidlineValue= (day_high + day_low)/2
%}
function out = ScalpNSDTmidline(H,L)
persistent XScnsdt
if isempty(XScnsdt)
    XScnsdt.is_first = 1;
    XScnsdt.day_highp = H;
    XScnsdt.day_lowp = L;
end
if XScnsdt.is_first
    day_high = H;
    day_low = L;
else
    day_high = XScnsdt.day_highp;
    day_low = XScnsdt.day_lowp;
end
k = find(H > day_high);
day_high(k) = H(k);
k = find(L < day_low);
day_low(k) = L(k);
MidlineValue = (day_high + day_low)/2;
k = find(MidlineValue > H*1.0);
day_high(k) = H(k);
k = find(MidlineValue < L*1.0);
day_low(k) = L(k);

XScnsdt.day_highp = day_high;
XScnsdt.day_lowp = day_low;
out(1,:) = day_high;
out(2,:) = day_low;
out(3,:) = MidlineValue;
XScnsdt.is_first = 0;
end
%{
https://www.tradingview.com/script/KDLzj2PW-Attrition-Scalper-v1-0/
VID(src, vidyauzunluk) =>
    momentum = change(src)
    upSum = sum(max(momentum, 0), vidyauzunluk)
    downSum = sum(-min(momentum, 0), vidyauzunluk)
    oute = (upSum - downSum) / (upSum + downSum)
    oute

vidyakaynak = close
vidyauzunluk = 9
vid = abs(VID(vidyakaynak, vidyauzunluk))
alpha = 2 / (vidyauzunluk + 1)
vidya = 0.0
vidya2 = 0.0
vidya3 = 0.0
vidya := vidyakaynak * alpha * vid + nz(vidya[1]) * (1 - alpha * vid)

lan = 20
p = close
sma = sma(p, lan)
avg = atr(lan)
fibratio1 = 1.618
fibratio2 = 2.618
fibratio3 = 4.236
r1 = avg * fibratio1
r2 = avg * fibratio2
r3 = avg * fibratio3
top3 = sma + r3
top2 = sma + r2
top1 = sma + r1
bott1 = sma - r1
bott2 = sma - r2
bott3 = sma - r3
%}
function out = ScalpAttrition(H,L,C)
lan = 20;
alph = 1/lan;
v = 9;
alpha = 2/(v+1);
p = C;
fibratio1 = 1.618;
fibratio2 = 2.618;
fibratio3 = 4.236;
persistent XScAtt
if isempty(XScAtt)
    XScAtt.Cwin = repmat(p,lan,1);
    XScAtt.atrp = max(H-L,max(H-p,abs(L-p)));
    XScAtt.momentum = zeros(v,length(H));
    XScAtt.vidyap = p;
end
XScAtt.Cwin = [p;XScAtt.Cwin(1:end-1,:)];
XScAtt.momentum = [XScAtt.Cwin(1,:)-XScAtt.Cwin(2,:);...
    XScAtt.momentum(1:end-1,:)];
upSum = sum(max(XScAtt.momentum,0));
downSum = sum(-min(XScAtt.momentum,0));
vid = abs(upSum - downSum) ./ (upSum + downSum);
vid(isnan(vid)) = 0;
vidya = p.*alpha.*vid + XScAtt.vidyap .* (1 - alpha .* vid);
sma = sum(XScAtt.Cwin)/lan;
atr = max(H-L,max(H-XScAtt.Cwin(2,:),...
    abs(L-XScAtt.Cwin(2,:))));
avg = (1-alph)*XScAtt.atrp + alph*atr;
r1 = avg * fibratio1;
r2 = avg * fibratio2;
r3 = avg * fibratio3;
top3 = sma + r3;
top2 = sma + r2;
top1 = sma + r1;
bott1 = sma - r1;
bott2 = sma - r2;
bott3 = sma - r3;
% updates
XScAtt.vidyap = vidya;
XScAtt.atrp = avg;
out(1,:) = sma;
out(2,:) = top1;
out(3,:) = top2;
out(4,:) = top3;
out(5,:) = bott1;
out(6,:) = bott2;
out(7,:) = bott3;
out(8,:) = vidya;
end
%{
https://www.tradingview.com/script/GVCNmuK0-Ehlers-Alternate-Signal-To-Noise-Ratio-CC/
study("Ehlers Alternate Signal To Noise Ratio [CC]", overlay=false)

f_security(_symbol, _res, _src, _repaint) => 
    security(_symbol, _res, _src[_repaint ? 0 : barstate.isrealtime ? 1 : 0])[_repaint ? 0 : barstate.isrealtime ? 0 : 1]
    
res = input(title="Resolution", type=input.resolution, defval="")
rep = input(title="Allow Repainting?", type=input.bool, defval=false)
bar = input(title="Allow Bar Color Change?", type=input.bool, defval=true)
src = f_security(syminfo.tickerid, res, hl2, rep)
h = f_security(syminfo.tickerid, res, high, rep)
l = f_security(syminfo.tickerid, res, low, rep)

pi = 2 * asin(1)
period = 0.0
range = 0.0
range := (0.1 * (h - l)) + (0.9 * nz(range[1]))

smooth = ((4 * src) + (3 * nz(src[1])) + (2 * nz(src[2])) + nz(src[3])) / 10
detrender = ((0.0962 * smooth) + (0.5769 * nz(smooth[2])) - (0.5769 * nz(smooth[4])) - (0.0962 * nz(smooth[6]))) * ((0.075 * nz(period[1])) + 0.54)

q1 = ((0.0962 * detrender) + (0.5769 * nz(detrender[2])) - (0.5769 * nz(detrender[4])) - (0.0962 * nz(detrender[6]))) * ((0.075 * nz(period[1])) + 0.54)
i1 = nz(detrender[3])

jI = ((0.0962 * i1) + (0.5769 * nz(i1[2])) - (0.5769 * nz(i1[4])) - (0.0962 * nz(i1[6]))) * ((0.075 * nz(period[1])) + 0.54)
jQ = ((0.0962 * q1) + (0.5769 * nz(q1[2])) - (0.5769 * nz(q1[4])) - (0.0962 * nz(q1[6]))) * ((0.075 * nz(period[1])) + 0.54)

i2 = i1 - jQ
i2 := (0.2 * i2) + (0.8 * nz(i2[1]))
q2 = q1 + jI
q2 := (0.2 * q2) + (0.8 * nz(q2[1]))

re = (i2 * nz(i2[1])) + (q2 * nz(q2[1]))
re := (0.2 * re) + (0.8 * nz(re[1]))
im = (i2 * nz(q2[1])) - (q2 * nz(i2[1]))
im := (0.2 * im) + (0.8 * nz(im[1]))

period := im != 0 and re != 0 ? 2 * pi / atan(im / re) : 0
period := min(max(period, 0.67 * nz(period[1])), 1.5 * nz(period[1]))
period := min(max(period, 6), 50)
period := (0.2 * period) + (0.8 * nz(period[1]))

snr = 0.0
snr := range > 0 ? (0.25 * ((10 * log((re + im) / (range * range)) / log(10)) + 6)) + (0.75 * nz(snr[1])) : 0

hline(6)
sig = src > smooth ? 1 : src < smooth ? -1 : 0
%}
function out = Scalpsnr(H,L,C)
src = (H+L)/2;
bsm = [4 3 2 1]/10;
bbp = [0.0962 0 0.5769 0 -0.5769 0 -0.0962];
persistent Xsnr
if isempty(Xsnr)
    Z = zeros(1,length(H));
    Xsnr.rangep = H-L;
    Xsnr.periodp = Z;
    Xsnr.srcwin = repmat(src,length(bsm),1);
    Xsnr.smwin = repmat(Z,length(bbp),1);
    Xsnr.detwin = repmat(Z,length(bbp),1);
    Xsnr.i1win = repmat(Z,length(bbp),1);
    Xsnr.q1win = repmat(Z,length(bbp),1);
    Xsnr.I2p = Z;
    Xsnr.Q2p = Z;
    Xsnr.rep = Z;
    Xsnr.imp = Z;
    Xsnr.snrp = Z;
end
tmp = (0.075 * Xsnr.periodp) + 0.54;
Xsnr.srcwin = [src;Xsnr.srcwin(1:end-1,:)];
range = 0.1*(H-L).*(H-L)/4 + 0.9*Xsnr.rangep;
smooth = sum(bsm'.*Xsnr.srcwin);
Xsnr.smwin = [smooth;Xsnr.smwin(1:end-1,:)];
detrender = sum(bbp'.*Xsnr.smwin.*tmp);
Xsnr.detwin = [detrender;Xsnr.detwin(1:end-1,:)];
q1 = sum(bbp'.*Xsnr.detwin.*tmp);
i1 = Xsnr.detwin(4,:);
Xsnr.i1win = [i1;Xsnr.i1win(1:end-1,:)];
Xsnr.q1win = [q1;Xsnr.q1win(1:end-1,:)];
jI = sum(bbp'.*Xsnr.i1win.*tmp);
jQ = sum(bbp'.*Xsnr.q1win.*tmp);
i2 = i1 - jQ;
i2 = 0.2 * i2 + 0.8 * Xsnr.I2p;
q2 = q1 + jI;
q2 = 0.2 * q2 + 0.8 * Xsnr.Q2p;
re = (i2 .* Xsnr.I2p) + (q2 .* Xsnr.Q2p);
re = (0.2 * re) + (0.8 * Xsnr.rep);
im = (i2 .* Xsnr.Q2p) - (q2 .* Xsnr.I2p);
im = (0.2 * im) + (0.8 * Xsnr.imp);
period = zeros(1,length(C));
k = find(im ~= 0 & re ~= 0);
period(k) = 2 * pi ./ atan(im(k) ./ re(k));
period = min(period,1.5 * Xsnr.periodp);
period = max(period,0.67 * Xsnr.periodp);
period = min(period,50);
period = max(period,6);
period = (0.2 * period) + (0.8 * Xsnr.periodp);
snr = zeros(1,length(C));
k = find((range > 0)&(re ~= 0)&(im ~= 0));
snr(k) = (0.25 * ((10 * log((re(k) + im(k)) ./ ...
    (range(k) .* range(k))) ./ log(10)) + 6)) + ...
    (0.75 * Xsnr.snrp(k));
% updates
Xsnr.rangep = range;
Xsnr.I2p = i2;
Xsnr.Q2p = q2;
Xsnr.rep = re;
Xsnr.imp = im;
Xsnr.periodp = period;
Xsnr.snrp = snr;
out(1,:) = smooth;
out(2,:) = detrender;
out(3,:) = snr;
out(4,:) = period;
out(5,:) = re;
out(6,:) = im;
out(7,:) = range;
end
%{
study("Ehlers Super PassBand Filter [CC]", overlay=false)

inp = input(title="Source", type=input.source, defval=close)
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
function out = ScalpSupBP(C)
src = C;
length1 = 40;
length2 = 60;
rmsLength = 50;
a1 = 5.0 / length1;
a2 = 5.0 / length2;
persistent XScSupbp
if isempty(XScSupbp)
    XScSupbp.srcp = src;
    XScSupbp.pbp = zeros(1,length(src));
    XScSupbp.pbpp = zeros(1,length(src));
    XScSupbp.pbwin = repmat(zeros(1,length(src)),rmsLength,1);
end
pb = ((a1 - a2) * src) + ...
    (((a2 * (1 - a1)) - (a1 * (1 - a2))) * XScSupbp.srcp) + ...
    (((1 - a1) + (1 - a2)) * XScSupbp.pbp) - ...
    ((1 - a1) * (1 - a2) * XScSupbp.pbp);
XScSupbp.pbwin = [pb;XScSupbp.pbwin(1:end-1,:)];
rms = zeros(1,length(src));
for i = 1:rmsLength
    rms = rms + power(XScSupbp.pbwin(i,:), 2);
end
rms = sqrt(rms / rmsLength);
sig = zeros(1,length(src));
sig(pb<0) = -0.45;
sig(pb>0) = 0.45;
% updates
XScSupbp.srcp = src;
XScSupbp.pbpp = XScSupbp.pbp;
XScSupbp.pbp = pb;
out(1,:) = pb;
out(2,:) = rms;
out(3,:) = sig;
end
%{
strategy(shorttitle="SSL EMA strat", title="ssl ema", overlay=true)

// Moving average
hma(src, len) =>
    wma(2 * wma(src, len / 2) - wma(src, len), round(sqrt(len)))

ma = input(title="MA type", defval="EMA", options=["EMA", "SMA", "Hull", "WMA"])

MA(price, length) =>
    current = if ma == 'EMA'
        ema(price, length)
    else
        if ma == 'SMA'
            sma(price, length)
        else
            if ma == 'WMA'
                wma(price, length)
            else
                hma(price, length)
    current

price = input(close, title='Price')
maFast = MA(price, input(50))
maSlow = MA(price, input(100, title='MA Slow'))
maTurtle = MA(price, input(200, title='MA Turtle'))
viewCrossFlag = input(false, title='View MA Slow/Turtle crossover')

plot(maTurtle, title="MA Turtle", style=plot.style_circles, linewidth=4, color=maFast >= maSlow ? #CCCCCC : #222222)
plot(maFast, title="MA Fast", style=plot.style_circles, linewidth=4, color=color.yellow, transp=0)
plot(maSlow, title="MA Slow", style=plot.style_circles, linewidth=4, color=color.purple, transp=0)

//plotchar(viewCrossFlag and crossunder(maSlow, maTurtle), char='✜', color=red, location=location.top, transp=0, size=size.tiny)
//plotchar(viewCrossFlag and crossover(maSlow, maTurtle), char='✜', color=green, location=location.bottom, transp=0, size=size.tiny)

period = input(title="Period", defval=10)
len = input(title="Period", defval=10)
smaHigh = sma(high, len)
smaLow = sma(low, len)
Hlv = int(na)
Hlv := close > smaHigh ? 1 : close < smaLow ? -1 : Hlv[1]
sslDown = Hlv < 0 ? smaHigh : smaLow
sslUp = Hlv < 0 ? smaLow : smaHigh

plot(sslDown, linewidth=2, color=color.red)
plot(sslUp, linewidth=2, color=color.lime)
// rsi

length = input( 14 )
overSold = input( 50 )
overBought = input( 50 )
pricev = close

tp = input(200)
sl = input(100)

vrsi = rsi(pricev, length)
co = crossover(vrsi, overSold)
cu = crossunder(vrsi, overBought)
%}
function out = ScalpSSLema(H,L,C)
price = C;
Fast = 50;
Slow = 100;
Turtle = 200;
aF = 2/(Fast+1);
aS = 2/(Slow+1);
aT = 2/(Turtle+1);
period = 10;
len = 10;
persistent Xssl
if isempty(Xssl)
    Xssl.emaFp = price;
    Xssl.emaSp = price;
    Xssl.emaTp = price;
    Xssl.Hwin = repmat(H,len,1);
    Xssl.Lwin = repmat(L,len,1);
    Xssl.H1vp = zeros(1,length(H));
end
Xssl.Hwin = [H;Xssl.Hwin(1:end-1,:)];
Xssl.Lwin = [L;Xssl.Lwin(1:end-1,:)];
maFast = (1-aF)*Xssl.emaFp + aF*price;
maSlow = (1-aS)*Xssl.emaSp + aS*price;
maTurtle = (1-aT)*Xssl.emaTp + aT*price;
smaHigh = sum(Xssl.Hwin)/len;
smaLow = sum(Xssl.Lwin)/len;
tmpH1v = Xssl.H1vp;
k = find(C<smaLow);
tmpH1v(k) = -1;
H1v = tmpH1v;
k = find(C>smaHigh);
H1v(k) = 1;
sslDown = smaLow;
sslUp = smaHigh;
k = find(H1v < 0);
sslDown(k) = smaHigh(k);
sslUp(k) = smaLow(k);
% updates
Xssl.emaFp = maFast;
Xssl.emaSp = maSlow;
Xssl.emaTp = maTurtle;
Xssl.H1vp = H1v;
out(1,:) = maFast;
out(2,:) = maSlow;
out(3,:) = maTurtle;
out(4,:) = smaHigh;
out(5,:) = smaLow;
out(6,:) = sslDown;
out(7,:) = sslUp;
end
%{
study(shorttitle="mForex - BB - Pinbar", title="mForex - Bollinger Bands - Pinbar scalping system", overlay=true)
length = input(20, minval=1, title="BB Length")
mult = input(2.0, minval=0.001, maxval=50, title="BB StdDev")
lengthRSI = input(9, minval=1, title="RSI Length")
pinbardown = input(75, minval=1, maxval=99, title="Bearish pinbar when RSI >= ")
pinbarup = input(25, minval=1, maxval=99, title="Bullish pinbar when RSI <= ")

basis = sma(close, length)
dev = mult * stdev(close, length)
upper = basis + dev
lower = basis - dev
plot(basis, "Basis", color=#872323, offset = 0)
p1 = plot(upper, "Upper", color=color.teal, offset = 0)
p2 = plot(lower, "Lower", color=color.teal, offset = 0)
fill(p1, p2, title = "Background", color=#198787, transp=95)

rsi = rsi(close, lengthRSI)
body = abs(close-open)
upshadow = open>close?(high-open):(high-close)
downshadow = open>close?(close-low):(open-low)
pinbar_h = close[1]>open[1] and rsi > pinbardown ?(body[1]>body?(upshadow>0.8*body?(upshadow>2*downshadow?1:0):0):0):0
pinbar_l = open[1]>close[1] and rsi < pinbarup ?(body[1]>body?(downshadow>0.8*body?(downshadow>2*upshadow?1:0):0):0):0
%}
function out = ScalpBollB(O,H,L,C)
Length = 20;
mult = 2.0;
lengthRSI = 9;
pinbardown = 75;
pinbarup = 25;
persistent XSboll
if isempty(XSboll)
    XSboll.Cwin = repmat(C,Length,1);
    XSboll.rsiwin = repmat(C,lengthRSI,1);
    XSboll.avgUp = zeros(1,length(C));
    XSboll.avgDp = zeros(1,length(C));
    XSboll.bodyp = abs(C-O);
    XSboll.Cp = C;
    XSboll.Op = O;
end
XSboll.Cwin = [C;XSboll.Cwin(1:end-1,:)];
XSboll.rsiwin = [C-XSboll.Cp;XSboll.rsiwin(1:end-1,:)];
basis = sum(XSboll.Cwin)/Length;
dev = mult * std(XSboll.Cwin);
upper = basis + dev;
lower = basis - dev;
alph = 1/lengthRSI;
tmpU = XSboll.rsiwin;
tmpU(tmpU<0)=0;
tmpD = XSboll.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*XSboll.avgUp + alph*avgU;
emaavgD = (1-alph)*XSboll.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
rsi = 100*(1 - 1./(1+RS));
body = abs(C-O);
upshadow = H-C;
k = find(O>C);
upshadow(k) = H(k)-O(k);
downshadow = O-L;
downshadow(k) = C(k)-L(k);
tmpH1 = zeros(1,length(O));
tmpL1 = zeros(1,length(O));
k = find(upshadow>2*downshadow);
tmpH1(k) = 1;
k = find(downshadow>2*upshadow);
tmpL1(k) = 1;
tmpH2 = zeros(1,length(O));
tmpL2 = zeros(1,length(O));
k = find(upshadow>0.8*body);
tmpH2(k) = tmpH1(k);
k = find(downshadow>0.8*body);
tmpL2(k) = tmpL1(k);
tmpH3 = zeros(1,length(O));
tmpL3 = zeros(1,length(O));
k = find(XSboll.bodyp>body);
tmpH3(k) = tmpH2(k);
tmpL3(k) = tmpL2(k);
pinbar_h = zeros(1,length(O));
pinbar_l = zeros(1,length(O));
k = find((XSboll.Cp>XSboll.Op)&(rsi>pinbardown));
pinbar_h(k) = tmpH3(k);
k = find((XSboll.Op>XSboll.Cp)&(rsi<pinbarup));
pinbar_l(k) = tmpL3(k);
% updates
XSboll.bodyp = body;
XSboll.Cp = C;
XSboll.Op = O;
out(1,:) = basis;
out(2,:) = upper;
out(3,:) = lower;
out(4,:) = rsi;
out(5,:) = upshadow;
out(6,:) = downshadow;
out(7,:) = pinbar_h;
out(8,:) = pinbar_l;
end
%{
https://www.tradingview.com/script/Q8NTThaR-Sniper-Scalper/
//-----Support and Resistance
supportSource = input(title="Suppport & Resistance source", type=input.source, defval=low)
resistanceSource = input(title="Suppport & Resistance source", type=input.source, defval=high)resistance = 21
resistanceTop = valuewhen(high >= highest(high, resistance), resistanceSource, 0)
stopZoneTop1 = atr(14) + resistanceTop
stopZoneTop2 = 2 * atr(14) + resistanceTop

resistanceBottom = valuewhen(low <= lowest(resistance), supportSource, 0)
stopZoneBottom1 = resistanceBottom - atr(14)
stopZoneBottom2 = resistanceBottom -  2 * atr(14)

resTop = plot(resistanceTop, color=resistanceTop != resistanceTop[1] ? na : color.red, linewidth=1, offset=0, transp=100)
stopT1 = plot(stopZoneTop1, color=resistanceTop != resistanceTop[1] ? na : color.red, linewidth=1, offset=0)
stopT2 = plot(stopZoneTop2, color=resistanceTop != resistanceTop[1] ? na : color.red, linewidth=1, offset=0)
fill(resTop, stopT1, color=color.red, transp=85)
fill(stopT1, stopT2, color=color.red, transp=80)

resBottom = plot(resistanceBottom, color=resistanceBottom != resistanceBottom[1] ? na : color.green, linewidth=1, offset=0, transp=100)
stopB1 = plot(stopZoneBottom1, color=resistanceBottom != resistanceBottom[1] ? na : color.green, linewidth=1, offset=0)
stopB2 = plot(stopZoneBottom2, color=resistanceBottom != resistanceBottom[1] ? na : color.green, linewidth=1, offset=0)
fill(resBottom, stopB1, color=color.green, transp=85)
fill(stopB1, stopB2, color=color.green, transp=80)

tema (src, len) => 
    ema1 = ema(src, len)
    ema2 = ema(ema1, len)
    ema3 = ema(ema2, len)
    (3*ema1)-(3*ema2) + ema3
    

// SWITCH MA Type
trendMaType = input(title="Trend MA type", options=["sma", "tema", "ema", "hma", "wma"], defval="ema")
trendMaSource = input(title="Trend MA source", type=input.source, defval=close)
trendMaLength = input(title="Trend MA length", defval=55)

entryMaLength = input(title="Entry MA length", defval=21)
entryMaSource = input(title="Entry MA source", type=input.source, defval=close)
entryMaType = input(title="Entry MA type", options=["sma", "tema", "ema", "hma", "wma"], defval="ema")

getMovingAverage(type, src, len) =>
      type == "sma"  ? sma(src, len) :
      type == "tema" ? tema(src, len) :
      type == "ema" ? ema(src, len) :
      type == "hma" ? hma(src, len) :
      type == "wma" ? wma(src, len) :
      na

    
trendMovingAverage = getMovingAverage(trendMaType, trendMaSource, trendMaLength)
plot(trendMovingAverage, color=color.orange)
entryMovingAverage = getMovingAverage(entryMaType, entryMaSource, entryMaLength)
plot(entryMovingAverage, color=color.blue)

maStop1 = plot(entryMovingAverage + atr(14), color=resistanceTop != resistanceTop[1] ? na : color.red, linewidth=1, offset=0, transp=100)
maStop2 = plot(entryMovingAverage - atr(14), color=resistanceTop != resistanceTop[1] ? na : color.red, linewidth=1, offset=0, transp=100)
fill(maStop1, maStop2, color=color.orange, transp=90)
%}
function out = ScalpSniper(H,L,C)
resistance = 21;
resistanceSource = H;
supportSource = L;
atrlen = 14;
entryMaLength = 21;
trendMaLength = 55;
ae = 2/(entryMaLength+1);
at = 2/(trendMaLength+1);
persistent Xsnip
if isempty(Xsnip)
    Xsnip.clwin = repmat(C,atrlen,1);
    Xsnip.hiwin = repmat(H,resistance,1);
    Xsnip.lowin = repmat(L,resistance,1);
    Xsnip.ema1entp = C;
    Xsnip.ema2entp = C;
    Xsnip.ema3entp = C;
    Xsnip.ema1trp = C;
    Xsnip.ema2trp = C;
    Xsnip.ema3trp = C;
end
Xsnip.clwin = [C;Xsnip.clwin(1:end-1,:)];
Xsnip.hiwin = [H;Xsnip.hiwin(1:end-1,:)];
Xsnip.lowin = [L;Xsnip.lowin(1:end-1,:)];
highest = max(Xsnip.hiwin);
k = find(H>=highest);
resistanceTop = resistanceSource;
resistanceTop(k) = H(k);
atr = max(H-L,max(H-Xsnip.clwin(2,:),...
    abs(L-Xsnip.clwin(2,:))));
stopZoneTop1 = resistanceTop + atr;
stopZoneTop2 = resistanceTop + 2*atr;
lowest = min(Xsnip.lowin);
k = find(L<=lowest);
resistanceBottom = supportSource;
resistanceBottom(k) = L(k);
atr = max(H-L,max(H-Xsnip.clwin(2,:),...
    abs(L-Xsnip.clwin(2,:))));
stopZoneBottom1 = resistanceBottom - atr;
stopZoneBottom2 = resistanceBottom - 2*atr;
ema1e = (1-ae)*Xsnip.ema1entp + ae*C;
ema2e = (1-ae)*Xsnip.ema2entp + ae*ema1e;
ema3e = (1-ae)*Xsnip.ema3entp + ae*ema2e;
entryMovingAverage = 3*(ema1e - ema2e) + ema3e;
ema1t = (1-at)*Xsnip.ema1trp + at*C;
ema2t = (1-at)*Xsnip.ema2trp + at*ema1t;
ema3t = (1-at)*Xsnip.ema3trp + at*ema2t;
trendMovingAverage = 3*(ema1t - ema2t) + ema3t;
maStop1 = entryMovingAverage + atr;
maStop2 = entryMovingAverage - atr;
% updates
Xsnip.ema1entp = ema1e;
Xsnip.ema2entp = ema2e;
Xsnip.ema3entp = ema3e;
Xsnip.ema1trp = ema1t;
Xsnip.ema2trp = ema2t;
Xsnip.ema3trp = ema3t;
out(1,:) = entryMovingAverage;
out(2,:) = trendMovingAverage;
out(3,:) = maStop1;
out(4,:) = maStop2;
out(5,:) = resistanceTop;
out(6,:) = stopZoneTop1;
out(7,:) = stopZoneTop2;
out(8,:) = resistanceBottom;
out(9,:) = stopZoneBottom1;
out(10,:) = stopZoneBottom2;
end
% startedScalp3EMA but decided it is out of scope
%{
https://www.tradingview.com/script/bOSjibk0-Three-EMA-Scalp-Signals-by-kmderham/
// It looks for a set up condition where 5 consecutive candles have broken away
// from the fast EMA (set to 8 by default) followed by a "trigger" candle that crosses
// back over the fast EMA but not the medium EMA (set to 13 by default). It then determines
// The entry point based on the bar high or low (not tail or wick) depending on direction
// of the trend. Once the entry point is crossed, we can enter the position. Win or loss
// is determined whether the lower or upper levels are crossed (as per trend). After the 
// position is won or lost and if the entry level  is re-crossed before a new set up 
// condition is found then a new entry signal is given.
//
// Please note that this should really be used in conjunction with a higher timeframe
// "Anchor" chart with a fast and a slow EMA so setups and positions should should
// correspond to the trend of the higher timeframe chart. This was designed for a 5 minute 
// timeframe and a 60 minute anchor chart.
//


// I recommend making the bars/wicks 50% transparent (can't code this in Pine Script)
// to enable the trigger candles to stand out

//@version=4
study(title="Three EMA Scalp Signals", shorttitle="Three_EMA_Scalp_kmderham", overlay=true)

// user parameters
slow = input(21, minval=1, title="Slow EMA")
med = input(13, minval=1, title="Medium EMA")
fast = input(8, minval=1, title="Fast EMA")
atrPeriods = input(6, minval=1, title="ATR Periods for risk")
stopSize = input(4, minval=1, title="Stop size (ATR Multiplier)", type=input.float)
limitSize = input(4, minval=1, title="Limit size (ATR Multiplier)", type= input.float)
//anchorResolution = input(title="Resolution", type=input.resolution, defval="60") // this is for a future version

// set up "global" variables
inLongSetUp = false
inShortSetUp = false
inLongPosition = false
inShortPosition = false
float lowerLevel = na
float upperLevel = na
float entryLevel = na

// carry over values from the previous candle
inLongSetUp := inLongSetUp[1]
inShortSetUp := inShortSetUp[1]
inLongPosition := inLongPosition[1]
inShortPosition := inShortPosition[1]
lowerLevel := lowerLevel[1]
upperLevel := upperLevel[1]
entryLevel := entryLevel[1]

// determine what type of candle we have
bullish = close > open
bearish = close < open

// set up the EMAs
emaSlow = ema(close, slow)
emaMedium = ema(close, med)
emaFast = ema(close, fast)
//emaAnchorFast = ema(close, fast*4)  //ema(security(syminfo.tickerid, anchorResolution, close), fast) // these are for a future version
//emaAnchorSlow = ema(close, slow*2)  //ema(security(syminfo.tickerid, anchorResolution, close), slow)

// determine trend direction using the EMAs
downtrend = emaSlow > emaMedium and emaMedium > emaFast
uptrend = emaSlow < emaMedium and emaMedium < emaFast

// break candles break away from the fast EMA in the direction of the trend
bullishBreakCandle = uptrend and low > emaFast
bearishBreakCandle = downtrend and high < emaFast

// we want to see 5 consecutive break candles
bullishBreak = bullishBreakCandle[5] and bullishBreakCandle[4] and bullishBreakCandle[3] and bullishBreakCandle[2] and bullishBreakCandle[1]
bearishBreak = bearishBreakCandle[5] and bearishBreakCandle[4] and bearishBreakCandle[3] and bearishBreakCandle[2] and bearishBreakCandle[1]

// determine our trigger candle
bullishTriggerCandle = uptrend and low <= emaFast and low >= emaMedium
bearishTriggerCandle = downtrend and high >= emaFast and high <= emaMedium

// set up
longSetUp = bullishBreak and bullishTriggerCandle and not (inLongPosition or inShortPosition)
shortSetUp = bearishBreak and bearishTriggerCandle and not (inShortPosition or inLongPosition)

inLongSetUp := longSetUp ? true : inLongSetUp[1]
inShortSetUp := shortSetUp ? true : inShortSetUp[1]

// some variable to hold values for comparison
float a = na
float b = na
float c = na
float d = na
float e = na
float comp1 = na
float comp2 = na
float comp3 = na

risk = atr(atrPeriods)
    
// if we're uptrending we need the higher bar value for the previous 5 candles
if longSetUp // we take close if bullish candle othewisd open of a bearish
    a := bullish[1] ? close[1] : open[1] 
    b := bullish[2] ? close[2] : open[2]
    c := bullish[3] ? close[3] : open[3]
    d := bullish[4] ? close[4] : open[4]
    e := bullish[5] ? close[5] : open[5]
    // compare pairs of values and take ther higher of each
    comp1 := a > b ? a : b
    comp2 := c > d ? c : d
    // now compare the results of the last two comparisons and take the higher
    comp3 := comp1 > comp2 ? comp1 : comp2
    // compare what we have left with the final value we haven't yet compared
    entryLevel := comp3 > e ? comp3 : e
    upperLevel := entryLevel + (risk*limitSize)
    lowerLevel := entryLevel - (risk*stopSize)
    inShortSetUp := not inLongSetUp
    
// if we're downtrending we need the lower bar value for the previous 5 candles
if shortSetUp // we take close if bearish candle otherwise open of a bullish
    a := bearish[1] ? close[1] : open[1] 
    b := bearish[2] ? close[2] : open[2]
    c := bearish[3] ? close[3] : open[3]
    d := bearish[4] ? close[4] : open[4]
    e := bearish[5] ? close[5] : open[5]
    // compare pairs of values and take the lower of each
    comp1 := a < b ? a : b
    comp2 := c < d ? c : d
    // now compare the results of the last two comparisons and take the lower
    comp3 := comp1 < comp2 ? comp1 : comp2
    // compare what we have left with the final value we haven't yet compared
    entryLevel := comp3 < e ? comp3 : e
    upperLevel := entryLevel + (risk*stopSize)
    lowerLevel := entryLevel - (risk*limitSize)
    inLongSetUp := not inShortSetUp

// i feeel these lines warrant some explanation but I've messed around so much with the 
// position entry logic that this is just what seems to work. Will cewan up / explain 
// better when I have some time. In short we need to be in a set up condition (but not the
// actual trigger candle becasue we want that to complete before opening a new position). At 
// some point the candle needs to cross over the entry level to say that we're in. That'll do Donkey.
openLong = inLongSetUp and not longSetUp and low < entryLevel and high >= entryLevel and not inLongPosition
openShort = inShortSetUp and not shortSetUp and high > entryLevel and low <= entryLevel and not inShortPosition 

inLongPosition := openLong ? true : inLongPosition[1]
inShortPosition := openShort ? true : inShortPosition[1]

bool winLong = false
bool winShort = false
bool loseLong = false
bool loseShort = false

if inLongPosition
    winLong := high >= upperLevel
    loseLong := low <= lowerLevel

if inShortPosition
    winShort := low <= lowerLevel
    loseShort := high >= upperLevel

if winLong or loseLong  
    inLongPosition := false
    //inLongSetUp := false

if winShort or loseShort
    inShortPosition := false
    //inLongSetUp := false

// reset setup if we're not in a position and the trend switches
//if downtrend and not downtrend[1] and not (inLongPosition or inShortPosition)
//    inLongSetUp := false
//if uptrend and not uptrend[1] and not (inLongPosition or inShortPosition)
//    inShortSetUp := false

// Colour trigger bars
barColour = (longSetUp or shortSetUp) and bullish ? color.blue : (longSetUp or shortSetUp) and bearish ? color.fuchsia :  na
barcolor(color=barColour)
plot(emaSlow, title="Slow EMA", color=color.orange)
plot(emaMedium, title="Medium EMA", color=color.blue)
plot(emaFast, title="Fast EMA", color=color.red)
//plot(emaAnchorSlow, title="Anchor Slow EMA", color=color.yellow, linewidth=2)
//plot(emaAnchorFast, title="Anchor Fast EMA", color=color.fuchsia, linewidth=2)
plot(entryLevel, title="Entry Point", color=color.white, linewidth=1, transp=60)
plot(upperLevel, title="Upper Line", color=color.green, linewidth=1, transp=0)
plot(lowerLevel, title="Lower Line", color=color.red, linewidth=1, transp=0)
%}
function out = Scalp3EMA(O,H,L,C)
slow = 21;
med = 13;
fast = 8;
atrPeriods = 6;
stopSize = 4;
limitSize = 4;
aS = 2/(slow+1);
aM = 2/(med+1);
aF = 2/(fast+1);
persistent X3ema
if isempty(X3ema)
    X3ema.inLongSetUpp = zeros(1,length(O));
    X3ema.inShortSetUpp = zeros(1,length(O));
    X3ema.inLongPositionp = zeros(1,length(O));
    X3ema.inShortPositionp = zeros(1,length(O));
    X3ema.lowerLevelp = zeros(1,length(O));
    X3ema.upperLevelp = zeros(1,length(O));
    X3ema.entryLevelp = zeros(1,length(O));
    X3ema.emaSp = C;
    X3ema.emaMp = C;
    X3ema.emaFp = C;
    X3ema.bullishBreakCandlep = repmat(zeros(1,length(O)),5,1);
    X3ema.bearishBreakCandlep = repmat(zeros(1,length(O)),5,1);
    X3ema.clwin = repmat(C,5,1);
    X3ema.opwin = repmat(O,5,1);
    X3ema.bullwin = repmat(zeros(1,length(O)),5,1);
    X3ema.bearwin = repmat(zeros(1,length(O)),5,1);
end
X3ema.clwin = [C;X3ema.clwin(1:end-1,:)];
X3ema.opwin = [O;X3ema.opwin(1:end-1,:)];
inLongSetUp = X3ema.inLongSetUpp;
inShortSetUp = X3ema.inShortSetUpp;
inLongPosition = X3ema.inLongPositionp;
inShortPosition = X3ema.inShortPositionp;
lowerLevel = X3ema.lowerLevelp;
upperLevel = X3ema.upperLevelp;
entryLevel = X3ema.entryLevelp;
bullish = C>O;
bearish = C<O;
X3ema.bullwin = [bullish;X3ema.bullwin(1:end-1,:)];
X3ema.bearwin = [bearish;X3ema.bearwin(1:end-1,:)];
emaSlow = (1-aS)*X3ema.emaSp + aS*C;
emaMedium = (1-aM)*X3ema.emaMp + aM*C;
emaFast = (1-aF)*X3ema.emaFp + aF*C;
downtrend = (emaSlow > emaMedium) & (emaMedium > emaFast);
uptrend = (emaSlow < emaMedium) & (emaMedium < emaFast);
bullishBreakCandle = uptrend & (L > emaFast);
bearishBreakCandle = downtrend & (H < emaFast);
bullishBreak = X3ema.bullishBreakCandlep(1,:) & ...
    X3ema.bullishBreakCandlep(2,:) & ...
    X3ema.bullishBreakCandlep(3,:) & ...
    X3ema.bullishBreakCandlep(4,:) & ...
    X3ema.bullishBreakCandlep(5,:);
bearishBreak = X3ema.bearishBreakCandlep(1,:) & ...
    X3ema.bearishBreakCandlep(2,:) & ...
    X3ema.bearishBreakCandlep(3,:) & ...
    X3ema.bearishBreakCandlep(4,:) & ...
    X3ema.bearishBreakCandlep(5,:);
X3ema.bullishBreakCandlep = [bullishBreakCandle;X3ema.bullishBreakCandlep(1:end-1,:)];
X3ema.bearishBreakCandlep = [bearishBreakCandle;X3ema.bearishBreakCandlep(1:end-1,:)];
bullishTriggerCandle = uptrend & (L <= emaFast) & ...
    (L >= emaMedium);
bearishTriggerCandle = downtrend & (H >= emaFast) & ...
    (H <= emaMedium);
longSetUp = bullishBreak & bullishTriggerCandle & ...
    ~(inLongPosition | inShortPosition);
shortSetUp = bearishBreak & bearishTriggerCandle & ...
    ~(inShortPosition | inLongPosition);
inLongSetUp = ones(1,length(O));
inShortSetUp = ones(1,length(O));
k = find(~longSetUp);
inLongSetUp(k) = X3ema.inLongSetUpp(k);
k = find(~shortSetUp);
inShortSetUp(k) = X3ema.inShortSetUpp(k);
% atr = average true range
risk = max(H-L,max(H-X3ema.clwin(2,:),...
    abs(L-X3ema.clwin(2,:))));
a = X3ema.opwin(1,:);
b = X3ema.opwin(2,:);
c = X3ema.opwin(3,:);
d = X3ema.opwin(4,:);
e = X3ema.opwin(5,:);
klong = find(longSetUp);
k = X3ema.bullwin(1,klong)==1;
a(klong(k)) = X3ema.clwin(1,klong(k));
k = X3ema.bullwin(2,klong)==1;
b(klong(k)) = X3ema.clwin(2,klong(k));
k = X3ema.bullwin(3,klong)==1;
c(klong(k)) = X3ema.clwin(3,klong(k));
k = X3ema.bullwin(4,klong)==1;
d(klong(k)) = X3ema.clwin(4,klong(k));
k = X3ema.bullwin(5,klong)==1;
e(klong(k)) = X3ema.clwin(5,klong(k));
kshort = find(shortSetUp);
k = X3ema.bearwin(1,kshort)==1;
a(kshort(k)) = X3ema.clwin(1,kshort(k));
k = X3ema.bearwin(2,kshort)==1;
b(kshort(k)) = X3ema.clwin(2,kshort(k));
k = X3ema.bearwin(3,kshort)==1;
c(kshort(k)) = X3ema.clwin(3,kshort(k));
k = X3ema.bearwin(4,kshort)==1;
d(kshort(k)) = X3ema.clwin(4,kshort(k));
k = X3ema.bearwin(5,kshort)==1;
e(kshort(k)) = X3ema.clwin(5,kshort(k));

% inLongSetUp = longSetUp ? true : inLongSetUp[1];
% inShortSetUp = shortSetUp ? true : inShortSetUp[1];
% updates
X3ema.inLongSetUpp = inLongSetUp;
X3ema.inShortSetUpp = inShortSetUp;
X3ema.inLongPositionp = inLongPosition;
X3ema.inShortPositionp = inShortPosition;
X3ema.lowerLevelp = lowerLevel;
X3ema.upperLevelp = upperLevel;
X3ema.entryLevelp = entryLevel;
X3ema.emaSp = emaSlow;
X3ema.emaMp = emaMedium;
X3ema.emaFp = emaFast;
out(1,:) = emaSlow;
out(2,:) = emaMedium;
out(3,:) = emaFast;
end
%{
study(title="mForex - Keltner channel + EMA Scalping system", shorttitle="mForex - Keltner - EMA", overlay=true)
length = input(42, minval=1, title="Length Keltner")
emaFirst = input(10, minval=1, title="EMA First")
emaSecond = input(110, minval=1, title="EMA Second")

esma(source, length)=>
	s = sma(source, length)
	e = ema(source, length)
	e
	
ma = esma(close, length)
rangema = rma(tr(true), length)
upper = ma + rangema * 1.0
lower = ma - rangema * 1.0
c = color.blue
u = plot(upper, color=#0094FF, title="Upper")
plot(ma, color=#0094FF, title="Basis")
l = plot(lower, color=#0094FF, title="Lower")
fill(u, l, color=#0094FF, transp=95, title="Background")

outEmaFirst = ema(close, emaFirst)
plot(outEmaFirst, color=color.green, title="EMA First", linewidth=2)
outEmaSecond = ema(close, emaSecond)
%}
function out = ScalpKelt(H,L,C)
Length = 42;
emaFirst = 10;
emaSecond = 110;
aL = 2/(Length+1);
a1 = 2/(emaFirst+1);
a2 = 2/(emaSecond+1);
arma = 1/Length;
persistent XScKel
if isempty(XScKel)
    XScKel.emap = C;
    XScKel.ema1p = C;
    XScKel.ema2p = C;
    XScKel.rangep = zeros(1,length(C));
    XScKel.Cp = C;
end
ma = (1-aL)*XScKel.emap + aL*C;
rangema = (1-arma)*XScKel.rangep + ...
    arma*(max(H-L,max(H-XScKel.Cp,abs(L-XScKel.Cp))));
upper = ma + rangema*1.0;
lower = ma - rangema*1.0;
outEmaFirst = (1-a1)*XScKel.ema1p + a1*C;
outEmaSecond = (1-a2)*XScKel.ema2p + a2*C;
% updates
XScKel.emap = ma;
XScKel.rangep = rangema;
XScKel.ema1p = outEmaFirst;
XScKel.ema2p = outEmaSecond;
XScKel.Cp = C;
out(1,:) = ma;
out(2,:) = upper;
out(3,:) = lower;
out(4,:) = outEmaFirst;
out(5,:) = outEmaSecond;
end
%{
study(title="CRUDE OIL BUY/SELL",shorttitle="CRUDE Scalp |3 Min",precision=2,overlay=true)
https://www.tradingview.com/script/BqkzYNrk-Intraday-BUY-SELL/
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
function out = ScalpIntra(C)
sma_value = 50;
Rsi_value = 14;
h1 = 75;
l1 = 25;
dist_SMA=1;
candle_length=1;
persistent XscInt
if isempty(XscInt)
    XscInt.Cwin = repmat(C,sma_value,1);
    XscInt.rsiwin = repmat(zeros(1,length(C)),Rsi_value,1);
    XscInt.Cp = C;
    XscInt.avgUp = zeros(1,length(C));
    XscInt.avgDp = zeros(1,length(C));
end
XscInt.Cwin = [C;XscInt.Cwin(1:end-1,:)];
XscInt.rsiwin = [C-XscInt.Cp;XscInt.rsiwin(1:end-1,:)];
sma1 = sum(XscInt.Cwin)/sma_value;

alph = 1/Rsi_value;
tmpU = XscInt.rsiwin;
tmpU(tmpU<0)=0;
tmpD = XscInt.rsiwin;
tmpD(tmpD>0)=0;
avgU = sum(tmpU);
avgD = sum(abs(tmpD));
emaavgU = (1-alph)*XscInt.avgUp + alph*avgU;
emaavgD = (1-alph)*XscInt.avgDp + alph*avgD;
tmp = emaavgD;
tmp(tmp==0) = 1;
RS = emaavgU./tmp;
rsi = 100*(1 - 1./(1+RS));
% updates
XscInt.avgUp = emaavgU;
XscInt.avgDp = emaavgD;
XscInt.Cp = C;
out(1,:) = sma1;
out(2,:) = rsi;
end
