function  res = crossValidation(allData_, K)
[all_count, col] = size(allData_);
all_data = allData_(:,2:end);
all_label = allData_(:, 1);
gap = all_count/10;
trainSet = zeros(all_count/10 * 9, col-1);
trainLabel = zeros(all_count / 10*9, 1);
testSet = zeros(all_count - all_count/10*9, col-1);
testLabel = zeros(all_count - all_count/10*9, 1);
correct_rate = zeros(1, 10);
for j = 1:1:10
    testSet_count = 1;
    trainSet_count = 1;
    cursor_set = 0;
    for i = 1:1:all_count
        if( i/gap > cursor_set)
            cursor_set  = cursor_set +1;
        end
        if(cursor_set == j)
            testSet(testSet_count,:) = all_data(i, :);
            testLabel(testSet_count, :) = all_label(i, :);
            testSet_count = testSet_count +1;
        else
            trainSet(trainSet_count, :) = all_data(i, :);
            trainLabel(trainSet_count, :) = all_label(i, :);
            trainSet_count = trainSet_count +1;
        end
    end
    correct_rate(j) = KNN(testSet, testLabel, trainSet, trainLabel,K);
end
%disp(correct_rate);
res = mean(correct_rate);
disp(res)



        


