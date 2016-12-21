function [prediction] = P3()
%Create X and Y matrices to calculate W from OLS formula
%Variable is the column from original data
    %df = df(randperm(size(df,1)),:); %shuffle data for improved performance
    df = xlsread('C:\Users\Alex\Documents\MATLAB\ECS171 HW3\ecs171.dataset.xlsx');        
    df = df(randperm(size(df,1)),:); %shuffle data for improved performance
    output = df(:,1);
    df = df(:, 2:(size(df,2)-1));

    train_size = round(size(df,1)*9/10);
    test_size = round(size(df,1)/10);    
    
    for j = 1:1
        
        lambda = 130;
    
        for i = 1:10

            train_x = df(1:(i-1)*test_size+1,:);
            train_y = output(1:(i-1)*test_size+1,:);
            train_x(test_size*(i-1)+1:train_size,:) = df((i*test_size)+1:size(df,1),:);
            train_y(test_size*(i-1)+1:train_size,:) = output((i*test_size)+1:size(df,1),:);
            test_x = df(test_size*(i-1)+1:test_size*i, :);
            test_x = mean(test_x);

            %1st order
            x = ones(size(train_x,1),size(train_x,2));
            x(1:size(train_x,1),2:(size(train_x,2)+1)) = train_x(:,:);

            test_input = ones(size(test_x,1),size(test_x,2));
            test_input(1:size(test_x,1),2:(size(test_x,2)+1)) = test_x(:,:);

            y = train_y;
            w1 = (x'*x+lambda*eye(size(x,2)))\x'*y;

            test_prediction = test_input*w1;
            prediction = test_prediction;

        end
    end
end