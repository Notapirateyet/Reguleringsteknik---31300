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

%% simulering af model i 2 sekunder
sim('regbot_4mg', 2);
%
%% linearisering i arbejdspunkt (startvinkel)
startAngle = 30; % in degrees
% linmod forventer her at model har netop et input og et output
[A,B,C,D] = linmod('regbot_3mg');
[num,den] = ss2tf(A,B,C,D);
% overføringsfunktion fra motorspænding til hjulhastighed
Gwv = minreal(tf(num,den))
%% Vi regner med den
figure(10);
Kph = 0.21;
margin(Kph*Gwv);
grid();
%% Den nedenst�ende regulator virker ikke.
figure(11);
margin(Gwv);


omega_c = 3;
Ni = 12;
alpha_h = 0.9;

tau_ih = Ni/omega_c;
tau_dh = 1/(omega_c * sqrt(alpha_h));
Kp = -0.21;
Gih = tf([tau_ih, 1],[tau_ih,0]);
Gdh = tf([tau_dh,1],[alpha_h*tau_dh,1]);
[Mh,Ph] = bode(Gih*Gwv*Gdh,omega_c);



figure(5);
Goh = Gwv*Gih*Kph
Gch = Goh/(1+Goh*Gdh)
step(Gch);

figure(6);
nyquist(Gwv*Gih*Kph*Gdh);
axis([-2 2 -2 2])

figure(7);
%pzplot(Gwv)
margin(Gwv*Gih*Kph*Gdh);
%%
figure(12);
margin(Gch);
grid();
%% simulering af model i 2 sekunder
sim('regbot_4mg', 30);

%%
figure(13)
pzplot(Gch)