%%------------------------------------------------|
% Frequency Division Multiplexing - FDM
%%------------------------------------------------|
clear all; close all; clc;
%%------------------------------------------------| SINAL TRANSMISSÃO
fm1 = 1e3; % frequencia do sinal de informação 1
tm = 1/fm1;
fm2 = 2e3; % frequencia do sinal de informação 2
fm3 = 3e3; % frequencia do sinal de informação 3
fosc1 = 20e3; % frequecia do oscilador 1
fosc2 = 24e3; % frequecia do oscilador 2
fosc3 = 29e3; % frequecia do oscilador 3

N = 100; % numero de amostras/periodo
fs = N*fosc1; % frequencia da amostragem
ts = 1/fs; % periodo de amostragem
P = 500; % numero de periodos
t = [0:ts:P*tm]; % vetor do sinal no tempo
f = [-fs/2:fm1/P:fs/2]; % vetor do sinal na frequencia
Ai = 2; % amplitude dos sinal de informação
Aosc = 1; % amplitude dos osciladores

m1 = Ai*cos(2*pi*fm1*t); % sinal modulador 1
m2 = Ai*cos(2*pi*fm2*t); % sinal modulador 2
m3 = Ai*cos(2*pi*fm3*t); % sinal modulador 3
osc1 = Aosc*cos(2*pi*fosc1*t); % oscilador 1
osc2 = Aosc*cos(2*pi*fosc2*t); % oscilador 2
osc3 = Aosc*cos(2*pi*fosc3*t); % oscilador 3
s1 = m1.*osc1; % sinal deslocado 1
s2 = m2.*osc2; % sinal deslocado 2
s3 = m3.*osc3; % sinal deslocado 3

M1 = fftshift(fft(m1));
M2 = fftshift(fft(m2));
M3 = fftshift(fft(m3));
OSC1 = fftshift(fft(osc1));
OSC2 = fftshift(fft(osc2));
OSC3 = fftshift(fft(osc3));
S1 = fftshift(fft(s1));
S2 = fftshift(fft(s2));
S3 = fftshift(fft(s3));

FPF1 = [zeros(1,490e3) ones(1,1e3) zeros(1,18e3+1) ones(1,1e3) zeros(1,490e3)];  
FPF2 = [zeros(1,488.5e3) ones(1,1e3) zeros(1,21e3+1) ones(1,1e3) zeros(1,488.5e3)];
FPF3 = [zeros(1,486.5e3) ones(1,1e3) zeros(1,25e3+1) ones(1,1e3) zeros(1,486.5e3)];
ST1 = S1.*FPF1; % sinal 1 SSB (LS)
ST2 = S2.*FPF2; % sinal 2 SSB (LS)
ST3 = S3.*FPF3; % sinal 3 SSB (LS)
S = ST1+ST2+ST3; % sinal de transmissão

%%------------------------------------------------| SINAL DE RECEPÇÃO
STR1 = S.*FPF1; % sinal de recepção 1 SSB (LS)
STR2 = S.*FPF2; % sinal de recepção 2 SSB (LS)
STR3 = S.*FPF3; % sinal de recepção 3 SSB (LS)
str1 = ifft(ifftshift(STR1));
str2 = ifft(ifftshift(STR2));
str3 = ifft(ifftshift(STR3));
sr1 = str1.*osc1; % sinal de recepção 1 deslocado pro centro
sr2 = str2.*osc2; % sinal de recepção 2 deslocado pro centro
sr3 = str3.*osc3; % sinal de recepção 3 deslocado pro centro
SR1 = fftshift(fft(sr1));
SR2 = fftshift(fft(sr2));
SR3 = fftshift(fft(sr3));

FPB1 = [zeros(1,499e3) ones(1,2e3+1) zeros(1,499e3)];
FPB2 = [zeros(1,498e3) ones(1,4e3+1) zeros(1,498e3)];
FPB3 = [zeros(1,496e3) ones(1,8e3+1) zeros(1,496e3)];
SF1 = SR1.*FPB1; % sinal modulador 1 recuperado
SF2 = SR2.*FPB2; % sinal modulador 2 recuperado
SF3 = SR3.*FPB3; % sinal modulador 3 recuperado
sf1 = ifft(ifftshift(SF1));
sf2 = ifft(ifftshift(SF2));
sf3 = ifft(ifftshift(SF3));

%%------------------------------------------------| PLOT 
##figure(1)
##subplot(311)
##plot(f,abs(M1)/length(M1))
##xlim([-60e3 60e3])
##subplot(312)
##plot(f,abs(OSC1)/length(M1))
##xlim([-60e3 60e3])
##subplot(313)
##plot(f,abs(S1)/length(M1))
##xlim([-60e3 60e3])
##
##figure(2)
##subplot(311)
##plot(f,abs(M2)/length(M1))
##xlim([-60e3 60e3])
##subplot(312)
##plot(f,abs(OSC2)/length(M1))
##xlim([-60e3 60e3])
##subplot(313)
##plot(f,abs(S2)/length(M1))
##xlim([-60e3 60e3])
##
##figure(3)
##subplot(311)
##plot(f,abs(M3)/length(M1))
##xlim([-60e3 60e3])
##subplot(312)
##plot(f,abs(OSC3)/length(M1))
##xlim([-60e3 60e3])
##subplot(313)
##plot(f,abs(S3)/length(M1))
##xlim([-60e3 60e3])
##
##figure(4)
##subplot(411)
##plot(f,abs(ST1)/length(M1))
##xlim([-60e3 60e3])
##subplot(412)
##plot(f,abs(ST2)/length(M1))
##xlim([-60e3 60e3])
##subplot(413)
##plot(f,abs(ST3)/length(M1))
##xlim([-60e3 60e3])
##subplot(414)
##plot(f,abs(S)/length(M1))
##xlim([-60e3 60e3])

figure(5)
subplot(311)
plot(f,abs(SR1)/length(M1))
xlim([-60e3 60e3])
subplot(312)
plot(t,sr1)
xlim([0 2*(1/fm1)])
subplot(313)
plot(t,sf1)
xlim([0 2*(1/fm1)])

figure(6)
subplot(311)
plot(f,abs(SR2)/length(M1))
xlim([-60e3 60e3])
subplot(312)
plot(t,sr2)
xlim([0 2*(1/fm1)])
subplot(313)
plot(t,sf2)
xlim([0 2*(1/fm1)])

figure(7)
subplot(311)
plot(f,abs(SR3)/length(M1))
xlim([-60e3 60e3])
subplot(312)
plot(t,sr3)
xlim([0 2*(1/fm1)])
subplot(313)
plot(t,sf3)
xlim([0 2*(1/fm1)])
