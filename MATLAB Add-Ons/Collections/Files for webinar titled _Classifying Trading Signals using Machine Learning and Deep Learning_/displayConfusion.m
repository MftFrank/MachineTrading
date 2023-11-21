function displayConfusion(yTest,yPred)
% This function aim to visualize yTest and yPred in confusional matrix
% Copyright 2017 The MathWorks, Inc.

nTest = size(yTest,1);
actual = zeros(2,nTest);
prediction = zeros(2,nTest);
for i = 1:2
    actual(i,:) = (double(yTest) == i)';
    prediction(i,:) = (double(yPred) == i)';
end
plotconfusion(actual,prediction);
end