%%------------------------------------------------|
% AM MODULATION DSB SC : Suppressed Carrier
% > Usando fir1
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

Ai = 1; % amplitude do sinal de informação
Ac = 2; % amplitude do sinal portadora

m = Ai*cos(2*pi*fm*t); % sinal modulador
c = Ac*cos(2*pi*fc*t); % portadora
s = m.*c; % sinal modulado
s_demod = s.*c; % sinal demodulado

filtro=fir1(50,(1000*2)/fs);
s_demod_f = filter(filtro,1,s_demod);

%%------------------------------------------------| FREQ
M = fftshift(fft(m));
C = fftshift(fft(c));
S = fftshift(fft(s));
S_DEMOD = fftshift(fft(s_demod));
S_DEMOD_F = fftshift(fft(s_demod_f));
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
subplot(211)
plot(t,s_demod)
xlim([0 2*(1/fm)])
subplot(212)
plot(t,s_demod_f)
xlim([0 2*(1/fm)])

figure(4)
subplot(211)
plot(f, abs(S_DEMOD)/length(c))
title('DOMÍNIO DA FREQUÊNCIA')
xlabel('f [Hz]') % eixo horizontal
ylabel('S_DEMOD(f)') % eixo vertical
xlim([-25e3 25e3])
subplot(212)
plot(f, abs(S_DEMOD_F)/length(c))
xlabel('f [Hz]') % eixo horizontal
ylabel('S_DEMOD_F(f)') % eixo vertical
xlim([-25e3 25e3])