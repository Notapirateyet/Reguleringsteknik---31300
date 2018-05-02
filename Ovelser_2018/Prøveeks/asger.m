funk1 = tf(600, [1 0.1]);
funk2 = tf(1, [1 20]);
funk3 = tf(1, [1 30]);
funks = funk1*funk2*funk3;

[M,P] = bode(funks, 6.9);
1/M;

%% 2) PI-LEAD
% Vi vælger
alpha = 0.2;
Ni = 3;
gamma_m = 60;

phi_i = atan(-1/Ni) * 180/pi;
phi_m = asin((1-alpha)/(1+alpha)) * 180/pi;
find = -180 + gamma_m - phi_m - phi_i

figure(2)
bode(funks)
title('Bode, uden regulering');

% fundet 1.22
wc = 12.8;

% I-led
tau_i = Ni/wc;
Gi = tf([tau_i 1],[tau_i 0]);

% D-led
tau_d = 1/(wc*sqrt(alpha));
Gd = tf([tau_d 1],[alpha*tau_d 1]);

% Kp-led
[M,P] = bode(Gi*Gd*funks, wc);
Kp = 1/M;

figure(3)
bode(Gi*Gd*H*Kp)

%% Opgave 4

omegan = 32;
K = omegan^2;

zeta = 1;

G = tf([K], [1, 2*zeta*omegan, omegan^2]);
step(G)
grid
%% Uh
[num,den] = pade(2,10);
sys = tf(num,den);

kp = 2;
ti = 10;
regul = kp*tf([ti 1], [ti 0]);

figure(7)
step(regul*sys);
