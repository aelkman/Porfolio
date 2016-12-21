function [te,mse] = Problem3( variable )
%Create X and Y matrices to calculate W from OLS formula
%Variable is the column from original data
    %df = df(randperm(size(df,1)),:); %shuffle data for improved performance
    df = xlsread('C:\Users\Alex\Downloads\ecs171autodata.xlsx');        
    xa = min(df(1:392,variable)):max(df(1:392,variable));
    xb = 1:90;
    xc = df(303:392, variable);
    xd = df(1:302, variable);
    yb = df(303:392,1);
    ya = df(1:302,1);
    
    %0th order
    x = ones(302,1);
    y = df(1:302,1);
    w0 = (x'*x)\x'*y;
    disp(w0);
    y1 = repmat(w0,size(xa),1);
    y1a = repmat(w0, 90, 1);
    y1b = repmat(w0, 302,1);
    e = (y1a-yb).^2;
    e0 = (y1b-ya).^2;
    te(1) = sum(e0)/302;
    MSE0 = sum(e)/90;
    disp(MSE0);
    
    %1st order
    x = ones(302,2);
    x(1:302,2) = df(1:302,variable);
    w1 = (x'*x)\x'*y;
    disp(w1);
    y2 = w1(1) + w1(2)*xa;
    y2a = w1(1) + w1(2)*xc;
    y2b = w1(1) + w1(2)*xd;
    e = (y2a-yb).^2;
    e0 = (y2b-ya).^2;
    te(2) = sum(e0)/302;
    MSE1 = sum(e)/90;
    disp(MSE1);

    %2nd order
    x = ones(302,3);
    x(1:302,2) = df(1:302,variable);
    x(1:302,3) = df(1:302,variable).^2;
    w2 = (x'*x)\x'*y;
    disp(w2);
    y3 = w2(1) + w2(2)*xa + w2(3)*xa.^2;
    y3a = w2(1) + w2(2)*xc + w2(3)*xc.^2;    
    y3b = w2(1) + w2(2)*xd + w2(3)*xd.^2;    
    e = (y3a-yb).^2;
    e0 = (y3b-ya).^2;
    te(3) = sum(e0)/302;
    MSE2 = sum(e)/90;
    disp(MSE2);    
    
    %3rd order
    x = ones(302,4);
    x(1:302,2) = df(1:302,variable);
    x(1:302,3) = df(1:302,variable).^2;
    x(1:302,4) = df(1:302,variable).^3;
    w3 = (x'*x)\x'*y;
    disp(w3);    
    y4 = w3(1) + w3(2)*xa + w3(3)*xa.^2 + w3(4)*xa.^3;
    y4a = w3(1) + w3(2)*xc + w3(3)*xc.^2 + w3(4)*xc.^3;
    y4b = w3(1) + w3(2)*xd + w3(3)*xd.^2 + w3(4)*xd.^3;
    e = (y4a-yb).^2;
    e0 = (y4b-ya).^2;
    te(4) = sum(e0)/302;
    MSE3 = sum(e)/90;
    disp(MSE3);  
    
    %4th order
    x = ones(302,4);
    x(1:302,2) = df(1:302,variable);
    x(1:302,3) = df(1:302,variable).^2;
    x(1:302,4) = df(1:302,variable).^3;
    x(1:302,5) = df(1:302,variable).^4;
    w4 = (x'*x)\x'*y;
    y5 = w4(1) + w4(2)*xa + w4(3)*xa.^2 + w4(4)*xa.^3 + w4(5)*xa.^4;    
    y5a = w4(1) + w4(2)*xc + w4(3)*xc.^2 + w4(4)*xc.^3 + w4(5)*xc.^4;    
    y5b = w4(1) + w4(2)*xd + w4(3)*xd.^2 + w4(4)*xd.^3 + w4(5)*xd.^4;    
    disp(w4);    
    e = (y5a-yb).^2;
    e0 = (y5b-ya).^2;
    te(5) = sum(e0)/302;
    MSE4 = sum(e)/90;
    disp(MSE4); 
    
    mse(1) = MSE0;
    mse(2) = MSE1;
    mse(3) = MSE2;
    mse(4) = MSE3;
    mse(5) = MSE4;
    
    figure;
    scatter(xc, yb, 3,'k','filled');
    hold on;
    plot(xa,y1,xa,y2,xa,y3,xa,y4,xa,y5, 'LineWidth', 2);
    
end