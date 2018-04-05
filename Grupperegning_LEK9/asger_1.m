%% 1) Systemet
% Vi har at systemet er et 1. ordens, og derefter gætter vi 
% kontanterne ud fra
% (tau*b) / (tau*s + 1)
b = 0.5;
tau = 10;

H = tf(tau*b,[tau 1]);
%figure(1)
%step(H);

%% 2) PI-LEAD
% Vi vælger
alpha = 0.7;
Ni = 1;
gamma_m = 60;

phi_i = atan(-1/Ni) * 180/pi;
phi_m = asin((1-alpha)/(1+alpha)) * 180/pi;
find = -180 + gamma_m - phi_m - phi_i

figure(2)
bode(H)
title('Bode, uden regulering');

% fundet 1.22
wc = 1.22;

% I-led
tau_i = Ni/wc;
Gi = tf([tau_i 1],[tau_i 0]);

% D-led
tau_d = 1/(wc*sqrt(alpha));
Gd = tf([tau_d 1],[alpha*tau_d 1]);

% Kp-led
[M,P] = bode(Gi*Gd*H, wc);
Kp = 1/M;

figure(3)
bode(Gi*Gd*H*Kp)
%% Mult
figure(7)
bode(tf([22 220],[1 1]))
figure(8)
bode(tf([220 220], [10 1]))


