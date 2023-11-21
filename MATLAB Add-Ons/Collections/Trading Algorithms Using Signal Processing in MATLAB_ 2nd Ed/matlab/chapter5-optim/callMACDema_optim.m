% callMACDema_optim.m
clc,clear all,close all,dbstop if error
dbstop('if', 'error', 'MATLAB:badsubscript')
clear obv_adx

vars = whos;
vars = vars([vars.persistent]);
varName = {vars.name};
clear(varName{:});

load stkfiles.mat
[nr,nc] = size(hi);
rowvec = (0:nr-1)/nr;
emaPeriod1 = 7;
emaPeriod2 = 25;
emaPeriod3 = 20;
emaPeriodSig = 20;

Len = 4;
cost = 0.008;
maxnum = 10;
minprof = 0.08;
lenw = 4; % length of array
lenw1 = 2; % length of array
% make arrays
emaPeriod1_A = emaPeriod1-lenw/2:1:emaPeriod1+lenw/2;
emaPeriod2_A = emaPeriod2-lenw/1:2:emaPeriod2+lenw/1;
emaPeriod3_A = emaPeriod3-lenw/2:1:emaPeriod3+lenw/2;
emaPeriodSig_A = emaPeriodSig-lenw/2:1:emaPeriodSig+lenw/2;
% ast3_A = ast3-lenw/2:1:ast3+lenw/2;
% armo_A = armo-lenw1:armo+lenw1;
Len_A = Len-lenw1:Len+lenw1;
len = length(emaPeriod1_A);
out = [];bnd = [];rsi = [];
Profitsma = zeros(size(cl(1,:)));
Profitmacd = zeros(size(cl(1,:)));
for i  = 1:len
    for j  = 1:len
        for m  = 1:len
            for n = 1:nr
                C = cl(n,:);L = lo(n,:);H = hi(n,:);
                temp = ema3_optim(n,H,L,emaPeriod1_A(i),emaPeriod2_A(j),emaPeriod3,emaPeriodSig_A(m));
                ema1(n,:,i,j,m) = temp(1,:);
                ema2(n,:,i,j,m) = temp(2,:);
                ema3(n,:,i,j,m) = temp(3,:);
                emasig(n,:,i,j,m) = temp(4,:);
                Buy(n,:,i,j,m) = temp(5,:);
                Sell(n,:,i,j,m) = temp(6,:);
                if n==1,numTrades(n,:,i,j,m) = zeros(size(temp(5,:)));end
                if n>1
                    numTrades(n,:,i,j,m) = abs(Buy(n,:,i,j,m)-Buy(n-1,:,i,j,m)) + ...
                        abs(Sell(n,:,i,j,m)-Sell(n-1,:,i,j,m));
                end
                Ptemp = clv(n,:).*Buy(n,:,i,j,m);
                Profit(n,:,i,j,m) = Ptemp - clv(n,:).*Sell(n,:,i,j,m);
                if n==1,CumProfit(n,:,i,j,m) = Profit(n,:,i,j,m);end
                if n>1
                    CumProfit(n,:,i,j,m) = Profit(n,:,i,j,m) + ...
                        CumProfit(n-1,:,i,j,m);
                    tempnum = numTrades(n,:,i,j,m);
                    numTrades(n,:,i,j,m) = tempnum;
                    CumProfit(n,:,i,j,m) = -cost*numTrades(n,:,i,j,m) + ...
                        CumProfit(n,:,i,j,m);
                end
            end
            EndProfit(:,i,j,m) = CumProfit(end,:,i,j,m);
            IdealCumProfit(:,:,i,j,m) = EndProfit(:,i,j,m)'.*rowvec(:);
            ProfitStdev(:,i,j,m) = std(IdealCumProfit(:,:,i,j,m)-CumProfit(:,:,i,j,m));
            [MaxEndProfit(:,i,j,m),Imax(:,i,j,m)] = maxk(EndProfit(:,i,j,m),maxnum);
            Ige10{:,i,j,m} = find(EndProfit(:,i,j,m)>minprof);
            EndProfitGE10{:,i,j,m} = EndProfit(Ige10{:,i,j,m},i,j,m);
            PortfolioProfit(i,j,m) = sum(CumProfit(end,:,i,j,m));
            PortfolioProfitMaxnum(i,j,m) = sum(MaxEndProfit(:,i,j,m));
            PortfolioProfitGE10(i,j,m) = sum(EndProfitGE10{:,i,j,m});
            ChangeInProfit(:,:,i,j,m) = diff(CumProfit(:,:,i,j,m),1,1);
            BuyDiff(:,:,i,j,m) = diff(Buy(:,:,i,j,m),1,1);
            SellDiff(:,:,i,j,m) = diff(Sell(:,:,i,j,m),1,1);
            %%{
            for ii = 1:nc
                f = find(diff([false,Buy(:,ii,i,j,m)'==1,false])~=0)';
                ftemp = f(2:2:end)-f(1:2:end-1);
                BuyGroupSequences{:,ii,i,j,m} = ftemp;
                BuyMaxLength(ii,i,j,m) = max(ftemp);
                BuyAvgLength(ii,i,j,m) = mean(ftemp);
                f = find(diff([false,Sell(:,ii,i,j,m)'==1,false])~=0)';
                ftemp = f(2:2:end)-f(1:2:end-1);
                SellGroupSequences{:,ii,i,j,m} = ftemp;
                SellMaxLength(ii,i,j,m) = max(ftemp);
                SellAvgLength(ii,i,j,m) = mean(ftemp);
            end
            %%}
            % compute Sharpe ratio for each equity
            %dailyret=(cls(2:end)-cls(1:end-1))./cls(1:end-1); % Daily Returns
            %excessRet = dailyret - 0.04/252; % Excess daily returns assuming risk-free rate of 4% per annum and 252 trading days in a year
            %sharpeRatio = sqrt(252)*mean(excessRet)/std(excessRet); 
            dailyret = Profit(:,:,i,j,m)./cl;
            excessRet = dailyret - 0.04/252;
            sharpeRatio(:,i,j,m) = sqrt(252)*mean(excessRet)./std(excessRet);
        end
    end
end
% data plots
%%{
% Plot checks
XX = 1:nr;
for idx = Imax(:,i,j,m)'
    figure
    ax(1) = subplot(411);
    plot(ax(1),XX(:),cl(:,idx),'k',XX(:),ema1(:,idx,i,j,m),'--k',...
        XX(:),ema2(:,idx,i,j,m),'-.k'),grid on
        %XX(:),ema2(:,idx,i,j,m),'-.k',XX(:),ema3(:,idx,i,j,m),':k'),grid on
    title(['Rahul Mohinder Oscillator for stock ',stk{idx},' at 30 min June 2020',', Transaction cost = ',num2str(cost*100),'%'])
    legend('cl','ema1','ema2','Location','Best')
    %legend('cl','ema1','ema2','ema3','Location','Best')
    ylabel(stk{idx},'FontSize',12,'FontWeight','bold')
    ax(2) = subplot(412);
    plot(ax(2),emasig(:,idx),'k'),grid on
    legend('signal','Location','Best')
    ylabel('indicator','FontSize',8,'FontWeight','bold')
    ax(3) = subplot(413);
    plot(ax(3),XX(:),Buy(:,idx,i,j,m),'k',XX(:),Sell(:,idx,i,j,m),':k'),grid on
    ylim([-.1,1.1])
    legend('Buy','Sell','Location','Best')
    ylabel('buy/sell signals','FontSize',8,'FontWeight','bold')
    ax(4) = subplot(414);
    plot(ax(4),XX(:),CumProfit(:,idx,i,j,m),'-k',XX(:),IdealCumProfit(:,idx,i,j,m),':k'),grid on
    legend('Profit','IdealProf','Location','Best')
    ylabel(['std from ideal',num2str(std(CumProfit(:,idx,i,j,m)-IdealCumProfit(:,idx,i,j,m)),'%.3f')],'FontSize',7,'FontWeight','bold')
    xlabel(['Period1, Period2, Period3, PeriodSig = ',num2str([emaPeriod1_A(i),emaPeriod2_A(j),emaPeriod3,emaPeriodSig_A(m)])],'FontWeight','bold')
    linkaxes(ax,'x')
end
%%}
%% The following attempts to show the portfolio profits according to varying 
%% parameters. The first set shows contour plots. 
for m = 1:len
labxsize = 12;
labysize = 12;
    figure
    [C,h] = contour(emaPeriod1_A,emaPeriod2_A,PortfolioProfit(:,:,m),8,'k');
    h.LevelList=round(h.LevelList,1);
    clabel(C,h,'fontsize', 8)
    title(['Profit Sums of Portfolio (',num2str(nc),' equities), ema3 = ',...
        num2str(emaPeriod3_A(m)),', Transaction cost = ',num2str(cost*100),'%'])
    xlabel('emaPeriod1','fontsize',labxsize,'FontWeight','bold')
    ylabel('emaPeriod2','fontsize',labysize,'FontWeight','bold')
    figure
    [C,h] = contour(emaPeriod1_A,emaPeriod2_A,PortfolioProfitMaxnum(:,:,m),8,'k');
    h.LevelList=round(h.LevelList,1);
    clabel(C,h,'fontsize', 8)
    title(['Profit Sums of top ',num2str(maxnum),' stocks, ema3 = ',...
        num2str(emaPeriod3_A(m)),', Transaction cost = ',num2str(cost*100),'%'])
    xlabel('emaPeriod1','fontsize',labxsize,'FontWeight','bold')
    ylabel('emaPeriod2','fontsize',labysize,'FontWeight','bold')
    figure
    [C,h] = contour(emaPeriod1_A,emaPeriod2_A,PortfolioProfitGE10(:,:,m),8,'k');
    h.LevelList=round(h.LevelList,1);
    clabel(C,h,'fontsize', 8)
    title(['Profit Sums of equities with profits > ',num2str(minprof),', ema3 = ',...
        num2str(emaPeriod3_A(m)),', Transaction cost = ',num2str(cost*100),'%'])
    xlabel('emaPeriod1','fontsize',labxsize,'FontWeight','bold')
    ylabel('emaPeriod2','fontsize',labysize,'FontWeight','bold')
end
%%
%%% The following set shows histograms of a portion of the parameters as they 
%%% vary and is based on an assumed transaction cost of 0.8%. 
for m = 1:floor(len/2)
    for i = 1:floor(len/2)
        for j = 1:floor(len/2)
            %% The following set shows histograms of a portion of the parameters as they
            %% vary and is based on an assumed transaction cost of 0.8%.
            figure
            h=histogram(EndProfit(:,i,j,m),15);
            x = h.BinEdges ;
            y = h.Values ;
            bar(x(1:end-1),y)
            xx = 1:length(y);
            title(['Portfolio (',num2str(nc),' stocks) Histogram of profits for (ema1, ema2, ema3) = ',...
                '(',num2str([emaPeriod1_A(i),emaPeriod2_A(j),emaPeriod3_A(m)]),')'])
            ylabel('No of equities in Portfolio','FontWeight','bold')
            xlabel('profit (%*100)','FontWeight','bold')
            for i1=1:numel(y)
                text(x(i1),y(i1),num2str(y(i1),'%d'),'FontSize',8,...
                    'HorizontalAlignment','center',...
                    'VerticalAlignment','bottom',...
                    'FontWeight','bold')
            end
            %ProfitStdev(:,i,j,m)
            box off 
            figure
            %%{
            Zaveb = BuyAvgLength(:,i,j,m);
            Zave = SellAvgLength(:,i,j,m);
            Zb = BuyMaxLength(:,i,j,m);
            Z = SellMaxLength(:,i,j,m);
            %%}
            Y = MaxEndProfit(:,i,j,m);
            X = 1:length(Y);
            bar(Y)
            title(['Top ',num2str(maxnum),' equities profits for (ema1, ema2, ema3) = ',...
                '(',num2str([emaPeriod1_A(i),emaPeriod2_A(j),emaPeriod3_A(m)]),')'])
            ylabel('profit (%*100)')
            xlabel(['Top ',num2str(maxnum),' equities in Portfolio'])
            for i1=1:numel(Y)
                text(X(i1),Y(i1),num2str(Y(i1),'%0.2f'),'FontSize',8,...
                    'HorizontalAlignment','center',...
                    'VerticalAlignment','bottom',...
                    'FontWeight','bold')
            end
            box off
            lab = stk(Imax(:,i,j,m));
            %fprintf(['Top',num2str(maxnum),'Equities Profit\n'])
            fprintf(['Top',num2str(maxnum),'Equities Profit MaxBuySequence   MaxSellSequence   AvgBuyLength   AvgSellLength\n'])
            for ix = 1:maxnum
               %fprintf('%5s%14.3f\n',lab{ix},Y(ix))
               XX = sprintf('%5s%14.3f%9d%18d%16.1f%16.1f',lab{ix},Y(ix),Zb(ix),Z(ix),Zaveb(ix),Zave(ix));
               disp(XX)
            end
        end
    end
end

