load mnist_uint8;

data = readtable('C:\Users\aelkman\Documents\MATLAB\yeast.dat', 'Format', '%s%f%f%f%f%f%f%f%f%f');
data = data(:,2:10);
data = data(randperm(size(data,1)),:); %shuffle data for improved performance
data = table2array(data);
Y = data(:,9);
trainingIndex = round(length(data)*0.70);
remainingSamples = 1484 - trainingIndex;
train_y = zeros(trainingIndex,10);
test_y = zeros(remainingSamples,10);

for i = 1:trainingIndex
    train_y(i,Y(i,1)) = 1;
end

for i = 1:remainingSamples
    test_y(i,Y(i+trainingIndex,1)) = 1;
end

train_x = data(1:trainingIndex,1:8);
testingData = data(trainingIndex+1:length(data),:);
test_x = [0.49 0.51 0.52 0.23 0.55 0.03 0.52 0.39];

%opts.plot = 1;

% normalize
[train_x, mu, sigma] = zscore(train_x);
test_x = normalize(test_x, mu, sigma);

rand('state',0)
nn = nnsetup([8 3 10]);

nn.activation_function = 'sigm';    %  Sigmoid activation function
nn.learningRate = 1;                %  Sigm require a lower learning rate
opts.numepochs =  200;                %  Number of full sweeps through data
opts.batchsize = 1;               %  Take a mean gradient step over this many samples
%weightData(3,9,op

%[nn, L, wd1, wd2] = nntrain(nn, train_x, train_y, opts);

[er, bad] = nntest(nn, test_x, test_y);


% figure;
% hold on;
% for i = 1:opts.numepochs
%     for j = 1:3
%         for k = 1:9
%             plot(squeeze(wd1(j,k,:)));
%         end
%     end
% end
% hold off

