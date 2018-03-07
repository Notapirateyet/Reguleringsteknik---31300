G1 = tf(9000, [100 6001 90060 900]);
Ni = 2;
alpha = 0.1; 
gamma_M = 70; %Degrees

phi_i = atan(-1/Ni); %rad
phi_i = phi_i*180.0/pi; %Degrees
phi_m = asin((1-alpha)/(1+alpha)); %rad
phi_m = phi_m*180/pi; % Degrees
phi_im = phi_i + phi_m; %deg
mellemregning = -180 + gamma_M - phi_m - phi_i;
%bode(G1)  % Udkommenter og aflæs frekvens ved fasedrejning mellemregnin
omega_c = 12.8; %Aflæst
% I-led
tau_i = Ni/omega_c;
Gi = tf([tau_i 1],[tau_i 0]);
% Lead-led
tau_d = 1/(omega_c*sqrt(alpha));
Gd = tf([tau_d 1],[alpha*tau_d 1]);
% Kp
[M,P] = bode(Gi*Gd*G1, omega_c);
Kp = 1/M;
% Tjek
margin(Kp*Gi*Gd*G1)


%% Multiple choice 1

gamma_M = 60;
alpha = 0.1;
G1 = tf(2.2, [0.4 1]);
G2 = tf(1,[1 0]);
H = tf(1, [0.02 1]);


phi_m = asin((1-alpha)/(1+alpha)); %rad
phi_m = phi_m*180/pi; % Degrees
mellemregning = -180 + gamma_M - phi_m;
figure(99);
bode(G1*G2*H);
omega_c = 9;
% Lead led
tau_d = 1/(omega_c*sqrt(alpha));
Gd = tf([tau_d 1],[alpha*tau_d 1]);
% Kp
[M,P] = bode(G2*Gd*G1*H, omega_c);
Kp = 1/M;

closedloop_f = G1*G2*Kp*Gd/(1 + G1*G2*Kp*Gd*H);

figure(98);
step(closedloop_f);
stepinfo(closedloop_f);

figure(80)
closedloop_b = G1*G2*Kp/(1 + G1*G2*Kp*Gd*H);
step(closedloop_b);
stepinfo(closedloop_b)

%% Mult2

gamma_M = 50;
alpha = 0.2;
Ni = 3;
G1 = tf(120, [0.01 1]);
G2 = tf(1,[0.0025 0.04 1]);
H = tf(1, [0.001 1]);

phi_i = atan(-1/Ni); %rad
phi_i = phi_i*180.0/pi; %Degrees
phi_m = asin((1-alpha)/(1+alpha)); %rad
phi_m = phi_m*180/pi; % Degrees
phi_im = phi_i + phi_m; %deg
mellemregning = -180 + gamma_M - phi_m - phi_i;
figure(70);
bode(G1*G2*H)  % Udkommenter og aflæs frekvens ved fasedrejning mellemregnin
omega_c = 28.8; %Aflæst
% I-led
tau_i = Ni/omega_c;
Gi = tf([tau_i 1],[tau_i 0]);
% Lead-led
tau_d = 1/(omega_c*sqrt(alpha));
Gd = tf([tau_d 1],[alpha*tau_d 1]);
% Kp
[M,P] = bode(Gi*Gd*G1, omega_c);
Kp = 1/M;
% Tjek
% closedloop_f = G1*G2*Kp*Gd/(1 + G1*G2*Kp*Gd*H);
% 
% figure(98);
% step(closedloop_f);
% stepinfo(closedloop_f);
% 
% figure(80)
% closedloop_b = G1*G2*Kp/(1 + G1*G2*Kp*Gd*H);
% step(closedloop_b);
% stepinfo(closedloop_b)

%% Multiple choice 3

gamma_M = 40;
alpha = 0.1;
G1 = tf(2, [0.05 1]);
G2 = tf(1,[1 0 0]);
H = tf(1, [0.002 1]);


phi_m = asin((1-alpha)/(1+alpha)); %rad
phi_m = phi_m*180/pi; % Degrees
mellemregning = -180 + gamma_M - phi_m;
figure(60);
bode(G1*G2*H);
omega_c = 4.82;
% Lead led
tau_d = 1/(omega_c*sqrt(alpha));
Gd = tf([tau_d 1],[alpha*tau_d 1]);
% Kp
[M,P] = bode(G2*Gd*G1*H, omega_c);
Kp = 1/M;

closedloop_f = G1*G2*Kp*Gd/(1 + G1*G2*Kp*Gd*H);

figure(61);
step(closedloop_f);
stepinfo(closedloop_f)

