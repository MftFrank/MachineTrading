% Estimate parameters of an AR(1) model using Econometrics toolbox's estimate function 
clear;
%tested 2023.11.15
% load('inputData_btcchina_secbars', 'ttime', 'cl');
load('Jonathan_BTCUSD_trades_daily', 'tday', 'cl'); % daily bars

model_ar1=arima(1, 0, 0) % assumes an AR(1) with unknown parameters

% model_ar1 = 
% 
%     ARIMA(1,0,0) Model:
%     --------------------
%     Distribution: Name = 'Gaussian'
%                P: 1
%                D: 0
%                Q: 0
%         Constant: NaN
%               AR: {NaN} at Lags [1]
%              SAR: {}
%               MA: {}
%              SMA: {}
%         Variance: NaN

model_ar1_estimates=estimate(model_ar1, cl)

%     ARIMA(1,0,0) Model:
%     --------------------
%     Conditional Probability Distribution: Gaussian
% 
%                                   Standard          t     
%      Parameter       Value          Error       Statistic 
%     -----------   -----------   ------------   -----------
%      Constant         3.4365       4.63118       0.742037
%         AR{1}       0.989484    0.00845394        117.044
%      Variance        405.023       15.2071        26.6337