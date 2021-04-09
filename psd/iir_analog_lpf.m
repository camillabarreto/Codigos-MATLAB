clear all; close all; clc;
% -------------------------------------------------| Filtro Analogico Butterworth

% Especificacao do filtro 

fp = 100; fs = 500; % Frequencia
Ap = 3; As = 40; G0 = -10; % Atenuacao e Ganho de topo
ws = 2*pi*fs; wp = 2*pi*fp; % Frequencia angular
Ap=-10*log10(0.5);  % quando Ap=3 o epslon(e) n eh exatamente 1

% Prototipo - Plano S nomalizado ( p )

WP=wp/wp;
WS=ws/wp;

e = sqrt(10^(0.1*Ap)-1);
n = ceil( log10( (10^(0.1*As)-1)/e^2 ) / (2*log10(WS)) );
k=1:n;
pk = e^(-1/n) * exp( (1i*pi)*(2*k+n-1)/(2*n) );

syms p
ap = real(poly(pk)); % coeficientes do denominador de H(p)
bp = ap(end); % coeficientes do numerador de H(p)
Dp(p) = poly2sym(ap,p); % criando o polinomio com os coeficientes
Hp(p) = bp/Dp;

figure(1)
[h,w]=freqs(bp,ap);
semilogx(w,20*log10(abs(h)))
title(sprintf('Filtro Protótipo LP Butterworth, n = %d',n))
ylim([-60 10])
grid on;
hold on;
% Mascara
xp = [0.1 1 1];
yp = [-3 -3 -40];
line(xp,yp,'Color','red','LineStyle','--');
xr = [5 5 10];
yr = [0 -40 -40];
line(xr,yr,'Color','red','LineStyle','--');
plot([WP WS],([-Ap -As]),'ko', 'MarkerSize',5);
hold off

%% Plano S - Desnormalizando ( p -> s/wp ) - LPF

syms s
Hs(s) = subs(Hp,s/wp);
Hs(s) = Hs(s)*10^(G0/20);
[N,D] = numden(Hs);
bs = sym2poly(N)
as = sym2poly(D)

figure(2)
[h,w]=freqs(bs,as);
semilogx(w/(2*pi),20*log10(abs(h)))
grid on
hold on

% [N,D] = numden(Hs);
% digits(4)
% N=vpa(N)
% D=vpa(D)
% Hs(s)=N/D
% pretty(Hs2)

% Mascara
xp = [10 100 100];
yp = [-13 -13 -50];
line(xp,yp,'Color','red','LineStyle','--');
xr = [500 500 1000];
yr = [-10 -50 -50];
line(xr,yr,'Color','red','LineStyle','--');
plot([wp ws]/(2*pi),([-Ap -As]+G0),'ko', 'MarkerSize',5);
ylim([-60 10])
title(sprintf('Filtro LP Butterworth, n = %d',n))
hold off;
