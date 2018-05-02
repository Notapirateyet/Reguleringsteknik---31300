close all
clear
%% logfile from robot Freja (4)
% Freja (4)
%  1    time 0.008 sec
%  2  3  4  5 Pose x,y,h,tilt [m,m,rad,rad]: 0.00162272 -5.30893e-07 0 0.451635
%% plotting the balance - 10 s 
data = load('10s_tilt_log.txt');
figure(100)
plot(data(:,1),data(:,5))
xlabel('Time [s]')
ylabel('Tilt [rad]')
axis([0 10.4 -0.2 0.5]);

%% plotting the balance - 30 s with extrenet input

data = load('30s_tilt_m_ekstern_forstyrrese.txt');
figure(110)
yyaxis left
plot(data(:,1),data(:,5))
xlabel('Time [s]')
ylabel('Tilt [rad]')
hold on 
yyaxis right
plot(data(:,1),data(:,2));
ylabel('x[m]')
legend('Tilt','Position in x-direction')
hold off

figure(112)
plot(data(:,2),data(:,3),'r');
xlabel('x[m]')
ylabel('y[m]')
color('r');
%% plotting simulated data - I hope

figure(120)
plot(pitchout.Time,pitchout.Data)
xlabel('Time [s]')
ylabel('Tilt [rad]')

%% plot af balance/hastighed regulator - simuleret
close all
figure(130)
yyaxis left
plot(pitchout.Time,pitchout.Data,'LineWidth',2)
xlabel('Time [s]','FontSize', 14)
ylabel('Tilt [rad]','FontSize', 14)
hold on 
yyaxis right
plot(speed_out.Time,speed_out.Data,'LineWidth',2)
ylabel('Velocity [rad]','FontSize', 14)
legend('Tilt','Velocity')
hold off

%% plot af balance/hastighed regulator - logget data
close all
%logfile from robot Freja (4)
% Freja (4)
%  1    time 0.021 sec
%  2  3 Wheel velocity [m/s] left, right: 0.4871 0.4185
%  4  5  6  7 Pose x,y,h,tilt [m,m,rad,rad]: 0.00709941 -6.10527e-06 -0.0026173 0.417936

data = load('velocity_balance_30s.txt');
figure(140)
yyaxis left
plot(data(:,1),data(:,7),'b','LineWidth',2)
xlabel('Time [s]','FontSize', 14)
ylabel('Tilt [rad]','FontSize', 14)
hold on 
yyaxis right
plot(data(:,1),data(:,2),'g','LineWidth',2);
ylabel('Velocity [m/s]','FontSize', 14)
linewidth = 2;
hold on 
plot(data(:,1),data(:,3),'-','LineWidth',1.5);
legend('Tilt','Left wheel velocity','Right wheel velocity')
xlim([0 30]);
hold off
