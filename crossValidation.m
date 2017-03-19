% crossValidation
% input:
% K refers to k-fold 
% f_handle: function that actually call this validation
% output: whole correct rate
% wrong_list: wrongly classified data matrix, each row is an item
% wrong_label: wronged label
% right_label: label should be
function  rate = crossValidation( f_handle)
%f_handle just has one output, the correct rate
load('data', 'data');
load('data', 'label');
%data = data(1:500,:);
%label = label(1:500,:);
assert(size(data)*[0,1]' == 784, 'Load data dimension wrong \n');
assert(size(data)*[1, 0]' == size(label)*[1, 0]', 'Label data length not match \n');
[dataCount, dataLen] = size(data);
gap = int16(dataCount / 10);
trainLabel = [];
trainData = [];
testData = [];
testLabel = [];
ind = [];
res = [];
for i=1:1:10
    ind = (i-1)*gap+1:i*gap;
    trainData = data(setdiff(1:dataCount, ind), :);
    trainLabel = label(setdiff(1:dataCount, ind), :);
    testData = data(ind, :);
    testLabel = label(ind, :);
    res  =[res ;f_handle(trainData, trainLabel, testData, testLabel)];
end
%disp(correct_rate);
disp(mean(res));



        


