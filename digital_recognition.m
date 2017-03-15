function rate = digital_recognition(funcName, fileName, K)
data = csvread(fileName,1, 0);
rate = crossValidation(data, K,funcName);