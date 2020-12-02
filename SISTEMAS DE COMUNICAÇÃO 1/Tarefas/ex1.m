clear all; close all; clc;
% 1) Gerar um sinal s(t) composto pela somatória de 3 senos 
%    com amplitudes de 6V, 2V e 4V e frequências de 1, 3 e 5kHz, respectivamente.

A = [6 2 4]; % amplitudes dos sinais de informação
fs = [1 3 5]*1e3; % frequencia dos sinais de informação
N = 100; % numero de amostras por periodo
fa = N*fs(3); % frequencia de amostragem
ta = 1/fa; % periodo de amostragem

P = 4; % numero de periodos
t = 0:ta:P/fs(1); % vetor temporal
theta = 2*pi*(fs'*t); % termos das senoides
s = sin(theta); 
s1 = A(1)*s(1,:);
s2 = A(2)*s(2,:);
s3 = A(3)*s(3,:);
s = s1+s2+s3; % sinal de informação no tempo

f = -fa/2:fs(1)/P:fa/2; % vetor espectral
S1 = fftshift(fft(s1));
S2 = fftshift(fft(s2));
S3 = fftshift(fft(s3));
S = fftshift(fft(s)); % sinal de informação na frequencia

% 2) Plotar em uma figura os três senos e o sinal 's' no domínio do tempo e da frequência.

figure(1)
subplot(421)
plot(t,s1);
title('DOMÍNIO DO TEMPO')
xlabel('t [sec]') % eixo horizontal
ylabel('s1(t)') % eixo vertical
subplot(422)
plot(f,abs(S1))%/length(f));
title('DOMÍNIO DA FREQUÊNCIA')
xlabel('f [Hz]') % eixo horizontal
ylabel('s1(f)') % eixo vertical
xlim([-2*fs(3) 2*fs(3)])

subplot(423)
plot(t,s2);
xlabel('t [sec]') % eixo horizontal
ylabel('s2(t)') % eixo vertical
subplot(424)
plot(f,abs(S2))%/length(f));
xlabel('f [Hz]') % eixo horizontal
ylabel('s2(f)') % eixo vertical
xlim([-2*fs(3) 2*fs(3)])

subplot(425)
plot(t,s3);
xlabel('t [sec]') % eixo horizontal
ylabel('s3(t)') % eixo vertical
subplot(426)
plot(f,abs(S3))%/length(f));
xlabel('f [Hz]') % eixo horizontal
ylabel('s3(f)') % eixo vertical
xlim([-2*fs(3) 2*fs(3)])

subplot(427)
plot(t,s);
xlabel('t [sec]') % eixo horizontal
ylabel('s(t)') % eixo vertical
subplot(428)
plot(f,abs(S))%/length(f));
xlabel('f [Hz]') % eixo horizontal
ylabel('s(f)') % eixo vertical
xlim([-2*fs(3) 2*fs(3)])

% 3) Utilizando a função 'norm', determine a potência média do sinal 's'.

pot_s = norm(s)

% 4) Utilizando a função 'pwelch', plote a Densidade Espectral de Potência do sinal 's'

%dep = pwelch(S)
