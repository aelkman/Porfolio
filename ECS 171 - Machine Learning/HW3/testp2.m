function [err, Kmean, weights] = testp2()
%Create X and Y matrices to calculate W from OLS formula
%Variable is the column from original data
    %df = df(randperm(size(df,1)),:); %shuffle data for improved performance
    df = xlsread('C:\Users\Alex\Documents\MATLAB\ECS171 HW3\ecs171.dataset.xlsx');        
    df = df(randperm(size(df,1)),:); %shuffle data for improved performance
    output = df(:,1);
    df = df(:, 2:(size(df,2)-1));
    
%     X_poly = zeros(size(X,1), size(X,2)*p);
%     for i = 1:(p*size(X,2))
%         X_poly(:,i) = X(:,mod(i,size(X,2))+1).^(mod(i,p));
%     end

    train_size = round(size(df,1)*9/10);
    test_size = round(size(df,1)/10);    

        lambda = 0;
        
        train_x = df(:,:);
        train_y = output(:,:);
        
            %1st order
            x = ones(size(train_x,1),size(train_x,2));
            x(1:size(train_x,1),2:(size(train_x,2)+1)) = train_x(:,:);
            y = train_y;
            w1 = (x'*x+lambda*eye(size(x,2)))\x'*y;
    
        for i = 1:10



            test_input = ones(size(test_x,1),size(test_x,2));
            test_input(1:size(test_x,1),2:(size(test_x,2)+1)) = test_x(:,:);



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