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

%% linearisering i arbejdspunkt (startvinkel)
startAngle = 30; % in degrees
% linmod forventer her at model har netop et input og et output
[A,B,C,D] = linmod('regbot_2mg');
[num,den] = ss2tf(A,B,C,D);
% overføringsfunktion fra hastighed til pitch
Gsp = minreal(tf(num,den))

%% Datasjov
close all

figure(2)
nyquist(Gsp);
figure(3)
bode(Gsp);
grid
figure(4)
pzmap(Gsp);

%% En regulator
% Vi har en hump ved 7.06 rad/s
% I regulator
Ni = 5;
alpha_b = 0.07;


%% simulering af model i 2 sekunder
sim('regbot_3mg', 30);

%% Plots

figure(1)
plot(speed_out);
figure(2)
plot(pitchout);


%% Ny regulator
 figure(4)
 margin(Gsp)
 grid
omega_c = 70;
Ni = 3;
omega_c2 = 15;
Ni2 = 3;
omega_c3 = 20;
alphab = 1;


tau_ib = Ni/omega_c;
tau_db = 1/(omega_c3 * sqrt(alphab));

tau_ib2 = Ni2/omega_c2;

Gib = tf([tau_ib, 1],[tau_ib,0]);
Gib2 = tf([tau_ib2, 1],[tau_ib2,0]);
Gdb = tf([tau_db,0],1);

Kpb = -1.5;

figure(7)
hold off
Gob2 = Gsp*Gib*Gib2*Kpb;
bode(Gob2)
 title('regulede med 2 i-led');
 hold on
 Gob3 = Gsp*Gib*Gib2*Gdb*Kpb;
bode(Gob3)
 hold off

figure(8);
nyquist(Gob3)
title('regulede med 2 i-led');
axis([-2 2 -3 3]);
grid on;
movegui('southeast')

%% simulering i 2 sekunder
sim('regbot_3mg', 5);
