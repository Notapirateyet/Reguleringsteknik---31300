%Vi regnede os frem til det følgende, testede det og konkluderede at der
%var for meget oversving.
%Så håndregulerede vi os frem til mindre oversving, men længdere
%insvingningstid.
%%
% Vi har valgt frq_43

G = tf([52.64 5.011 3.724 0.05889],[1 0.5271 0.1421 0.03397 0.0004442]);

gamma_m = 90;
alphaf = 0.2;
Nif =1;
phi_i = atan(-1/Nif)*180/pi;
phi_m = asin((1-alphaf)/(1+alphaf))*180/pi;
fG = -180 - phi_i - phi_m + gamma_m
figure(1)
bode(G)
title('Ikke reguleret');
grid;

omegaf_c = 7.63;
tauf_i = Nif/omegaf_c;
Ci = tf([tauf_i 1],[tauf_i 0]);
tauf_d = 1/(sqrt(alphaf)*omegaf_c);
Cd = tf([tauf_d 1],[alphaf*tauf_d 1]);
%Kpf er så:
[M,P] = bode(Ci*Cd*G, omegaf_c);
Kpf = 1/M;
% Hvilket giver et åbensløjfe system:
Go = Kpf*G*Ci*Cd;
figure(3);
margin(Go);
title('Reguleret, åben sløjfe');
grid;

Gl = Kpf*G*Ci*Cd/(1+Kpf*G*Ci*Cd);
figure(4);
margin(Gl);
title('Reguleret, lukket sløjfe');
grid;

figure(5);
step(Gl);
title('step, lukket sløjfe');
grid;
