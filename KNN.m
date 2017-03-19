% do KNN use data given as arguments
% All input 
% testData: vertical vector without label
% testLabel: corresponding label, just a signle column
% trainData, trainLabel just like those above
% K refers to KNN's K

% output: correct_rate
function [rate, wrong_list, wrong_label, right_label] = KNN(trainData, trainLabel, testData, testLabel,k)

assert(size(k)*[1, 1]' == 2, 'Input Lambda wrong\n');
assert(size(trainLabel)*[0,1]' == 1, 'Input trainLabel wrong\n')
assert(size(testLabel)*[0,1]' == 1, 'Input testLabel wrong\n');
assert(size(trainData)*[0,1]' == size(testData)*[0,1]', 'Input train and test not match\n');

delta = 0.00001; % when compare double
[trainData_len, ~] = size(trainData);
[testData_len, ~] = size(testData);
cort_count = 0;
test_count = 0;
w_list = [];
w_label = [];
r_label = [];
for row = testData'
    digit_count = zeros(1, 10); % used to compare which class match the most
    test_count = test_count +1;
    dis_tmp = zeros(1, trainData_len);
    count = 0;
    % get distance between one test case with all trian data
    for trainRow = trainData'
        count = count +1;
        dis_tmp(count) = (row - trainRow)'*((row - trainRow));
    end
    assert((size(dis_tmp) - [1, trainData_len])*[1, 1]' == 0, 'dis_tmp dimension wrong\n');
   [~, I ]= sort(dis_tmp); % from small to large
   % do classification
    for i = 1:1:k
        for j= 1:1:10
            if(abs(trainLabel(I(i)) - mod(j, 10) ) < delta )
                digit_count(j) = digit_count(j)+1;
            end
        end
    end
    [~, res] = sort(digit_count, 'descend');
    if(abs(mod(res(1), 10) - testLabel(test_count)) < 0.001)
        cort_count = cort_count +1;
    else
        w_list = [w_list, row];
        w_label = [w_label, mod(res(1), 10)];
        r_label = [r_label, testLabel(test_count)];
    end
end
rate = cort_count / testData_len;
wrong_list = w_list;
wrong_label = w_label;
right_label = r_label;
    
