clear all; close all; clc;

% 1) Gerar um sinal s(t) composto pela somatória de 3 senos com amplitudes de 5V, 5/3V e 1V
%    e frequências de 1, 3 e 5kHz, respectivamente.

A = [5 5/3 1]; % amplitudes dos sinais de informação
fs = [1 3 5]*1e3; % frequencia dos sinais de informação
N = 100; % numero de amostras por periodo
fa = N*fs(3); % frequencia de amostragem
ta = 1/fa; % periodo de amostragem

P = 10; % numero de periodos
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

% 2) Plotar em uma figura os três senos e o sinal 's' no domínio do tempo e da frequência

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

% 3) Gerar 3 filtros ideais:
%    - Passa baixa (frequência de corte em 2kHz)
%    - Passa alta (banda de passagem acima de 4kHz)
%    - Passa faixa (banda de passagem entre 2 e 4kHz)

fc = [2 4]*1e3;
r = ((fa/2)-fc(1))/(fs(1)/P); p = 2*(fc(1)/(fs(1)/P)) + 1;
fpb = [zeros(1,r) ones(1,p) zeros(1,r)]; % FPB 2kHz
r = 2*(fc(2)/(fs(1)/P))+1; p = ((fa/2)-fc(2))/(fs(1)/P);
fpa = [ones(1,p) zeros(1,r) ones(1,p)]; % FPA 4kHz
rl = ((fa/2)-fc(2))/(fs(1)/P); rc = 2*(fc(1)/(fs(1)/P)) + 1; p = (fc(2)-fc(1))/(fs(1)/P);
fpf = [zeros(1,rl) ones(1,p) zeros(1,rc) ones(1,p) zeros(1,rl)]; % FPF 2kHz - 4kHz

% 4) Plotar em uma figura a resposta em frequência dos 3 filtros
figure(2)
subplot(311)
plot(f,fpb)
title('RESPOSTA EM FREQUÊNCIA')
xlabel('f [Hz]') % eixo horizontal
ylabel('FPB(f)') % eixo vertical
axis([-4*fc(1) 4*fc(1)  0 1.5])
subplot(312)
plot(f,fpa)
xlabel('f [Hz]') % eixo horizontal
ylabel('FPA(f)') % eixo vertical
axis([-4*fc(1) 4*fc(1)  0 1.5])
subplot(313)
plot(f,fpf)
xlabel('f [Hz]') % eixo horizontal
ylabel('FPF(f)') % eixo vertical
axis([-4*fc(1) 4*fc(1)  0 1.5])

% 5) Passar o sinal s(t) através dos 3 filtros e plotar as saídas,
%    no domínio do tempo e da frequência, para os 3 casos

S_fpb = abs(S).*fpb;
S_fpa = abs(S).*fpa;
S_fpf = abs(S).*fpf;

s_fpb = ifft(ifftshift(S_fpb));
s_fpa = ifft(ifftshift(S_fpa));
s_fpf = ifft(ifftshift(S_fpf));

figure(3)
subplot(321)
plot(t,s_fpb);
title('DOMÍNIO DO TEMPO')
xlabel('t [sec]') % eixo horizontal
ylabel('s1(t)') % eixo vertical
subplot(322)
plot(f,abs(S_fpb))%/length(f));
title('DOMÍNIO DA FREQUÊNCIA')
xlabel('f [Hz]') % eixo horizontal
ylabel('s1(f)') % eixo vertical
xlim([-2*fs(3) 2*fs(3)])

subplot(323)
plot(t,s_fpa);
xlabel('t [sec]') % eixo horizontal
ylabel('s1(t)') % eixo vertical
subplot(324)
plot(f,abs(S_fpa))%/length(f));
xlabel('f [Hz]') % eixo horizontal
ylabel('s1(f)') % eixo vertical
xlim([-2*fs(3) 2*fs(3)])

subplot(325)
plot(t,s_fpf);
xlabel('t [sec]') % eixo horizontal
ylabel('s1(t)') % eixo vertical
subplot(326)
plot(f,abs(S_fpf))%/length(f));
xlabel('f [Hz]') % eixo horizontal
ylabel('s1(f)') % eixo vertical
xlim([-2*fs(3) 2*fs(3)])