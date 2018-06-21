%%
% Definer den opgivne overføringsfunktion
H = tf([1.6], [1 5.75 16.56 1.6])
[Gm, Pm, Wgm, Wpm] = margin(H)
figure(12)
bode(H)
isstable(H)
grid
%% info om system
bandwidth(H)
stepinfo(H)
[Gm, Pm, Wgm, Wpm] = margin(H) %% Gain margin, phase margin, frekvens ved 180* (Pi frekvens), krydsfrekvens
damp(H)

%% Regulatorberegning
%krydsfrekvens
omega_c = 0.3

% I-regulator
tau_i = 1/omega_c;
Hi =  tf([tau_i 1],[tau_i 0])

% Lead-regulator
alpha = 0.1;
tau_d = 3.16%1/(omega_c*sqrt(alpha));
Hlead = tf([tau_d 1],[alpha*tau_d 1])

% P-regulator
kP = 0.1;

%% påmontering
figure(5)
bode(Hi*H)
%%
figure(14)
Go =6*H
Gint = tf([0.1 1],[0.1 0])
step(10*Gint*H/(1+10*Gint*H))

%% PI-lead designprocesss

Ni = 3;
alpha = 0.1;
gamma = 60;

% 1. Fasedrejninger
phi_i = -(atan(1/Ni)*180/pi); %I-led fasedrejning
phi_m = asin((1-alpha)/(1+alpha))*180/pi;

%Krydsfrekvens findes da ved:
kryds = -180 + gamma - phi_i - phi_m

% Identificer position af den beregnede krydsfrekvens ud fra bodeplottet
bode(H)
grid
omega_c = 3;

% Tidskonstanterne for hhv. I og lead leddene kan nu beregnes
tau_i = Ni/omega_c;
tau_d = 1/(omega_c*sqrt(alpha));


% Da kan overføringsfunktionen for PI-lead kompensatoren beregnes:
G_lead = tf([tau_d 1],[alpha*tau_d 1]);
G_i = tf([tau_i 1],[tau_i 0]);

%% Inspicer system med påmonteret regulator
figure(111)
Hreg =G_lead*G_i*H
bode(Hreg)
grid

% Gain aflæses ved krydsfrekvens til at være:
p_Kp = (1/(10^(-20.5/20))); %(1/(10^(#aflæst gain#/20)))

%% Endeligt system
bode(p_Kp*Hreg)
grid
