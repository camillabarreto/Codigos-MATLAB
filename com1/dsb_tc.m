%%------------------------------------------------|
% AM MODULATION DSB TM : Transmitted Carrier
% > Variando o índice de modulação
%%------------------------------------------------|
clear all; close all; clc;
%%------------------------------------------------| SINAL
fm = 1e3; % frequencia do sinal de informação
tm = 1/fm;
fc = 20e3; % frequecia do sinal portadora

N = 100; % numero de amostras/periodo
fs = N*fc; % frequencia da amostragem
ts = 1/fs; % periodo de amostragem
P = 10; % numero de periodos
t = [0:ts:P*tm]; % vetor do sinal no tempo
f = [-fs/2:fm/P:fs/2]; % vetor do sinal na frequencia

indices = [0.25, 0.5, 0.75, 1, 1.5] % Ai/Ao , μ = ka*Ai
i = indices(1) % selecionando o indice de modulação
Ai = 1; % amplitude do sinal de informação
Ao = 1/i; % componente dc
Ac = 2; % amplitude do sinal portadora

m = Ao + Ai*cos(2*pi*fm*t); % sinal modulador
c = Ac*cos(2*pi*fc*t); % portadora
s = m.*c; % sinal modulado

%%------------------------------------------------| FREQ
M = fftshift(fft(m));
C = fftshift(fft(c));
S = fftshift(fft(s));
%%------------------------------------------------| PLOT 
figure(1)
subplot(311)
plot(t,m)
title('DOMÍNIO DO TEMPO')
xlabel('t [sec]') % eixo horizontal
ylabel('m(t)') % eixo vertical
xlim([0 2*(1/fm)])
subplot(312)
plot(t,c)
xlabel('t [sec]') % eixo horizontal
ylabel('c(t)') % eixo vertical
xlim([0 2*(1/fm)])
subplot(313)
plot(t,s)
xlabel('t [sec]') % eixo horizontal
ylabel('s(t)') % eixo vertical
xlim([0 2*(1/fm)])

figure(2)
subplot(311)
plot(f, abs(M)/length(c))
title('DOMÍNIO DA FREQUÊNCIA')
xlabel('f [Hz]') % eixo horizontal
ylabel('M(f)') % eixo vertical
xlim([-25e3 25e3])
subplot(312)
plot(f, abs(C)/length(c))
xlabel('f [Hz]') % eixo horizontal
ylabel('C(f)') % eixo vertical
xlim([-25e3 25e3])
subplot(313)
plot(f, abs(S)/length(c))
xlabel('f [Hz]') % eixo horizontal
ylabel('S(f)') % eixo vertical
xlim([-25e3 25e3])

figure(3)
plot(t,m)
xlim([0 2*(1/fm)])
hold on
plot(t,s)
xlim([0 2*(1/fm)])
hold off