function [test_matrix, quantile_data] = P2()

    df = xlsread('C:\Users\Alex\Documents\MATLAB\ECS171 HW3\ecs171.dataset.xlsx');        
    df = df(randperm(size(df,1)),:); %shuffle data for improved performance
    output = df(:,1);
    df = df(:, 2:(size(df,2)-1)); 
    lambda = 0;
    
    
    train_x = df(:,:);
    train_y = output(:,:);

    %1st order
    x = ones(size(train_x,1),size(train_x,2));
    
    for i = 1:100
   
        index = randsample(1:size(train_x,1), size(train_x,1), true);
        test_x = train_x(index,:);
        test_y = train_y(index,:);

        test_input = ones(size(test_x,1),size(test_x,2));
        test_input(1:size(test_x,1),2:(size(test_x,2)+1)) = test_x(:,:);

        x(:,2:(size(train_x,2)+1)) = test_x(:,:);
        y = test_y;
        w1 = (x'*x+lambda*eye(size(x,2)))\x'*y;
        test_prediction = test_input*w1;
        test_matrix(:,i) = test_prediction;

    end
    
    quantile_data(1) = quantile(test_matrix,0.05);
    quantile_data(2) = quantile(test_matrix,0.95);
end