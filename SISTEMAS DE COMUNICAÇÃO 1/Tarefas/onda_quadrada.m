%%------------------------------------------------------------| 
% GERADOR DE ONDA QUADRADA COM FREQUENCIA FUNDAMENTAL DE 1kHz.
%%------------------------------------------------------------|
clear all; close all; clc;
%%------------------------------------------------------------| SINAL
fm = 1e3; % frequencia fundamental
tm = 1/fm; % periodo do sinal fundamental
N = 100; % numero de amostras por periodo
fs = N*fm; % frequencia de amostragem
ts = 1/fs; % periodo de amostragem

P = 5; % numero de periodos
t = 0:ts:P*tm; % vetor temporal
H = 15; % numero de harmonicas
v = 1:2:2*H; % vetor de harmonicas
theta = 2*pi*fm*(v'*t);
A = 4/pi; % amplitude
m = (A./v)*sin(theta); % onda quadrada

%%------------------------------------------------------------| PLOT
figure(1)
plot(t,m)