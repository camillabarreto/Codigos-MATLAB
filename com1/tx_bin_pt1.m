%%------------------------------------------------|
% TRANSMISSÃO BINÁRIA - PARTE 1
% Sinalização RZ unipolar (A=1V)
% Canal AWGN (SNR=10dB)
%%------------------------------------------------|
clear all; close all; clc
%%------------------------------------------------|

SNR_dB = 10;
A = 1; % nível de tensão da sinalização
N = 10; % n. de amostras por duração do bit
Rb = 10e3; % taxa de transmissão
Tb = 1/Rb; % duração do bit
fs = N*Rb; % frequência de amostragem
Ts = 1/fs; % tempo de amostragem
t=[0:Ts:1-Ts];

filtro_RZ = ones(1,N);
filtro_RZ_casado = fliplr(filtro_RZ);

info = [0 1 1 0 1 0 1 1 0 1 0 (randn(1,Rb-11)>0)]; % informação binária (11 bits)
info_up = upsample(info,N); % informação super amostrada
sinal_tx = filter(filtro_RZ, 1, info_up)*A; % sinal transmitido (código de linha)
r_t = awgn(sinal_tx, SNR_dB); % sinal recebido
z_t = filter(filtro_RZ_casado,1,r_t)/N;

z_T = z_t(N:N:end);
n = t(N:N:end);

A=A+0.2
figure(1)
subplot(311)
plot(t,sinal_tx)
title('SINAL TRANSMITIDO')
xlim([0 11*Tb])
ylim([-A/2 1.5*A])
xlabel('t [s]') % eixo horizontal
ylabel('s(t)') % eixo vertical
subplot(312)
plot(t,r_t)
title('SINAL RECEBIDO')
xlim([0 11*Tb])
ylim([-A/2 1.5*A])
xlabel('t [s]') % eixo horizontal
ylabel('r(t)') % eixo vertical
subplot(313)
plot(t,z_t)
title('SINAL TRATADO')
xlim([0 11*Tb])
ylim([-A/2 1.5*A])
xlabel('t [s]') % eixo horizontal
ylabel('z(t)') % eixo vertical
hold on
subplot(313)
stem(n,z_T)
