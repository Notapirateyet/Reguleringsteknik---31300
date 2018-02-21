clear;
%% Data
% data = load('data_sutten.txt');
% Freja (4)
%  1    time 0.000 sec
%  2  3 Motor voltage [V] left, right: 3.00 3.00
%  4  5 Motor current left, right [A]: 0.150 0.128
%  6  7 Wheel velocity [m/s] left, right: -0.0000 0.0000

data = load('3_6V.txt');

d_start_3v = 250;
d_end_3v = 460;
d_start_6v = 800;
d_end_6v = 970;

%% Udregnign af diverse v?rdier:
% motorkonstant Kemf

%Va - Vemf - Ra * Ia = 0 <=> Vemf = Va - Ra*Ia
%Vemf = Kemf * omega <=> kemf = Vemf/omega = Vemf/(v*(G/rw))
%Vi v?lger Va = 4V, og finder s? motorsp?ndingen i det interval

Ia = (sum(data(d_start_3v:d_end_3v,5)))/(d_end_3v - d_start_3v);
Va = 3; %V
Ra = 4; %Ohm
G = 9.68; %gear
rw = 0.03; %m
Vemf = Va - Ra*Ia;

omega3v = (sum(data(d_start_3v:d_end_3v,7)))/(d_end_3v - d_start_3v) * G/rw;

Kemf = Vemf/omega3v;
Ktau = Kemf;

% Måske
Bm = (Ia*Ktau)/omega3v;

Ra3v = (Va-Vemf)/Ia;


%% Samme men ved 6V

Ia =(sum(data(d_start_6v:d_end_6v,5)))/(d_end_6v - d_start_6v);
Va = 6; %V
Ra = 4; %Ohm
G = 9.68; %gear
rw = 0.03; %m
Vemf6v = Va - Ra*Ia;

omega6v = (sum(data(d_start_6v:d_end_6v,7)))/(d_end_6v - d_start_6v) * G/rw;

Kemf6v = Vemf6v/omega6v;
Ktau6v = Kemf6v;

% Måske
Bm6v = (Ia*Ktau6v)/omega6v;

Ra6v = (Va-Vemf6v)/Ia;




%% Udregnning af Bm

% G(s) = K_tau/(J_m*s+B_m)

deltaOmega = (((sum(data(d_start_6v:d_end_6v,7)))/(d_end_6v - d_start_6v)) * G/rw)-(((sum(data(d_start_3v:d_end_3v,7)))/(d_end_3v - d_start_3v)) * G/rw);
deltaV = 6-3;
deltaI = ((sum(data(d_start_6v:d_end_6v,5)))/(d_end_6v - d_start_6v)) - ((sum(data(d_start_3v:d_end_3v,5)))/(d_end_3v - d_start_3v));

Bm_v1 = deltaI*Ktau/deltaOmega;
Bm_v2 = -(deltaI*Kemf*Ktau) / (deltaI*Ra-deltaV);

%% Udregning af 



%% Output
fprintf("K_emf = %e\nBm_v1 = %e \tBm_v2 = %e\n", [Kemf, Bm_v1,Bm_v2]);









fprintf("\n");