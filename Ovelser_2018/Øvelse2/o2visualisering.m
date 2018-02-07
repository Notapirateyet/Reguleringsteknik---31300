close all
clear
%%
data = load('O2D12.txt');
%% logfile from robot Freja (4)
% Freja (4)
%  1    time 0.000 sec
%  2  3 Motor voltage [V] left, right: 1.20 1.20
%  4  5 Wheel velocity [m/s] left, right: 0.0000 0.0000
%  6  7  8  9 Pose x,y,h,tilt [m,m,rad,rad]: 0 0 0 -3.11947
%% Plotting

figure(98)
subplot(2,1,1);
plot(data(:,1), data(:,2), 'b')
hold on
plot(data(:,1), data(:,3), 'r')
set(gca,'FontSize',12)
grid on
grid MINOR
title('Robot Freja (4), Manual tuning, Kp=10')
xlabel('Time [s]')
ylabel('Motor voltage [V]')
legend('Left', 'Right')
%axis equal

subplot(2,1,2);
plot(data(:,1), data(:,4), 'b')
hold on
plot(data(:,1), data(:,5), 'r')
set(gca,'FontSize',12)
grid on
grid MINOR
%title('Robot Freja (5), Manual tuning')
xlabel('Time [s]')
ylabel('Motor speed [m/s]')
legend('Left', 'Right')
%axis equal

%print('O2D1','-dpng');