close all
clear
%%
dataCV = load('Log1CW1.txt');
dataCCV = load('Log1CCW1.txt');
%% logfile from robot Freja (4)
% Freja (4)
%  1    time 0.007 sec
%  2  3  4  5   (mission 0), state 2, entered (thread 1, line 0), events 0x0 (bit-flags)
%  6  7 Motor voltage [V] left, right: 2.00 2.00
%  8  9 Motor current left, right [A]: -0.094 0.084
% 10 11 Wheel velocity [m/s] left, right: 0.0000 -0.0000
% 12 13 14 15 Pose x,y,h,tilt [m,m,rad,rad]: 0 0 0 -0.672605
% 16    Battery voltage [V]: 12.50
%% plot path
figure(100)
plot(dataCV(:,12), dataCV(:,13), 'b')
hold on
plot(dataCCV(:,12), dataCCV(:,13), 'r')
set(gca,'FontSize',12)
grid on
grid MINOR
%title('Robot Birte (60), Square - no controller')
xlabel('X [m]')
ylabel('Y [m]')
legend('CV square', 'CCV square')
axis equal
print('square_no_control','-dpng');

%Afstand
dxCV = dataCV(end,12) - dataCV(1,12);
dyCV = dataCV(end,13) - dataCV(1,13);


dxCCV = dataCCV(end,12) - dataCCV(1,12);
dyCCV = dataCCV(end,13) - dataCCV(1,13);

%% Voltage

figure(101)
subplot(2,1,1);
hold on
grid on
plot(dataCV(:,1),dataCV(:,6), 'c');
plot(dataCV(:,1),dataCV(:,7), 'm');
xlabel('Time [s]')
ylabel('Motor Voltage [V]')
legend('CV Left', 'CV Right')

subplot(2,1,2);
hold on
grid on
plot(dataCCV(:,1),dataCCV(:,6), 'c');
plot(dataCCV(:,1),dataCCV(:,7), 'm');
legend('CCV Left', 'CCV Right')
xlabel('Time [s]')
ylabel('Motor Voltage [V]')
print('motor_no_control','-dpng');