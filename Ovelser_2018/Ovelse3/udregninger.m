%Data
data = load('data_sutten.txt');
% Freja (4)
%  1    time 0.000 sec
%  2  3 Motor voltage [V] left, right: 3.00 3.00
%  4  5 Motor current left, right [A]: 0.150 0.128
%  6  7 Wheel velocity [m/s] left, right: -0.0000 0.0000

%%%Udregnign af diverse v?rdier:
%%motorkonstant Kemf

%Va - Vemf - Ra * Ia = 0 <=> Vemf = Va - Ra*Ia
%Vemf = Kemf * omega <=> kemf = Vemf/omega = Vemf/(v*(G/rw))
%Vi v?lger Va = 4V, og finder s? motorsp?ndingen i det interval

Ia = (sum(data(206:506,5)))/(300);
Va = 3; %V
Ra = 4; %Ohm
Vemf = Va - Ra*Ia;

omega = ((sum(data(206:506,5)))/(300)) * G/rw;

Kemf = Vemf/omega;

