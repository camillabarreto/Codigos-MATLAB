clear all; close all; clc;
% 1) Gerar um vetor representando um ruído com distribuição normal utilizando a função 'randn' do matlab.
%    Gere 1 segundo de ruído considerando um tempo de amostragem de 1/10k.

ts = 1/10e3;
fs = 1/ts;
t = 0:ts:1;
x = randn(1,length(t));
f = -fs/2:1:fs/2;
X = fftshift(fft(x));

% 2) Plotar o histograma do ruído para observar a distribuição Gaussiana. Utilizar a função 'histogram'

##figure(1)
##hist(x,100);

% 3) Plotar o ruído no domínio do tempo e da frequência

##figure(2)
##subplot(211)
##plot(t,x/length(x))
##subplot(212)
##plot(f,abs(X)/length(X))

% 4) Utilizando a função 'xcorr', plote a função de autocorrelação do ruído.

##Rx = xcorr(x);
##Gx = fftshift(fft(Rx));

##figure(3)
##plot(abs(Gx))

% 5) Utilizando a função 'filtro=fir1(50,(1000*2)/fs)', realize uma operação de filtragem passa baixa do ruído.
%    Para visualizar a resposta em frequência do filtro projetado, utilize a função 'freqz'.

##filtro=fir1(50,(1000*2)/fs);
##figure(4)
##freqz(filtro);


% 6) Plote, no domínio do tempo e da frequência, a saída do filtro e o histograma do sinal filtrado



