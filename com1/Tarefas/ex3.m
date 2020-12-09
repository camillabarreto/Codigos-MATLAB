clear all; close all; clc;
% 1) Gerar um vetor representando um ruído com distribuição normal utilizando a função 'randn' do matlab.
%    Gere 1 segundo de ruído considerando um tempo de amostragem de 1/10k.

ts = 1/10e3; % periodo de amostragem
fs = 1/ts; % frequencia de amostragem
t = 0:ts:1; % vetor temporal
x = randn(1,length(t)); %ruido
f = -fs/2:1:fs/2; % vetor espectral
X = fftshift(fft(x)); 

% 2) Plotar o histograma do ruído para observar a distribuição Gaussiana. Utilizar a função 'histogram'

figure(1)
hist(x,100);
xlabel('Valores') % eixo horizontal
ylabel('Frequência') % eixo vertical
xlim([-4 4])

% 3) Plotar o ruído no domínio do tempo e da frequência

figure(2)
subplot(211)
plot(t,x/length(x))
title('DOMINIO DO TEMPO')
xlabel('t [sec]') % eixo horizontal
ylabel('x(t)') % eixo vertical
subplot(212)
plot(f,abs(X)/length(X))
title('DOMINIO DA FREQUÊNCIA')
xlabel('f [Hz]') % eixo horizontal
ylabel('X(f)') % eixo vertical

% 4) Utilizando a função 'xcorr', plote a função de autocorrelação do ruído.

[c,lags] = xcorr(x);
figure(3)
plot(lags,c)

figure(3)
plot(Rx)
xlabel('τ [sec]') % eixo horizontal
ylabel('Rx(τ)') % eixo vertical

% 5) Utilizando a função 'filtro=fir1(50,(1000*2)/fs)', realize uma operação de filtragem passa baixa do ruído.
%    Para visualizar a resposta em frequência do filtro projetado, utilize a função 'freqz'.

filtro=fir1(50,(1000*2)/fs);
figure(4)
freqz(filtro);

% 6) Plote, no domínio do tempo e da frequência, a saída do filtro e o histograma do sinal filtrado

xf = filter(filtro,1,x);
XF = fftshift(fft(xf));

figure(5)
subplot(211)
plot(t,xf/length(xf))
title('DOMINIO DO TEMPO')
xlabel('t [sec]') % eixo horizontal
ylabel('x(t)') % eixo vertical
subplot(212)
plot(f,abs(XF)/length(XF))
title('DOMINIO DA FREQUÊNCIA')
xlabel('f [Hz]') % eixo horizontal
ylabel('X(f)') % eixo vertical

figure(6)
hist(xf,100);
xlabel('Valores') % eixo horizontal
ylabel('Frequência') % eixo vertical
xlim([-4 4])