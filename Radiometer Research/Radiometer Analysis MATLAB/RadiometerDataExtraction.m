tmp_data=importdata('C:\Users\Alex\Desktop\Radiometer Experiment\Radiometer Constant Temp Trial 2.txt');

DOff=tmp_data(:,1);
DOn=tmp_data(:,2);

c_mean=mean2(DOff);
m_mean=mean2(DOn);
scale=m_mean/c_mean;

DOnF=(DOn./m_mean);
DOnF=DOnF-mean2(DOnF);
DOffF=(DOff./c_mean);
DOffF=DOffF-mean2(DOffF);

v=numel(final_output);
time=linspace(0,40,v);

hold on

%plot(time, DOnF);
plot(time, DOffF);

hold off