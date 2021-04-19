close all; clear all; clc;
% Projetar o filtro passa baixas : Parks-McClellan

fa = 2000;

Ap = 3;          
Ar = 40;
Go=-10;
       
fp = 100;
fr = 500;

f = [fp fr];    
a = [1 0];        
Apa = Ap-2.5; Ara = Ar+6; %n=7
%Apa = Ap; Ara = Ar; %n=4
dev = [(10^(Apa/20)-1)/(10^(Apa/20)+1)  10^(-Ara/20)]; 
[n,fo,ao,w] = firpmord(f,a,dev,fa);
b = firpm(n,fo,ao,w);
b=b*10^(Go/20)
[h,w] = freqz(b,1,1024,fa);
plot(w, 20*log10(abs(h))); hold on;
plot([0 fr fr fa/2], [Ap/2 Ap/2 -Ar -Ar]+Go,':m')
plot([0 fp fp], [-Ap/2 -Ap/2 -(Ar+30)]+Go,':m');
