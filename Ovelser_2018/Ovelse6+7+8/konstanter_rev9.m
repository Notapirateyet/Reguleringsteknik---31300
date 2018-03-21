% Dampmaskine konstanter
%
clear


%% el varmelegeme
inputSW = -1; % step input for simulation
CthV1 = 5; % varmekapacitet - varmetrÃ¥d [Joule per kelvin]
RthV1 = 0.3; % termisk modstand varmelegeme til kedel [Watt per kelvin]
CthV2 = 50; % varmekapacitet - varmetrÃ¥d [Joule per kelvin]
RthV2 = 0.1; % termisk modstand varmelegme til kedel [Watt per kelvin]
%% kedel
kedelDiameter = 0.068; % meter
kedelLength = 0.155; % meter
kedelGodsTykkelse = 0.0015; % meter
kedelVolumen = (kedelDiameter / 2 - kedelGodsTykkelse)^2 * pi * (kedelLength - kedelGodsTykkelse*2); % m^3 (0.5 liter)
kedelOverflade = 2 * (kedelDiameter / 2)^2 * pi + kedelDiameter * pi * kedelLength; % m^2
% varmekapacitet af kedel og fyldt med vand
jernVarmefylde=444; % J/kg/K
jernMassefylde=7880; % kg/m^3
kedelGodsVarmekapacitet = kedelOverflade*kedelGodsTykkelse * jernMassefylde * jernVarmefylde; % i J/K
vandVarmefylde=4185; % J/kg/K
vandMassefylde=1000; % kg/m^3
kedelVandVarmekapacitet = kedelVolumen * vandMassefylde * vandVarmefylde; % i J/K
%
%% dampmotor
boring = 0.009; % boring i m (diameter)
krumtapArm = 0.008; % halv slaglÃ¦ngde
slaglng = 2 * krumtapArm;
stempelAreal = (boring/2)^2*pi;
fyndningsgrad = 1;
% virkningsgrad af stempel - omsÃ¦tte tryk til moment
kd_ny = 0.1;
% 2 stempler dobbeltvirkende, slaglÃ¦ngde = 2*krumtap
antalCylindre = 4;
% tryk til moment for dampmotor
Kd = stempelAreal*krumtapArm/2 * kd_ny * antalCylindre;
% spild = 0.4 betyder der spildes 40% af dampen
spild = 0.3;
Kvm = 1/(1-spild)*stempelAreal * slaglng / (2 * pi) * fyndningsgrad * antalCylindre;
% Motor friktion - bremsemoment pr rad/sec 
Bm = 2e-6;
% inertimoment svinghjul
% Jm=m*r^2, m=2*r*pi*w*t*jern
Jmm = (2*0.039*pi*0.015*0.002*jernMassefylde)*0.039^2;
% motor + generator + kÃ¦de - ca. cylinder r=1.5cm h=3cm jern I=0.5*m*R^2
Jm = Jmm + 0.5 * (0.015^2 * pi * 0.03 * jernMassefylde) * 0.015^2
% friktion der ikke er afhÃ¦ngig af omdrejningstal
startFriction = 0.005;
%
%% generator
% assumed 5V out of rectifier at 2500 RPM
voltPerRPM = 5/2500;
voltPerRad = voltPerRPM*60/2/pi;
generatorpoler = 13;
polPrRad = 13/(2*pi);
%% Regulering
% Til bestemmelse af reguleringsting, udkommenter
% hvis regulering fjernes.

% sys_42 = tf([1.003e-05 1.248e-05 3.282e-06],[1 1.439 0.5805 0.085 0.00393]);

tau_i = 32.05;
Kp = 3.3603e+03;
%% simulering
sim('dampmaskine_rev9', 1000);
%% plot tryk
figure(100)
hold off
plot(power_in.time, power_in.data/1000,'r');
hold on
plot(tryk_out.time, tryk_out.data,'c');
legend('power in [kW]', 'pressure out [Atm]')
xlabel('seconds');
ylabel('power in kW, pressure in Atm')
grid on
hold off
%% Model
% % Følgende er brugt til at finde en overføringsfunktion 
% % for systemet uden regulering, og skal ikke bruges
% % så længe der er regulering på modellen.
% 
% step_in_offset=mean(power_in.data(1300:1499));
% step_ud_offset=mean(tryk_out.data(1300:1499));
% step_in=power_in.data(1400:2500)-step_in_offset;
% step_ud=tryk_out.data(1400:2500)-step_ud_offset;
% figure(60);
% plot(step_ud);
% grid on
% ylabel('Pressure in atm');
% xlabel('Time in seconds')
% title('Step ud, offset by 1400');
% 
% linSample=iddata(step_ud,step_in,0.1);
% % sys_20=tfest(linSample,1,0)
% % sys_30=tfest(linSample,2,0)
% % sys_31=tfest(linSample,3,1)
% sys_42=tfest(linSample,4,2)
% % sys_43=tfest(linSample,4,3)
% % sys_44=tfest(linSample,4,4)
% %sys_42 = tf([1.003e-05 1.248e-05 3.282e-06],[1 1.439 0.5805 0.085 0.00393]);
% figure(61)
% bode(sys_42);
% grid on
% title('Bode af sys 42')
% 
% % Vi vælger sys_42

%% Frekvens analyse
% plot freq
figure(70)
plot(gen_frq)
grid on
title('Generator frequency')
xlabel('Time [s]')
ylabel('Frequency [Hz]')

fstep_in_offset=mean(power_in.data(3000:4999));
fstep_ud_offset=mean(gen_frq.data(3000:4999));
fstep_in=power_in.data(4000:end)-fstep_in_offset;
fstep_ud=gen_frq.data(4000:end)-fstep_ud_offset;

flinSample=iddata(fstep_ud,fstep_in,0.1);

figure(69);
plot(fstep_ud);
title('Step ud for valve shift')
xlabel('Time')
ylabel('Frequency')

% frq_41=tfest(flinSample,4,1)
% frq_42=tfest(flinSample,4,2)
% frq_43=tfest(flinSample,4,3)
frq_44=tfest(flinSample,4,4)
figure(44);
hold on
% bode(frq_41)
% bode(frq_42)
% bode(frq_43)
margin(frq_44)
hold off
% Vi vælger frq_44

%% Sammenlign
% 
% figure;
% tv=0:0.1:100;
% [y_42,t_42]=step(sys_42, tv);
% plot(t_42+150,-y_42*50,':c','linewidth',5);
% hold on
% plot(tryk_out.time(1400:end),step_ud,'k','linewidth',2)
% legend('Estimeret','Målt')
% xlabel('seconds');
% ylabel('Tryk [Atm]')
% grid on

figure;
plot(tryk_out);
xlabel('Tid [s]')
ylabel('Tryk [ATM]')

figure;
plot(gen_frq);
xlabel('Tid [s]')
ylabel('Frekvens [Hz]')

