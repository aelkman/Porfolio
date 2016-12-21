function [te,mse] = Problem5()
%Create X and Y matrices to calculate W from OLS formula
%Variable is the column from original data
    %df = df(randperm(size(df,1)),:); %shuffle data for improved performance
    df = xlsread('C:\Users\Alex\Downloads\ecs171autodata.xlsx');    
    variable = 2:8;
    xa = min(df(1:392,variable)):max(df(1:392,variable));
    xb = 1:90;
    xc = df(303:392, variable);
    yb = repmat(df(303:392,1),1,7);
    yc = df(303:392,1);
    
    %0th order
    x = ones(302,1);
    y = df(1:302,1);
    w0 = (x'*x)\x'*y;
    disp(w0);
    y1 = repmat(w0,size(xa),1);
    y1a = repmat(w0, 90, 1);
    e = (y1a-yc).^2;
    e1 = (repmat(w0, 302,1)-df(1:302,1)).^2;
    te(1) = sum(e1)/302;
    MSE0 = sum(e)/90;
    disp(MSE0);
    
    %1st order
    x = ones(302,8);
    x(1:302,2:8) = df(1:302,2:8);
    w1 = (x'*x)\x'*y;
    %y2 = w1(1) + w1(2)*xa;
    y2a = w1(1) + w1(2)*df(303:392, 2) + w1(3)*df(303:392, 3) + w1(4)*df(303:392, 4) + w1(5)*df(303:392, 5) + w1(6)*df(303:392, 6) + w1(7)*df(303:392, 7) + w1(8)*df(303:392, 8);
    y2b = w1(1) + w1(2)*df(1:302, 2) + w1(3)*df(1:302, 3) + w1(4)*df(1:302, 4) + w1(5)*df(1:302, 5) + w1(6)*df(1:302, 6) + w1(7)*df(1:302, 7) + w1(8)*df(1:302, 8);    
    disp(size(y2a));
    disp(size(yb));
    disp(w1);
    e = (y2a-yc).^2;
    e1 = (y2b - df(1:302,1)).^2;
    te(2) = sum(e1)/302;
    MSE1 = sum(e)/90;

    %2nd order
    x = ones(302,15);
    x(1:302,2:8) = df(1:302,variable);
    x(1:302,9:15) = df(1:302,variable).^2;
    w1 = (x'*x)\x'*y;
    disp(size(w1));
    %y3 = w2(1) + w2(2)*xa + w2(3)*xa.^2;
    y3a = w1(1) + w1(2)*df(303:392, 2) + w1(3)*df(303:392, 3) + w1(4)*df(303:392, 4) + w1(5)*df(303:392, 5) + w1(6)*df(303:392, 6) + w1(7)*df(303:392, 7) + w1(8)*df(303:392, 8)...
        + w1(9)*df(303:392, 2).^2 + w1(10)*df(303:392, 3).^2 + w1(11)*df(303:392, 4).^2 + w1(12)*df(303:392, 5).^2 + w1(13)*df(303:392, 6).^2 + w1(14)*df(303:392, 7).^2 + w1(15)*df(303:392, 8).^2;
    y3b = w1(1) + w1(2)*df(1:302, 2) + w1(3)*df(1:302, 3) + w1(4)*df(1:302, 4) + w1(5)*df(1:302, 5) + w1(6)*df(1:302, 6) + w1(7)*df(1:302, 7) + w1(8)*df(1:302, 8)...
        + w1(9)*df(1:302, 2).^2 + w1(10)*df(1:302, 3).^2 + w1(11)*df(1:302, 4).^2 + w1(12)*df(1:302, 5).^2 + w1(13)*df(1:302, 6).^2 + w1(14)*df(1:302, 7).^2 + w1(15)*df(1:302, 8).^2;    
    e = (y3a-yc).^2;
    e1 = (y3b - df(1:302,1)).^2;
    te(3) = sum(e1)/302;
    MSE2 = sum(sum(e))/630;
    disp(w1);    
    
    mse(1) = MSE0;
    mse(2) = MSE1;
    mse(3) = MSE2;
    
    %figure;
    %scatter(xc, yb, 3,'k','filled');
    %hold on;
    %plot(xa,y1,xa,y2,xa,y3, 'LineWidth', 2);
    
end