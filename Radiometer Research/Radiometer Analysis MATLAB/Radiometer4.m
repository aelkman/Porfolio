tmp_data=importdata('C:\Users\Alex\Desktop\Radiometer Experiment MATLAB\Results 3.txt');

DOff=tmp_data(:,1);
DOn=tmp_data(:,2);

c_mean=mean2(DOff);
m_mean=mean2(DOn);
scale=m_mean/c_mean;

DOnF=(DOn./m_mean);
DOffF=(DOff./c_mean);

DOnF=DOnF-scale.*DOffF;
DOffF=DOffF-(scale).*DOnF;
DOnF=smooth(DOnF*sqrt(2));
DOffF=smooth(DOffF-1.2);
%DOffF=DOffF - mean2(DOffF);

diff = smooth(DOnF + DOffF);

v=numel(DOnF);
time=linspace(0,60,v);

figure % create new figure
subplot(2,2,[1 2]) % first subplot
plot(time,-DOnF, time, DOffF)
title('DICKE ON/OFF')

subplot(2,2, [3 4])
plot(time, diff)
title('DIFFERENCE ON/OFF')

hold off