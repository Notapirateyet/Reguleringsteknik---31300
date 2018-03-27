%
%
%   
% --------------------

%% Analyse a system
sys_42 = tf([1.003e-05 1.248e-05 3.282e-06],[1 1.439 0.5805 0.085 0.00393]);

gamma_m = 60;
alpha = 0.2;
Ni = 10;
phi_i = atan(-1/Ni);
phi_m = asin((1-alpha)/(1+alpha));
phi = -180 + gamma_m - phi_i - phi_m
figure(10)
bode(sys_42)
omega_c = 0.1595;
phi_i = atan(-1/Ni)*180/pi;
%aflæst fra figur 1
tau_i = Ni/omega_c;
tau_d = 1/(sqrt(alpha)*omega_c);

Gi = tf([tau_i 1],[tau_i 0]);
Gl = tf([tau_d 1],[alpha*tau_d 1]);

[M,P] = bode(Gl*Gi*sys_42,omega_c);
Kp = 1/M;

Gopen = Gi*Gl*Kp*sys_42;
Gclosed = Gopen/(1+Gopen);
figure(30)
hold on
bode(Gopen);
bode(sys_42);
legend("Uden regulator", "Open loop");
hold off
%% Konstanter til regulering

stepsize = 1;

% I skal ændres manuelt i modellen


%% Simuler
sim('tfAfDamp', 250);

figure;
plot(tryk_app);
xlabel('Tid [s]');
ylabel('Tryk i guess [atm]');
