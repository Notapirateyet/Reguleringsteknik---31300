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
%% Plot sim
%run("regbot_freja_model");
plot(model.time, model.data(:,2),'-y','linewidth',2) %m/s
plot(model.time, model.data(:,1),'-b','linewidth',2) %A

%% Plot Voltage

ylabel('velocity and current')
hold on
axis([0,1,-1,10])
yyaxis right
hold off % repaint plots
plot(data(:,1), data(:,3),'--m','linewidth',2) %V
axis([0,1,-1,10]) % axis limits [x-min, x-max, ymin, ymax]
ylabel('motorsp?nding');
%
<<<<<<< Updated upstream
legend('Hastighed [m/s]', 'Motorstr�m [A]', 'Hastighed_{sim} [m/s]', 'Motorstr�m_{sim} [A]', 'Motorsp�nding [V]');
xlabel('time [s]');
=======
legend('Hastighed [m/s]', 'Motorstr?m [A]', 'Motorsp?nding [V]');
Xlabel('time [s]');
>>>>>>> Stashed changes
set(gca,'FontSize',12);
grid on     % show major grid (for left axis)
grid MINOR  % show also fine grid

