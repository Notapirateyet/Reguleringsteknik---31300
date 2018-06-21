%% By Asger Kühl

%% Opgave 1
M = 1;
l = 0.3;
g = 9.82;
tau_0 = M*g*l*sin(-5*pi/180);
M*g*l*cos(-5*pi/180);
M*l^2;

%% Opgave 4

opg4 = tf([6 0],[1 1]);
figure(4)
step(opg4)

%% Opgave 5

figure(5)
opg5c = tf(100,[1 4 25]);
step(opg5c)
hold on
opg5e = tf([400],[1 20 100]);
step(opg5e)
opg5b = tf(4,[1 1]);
step(opg5b)
legend
hold off

%% Opgave 6

stepinfo(opg5c)

%% Opgave 10

opg10 = tf(687500, [1 400 62500]) * tf(1, [0.0048 1]);
figure(10)
step(opg10)

%% opgave 11
opg11_1 = mag2db(2);
opg11_2 = mag2db(1.111);
minven = sprintf('Er det: \n2 = %f dB \n1.111 = %f dB',opg11_1, opg11_2);


%% Opgave 12
opg12 = tf(30000, [1 181 10180 10000]);
wc = 30;
[M,P] = bode(opg12, wc);
Kp = 1/M;

%% Opgave 13
opg13 = tf(0.7, [0.0196 0.1876 1.168 1]);
Ni = 2;
gamma_m = 60;

phi_i = atan(-1/Ni) * 180/pi;
find = -180 + gamma_m - phi_i

% fundet 1.22
wc = 2.5;

% I-led
tau_i = Ni/wc;
Gi = tf([tau_i 1],[tau_i 0]);

% Kp-led
[M,P] = bode(Gi*opg13, wc);
Kp = 1/M;

Gi*Kp

%% Opgave 14
alpha = 0.15;
Ni = 2.5;
gamma_m = 50;

phi_i = atan(-1/Ni) * 180/pi;
phi_m = asin((1-alpha)/(1+alpha)) * 180/pi;
find = -180 + gamma_m - phi_m - phi_i

% fundet 1.22
wc = 1.22;

% I-led
tau_i = Ni/wc;
Gi = tf([tau_i 1],[tau_i 0]);

% D-led
tau_d = 1/(wc*sqrt(alpha));
Gd = tf([tau_d 1],[alpha*tau_d 1]);

% Kp-led
[M,P] = bode(Gi*Gd*H, wc);
Kp = 1/M;


%% Opgave 18

sys0 = tf(20, [25 0 1]);
sys1 = tf(1, [0.002 1]);
sys2 = tf([5 3.75], [0.012 1]);
Glead = tf([0.034 1],[0.0034 1]);
Kp = 50;
Gi = tf([1/26 1],[1/26 0]);

D1Y = sys0/(1+sys1*Glead*Kp*Gi*sys2*sys0);
figure(18)
step(D1Y)

D2Y = 1/(1+sys1*Glead*Kp*Gi*sys2*sys0);
figure(19)
step(D2Y)

D3Y = (Glead*Kp*Gi*sys2*sys0)/(1+sys1*Glead*Kp*Gi*sys2*sys0);
figure(20)
step(D3Y)



%% Opgave 17

opg17_1 = tf([0.75 0],1);
opg17_2 = tf([16.5 0],1);
opg17_sam = tf([0.75 1],[0.075 1]);

figure(17)
bode(opg17_1)
hold on
bode(opg17_2)
bode(opg17_sam)
legend
hold off



