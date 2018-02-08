close all
clear
%% Data
data = load('O2D1_line.txt');

%% Freja (4)
%  1    time 0.000 sec
%  2  3 Motor voltage [V] left, right: 0.00 0.00
%  4  5 Wheel velocity [m/s] left, right: -0.0000 -0.0000
% 6 7 Turnrate [r/s]: 0.0000, steer angle [rad]: 0.0000
%  8  9 10 11 Pose x,y,h,tilt [m,m,rad,rad]: 0 0 0 3.07458
%% Plotting

figure(98)
subplot(2,2,1);
plot(data(:,1), data(:,2), 'b')
hold on
plot(data(:,1), data(:,3), 'r')
set(gca,'FontSize',12)
grid on
grid MINOR
title('Robot Freja (4), Manual tuning, 3 speeds, Kp = 12, Kf = 3.5')
xlabel('Time [s]')
ylabel('Motor voltage [V]')
legend('Left', 'Right')
%axis equal

subplot(2,2,2);
plot(data(:,1), data(:,10)*180/pi, 'b')
hold on
%plot(data(:,1), data(:,5), 'r')
set(gca,'FontSize',12)
grid on
grid MINOR
%title('Robot Freja (5), Manual tuning')
xlabel('Time [s]')
ylabel('Heading [deg]')
%legend('Left', 'Right')
axis([0 2.5 -10 10])

%% More plots

subplot(2,2,3);
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

subplot(2,2,4);
plot(data(:,8), data(:,9), 'b')
hold on
%plot(data(:,1), data(:,3), 'r')
set(gca,'FontSize',12)
grid on
grid MINOR
%title('Robot Freja (5), Manual tuning')
xlabel('x [m]')
ylabel('y [m]')
%legend('Left', 'Right')
axis equal

%print('O2D14','-dpng');