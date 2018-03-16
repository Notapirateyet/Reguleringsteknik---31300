%
%
%   
% --------------------

%% Analyse a system

Ni = 5;
phi_i = atan(-1/Ni)*180/pi;
phi = -180 + 60 - phi_i;
%aflæst fra figur 1
omega_c = 0.156;
tau_i = Ni/omega_c;
Gi = tf([tau_i 1],[tau_i 0]);
[M,P] = bode(Gi*sys_42,omega_c);
Kp = 1/M;
%% Konstanter til regulering

stepsize = 1;

% I skal ændres manuelt i modellen


%% Simuler
sim('tfAfDamp', 250);

figure;
plot(tryk_app);
xlabel('Tid [s]');
ylabel('Tryk i guess [atm]');
