function correct_rate = linear_reg( testData, testLabel,trainData, trainLabel, lambda)
[test_count, data_len] = size(testData);
A  = zeros(data_len +1);
B = zeros(data_len + 1, 1);
Lam = lambda*eye(data_len + 1);
trainCount = 0;
for trainRow = trainData'
    trainCount = trainCount +1;
    A = A+[1;trainRow]*[1,trainRow'];
    B = B + trainLabel(trainCount)*[1;trainRow];
end
w = linsolve(A+Lam, B);
correctCount = 0;
testCount = 0;
for testRow = testData'
    testCount = testCount +1;
    tmp_ans = w'*[1;testRow];
    for i = 1:1:10
        %disp(tmp_ans);
        if((tmp_ans - i <0.5) && (tmp_ans - i >= -0.5))
            if(testLabel(testCount) == i)
                correctCount = correctCount+1;
            end
            %break;
        end
    end
end
correct_rate = correctCount/ test_count;
        
            
    