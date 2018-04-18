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

%% En cmosgulator
% Vi har en hump ved 7.06 rad/s
% I regulator
Ni = 5;
tau_ib = Ni/7.06;
gi = tf([tau_ib 1],[tau_ib 0]);
% D-regulator
alpha_b = 0.01;
omega_c = 7.06;
tau_db = 1/(omega_c*sqrt(alpha_b));
gd = tf([tau_db 1],1);
[M,P] = bode(Gsp*gi*gd,omega_c);
Kp_b = -8;
% Post regulator
tau_ibp = 0.1;
if (tau_ibp ~= 0)
    gip = tf([tau_ibp 1],[tau_ibp 0]);
else
    gip = 1;
end
% Plots
figure(5)
nyquist(gd*Kp_b*Gsp*gi*gip);
figure(7)
bode(Kp_b*Gsp*gi*gip);

Gcl = (Gsp*gi*Kp_b*gip)/(1+gd*Gsp*gi*Kp_b*gip);
figure(6)
step(Gcl)

%% simulering af model i 2 sekunder
sim('regbot_3mg', 2);

%% Plots

figure(1)
plot(speed_out);
figure(2)
plot(pitchout);








