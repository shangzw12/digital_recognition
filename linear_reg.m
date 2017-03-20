% do linear regression use data given as arguments
% All input 
% testData: each row is a data
% testLabel: corresponding label, just a signle column
% trainData, trainLabel just like those above
% lambda: used to regulize

% main formula (A + lambda)*x = B
% output: correct_rate
% wrong_list: data item that is wrong classified, each row is a item
% wrong_label: wrong label of the corresponding item
% righ_label: right label of the corresponding item
function [correct_rate, wrong_list, wrong_label, right_label] = linear_reg(trainData, trainLabel, testData, testLabel, lambda)

assert(size(lambda) == [1, 1], 'Input Lambda wrong\n');
assert(size(trainLabel)*[0,1]' == 1, 'Input trainLabel wrong\n')
assert(size(testLabel)*[0,1] == 1, 'Input testLabel wrong\n');
assert(size(trainData)*[0,1]' == size(testData)*[0,1]', 'Input train and test not match\n');

[test_count, data_len] = size(testData);
len = data_len;
A  = zeros(data_len +1);
B = zeros(data_len + 1, 1);
Lam = lambda*eye(data_len + 1);
trainCount = 0;
% get A B from train data
for trainRow = trainData'
    trainCount = trainCount +1;
    A = A+[1;trainRow]*[1;trainRow]';
    B = B + trainLabel(trainCount)*[1;trainRow];
end
assert(size(A) == [len+1, len+1], 'A size wrong\n');
assert(size(B) == [len+1, 1], 'B size wrong\n');
% get w for regression
w = linsolve(A+Lam, B);
assert(size(w)==[len +1, len+1], 'W dimension wrong\n');
correctCount = 0;
testCount = 0;
w_list = [];
w_label = [];
r_label = [];
% do regression
for testRow = testData'
    testCount = testCount +1;
    tmp_ans = w'*[1;testRow];
    assert(size(tmp_ans) == [1, 1], 'temp_ans Dimension wrong\n');
    for i = 1:1:10
        if((tmp_ans - i <0.5) && (tmp_ans - i >= -0.5))
            if(testLabel(testCount) == i)
                correctCount = correctCount+1;
            else
                w_label = [w_label, i];
                r_label  = [r_label, testLabel(testCount)];
                w_list = [w_list, testRow];
            end
        end
    end
end
correct_rate = correctCount/ test_count;
wrong_list = w_list';
wrong_label = w_label;  
right_label = r_label;
assert(size(wrong_label)*[0, 1]' ==  test_count, 'Output wrong_label wrong\n');
assert(size(right_label) == size(wrong_label), 'Output wrong and right label not match \n');

        
            
    