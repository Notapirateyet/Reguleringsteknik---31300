close all
clear
data = load('balance_log.txt');
%% logfile from robot Freja (4)
% Freja (4)
%  1    time 0.013 sec
%  2 11 ctrl balance, ref=0, m=0.435206, m2=0.419413, uf=0, r2=0, ep=0.62912,up=0.62912, ui=0.204522, u1=0.833642, u=0.884556

%% plotting the balance - hopefully

figure(100)
plot(data(:,1),data(:,2))
hold on
plot(data(:,1),data(:,3))
hold on
plot(data(:,1),data(:,4))
hold on
plot(data(:,1),data(:,5))
hold on
plot(data(:,1),data(:,6))
hold on
plot(data(:,1),data(:,7))
hold on
plot(data(:,1),data(:,8))
hold on 
plot(data(:,1),data(:,9))
hold on
plot(data(:,1),data(:,10))
hold on
plot(data(:,1),data(:,11))
legend('ref=0', 'm=0.435206', 'm2=0.419413', 'uf=0', 'r2=0', 'ep=0.62912','up=0.62912', 'ui=0.204522', 'u1=0.833642', 'u=0.884556');
hold off

%Efter visuel inspektion... har jeg stadig ingen ide om hvilken en af de
%her er ti
