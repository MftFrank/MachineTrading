clear;
% Daily data on EWA-EWC
symbolA = 'ARBUSDT';
symbolB = 'RDNTUSDT';

invterval = [datetime(2023,10,1) datetime('now')];
PairA = pub.repFKlines(symbolA,'1h',invterval);
PairB = pub.repFKlines(symbolB,'1h',invterval);
tday = intersect(PairA(:, 1), PairB(:, 1));
PairA = PairA(ismember(PairA(:, 1), tday), :);
PairB = PairB(ismember(PairB(:, 1), tday), :);
trainset=1:325;


% Using Matlab ssm notation: 
% x(t)=A(t)*x(t-1) + B(t)*u(t), state transition equation
% y(t)=C(t)*x(t)+D(t)*e(t), measurement equation
% where u and e are zero mean and unit variance Gaussian noise.

y=PairA(:, 5); % EWC price is measurement (observation)

C=[PairB(:, 5) ones(size(PairB, 1), 1)]; % EWA prices augmented with constant offset as time-varying measurement 1x2 matrix.
%% 

A=eye(2); % State transition matrix
% B=num2cell(NaN(2, 2, size(cl, 1)), [1 2]); % state-disturbance-loading matrix. Cell array of 2x2 matrices, undetermined values.
B=NaN(2); % state-disturbance-loading matrix. Time invariant, undetermined values.
C=mat2cell(C, ones(size(PairB, 1), 1)); % Time-varying measurement matrix
% D=mat2cell(NaN(size(cl, 1), 1), ones(size(cl, 1), 1)); % measurement-innovation matrix, time varying variance. Cell array of 1x1 scalar, undetermined values.
D=NaN; % measurement-innovation matrix, time-invariant variance, undetermined values.

model=ssm(A, B, C(trainset, :), D);

rng('default'); % Fix random number generator seed to get repeatable results
rng(1);

param0=randn(5, 1); % 5 unknown parameters per bar.
model=estimate(model, y(trainset), param0);

B=model.B;
D=model.D;

model=ssm(A, B, C, D); % Now fully specified

[beta, logL, output]=filter(model, y);

plot(datetime(tday/1000, 'ConvertFrom', 'posixtime'), beta(:, 1));
title(['Kalman Filter Estimate of Slope between ' symbolA ' vs ' symbolB]);
xlabel('Date');
ylabel('Slope=x(t, 1)');

figure;

plot(datetime(tday/1000, 'ConvertFrom', 'posixtime'), beta(:, 2));
title(['Kalman Filter Estimate of Slope between ' symbolA ' vs ' symbolB]);

xlabel('Date');
ylabel('Offset=x(t, 2)');
figure;


% yhat=NaN(size(y));
% ymse=NaN(size(y));
% for t=2:length(tday)
%     [yhat(t), ymse(t)]=forecast(model, 1, y(1:t-1), 'C', C(t));
% end

yF=NaN(size(y));
ymse=NaN(size(y));
for t=1:length(output)
    yF(t, :)=output(t).ForecastedObs';
    ymse(t, :)=output(t).ForecastedObsCov';
end
e=y-yF; % forecast error

% plot(e(3:end), 'r');
plot(datetime(tday(3:end)/1000, 'ConvertFrom', 'posixtime'), e(3:end), 'r');
title('Measurement forecast error e(t) and standard deviation of e(t)');
xlabel('Date');
hold on;

ymse(1:5)=NaN; % Early error estimates are too high and they distort our plot
plot(datetime(tday/1000, 'ConvertFrom', 'posixtime'), sqrt(ymse));
% set(legend, 'Interpreter', 'Latex');
legend('e(t)',  '$\sqrt{|D|}$' );
set(legend, 'Interpreter', 'Latex');

y2=[PairB(:, 5) y];

longsEntry=e < -sqrt(ymse); % a long position means we should buy EWC
longsExit=e > -sqrt(ymse);

shortsEntry=e > sqrt(ymse);
shortsExit=e < sqrt(ymse);

numUnitsLong=NaN(length(y2), 1);
numUnitsShort=NaN(length(y2), 1);

numUnitsLong(1)=0;
numUnitsLong(longsEntry)=1; 
numUnitsLong(longsExit)=0;
numUnitsLong=fillMissingData(numUnitsLong); 

numUnitsShort(1)=0;
numUnitsShort(shortsEntry)=-1; 
numUnitsShort(shortsExit)=0;
numUnitsShort=fillMissingData(numUnitsShort);

numUnits=numUnitsLong+numUnitsShort;
positions=repmat(numUnits, [1 size(y2, 2)]).*[-beta(:, 1) ones(size(beta(:, 1)))].*y2; % [hedgeRatio -ones(size(hedgeRatio))] is the shares allocation, [hedgeRatio -ones(size(hedgeRatio))].*y2 is the dollar capital allocation, while positions is the dollar capital in each ETF.
pnl=sum(lag(positions, 1).*(y2-lag(y2, 1))./lag(y2, 1), 2); % daily P&L of the strategy
ret=pnl./sum(abs(lag(positions, 1)), 2); % return is P&L divided by gross market value of portfolio
ret(isnan(ret))=0;

figure;

cumret=cumprod(1+ret(trainset))-1;
plot(datetime(tday(trainset)/1000, 'ConvertFrom', 'posixtime'), cumret);
title(['Trainset: Cumulative Returns of Kalman Filter Strategy on ' symbolA '-' symbolB]);
xlabel('Date');
ylabel('Cumulative Returns');

figure;

testset=trainset(end)+1:length(tday);

cumret=cumprod(1+ret(testset))-1;

% plot(cumprod(1+ret(testset))-1); % Cumulative compounded return

plot(datetime(tday(testset)/1000, 'ConvertFrom', 'posixtime'), cumret);
title(['Testset: Cumulative Returns of Kalman Filter Strategy on ' symbolA '-' symbolB]);
xlabel('Date');
ylabel('Cumulative Returns');

cagr=(1+cumret(end))^(252/length(cumret))-1;
[maxDD, maxDDD]=calculateMaxDD(cumret);
fprintf(1, 'Out-of-sample: CAGR=%f Sharpe ratio=%f maxDD=%f maxDDD=%i Calmar ratio=%f\n', cagr, sqrt(252)*mean(ret(testset))/std(ret(testset)), maxDD, maxDDD, -cagr/maxDD);
