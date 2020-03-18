clear all; close all; clc;
%% --------------------------------------------------------------| DEFININDO VARIAVEIS
A1 = 6;
A2 = 2;
A3 = 4;

F1 = 1e3;
F2 = 3e3;
F3 = 5e3;

T1 = 1/F1;
T2 = 1/F2;
T3 = 1/F3;

N = 100;                % fator de super amostragem
fs = N*F3;              % frequencia de amostragem
ts = 1/fs;              % periodo de amostragem 

num_period = 3;         % qtd de periodos
t_final = num_period*T1;
t = 0:ts:t_final;

passo = 1/t_final;
f = -fs/2:passo:fs/2;
%% --------------------------------------------------------------| SINAIS
s1 = A1*sin(2*pi*F1*t);
s2 = A2*sin(2*pi*F2*t);
s3 = A3*sin(2*pi*F3*t);
s = s1+s2+s3;

S1 = fft(s1)/length(s1);
S2 = fft(s2)/length(s2);
S3 = fft(s3)/length(s3);
S = fft(s)/length(s);
%% --------------------------------------------------------------| PLOTS
figure(1)
subplot(421)
plot(t,s1)
subplot(422)
plot(f,abs(fftshift(S1)))
xlim([-2*F3 2*F3])

subplot(423)
plot(t,s2)
subplot(424)
plot(f,abs(fftshift(S2)))
xlim([-2*F3 2*F3])

subplot(425)
plot(t,s3)
subplot(426)
plot(f,abs(fftshift(S3)))
xlim([-2*F3 2*F3])

subplot(427)
plot(t,s)
subplot(428)
plot(f,abs(fftshift(S)))
xlim([-2*F3 2*F3])
%% --------------------------------------------------------------| CALCULOS
potencia = norm(s)
d = pwelch(s);
figure(2)
pwelch(s);