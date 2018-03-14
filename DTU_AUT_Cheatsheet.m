%% Cheatsheet for matlab for the course 31300/31301 Linear Control theory
% For DTU department for automation and control
% Made by Kristian Revsbech, spring 2018
% krrevs@elektro.dtu.dk
% Version 0.1
%
%
%% Index
% clear,clc,close all
% ; to mute
% commenting syntax
% tf
% s=tf('s')
% figure
% bode and margin
% nyquist
% minreal
% disp
% step
% hold on/off
% db2mag and mag2db
% xlabel ylabel title'
% moviegui

%% starting your script in a good manner:
clear;clc;close all
% "clear" clears the workspace variables, so you dont over itterate and get
% wrong anwsers
% "clc" clears the ocmmands window, so it's easy to se where the output
% starts.
% "close all" closes all open figures, so when you run the script again, the
% needed windows will pop up

%% use ";" to mute equations you do not need to print the output off
A=2 % this equation will print out in the command window: "A = 2" and take up a lot of space
B=3; %this equation is mutet and will not print out anything. by default all equations should be muted

%% commenting syntax
% a single procent sign starts a equation.
% %% starting a line with 2 procent signs starts a new
% executionblock/section. this is useful, for fx keeping you calculations
% in, while keeping your constants in a different section, so you do not
% have to re run everything every time.

%% Creating transferfunctions using the tf command, listing the ammounts of
% s from highest to lowest
% here we could place a nice exeplenation. but there is one in the slides
%tf([numerator],[denominator])

%to create a (s+2)/(3*s+4) tf
tf([1 2],[3 4])

%% writing transfer equations using the s notation
s=tf('s')
% tf('s') converts the symbol s to the transfer function s, which is equal
% to how we use it in 31300/31301. when this is written, we can write
% transfer functions easily
G1=s/(1+s)
% is the same as writing
G2=tf([1 0],[1 1])
% this can be usefull at times, especially when dealing with a function
% where the denominator looks something like: (s+3)*(s+8+s^2)*s, where it
% can be difficult to convert it to the a1*s^5+a2*s^4+a3*s^3.... form,
% without using analytical tools like maple.

%% using figure to increment the figure number
%setup
clc;clear;close all;
s=tf('s'); G1=1/(1+s); G2=(1+s)/(10+s)
% figure can be used without a argument to just increment the figure
% number. this makes code easy to edit later on, as oppesed to use
% figure(1), figure(2), figure(3) which makes it hard to later add a figure
% between 1 and 2.
bode(G1)
figure
bode(G2)

%% bode and margin.
% bode(system) creates a bodeplot as we know it, of a system, with the
% title bode plot.
% margin(system) creates the same plot, but draws onto it the gain margin
% and phase margin, and as title shows the actual values, so it's no longer
% neccecary to manualy read it from the plot, which removes reading errors.

%setup
clc;clear;close all;
s=tf('s'); G1=100/((s+1)*(s+2)*(s+10));
% example of use 
bode(G1)
figure
margin(G1)

%% nyquist
% the nyquist function creastes a nyquist plot of a system, which can be
% used to evaluate the stability

%setup
clc;clear;close all;
s=tf('s'); G1=100/((s+1)*(s+2)*(s+10));
%example
nyquist(G1)

%% minreal
% the minreal function minimizes transfer functions and removes some higher
% order poles, that show up as artefact of matlab solving somethings
% numericaly insted of analytically. This functions should be used when
% multiplying several funcitons, eg closing a loop

%setup
clc;clear;close all;
s=tf('s'); G1=1/(1+s); G2=(1+s^2)/(10+s^3); H=0.1/(s+1);
%example
sys=(G1*G2)/(1+G1*G2*H)
disp('the above system has a s^9 as the highest order s')
sys=minreal(sys)
disp('by calling minreal, the system is reduced to the real 5th order system')


%% disp to make your output readable.
% the disp funktion works like printf or prinout, and writes text or other
% stuff to the command window. this can be very helpfull in larger scripts,
% to know what is what when reading the output on the command log. 
% this is especially usefull when we do a calculation without assigning the
% result to a variable, since the log will just say ans= "the anwser"
disp( 'and now we se the result of this specific equation')
h=2+3+5

%% Step
% the step function is used to test the stepresponse of a system. we often
% do this on our closed loop systems.

%setup
clc;clear;close all;
s=tf('s'); G1=1/(1+s);
%example
step(G1)
figure
% to choose how long time the step should display, write the time as the
% second parameter. this can be usefull to make seveeral systems stop over
% the same time, in order to compare the speed of different systems
% properly.
time=100;
step(G1,time)
%% hold on and hold off.
% we use the hold on functon to plot several things on top of eachother in
% a single plot. the hold off command stops it again.

clc;clear;close all;
s=tf('s'); G1=1/(1+s); G2=(2)/(2+s)
%
step(G1)
hold on
step(G2)
hold off

%% db2mag og mag2db
% we use db2mag to convert from decibels to magnetude, and mag2db to go the
% other way. this way we remove errors from wrong conversions
disp('the magnitude of 6db is')
mag_of_6_db = db2mag(6)
disp('the db value of a amplitude of 2 is')
db_of_10_mag=mag2db(2)

% there are many other printing fuctions avaliable, some bettter suitet to
% different tasks.

%% xlabel ylabel title
% we can name the x and y labels and the title to make more clear plots and
% figures.

%setup
clc;clear;close all;
s=tf('s'); G1=1/(1+s);
%example
thexlabel='an x label';
theylabel='an y label';
thetitle='meaningfull title';
step(G1)
xlabel(thexlabel); ylabel(theylabel); title(thetitle);

%% movegui
% we can use the movegui function to move a figure to a specific place on
% the screen. this can be usefull when spawning many plots in your script,
% since it makes it possible to se more plots at the same time.
clc;clear;close all;
s=tf('s'); G1=1/(1+s);

bode(G1)
movegui('northwest')

figure
margin(G1)
movegui('north')

figure
step(G1)
movegui('northeast')

% there is more positions avaliable, see "help movegui"

