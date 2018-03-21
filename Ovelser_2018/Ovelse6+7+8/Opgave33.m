%%
% Vi har valgt frq_44

G = tf([0.2191 3.988 0.3878 0.2822 0.004053],[1 5.225 4.758 0.7295 0.009386]);

gamma_m = 100;
alpha = 1;
Ni = 1;
phi_i = atan(-1/Ni)*180/pi;
phi_m = asin((1-alpha)/(1+alpha));
fG = -180 - phi_i - phi_m + gamma_m
figure(1)
bode(G)
title('Ikke reguleret');

omega_c = 0.178;
tau_i = Ni/omega_c;
Ci = tf([tau_i 1],[tau_i 0]);
tau_d = 1/(sqrt(alpha)*omega_c);
Cd = tf([tau_d 1],[alpha*tau_d 1]);
%Kp er så:
[M,P] = bode(Ci*Cd*G, omega_c);
Kp = 1/M;
% Hvilket giver et åbensløjfe system:
figure(3);
margin(Kp*G*Ci*Cd);
title('Reguleret, åben sløjfe');

figure(4);
margin(Kp*G*Ci*Cd/(1+Kp*G*Ci*Cd));
title('Reguleret, lukket sløjfe');
