load mnist_uint8;

data = readtable('C:\Users\aelkman\Documents\MATLAB\yeast.dat', 'Format', '%s%f%f%f%f%f%f%f%f%f');
data = data(:,2:10);
data = table2array(data);
Y = data(:,9);
trainingDataY = zeros(1484,10);
for i = 1:1484
    trainingDataY(i,Y(i,1)) = 1;
end
trainingIndex = round(length(data));

%trainingIndex = round(length(data)*0.70);
trainingDataX = data(:,1:8);
testingData = normc(data(trainingIndex+1:length(data),:));
testingDataX = testingData(:,1:8);
testingDataY = testingData(:,9);

train_x = trainingDataX;
test_x  = testingDataX;
train_y = trainingDataY;
test_y  = testingDataY;

for i = 1:4
        opts.plot = 0;

        % normalize
        [train_x, mu, sigma] = zscore(train_x);
        test_x = normalize(test_x, mu, sigma);

        rand('state',0)
        nn = nnsetup([8 3*i 10]);

        nn.activation_function = 'sigm';    %  Sigmoid activation function
        nn.learningRate = 1;                %  Sigm require a lower learning rate
        opts.numepochs =  200;                %  Number of full sweeps through data
        opts.batchsize = 1;               %  Take a mean gradient step over this many samples
        %weightData(3,9,op

        [nn, L, wd1, wd2, mse, fe] = nntrain(nn, train_x, train_y, opts);

        [er, bad] = nntest(nn, test_x, test_y);
        mserror(i) = mse;
        ferror(i) = fe;
end