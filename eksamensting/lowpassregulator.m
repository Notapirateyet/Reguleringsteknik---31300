%% Opstilling af bodeplot

%Prototype for low pass filter

%dB aflæst
dB = -5;
%peak frekvens (rad/s) aflæst
wPeak = 60;
% estimeret Q
Q = 9;

% orden? [1,2,3]
orden = 4;

% beregnede værdier
g = 10^(dB/20);% overføringsfunktion gain

% beregnet system
if (orden == 1)
    H = tf([wPeak],[1 wPeak]);
elseif orden == 2
    H = tf([g*(wPeak^2)], [1 wPeak/Q wPeak^2])
elseif orden == 3
    H = tf([g*(wPeak^2)], [1 wPeak/Q wPeak^2])
    H = H*tf([wPeak],[1 wPeak]); % der ganges et 1 ordens filter på et 2. ordens filter
elseif orden > 3
    H = tf([g*(wPeak^2)], [1 wPeak/Q wPeak^2]);
    for i = 1:(orden-1)
        H = H*tf([wPeak],[1 wPeak]);
    end
end
% Bodeplot for system - tjek!
figure(1)
bode(H)
grid

%% Ren Regulatorberegning
%krydsfrekvens
omega_c = 15

% I-regulator
tau_i = 1 ;%1/omega_c;
Hi =  tf([tau_i 1],[tau_i 0])

% Lead-regulator
alpha = 0.1;
tau_d = 3.16%1/(omega_c*sqrt(alpha));
Hlead = tf([tau_d 1],[alpha*tau_d 1])

% P-regulator
kP = 2;

%% PI-Lead designprocess
Ni = 12.5;
alpha = 0.1;
gamma = 60;

% 1. Fasedrejninger
phi_i = -(atan(1/Ni)*180/pi); %I-led fasedrejning
phi_m = asin((1-alpha)/(1+alpha))*180/pi;

%Krydsfrekvens findes da ved:
kryds = -180 + gamma - phi_i %- phi_m

% Identificer position af den beregnede krydsfrekvens ud fra bodeplottet
bode(H)
omega_c = 43.7;
grid

% Tidskonstanterne for hhv. I og lead leddene kan nu beregnes
tau_i = Ni/omega_c;
tau_d = 1/(omega_c*sqrt(alpha));


% Da kan overføringsfunktionen for PI-lead kompensatoren beregnes:
G_lead = tf([tau_d 1],[alpha*tau_d 1]);
G_i = tf([tau_i 1],[tau_i 0]);


%% Regulatorpåmontering
figure(2)
Gi = tf([1 1],[1 0])
GLead = tf([0.75 1],[0.15 1])
bode(Gi*H/(1+Gi*H))
grid
%%
figure(141)
bode(0.16*G_i*H)
%%
figure(1413)
step(0.16*G_i*H/(1+0.16*G_i*H))
