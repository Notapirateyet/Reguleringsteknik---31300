% Freja (4)
%  1    time 0.000 sec
%  2  3 Motor voltage [V] left, right: 3.62 3.62
%  4  5 Wheel velocity [m/s] left, right: -0.0000 0.0000
%  6  7  8  9 Pose x,y,h,tilt [m,m,rad,rad]: 0 0 0 -3.0872
%% Load data

data = load('hastigregdata_1.txt');

%%
sim('regbot_2mg.slx',1);


%%
close all
figure(1)
hold on
plot(data(:,1),data(:,4));
plot(speed_out);
legend('Measurement', 'Simulation')
title(' ');
axis([0, 0.4, -0.2, 1.2]);
hold off

figure(2)
hold on
plot(data(:,1),data(:,2));
plot(motor_voltage_out);
legend('Measurement', 'Simulation')
title(' ');
axis([0, 0.4, 0, 10]);
hold off


