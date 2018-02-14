% konstanter til REGBOT model
G = 9.68;  % gearing
rw = 0.03; % hjulradius [m]
% NB! efterf?lgende v?rdier er IKKE de rigtige,
%     men OK inden for en faktor 10-50
Ra = 4;  % Rotorviklingmodstand medregnet H-bro og ledninger [Ohm]
Ktau = 0.02; % Motorkonstant [Nm/A]
Kemf = Ktau; % Motorkonstant [Vs]
La = 0.02; % rotor (anker) induktans [Henry]
Bm = 2e-6; % viskos friktion [Nms]
Jm = 5e-6; % intertimoment for motor [Kgm^2]