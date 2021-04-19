close all; clear all; clc;
% Projetar o filtro passa faixa : Parks-McClellan

fa = 4000;

Ap = 3;          
Ar = 40;
Go=-10;
       
fp = [800 1000];
fr = [400 1400];

f = [fr(1) fp(1) fp(2) fr(2)];    
a = [0 1 0];        
%Apa = Ap-2; Ara = Ar+1; %n=15
Apa = Ap; Ara = Ar; % n=10
dev = [10^(-Ara/20) (10^(Apa/20)-1)/(10^(Apa/20)+1)  10^(-Ara/20)]; 
[n,fo,ao,w] = firpmord(f,a,dev,fa);
b = firpm(n,fo,ao,w);
b=b*10^(Go/20)
[h,w] = freqz(b,1,1024,fa);
plot(w, 20*log10(abs(h))); hold on;
plot([fp(1) fp(1) fp(2) fp(2)], [-Ar -Ap/2 -Ap/2 -Ar]+Go,':m')
plot([0 fr(1) fr(1) fr(2) fr(2) fa/2], [-Ar -Ar Ap/2 Ap/2 -Ar -Ar]+Go,':m');
