clear all; close all; clc;
% -------------------------------------------------| Filtro Digital
% Chebyshev 2 (bilinear)

% Especificacao do filtro 

fa = 4000; % Frequencia de amostragem
fs1 = 400; fs2 = 1400; % Frequencias bandstop
fp1 = 800; fp2 = 1000; % Frequencias bandpass
Ap = 3; As = 40; G0 = -10; % Atenuacao e Ganho de topo
wa = 2*pi*fa; ws = 2*pi*[fs1 fs2]; wp = 2*pi*[fp1 fp2]; % Frequencia angular

Ap=-10*log10(0.5); % quando Ap=3 o epslon(e) n eh exatamente 1

% Compensacao da tangente
theta_s = ws./(wa/2);
theta_p = wp./(wa/2);

lambda_s = 2*tan(theta_s*pi/2);
lambda_p = 2*tan(theta_p*pi/2);
B = lambda_p(2)-lambda_p(1);
lambda0 = sqrt(lambda_p(2)*lambda_p(1));

WP = 1;
WS = abs( (-(lambda_s.^2) + lambda0) ./ (B.*lambda_s) );
WS = min(WS)

% Chebyshev II
% type = 'bandpass';
n = cheb2ord(WP, WS, Ap, As,'s');
[bp,ap] = cheby2(n,As, WS,'s');
% bp = bp*10^(G0/20);
[h,w] = freqs(bp,ap);
figure(1); semilogx(w,20*log10(abs(h)));grid on;

syms p
BP(p) = poly2sym(bp,p)
AP(p) = poly2sym(ap,p)
Hp(p) = BP/AP;

% Plano S - Desnormalizando ( p -> (s^2+lambda0^2)/Bs ) - BPF

syms s
Hs(s) = subs(Hp,(s^2+lambda0^2)/(B*s));
Hs(s) = Hs(s)*10^(G0/20);
[N,D] = numden(Hs);
bs = sym2poly(N);
as = sym2poly(D);
%%
figure(2)
[h,w]=freqs(bs,as);
semilogx(w,20*log10(abs(h)))
% semilogx(fa*w/pi,20*log10(abs(h)))
grid on

% Mascara


