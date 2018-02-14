%Data
data = load('xxx.txt');
figure(100) % start figure 100
yyaxis left % use left y-axis
hold off    % repaint plot
plot(data(:,1), model.data(:,2),'-g','linewidth',2) %m/s
hold on  % keep previous plots
plot(data(:,1), model.data(:,1),'-r','linewidth',2) %A
ylabel('velocity and current')
hold on
yyaxis right
hold off % repaint plots
plot(data(:,1), model.data(:,3),'--m','linewidth',2) %V
axis([0,1,0,5]) % axis limits [x-min, x-max, ymin, ymax]
ylabel('motorsp?nding');
%
legend('Hastighed [m/s]', 'Motorstr?m [A]', 'Motorsp?nding [V]');
xlabel('time [s]');
set(gca,'FontSize',12);
grid on     % show major grid (for left axis)
grid MINOR  % show also fine grid