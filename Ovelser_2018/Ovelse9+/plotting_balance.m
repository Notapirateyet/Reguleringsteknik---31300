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