% Freja (4)
%  1    time 0.000 sec
%  2  3 Motor voltage [V] left, right: 0.00 0.00
%  4  5 Wheel velocity [m/s] left, right: -0.0000 -0.0000
%  6 15 ctrl left , ref=0, m=-0, m2=0, uf=0, r2=0, ep=0,up=0, ui=0, u1=0, u=0
% 16 25 ctrl right, ref=0, m=-0, m2=0, uf=0, r2=0, ep=0,up=0, ui=0, u1=0, u=0
%% Load data

data = load('data1.txt');

%%
close all
figure(1)
%plot(data(:,1),data(:,2))
hold on
plot(data(:,1),data(:,4))
%legend('Motor voltage', 'Wheel velocity')
hold off

