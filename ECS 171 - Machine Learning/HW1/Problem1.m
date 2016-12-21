function [t1, t2, t3] = Problem1()
%Find all 3 thresholds for low, medium, and high mpg
%   t1 is low, t2 is medium, t3 is high
    df = xlsread('C:\Users\Alex\Downloads\ecs171autodata.xlsx');    
    df = sortrows(df);
    x = round(size(df, 1)/3);
    t1 = [df(1,1),df(x, 1)];
    t2 = [df(x+1,1),df(2*x, 1)];
    t3 = [df(2*x,1),df(size(df,1))];
end

