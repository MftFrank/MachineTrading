clear;

addpath('/usr/local/MATLAB/R2023b/toolbox/econ')
addpath('/home/statarb/DataAnalysis/Algorithmic_Trading_Chan')
load('/home/statarb/DataAnalysis/candle_data/scripts/ba_future_future.mat');

% 0 创建空的矩阵
outputMatrix = [];
% 1 hour data on CRV-CVX
for i = 434:23653
    try
        pairA = string(future_future{i, 1});
        pairB = string(future_future{i, 2});
        csvPathA = strcat('/home/statarb/DataAnalysis/candle_data/', pairA, '_FUTURE_1h.csv');
        csvPathB = strcat('/home/statarb/DataAnalysis/candle_data/', pairB, '_FUTURE_1h.csv');
        datay = readtable(csvPathA); datax = readtable(csvPathB);
        disp(pairA)
        disp(pairB)

        % 取交集
        common_timestamp = intersect(datax.timestamp, datay.timestamp);
        plength = length(common_timestamp);
        disp(pairA)
        
        y = datay.close(ismember(datay.timestamp, common_timestamp));
        x = datax.close(ismember(datax.timestamp, common_timestamp));
        
        zlog = abs(log(y)-log(x)); 
        
        % 对冲比例计算
        regression_result=ols(y, [x ones(size(x))]);
        hedgeRatio=regression_result.beta(1);
        
        % Assume a non-zero offset but no drift, with lag=1.
        cadfr=cadf(y, x, 0, 1); % cadf is a function in the jplv7 (spatial-econometrics.com) package. We pick y to be the dependent variable again.
        
        % 合并两个序列作约翰逊测试
        y2=[y, x];
        jsen=johansen(y2, 0, 1); % johansen test with non-zero offset but zero drift, and with the lag k=1.
        
        % ADF检验对数差分与比例
        adflog=adf(zlog, 0, 1); %adfratio=adf(zratio, 0, 1); 
        hurst=genhurst(log(zlog), 2);
        [h,pValue]=vratiotest(log(zlog));
        
        % 将特征向量乘以均值
        yport=jsen.evec(1,1) * mean(y(end-71:end));
        xport=jsen.evec(2,1) * mean(x(end-71:end));
         
        % 添加输出结果到矩阵中
        critStr = strcat(num2str(cadfr.crit(1)), ', ', num2str(cadfr.crit(2)), ', ', num2str(cadfr.crit(3)));
        adflogStr = strcat(num2str(adflog.crit(1)), ', ', num2str(adflog.crit(2)), ', ', num2str(adflog.crit(3)));
        
        jsenEig1=jsen.eig(1); jsenEig2=jsen.eig(2);
        jsenEvec11=jsen.evec(1);jsenEvec12=jsen.evec(2);jsenEvec21=jsen.evec(3);jsenEvec22=jsen.evec(4);
        jsenTS1=jsen.lr1(1);jsenTS2=jsen.lr1(2);jsenES1=jsen.lr2(1);jsenES2=jsen.lr2(2);
           
        %variableNames = {'pairA', 'pairB', 'plength', 'hedgeRatio', 'cadf.adf','cadf.alpha', 'cadf.nlag', ...
        % 'cadf.crit','jsenTS1','jsenTS2','jsenES1','jsenES2','jsenEig1','jsenEig2','jsenEvec11',...
        %'jsenEvec12','jsenEvec21','jsenEvec22','adf','adf_AR','adflogStr','hurst','h','pValue','yport','xport'};
        outputMatrix = [outputMatrix;[pairA, pairB,plength,hedgeRatio,cadfr.adf,cadfr.alpha,cadfr.nlag,critStr,...
            jsenTS1,jsenTS2,jsenES1,jsenES2,jsenEig1,jsenEig2,jsenEvec11,jsenEvec12,jsenEvec21,jsenEvec22...
            adflog.adf,adflog.alpha,adflogStr,hurst,h,pValue,yport,xport]];
    catch exception
        % 输出异常信息
        disp(['Exception occurred in iteration ', num2str(1i)]);
        disp(exception.message);
        
        % 继续执行下一个循环
        continue;
    end
end

% 创建表格变量
variableNames = {'pairA', 'pairB', 'plength', 'hedgeRatio', 'cadf.adf','cadf.alpha', 'cadf.nlag', ...
     'cadf.crit','jsenTS1','jsenTS2','jsenES1','jsenES2','jsenEig1','jsenEig2','jsenEvec11',...
    'jsenEvec12','jsenEvec21','jsenEvec22','adf','adf_AR','adflogStr','hurst','h','pValue','yport','xport'};
outputTable = array2table(outputMatrix, 'VariableNames', variableNames);

% 将表格写入CSV文件
csvPath = 'coint_FF_btceth.csv';  % 指定CSV文件的路径和名称
writetable(outputTable, csvPath, 'Delimiter', ',');

% 输出成功保存的消息
disp(['CSV文件已成功保存为: ', csvPath]);
