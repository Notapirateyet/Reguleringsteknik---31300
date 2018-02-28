%% Opgave 1

Gs = tf(45^2,[1 2*0.3*45 45^2]);
figure(11)
bode(Gs)

%% Opgave 2

Gs = tf(10,[0.0009 0.018 1 0]);
figure(12)
bode(Gs)
grid()
% aflæst
figure(13)
polerne = pole(Gs);
pzplot(Gs)
grid
axis([-13 1 -40 40])

%% Opgave 3

Gs =300* tf(10,[0.0009 0.018 1 0]);
figure(12)
hold on
bode(Gs,'r')
legend('Kp=1','Kp=3')
hold off
% aflæst
figure(13)
hold on
pzplot(Gs, 'r')
legend('Kp=1','Kp=3')
hold off

%% Mult 2
K=1
Ms = tf([K K],[1 10*K K-1])
pole(Ms)





