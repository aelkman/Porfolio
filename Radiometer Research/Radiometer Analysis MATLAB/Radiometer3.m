tmp_data=importdata('C:\Users\Alex\Desktop\Radiometer Experiment\Radiometer Constant Temp Trial 2.txt');
DOff=tmp_data(:,1);
DOn=tmp_data(:,2);

v=numel(DOff);
time=linspace(0,40,v);

hold on
plot(time,DOff);
plot(time,DOn);