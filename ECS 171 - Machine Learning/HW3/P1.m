function [err, Kmean, weights] = P1()
%Create X and Y matrices to calculate W from OLS formula
%Variable is the column from original data
    %df = df(randperm(size(df,1)),:); %shuffle data for improved performance
    df = xlsread('C:\Users\Alex\Documents\MATLAB\ECS171 HW3\ecs171.dataset.xlsx');        
    df = df(randperm(size(df,1)),:); %shuffle data for improved performance
    output = df(:,5);
    df = df(:, 6:(size(df,2)-1));
    
%     X_poly = zeros(size(X,1), size(X,2)*p);
%     for i = 1:(p*size(X,2))
%         X_poly(:,i) = X(:,mod(i,size(X,2))+1).^(mod(i,p));
%     end

    train_size = round(size(df,1)*9/10);
    test_size = round(size(df,1)/10);    
    
    for j = 1:30
        
        lambda = j*10;
    
        for i = 1:10

            train_x = df(1:(i-1)*test_size+1,:);
            train_y = output(1:(i-1)*test_size+1,:);
            train_x(test_size*(i-1)+1:train_size,:) = df((i*test_size)+1:size(df,1),:);
            train_y(test_size*(i-1)+1:train_size,:) = output((i*test_size)+1:size(df,1),:);
            test_x = df(test_size*(i-1)+1:test_size*i, :);
            test_y = output(test_size*(i-1)+1:test_size*i, :);

            %1st order
            x = ones(size(train_x,1),size(train_x,2));
            x(1:size(train_x,1),2:(size(train_x,2)+1)) = train_x(:,:);

            test_input = ones(size(test_x,1),size(test_x,2));
            test_input(1:size(test_x,1),2:(size(test_x,2)+1)) = test_x(:,:);


            y = train_y;
            w1 = (x'*x+lambda*eye(size(x,2)))\x'*y;

            train_prediction = x*w1;
            test_prediction = test_input*w1;

            train_e = (train_prediction - train_y).^2;
            test_e = (test_prediction - test_y).^2;
            tr_e = mean(train_e);
            te_e = mean(test_e);
% 
%             disp('train err = ');
%             disp(tr_e);
%             disp('test err = ');
%             disp(te_e);

            err(i,1,j) = tr_e;
            err(i,2,j) = te_e;

    % %         mse(2) = MSE1;
    % 
    %         figure;
    %         scatter(xc, yb, 3,'k','filled');
    %         hold on;
    %         plot(xa,y2, 'LineWidth', 2);

        end
    
    weights(1:size(w1,1), j) = w1;
    Kmean(j) = mean(err(:,2,j));
    lamdata(j) = lambda;
    disp(lambda);
    disp(Kmean(j));    
    end
    
    figure;
    plot(lamdata(1:end),Kmean(1:end), 'LineWidth', 2);
end