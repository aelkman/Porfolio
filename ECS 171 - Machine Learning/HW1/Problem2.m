function [] = Problem2 ()
%Graphs scatter plot matrix for 3 sub groups of mpg on sorted data set
    df = xlsread('C:\Users\Alex\Downloads\ecs171autodata.xlsx');    
    df = sortrows(df);
    group = zeros(392,1);
    val = round(size(df, 1)/3);
    group(val:val*2, :) = 1;
    group(val*2+1:392, :) = 2;
    gplotmatrix(df,[],group);
end

