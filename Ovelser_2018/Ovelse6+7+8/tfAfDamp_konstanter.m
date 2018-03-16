%
%
%   
% --------------------

%% Analyse a system

bode(

%% Konstanter til regulering

stepsize = 1;

Kp = 1000;
% I skal ændres manuelt i modellen


%% Simuler
sim('tfAfDamp', 250);

figure;
plot(tryk_app);
xlabel('Tid [s]');
ylabel('Tryk i guess [atm]');

