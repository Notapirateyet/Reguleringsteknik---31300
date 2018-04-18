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
% kÃ¸retÃ¸j
NG = 9.69; % gear
WR = 0.03; % hjul radius
% motor driver
vaLimit = 9;
%
%% model af balancerende pendul
mmotor = 0.193;   % samlet masse af motor og gear
mframe = 0.32;    % samlet masse af ramme og print
mtopextra = 0.27; % 0.27; % extra masse pÃ¥ top
mpdist =  0.10;   % afstand til lÃ¥g
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
% overfÃ¸ringsfunktion fra hastighed til pitch
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
alpha_b = 0.01;
omega1 = 100; %Ændre i den her
omega2 = 2*omega1; %giver fire frekvenser med steps på den valgte omega1
omega3 = 3*omega1;
omega4 = 4*omega1;
%4 regulatorer laves fra valgte frekvenser:
%i led laves
tau_ib1 = Ni/omega1;
gi1 = tf([tau_ib1 1],[tau_ib1 0]);

tau_ib2 = Ni/omega2;
gi2 = tf([tau_ib2 1],[tau_ib2 0]);

tau_ib3 = Ni/omega3;
gi3 = tf([tau_ib3 1],[tau_ib3 0]);

tau_ib4 = Ni/omega4;
gi4 = tf([tau_ib4 1],[tau_ib4 0]);

%lead led laves:
tau_db1 = 1/(omega1*sqrt(alpha_b));
gd1 = tf([tau_db1 1],1);

tau_db2 = 1/(omega2*sqrt(alpha_b));
gd2 = tf([tau_db2 1],1);

tau_db3 = 1/(omega3*sqrt(alpha_b));
gd3 = tf([tau_db3 1],1);

tau_db4 = 1/(omega4*sqrt(alpha_b));
gd4 = tf([tau_db4 1],1);

%Kp findes
[M1,P1] = bode(Gsp*gi1*gd1,omega1);
Kp_b1 = -1/M1;

[M2,P2] = bode(Gsp*gi2*gd2,omega2);
Kp_b2 = -1/M2;

[M3,P3] = bode(Gsp*gi3*gd3,omega3);
Kp_b3 = -1/M3;

[M4,P4] = bode(Gsp*gi4*gd4,omega4);
Kp_b4 = -1/M4;

%nyquist, bode og step laves fra valgte frekvenser

figure(5) %plot nyquist
hold on
nyquist(gd1*Kp_b1*Gsp*gi1);
nyquist(gd2*Kp_b2*Gsp*gi2);
nyquist(gd3*Kp_b3*Gsp*gi3);
nyquist(gd4*Kp_b4*Gsp*gi4);
hold off
figure(7) %plot bode
hold on
bode(Kp_b1*gd1*Gsp*gi1);
bode(Kp_b2*gd2*Gsp*gi2);
bode(Kp_b3*gd3*Gsp*gi3);
bode(Kp_b4*gd4*Gsp*gi4);
hold off
Gcl1 = (Gsp*gi1*Kp_b1)/(1+gd1*Gsp*gi1*Kp_b1);
Gcl2 = (Gsp*gi2*Kp_b2)/(1+gd2*Gsp*gi2*Kp_b2);
Gcl3 = (Gsp*gi3*Kp_b3)/(1+gd3*Gsp*gi3*Kp_b3);
Gcl4 = (Gsp*gi4*Kp_b4)/(1+gd4*Gsp*gi4*Kp_b4);
figure(6) %plot step
hold on
step(Gcl1)
step(Gcl2)
step(Gcl3)
step(Gcl4)
hold off

%% Vælg den bedste, kør forrige blok først
tau_ib = tau_ib1; %ændre tallet for at vælge en anden regulator
tau_db = tau_db1;
Kp_b = Kp_b1;
%% simulering af model i 2 sekunder
sim('regbot_3mg', 2);

%% Plots

figure(1)
plot(speed_out);
figure(2)
plot(pitchout);








