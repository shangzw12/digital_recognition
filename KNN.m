function rate = KNN(testData, testLabel,trainData,trainLabel,  k)%%k means KNN
delta = 0.00001;
data  = trainData;
label = trainLabel;
[trainData_len, ~] = size(data);
[testData_len, ~] = size(testData);
cort_count = 0;
test_count = 0;
disp('label');
%disp(label);
for row = testData'
    digit_count = zeros(1, 10);
    test_count = test_count +1;
    dis_tmp = zeros(1, trainData_len);
    count = 0;
    for trainRow = data'
        count = count +1;
        dis_tmp(count) = (row - trainRow)'*((row - trainRow));
    end
   [~, I ]= sort(dis_tmp);
    for i = 1:1:k
        %disp(label(I(i)));
        for j= 1:1:10
            if(abs(label(I(i)) - mod(j, 10) ) < delta )
                digit_count(j) = digit_count(j)+1;
            end
        end
    end
    [~, res] = sort(digit_count, 'descend');
    %disp(res(1));
    %disp(testLabel(test_count));
    if(abs(mod(res(1), 10) - testLabel(test_count)) < 0.001)
        cort_count = cort_count +1;
    end
end
disp(cort_count);
disp(testData_len);
rate = cort_count / testData_len;
    
