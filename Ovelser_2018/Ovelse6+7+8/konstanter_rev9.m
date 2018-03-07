% Dampmaskine konstanter
%
clear
%% el varmelegeme
inputSW = -1; % step input for simulation
CthV1 = 5; % varmekapacitet - varmetråd [Joule per kelvin]
RthV1 = 0.3; % termisk modstand varmelegeme til kedel [Watt per kelvin]
CthV2 = 50; % varmekapacitet - varmetråd [Joule per kelvin]
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
krumtapArm = 0.008; % halv slaglængde
slaglng = 2 * krumtapArm;
stempelAreal = (boring/2)^2*pi;
fyndningsgrad = 1;
% virkningsgrad af stempel - omsætte tryk til moment
kd_ny = 0.1;
% 2 stempler dobbeltvirkende, slaglængde = 2*krumtap
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
% motor + generator + kæde - ca. cylinder r=1.5cm h=3cm jern I=0.5*m*R^2
Jm = Jmm + 0.5 * (0.015^2 * pi * 0.03 * jernMassefylde) * 0.015^2
% friktion der ikke er afhængig af omdrejningstal
startFriction = 0.005;
%
%% generator
% assumed 5V out of rectifier at 2500 RPM
voltPerRPM = 5/2500;
voltPerRad = voltPerRPM*60/2/pi;
generatorpoler = 13;
polPrRad = 13/(2*pi);
%% simulering
sim('dampmaskine_rev9', 250);
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
%% Model
step_in_offset=mean(power_in.data(1300:1499));
step_ud_offset=mean(tryk_out.data(1300:1499));
step_in=power_in.data(1400:end)-step_in_offset;
step_ud=tryk_out.data(1400:end)-step_ud_offset;
figure(60);
plot(step_ud);

linSample=iddata(step_ud,step_in,0.1);
sys_20=tfest(linSample,1,0)
sys_30=tfest(linSample,2,0)
sys_31=tfest(linSample,3,1)
sys_42=tfest(linSample,4,2)
