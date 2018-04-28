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
%%
figure(1)
margin(Gwv)
%%
omega_pos = 10;
Ni = 5;
alpha = 0.001;
tau_ipos = Ni/omega_pos;
tau_dpos = 1/(sqrt(alpha) * omega_pos);

Gipos = tf([tau_ipos, 1],[tau_ipos,0]);
Gdpos = tf([tau_dpos, 1],[tau_dpos*alpha,1]);
[Mpos,Ppos] = bode(Gwv*Gipos*Gdpos,omega_pos);
Kpos = 1/Mpos;

figure(5);
Gopos = Gwv*Kpos*Gipos
Gcpos = Gopos/(1+Gopos*Gdpos)
step(Gcpos);
figure(6);
margin(Gopos);