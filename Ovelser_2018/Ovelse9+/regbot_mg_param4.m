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
Kp_speed = 12;
tau_i = 0.0714;

Kpb = -1.5;
tau_db = 0.05;
alpha_b = 0.07;

tau_ib = 0.0429;
tau_ib2 = 0.200;

Kph = 0.001;
tau_ih = 0.01667;
tau_dh = 3.1623;
alpha_h = 0.1;

%% linearisering i arbejdspunkt (startvinkel)
startAngle = 30; % in degrees
% linmod forventer her at model har netop et input og et output
[A,B,C,D] = linmod('regbot_4mg');
[num,den] = ss2tf(A,B,C,D);
% overføringsfunktion fra motorspænding til hjulhastighed
Gwv = minreal(tf(num,den))
%% simulering af model i 30 sekunder
sim('regbot_5mg', 80);
%%
figure(1)
pzplot(Gwv)
figure(2)
nyquist(Gwv)
grid
figure(3)
margin(Gwv)
grid
%%
Ni = 5;
Ni2 = 5;
alpha = 0.001;
tau_dpos = 1/(sqrt(alpha) * omega_pos);
phi_i = atan(-1/Ni) * 180/pi;
phi_i2 = atan(-1/Ni2) * 180/pi;
gamma_m = 60;
phaase_margin = -180 + gamma_m - phi_i - phi_i2

figure(3)
bode(Gwv)

%%
omega_pos = 0.05;

tau_ipos = Ni/omega_pos;
tau_ipos2 = Ni2/omega_pos;

Gipos = tf([tau_ipos, 1],[tau_ipos,0]);
Gdpos = tf([tau_dpos, 1],[tau_dpos*alpha,1]);
Gipos2 = tf([tau_ipos2, 1],[tau_ipos2,0]);
[Mpos,Ppos] = bode(Gwv*Gipos*Gipos2,omega_pos);
Kpos = (1/Mpos);
Kpos = Kpos/2;
figure(5);
Gopos = Gwv*Kpos*Gipos*Gipos2
Gcpos = Gopos/(1+Gopos)
step(Gcpos);
figure(6);
margin(Gopos);

figure(7);
nyquist(Gopos);