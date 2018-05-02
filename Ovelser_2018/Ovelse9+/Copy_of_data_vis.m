% Freja (4)
%  1    time 0.000 sec
%  2  3 Motor voltage [V] left, right: 3.62 3.62
%  4  5 Wheel velocity [m/s] left, right: -0.0000 0.0000
%  6  7  8  9 Pose x,y,h,tilt [m,m,rad,rad]: 0 0 0 -3.0872
%% Load data

data = load('hastighed_og_balance.txt');

%%
sim('regbot_2mg.slx',1);


%%
close all
figure(1)
hold on
plot(data(:,1),data(:,2));
plot(speed_out);
legend('Measurement', 'Simulation')
title(' ');
ylabel('velocity');
axis([0, 31, -1.6, 1.6]);
hold off

figure(2)
hold on
plot(data(:,1),data(:,7));
plot(pitchout);
legend('Measurement', 'Simulation')
title(' ');
ylabel('pitch');
axis([0, 31,-0.2, 0.6]);
hold off


