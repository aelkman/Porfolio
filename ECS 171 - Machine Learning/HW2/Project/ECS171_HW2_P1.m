%aelkman 10/24/16 ECS171 FQ HW2 P1%

numAttr = 8;
numLayers = 1; 

data = readtable('C:\Users\aelkman\Documents\MATLAB\yeast.dat', 'Format', '%s%f%f%f%f%f%f%f%f%f');
data = data(:,2:10);
data = table2array(data);
trainingIndex = round(length(data)*0.70);
trainingData = data(1:trainingIndex,:);
testingData = data(trainingIndex+1:length(data),:);

a = -1/sqrt(numAttr);
b = 1/sqrt(numAttr);

W = (b-a).*rand(numAttr,numLayers + 1) + a; %generate matrix of random weights

result = forwardprop(trainingData, W);
disp(result);