tmp_data=importdata('C:\Users\Alex\Desktop\Radiometer Experiment\Radiometer LNO2 Temp Trial 1.txt');
DOff=tmp_data(:,1);
DOn=tmp_data(:,2);
mean=(DOff+DOn)./2;

v=numel(mean);
time=linspace(0,40,v);

plot(time,mean);