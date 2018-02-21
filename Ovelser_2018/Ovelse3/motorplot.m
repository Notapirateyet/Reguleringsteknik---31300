%Data
data = load('3_6V.txt');
% Freja (4)
%  1    time 0.000 sec
%  2  3 Motor voltage [V] left, right: 3.00 3.00
%  4  5 Motor current left, right [A]: 0.135 0.132
%  6  7 Wheel velocity [m/s] left, right: 0.0000 0.0000
figure(99) % start figure 100
yyaxis left % use left y-axis
hold off    % repaint plot
plot(data(:,1), data(:,7),'-g','linewidth',2) %m/s
hold on  % keep previous plots
plot(data(:,1), data(:,5),'-r','linewidth',2) %A
ylabel('velocity and current')
hold on
axis([0,1,-1,10])
yyaxis right
hold off % repaint plots
plot(data(:,1), data(:,3),'--m','linewidth',2) %V
axis([0,1,-1,10]) % axis limits [x-min, x-max, ymin, ymax]
ylabel('motorsp?nding');
%
legend('Hastighed [m/s]', 'Motorstr?m [A]', 'Motorsp?nding [V]');
xlabel('time [s]');
set(gca,'FontSize',12);
grid on     % show major grid (for left axis)
grid MINOR  % show also fine grid

