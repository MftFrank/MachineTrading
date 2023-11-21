function [trainedModel, validationRMSE] = trainRegressionModel(trainingData)
% Copyright (c) 2018, MathWorks, Inc.
% [trainedModel, validationRMSE] = trainRegressionModel(trainingData)
% returns a trained regression model and its RMSE. This code recreates the
% model trained in Regression Learner app. Use the generated code to
% automate training the same model with new data, or to learn how to
% programmatically train models.
%
%  Input:
%      trainingData: a table containing the same predictor and response
%       columns as imported into the app.
%
%  Output:
%      trainedModel: a struct containing the trained regression model. The
%       struct contains various fields with information about the trained
%       model.
%
%      trainedModel.predictFcn: a function to make predictions on new data.
%
%      validationRMSE: a double containing the RMSE. In the app, the
%       History list displays the RMSE for each model.
%
% Use the code to train the model with new data. To retrain your model,
% call the function from the command line with your original data or new
% data as the input argument trainingData.
%
% For example, to retrain a regression model trained with the original data
% set T, enter:
%   [trainedModel, validationRMSE] = trainRegressionModel(T)
%
% To make predictions with the returned 'trainedModel' on new data T2, use
%   yfit = trainedModel.predictFcn(T2)
%
% T2 must be a table containing at least the same predictor columns as used
% during training. For details, enter:
%   trainedModel.HowToPredict

% Auto-generated by MATLAB on 15-Aug-2018 09:18:29


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'MKPRU', 'MKPRU_momentum7', 'MKPRU_momentum15', 'MKPRU_momentum30', 'MWNUS_momentum7', 'MWNUS_momentum15', 'MWNUS_momentum30', 'DIFF_momentum7', 'DIFF_momentum15', 'DIFF_momentum30', 'MWNTD_momentum7', 'MWNTD_momentum15', 'MWNTD_momentum30', 'MWTRV_momentum7', 'MWTRV_momentum15', 'MWTRV_momentum30', 'AVBLS_momentum7', 'AVBLS_momentum15', 'AVBLS_momentum30', 'BLCHS_momentum7', 'BLCHS_momentum15', 'BLCHS_momentum30', 'ATRCT_momentum7', 'ATRCT_momentum15', 'ATRCT_momentum30', 'MIREV_momentum7', 'MIREV_momentum15', 'MIREV_momentum30', 'HRATE_momentum7', 'HRATE_momentum15', 'HRATE_momentum30', 'CPTRA_momentum7', 'CPTRA_momentum15', 'CPTRA_momentum30', 'TRVOU_momentum7', 'TRVOU_momentum15', 'TRVOU_momentum30', 'ETRVU_momentum7', 'ETRVU_momentum15', 'ETRVU_momentum30', 'TOUTV_momentum7', 'TOUTV_momentum15', 'TOUTV_momentum30', 'NTRBL_momentum7', 'NTRBL_momentum15', 'NTRBL_momentum30', 'NTRAT_momentum7', 'NTRAT_momentum15', 'NTRAT_momentum30', 'TRFUS_momentum7', 'TRFUS_momentum15', 'TRFUS_momentum30', 'MKTCP_momentum7', 'MKTCP_momentum15', 'MKTCP_momentum30', 'TOTBC_momentum7', 'TOTBC_momentum15', 'TOTBC_momentum30', 'ret1', 'ret5', 'ret10', 'ret20', 'vol10', 'vol30', 'vol60', 'vol180'};
predictors = inputTable(:, predictorNames);
response = inputTable.Response;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Train a regression model
% This code specifies all the model options and trains the model.
template = templateTree(...
    'MinLeafSize', 8);
regressionEnsemble = fitrensemble(...
    predictors, ...
    response, ...
    'Method', 'LSBoost', ...
    'NumLearningCycles', 30, ...
    'Learners', template, ...
    'LearnRate', 0.1,...
    'OptimizeHyperparameters','auto');

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
ensemblePredictFcn = @(x) predict(regressionEnsemble, x);
trainedModel.predictFcn = @(x) ensemblePredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedModel.RequiredVariables = {'MKPRU', 'MKPRU_momentum7', 'MKPRU_momentum15', 'MKPRU_momentum30', 'MWNUS_momentum7', 'MWNUS_momentum15', 'MWNUS_momentum30', 'DIFF_momentum7', 'DIFF_momentum15', 'DIFF_momentum30', 'MWNTD_momentum7', 'MWNTD_momentum15', 'MWNTD_momentum30', 'MWTRV_momentum7', 'MWTRV_momentum15', 'MWTRV_momentum30', 'AVBLS_momentum7', 'AVBLS_momentum15', 'AVBLS_momentum30', 'BLCHS_momentum7', 'BLCHS_momentum15', 'BLCHS_momentum30', 'ATRCT_momentum7', 'ATRCT_momentum15', 'ATRCT_momentum30', 'MIREV_momentum7', 'MIREV_momentum15', 'MIREV_momentum30', 'HRATE_momentum7', 'HRATE_momentum15', 'HRATE_momentum30', 'CPTRA_momentum7', 'CPTRA_momentum15', 'CPTRA_momentum30', 'TRVOU_momentum7', 'TRVOU_momentum15', 'TRVOU_momentum30', 'ETRVU_momentum7', 'ETRVU_momentum15', 'ETRVU_momentum30', 'TOUTV_momentum7', 'TOUTV_momentum15', 'TOUTV_momentum30', 'NTRBL_momentum7', 'NTRBL_momentum15', 'NTRBL_momentum30', 'NTRAT_momentum7', 'NTRAT_momentum15', 'NTRAT_momentum30', 'TRFUS_momentum7', 'TRFUS_momentum15', 'TRFUS_momentum30', 'MKTCP_momentum7', 'MKTCP_momentum15', 'MKTCP_momentum30', 'TOTBC_momentum7', 'TOTBC_momentum15', 'TOTBC_momentum30', 'ret1', 'ret5', 'ret10', 'ret20', 'vol10', 'vol30', 'vol60', 'vol180'};
trainedModel.RegressionEnsemble = regressionEnsemble;
trainedModel.About = 'This struct is a trained model exported from Regression Learner R2018b.';
trainedModel.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appregression_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'MKPRU', 'MKPRU_momentum7', 'MKPRU_momentum15', 'MKPRU_momentum30', 'MWNUS_momentum7', 'MWNUS_momentum15', 'MWNUS_momentum30', 'DIFF_momentum7', 'DIFF_momentum15', 'DIFF_momentum30', 'MWNTD_momentum7', 'MWNTD_momentum15', 'MWNTD_momentum30', 'MWTRV_momentum7', 'MWTRV_momentum15', 'MWTRV_momentum30', 'AVBLS_momentum7', 'AVBLS_momentum15', 'AVBLS_momentum30', 'BLCHS_momentum7', 'BLCHS_momentum15', 'BLCHS_momentum30', 'ATRCT_momentum7', 'ATRCT_momentum15', 'ATRCT_momentum30', 'MIREV_momentum7', 'MIREV_momentum15', 'MIREV_momentum30', 'HRATE_momentum7', 'HRATE_momentum15', 'HRATE_momentum30', 'CPTRA_momentum7', 'CPTRA_momentum15', 'CPTRA_momentum30', 'TRVOU_momentum7', 'TRVOU_momentum15', 'TRVOU_momentum30', 'ETRVU_momentum7', 'ETRVU_momentum15', 'ETRVU_momentum30', 'TOUTV_momentum7', 'TOUTV_momentum15', 'TOUTV_momentum30', 'NTRBL_momentum7', 'NTRBL_momentum15', 'NTRBL_momentum30', 'NTRAT_momentum7', 'NTRAT_momentum15', 'NTRAT_momentum30', 'TRFUS_momentum7', 'TRFUS_momentum15', 'TRFUS_momentum30', 'MKTCP_momentum7', 'MKTCP_momentum15', 'MKTCP_momentum30', 'TOTBC_momentum7', 'TOTBC_momentum15', 'TOTBC_momentum30', 'ret1', 'ret5', 'ret10', 'ret20', 'vol10', 'vol30', 'vol60', 'vol180'};
predictors = inputTable(:, predictorNames);
response = inputTable.Response;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Set up holdout validation
cvp = cvpartition(size(response, 1), 'Holdout', 0.3);
trainingPredictors = predictors(cvp.training, :);
trainingResponse = response(cvp.training, :);
trainingIsCategoricalPredictor = isCategoricalPredictor;

% Train a regression model
% This code specifies all the model options and trains the model.
template = templateTree(...
    'MinLeafSize', 8);
regressionEnsemble = fitrensemble(...
    trainingPredictors, ...
    trainingResponse, ...
    'Method', 'LSBoost', ...
    'NumLearningCycles', 30, ...
    'Learners', template, ...
    'LearnRate', 0.1);

% Create the result struct with predict function
ensemblePredictFcn = @(x) predict(regressionEnsemble, x);
validationPredictFcn = @(x) ensemblePredictFcn(x);

% Add additional fields to the result struct


% Compute validation predictions
validationPredictors = predictors(cvp.test, :);
validationResponse = response(cvp.test, :);
validationPredictions = validationPredictFcn(validationPredictors);

% Compute validation RMSE
isNotMissing = ~isnan(validationPredictions) & ~isnan(validationResponse);
validationRMSE = sqrt(nansum(( validationPredictions - validationResponse ).^2) / numel(validationResponse(isNotMissing) ));
