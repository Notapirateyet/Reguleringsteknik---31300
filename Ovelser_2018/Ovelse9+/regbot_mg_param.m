%% mekanisk_model_regbot
close all
clear
%% parametre
% motor
RA = 3.3;    % ohm
JA = 1.3e-6; % motor inerti
LA = 6.6e-3; % ankerspole
BA = 3e-6;   % ankerfriktion
Kemf = 0.0105; % motorkonstant
% køretøj
NG = 9.69; % gear
WR = 0.03; % hjul radius
% motor driver
vaLimit = 9;
%
%% model af balancerende pendul
mmotor = 0.193;   % samlet masse af motor og gear
mframe = 0.32;    % samlet masse af ramme og print
mtopextra = 0.27; % 0.27; % extra masse på top
mpdist =  0.10;   % afstand til låg
% start vinkel
startAngle = 30; % in degrees
% forstyrrelse - skub position (Z)
pushDist = 0.1;
%
%% Hastighedsregulator

Kp_speed = 200;

%% simulering af model i 2 sekunder
sim('regbot_1mg', 2);
%
%% linearisering i arbejdspunkt (startvinkel)
startAngle = 30; % in degrees
% linmod forventer her at model har netop et input og et output
[A,B,C,D] = linmod('regbot_1mg');
[num,den] = ss2tf(A,B,C,D);
% overføringsfunktion fra motorspænding til hjulhastighed
Gwv = minreal(tf(num,den))
%%
% Gwv;
close all
figure(10)
margin(Gwv)
grid()
figure(11)
pzmap(Gwv)

%% Se p� tf
figure(1)
bode(Gwv)
figure(2)
step(Gwv)

Ni = 5;
a = 0.3;
gamma_m = 60;
phi_i = atan(-1/Ni)*180/pi;
phi_m = asin((1-a)/(1+a))*180/pi;
-180 - phi_i - phi_m + gamma_m

omega_c = 200;

tau_i = Ni/omega_c;
tau_d = 1/(omega_c*sqrt(a));

beta = 4;
Gi = tf([tau_i 1],[tau_i 1/beta]);
Gd = tf([tau_d 1],[a*tau_d 1]);

[M,P] = bode(Gi*Gd*Gwv,omega_c);
Kp = 1/M;
Go = Gi*Gwv*Kp;
Gc = Go/(1+Gd*Go);

figure(15)
step(Gc)

figure(16)
margin(Go)
grid

stepinfo(Gc)

%% plotting stuff
figure(1);
bode(Gwv);
movegui('northwest');
figure(2);
nyqui   st(-1*Gwv)
movegui('southwest');
hold on
nyquist(-8*Gwv)
figure(3);
step(Gwv)
axis([0 150*10^(-3) 0 1])
%% PI-regulator:
Ni = 9;
%alpha = 0.2;
gammaM = 60 * pi/180;

phi_i = atan(-1/Ni);

angleG = (-pi + gammaM-phi_i) * (180/pi) %-108.6901
omega_c = 97;
tau_i = Ni/omega_c;

Gi = tf([tau_i, 1],[tau_i,0]);

[M,P] = bode(Gi*Gwv,omega_c);
Kp = 1/M;

figure(4);
Gpi = (Gwv*Gi*Kp)/(1+Gwv*Gi*Kp);
step(Gpi);
stepinfo(Gpi)

%% %% PID-regulator:
Ni = 1;
alpha = 0.2;
gammaM = 80 * pi/180;

phi_i = atan(-1/Ni);
phi_m = asin((1-alpha)/(1+alpha));
phi_mi = phi_i + phi_m;

angleG = (-pi + gammaM - phi_mi) * (180/pi)

omega_c = 103;
tau_i = Ni/omega_c;
tau_d = 1/(omega_c * sqrt(alpha));

Gi = tf([tau_i, 1],[tau_i,0]);
Gd = tf([tau_d,1],[alpha*tau_d,1]);

[M,P] = bode(Gi*Gd*Gwv,omega_c);
Kp = 1/M;

figure(5);
Gpid = (Gwv*Gi*Kp)/(1+Gwv*Gd*Gi*Kp);
step(Gpid);
stepinfo(Gpid)

figure(6);
bode(Gpid)
%% Vi laver en ny med Kp mellem 10 og 20
Gwv;
figure(10)
margin(Gwv)
grid()
%%
figure(4)
bode(Gwv);
omega_c = 70;
Ni = 5;
alpha = 0.5;

tau_i = Ni/omega_c;
tau_d = 1/(omega_c * sqrt(alpha));

Gi = tf([tau_i, 1],[tau_i,0]);
Gd = tf([tau_d,1],[alpha*tau_d,1]);
[M,P] = bode(Gi*Gwv,omega_c);
Kp = 12;
figure(7);
Go = Gwv*Gi*Kp
Gc = Go/(1+Go)
step(Gc);
title('omega_c = 50,Ni = 10,alpha=0.5')
grid();
axis([0 0.5 0 1.3]);
figure(99)
nyquist(Go);
grid()
figure(98)
margin(Go)
grid

%% Get plot

sim('regbot_2mg.slx',1);
figure(69); % nice
plot(speed_out);




