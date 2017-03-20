% Mixture of Gaussian
% All input 
% testData: each row is a data
% testLabel: corresponding label, just a signle column
% trainData, trainLabel just like those above

% output: correct_rate
% wrong_list: data item that is wrong classified, each row is a item
% wrong_label: wrong label of the corresponding item
% righ_label: right label of the corresponding item
function [correct_rate, wrong_list, wrong_label, right_label] = MixtureGaussian(trainData, trainLabel, testData, testLabel)

assert(size(trainLabel)*[0,1]' == 1, 'Input trainLabel wrong\n')
assert(size(testLabel)*[0,1]' == 1, 'Input testLabel wrong\n');
assert(size(trainData)*[0,1]' == size(testData)*[0,1]', 'Input train and test not match\n');
[trainLen, data_len] = size(trainData);
sigma = [];
sigma_1 = [];
mu= zeros(10, data_len);
labelBegin = zeros(1, 10);
labelEnd = zeros(1, 10);
[~, I] = sort(trainLabel); %from 0 to 9
trainData = trainData(I', :);
disp(size(trainData));
assert(size(trainData)*[0,1]' == size(testData)*[0,1]', 'Input train and test not match\n');
labelBegin(10) = 1;
labelEnd(9) = trainLen;
pr = zeros(1,10);
delta = 1 *eye(data_len);
count = 0;
former = 0;
for i = trainLabel(I)'
    count = count +1;
    if(i ~= former)
        if( former == 0)
            labelEnd(10) = count -1;
        else
            labelEnd(former) = count -1;
        end
        labelBegin(i) = count;
    end
    former = i;
end
for i=1:1:10
    pr(i) = (labelEnd(i) - labelBegin(i))/trainLen;
    mu(i, :) = mean(trainData(labelBegin(i):labelEnd(i), :));
    sigma = [sigma; cov(trainData(labelBegin(i):labelEnd(i), :))+delta ];
    sigma_1 = [sigma_1; inv(cov(trainData(labelBegin(i):labelEnd(i), :)) + delta)];
end
save('MixtureGaussian','labelBegin', 'labelEnd', 'pr', 'mu', 'sigma', 'sigma_1');
tmp_pr = zeros(10);
pred = zeros(size(testLabel));
tmp_count  = 0;
% make prediction
c_count =0;
w_list = [];
w_label = [];
r_label = [];
for item = testData'
    tmp_count = tmp_count +1;
    for i=1:1:10
        tmp_pr(i) = log(pr(i)) + Normal(mu(i,:)',...
            sigma((i-1)*data_len+1: (i)*data_len, :),...
            sigma_1((i-1)*data_len+1: (i)*data_len, :), item );
    end
    %disp(tmp_pr);
    [~, I] = sort(tmp_pr, 'descend');
    if(I(1) == 10)
        pred(tmp_count) = 0;
    else
        pred(tmp_count) = I(1);
    end
    if(pred(tmp_count) == testLabel(tmp_count))
        c_count = c_count +1;
    else
        w_label = [w_label, pred(tmp_count)];
        r_label  = [r_label, testLabel(tmp_count)];
        w_list = [w_list, item];
    end
end
correct_rate = c_count/ tmp_count;
disp(correct_rate);
wrong_list = w_list';
wrong_label = w_label;
%disp(w_label);
%disp(r_label);
right_label = r_label;
assert(size(wrong_label)*[1,0]'== 1, 'Output wrong_label wrong\n');
assert(size(right_label)*[1, 1]' == size(wrong_label)*[1,1]', 'Output wrong and right label not match \n');
