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

Kp_speed = 51.2;
tau_i = 0.025;
tau_d = 0.0091;
alpha = 0.3;
beta = 4;

%% simulering af model i 2 sekunder
sim('regbot_2mg', 2);
%
%% Plots

% figure(1)
% plot(speed_out);


%% linearisering i arbejdspunkt (startvinkel)
startAngle = 30; % in degrees
% linmod forventer her at model har netop et input og et output
[A,B,C,D] = linmod('regbot_1mg');
[num,den] = ss2tf(A,B,C,D);
% overføringsfunktion fra hastighed til pitch
Gsp = minreal(tf(num,den))

%% Datasjov
close all

Kpp = 1;
tauip = 0.2;
Gi = tf([tauip 1],[tauip 0]);


figure(2)
nyquist(Kpp*Gsp*Gi)
hold on
nyquist(Gsp*Kpp);


%% En Frederegulator

Ni = 5;
a = 0.01;
gamma_m = 80;
phi_i = atan(-1/Ni)*180/pi;
phi_m = asin((1-a)/(1+a))*180/pi;
-180 - phi_i - phi_m + gamma_m

omega_c = 3.51e3;
tau_i = Ni/omega_c;
tau_d = 1/(omega_c*sqrt(a));

Gi = tf([tau_i 1],[tau_i 0]);
Gd = tf([tau_d 1],[a*tau_d 1]);

[M,P] = bode(Gi*Gd*Gsp,omega_c);
Kp = 1/M;
Go = Gi*Gsp*Kp;
Gc = Go/(1+Gd*Go);

figure(15)
step(Gc)

figure(16)
margin(Go)
grid
figure(17)
nyquist(Gc)

stepinfo(Gc)