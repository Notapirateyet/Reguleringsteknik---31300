%%
% Vi har valgt frq_44

G = tf([52.64 5.011 3.724 0.05889],[1 0.5271 0.1421 0.03397 0.0004442]);

gamma_m = 70;
alpha = 0.2;
Ni = 2;
phi_i = atan(-1/Ni)*180/pi;
phi_m = asin((1-alpha)/(1+alpha));
fG = -180 - phi_i - phi_m + gamma_m
figure(1)
bode(G)
title('Ikke reguleret');

omega_c = 4.3;
tau_i = Ni/omega_c;
Ci = tf([tau_i 1],[tau_i 0]);
tau_d = 1/(sqrt(alpha)*omega_c);
Cd = tf([tau_d 1],[alpha*tau_d 1]);
%Kp er så:
[M,P] = bode(Ci*Cd*G, omega_c);
Kp = 1/M;
% Hvilket giver et åbensløjfe system:
Go = Kp*G*Ci*Cd;
figure(3);
margin(Go);
title('Reguleret, åben sløjfe');

Gl = Kp*G*Ci*Cd/(1+Kp*G*Ci*Cd);
figure(4);
margin(Gl);
title('Reguleret, lukket sløjfe');

figure(5);
step(Gl);
title('step, lukket sløjfe');

