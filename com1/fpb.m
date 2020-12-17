%%------------------------------------------------------------| 
% FILTRO PASSA BAIXA NO DOMINIO DA FREQUENCIA
% FREQUENCIA DE CORTE: 300Hz.
%%------------------------------------------------------------|
clear all; close all; clc;
%%------------------------------------------------------------| SINAL
A = 1;
fm = 1e3;
fc = 10e3;
N = 100;
fs = N*fc;
ts = 1/fs;
t_final = 1;
filtro_pb = [zeros(1,499700) ones(1,601) zeros(1,499700)];
t = [0:ts:t_final];
y = cos(2*pi*100*t) + cos(2*pi*500*t);
T = length(y);
f = [-fs/2:1:fs/2];

Y = fft(y);
Y = fftshift(Y);
Y1 = abs(Y).*filtro_pb;
y1 = ifftshift(Y1);
y1 = ifft(y1);

%%------------------------------------------------------------| PLOT
figure(1)
subplot(211)
plot(t,y)
xlim([0 20e-3])
subplot(212)
plot(f,abs(Y)/length(y))
xlim([-15e3 15e3])

figure(2)
title('SINAL FILTRADO')
subplot(211)
plot(t,y1)
xlim([0 20e-3])
subplot(212)
plot(f,abs(Y1)/length(y))
xlim([-15e3 15e3])