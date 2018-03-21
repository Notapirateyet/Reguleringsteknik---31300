%%
% Vi har valgt frq_44

G = tf([52.64 5.011 3.724 0.05889],[1 0.5271 0.1421 0.03397 0.0004442]);

gamma_m = 70;
alphaf = 0.2;
Nif = 2;
phi_i = atan(-1/Nif)*180/pi;
phi_m = asin((1-alphaf)/(1+alphaf));
fG = -180 - phi_i - phi_m + gamma_m
figure(1)
bode(G)
title('Ikke reguleret');

omegaf_c = 4.3;
tauf_i = Nif/omegaf_c;
Ci = tf([tauf_i 1],[tauf_i 0]);
tau_d = 1/(sqrt(alphaf)*omegaf_c);
Cd = tf([tau_d 1],[alphaf*tau_d 1]);
%Kpf er så:
[M,P] = bode(Ci*Cd*G, omegaf_c);
Kpf = 1/M;
% Hvilket giver et åbensløjfe system:
Go = Kpf*G*Ci*Cd;
figure(3);
margin(Go);
title('Reguleret, åben sløjfe');

Gl = Kpf*G*Ci*Cd/(1+Kpf*G*Ci*Cd);
figure(4);
margin(Gl);
title('Reguleret, lukket sløjfe');

figure(5);
step(Gl);
title('step, lukket sløjfe');

