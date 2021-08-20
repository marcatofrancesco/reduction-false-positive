% questo file testa vari valori di marginRate per verificarne la Precision e il Recall

start = 0;
step = 0.1;
finish = 2;

testingData = zeros(ceil((finish-start)/step),3); %matrice di Precision e Recall

marginRate = start

k = 1;

while marginRate <= finish
    
    results = applicaMetodo(marginRate, DepthDATA, 0);
    
    checkResults;
    
    precision = truePositive/(truePositive+falsePositive);
    recall = truePositive/(truePositive+falseNegative);
    
    testingData(k, 1) = marginRate;
    testingData(k, 2) = precision;
    testingData(k, 3) = recall;
    
    marginRate = marginRate + step
    k = k + 1;
    
end

hold on
scatter(testingData(:,1), testingData(:,2), 'filled');
line(testingData(:,1), testingData(:,2))

scatter(testingData(:,1), testingData(:,3), 'filled', 'red');
line(testingData(:,1), testingData(:,3), 'Color', 'red')

