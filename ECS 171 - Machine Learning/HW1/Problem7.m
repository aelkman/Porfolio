function [mpg] = Problem7( )
%Truncated code taken from Problem5
    df = xlsread('C:\Users\Alex\Downloads\ecs171autodata.xlsx');    

    %2nd order
    x = ones(302,15);
    x(1:302,2:8) = df(1:302,2:8);
    x(1:302,9:15) = df(1:302,2:8).^2;
    y = df(1:302,1);
    w1 = (x'*x)\x'*y;
    disp(size(w1));
    t=[6,300,170,3600,9,80,1];
    mpg = w1(1) + w1(2)*t(1) + w1(3)*t(2) + w1(4)*t(3) + w1(5)*t(4) + w1(6)*t(5) + w1(7)*t(6) + w1(8)*t(7)...
        + w1(9)*t(1).^2 + w1(10)*t(2).^2 + w1(11)*t(3).^2 + w1(12)*t(4).^2 + w1(13)*t(5).^2 + w1(14)*t(6).^2 + w1(15)*t(7).^2;
end

