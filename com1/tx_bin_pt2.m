%%------------------------------------------------|
% TRANSMISSÃO BINÁRIA - PARTE 2
% Comparação de Desempenho de Erro (Pb vs SNR)
%%------------------------------------------------|
##clear all; close all; clc
%%------------------------------------------------|

## 1)  RZ (1V) vs RZ (2V)
## 2)  RZ (1V) vs RZ (1V - filtro casado)
## 3)  RZ (1V - filtro casado) vs NRZ (1V - filtro casado)
## 4)  ....

#### 1)  RZ (1V) vs RZ (2V)
##SNR_dB_min = 0;
##SNR_dB_max = 15;
##vet_SNR = [SNR_dB_min:SNR_dB_max];
##A = 2; % nível de tensão da sinalização
##limiar = A/2;
##N = 5; % n. de amostras por duração do bit
##Rb = 1e6; % taxa de transmissão
##Tb = 1/Rb; % duração do bit
##fs = N*Rb; % frequência de amostragem
##Ts = 1/fs; % tempo de amostragem
##t=[0:Ts:1-Ts];
##filtro_NRZ = ones(1,N); % filtro NRZ
##info = randn(1,Rb)>0; % informação binária
##info_up = upsample(info,N); % informação super amostrada
##sinal_tx = filter(filtro_NRZ, 1, info_up)*A; %código de linha/sinal de tensão transmitido
##
##for SNR_dB = SNR_dB_min : SNR_dB_max
##  z_t = awgn(sinal_tx, SNR_dB);
##  z_T = z_t(N/2:N:end);
##  info_hat = z_T > limiar;
##  num_erro(SNR_dB+1) = sum(xor(info, info_hat));
##  taxa_erro(SNR_dB +1) = num_erro(SNR_dB+1)/length(info);
##end
##hold on
##semilogy(vet_SNR, taxa_erro,"-*;RZ (2V);")
##xlim([SNR_dB_min SNR_dB_max])
##xlabel('SNR [dB]')
##ylabel('Pb - BER')
##hold off

## 3)  RZ (1V - filtro casado) vs NRZ (1V - filtro casado)
SNR_dB_min = 0;
SNR_dB_max = 15;
vet_SNR = [SNR_dB_min:SNR_dB_max];
A = 1; % nível de tensão da sinalização
limiar = A/2;
N = 5; % n. de amostras por duração do bit
Rb = 1e6; % taxa de transmissão
Tb = 1/Rb; % duração do bit
fs = N*Rb; % frequência de amostragem
Ts = 1/fs; % tempo de amostragem
t=[0:Ts:1-Ts];
filtro_RZ = ones(1,N); % filtro RZ
filtro_RZ_casado = fliplr(filtro_RZ);
info = randn(1,Rb)>0; % informação binária
info_up = upsample(info,N); % informação super amostrada
sinal_tx = filter(filtro_RZ, 1, info_up)*(2*A)-A;%código de linha/sinal de tensão transmitido

for SNR_dB = SNR_dB_min : SNR_dB_max
  z_t = awgn(sinal_tx, SNR_dB);
  z_t = filter(filtro_RZ_casado,1,z_t)/N;
##  z_T = z_t(round(N/2):N:end);
  z_T = z_t(N:N:end);
  info_hat = z_T > limiar;
  num_erro(SNR_dB+1) = sum(xor(info, info_hat));
  taxa_erro(SNR_dB +1) = num_erro(SNR_dB+1)/length(info);
end
hold on
semilogy(vet_SNR, taxa_erro,"-*;NRZ (1V) - filtro casado;")
xlim([SNR_dB_min SNR_dB_max])
xlabel('SNR [dB]')
ylabel('Pb - BER')
hold off


#### 2)  RZ (1V) vs RZ (1V - filtro casado)
##SNR_dB_min = 0;
##SNR_dB_max = 15;
##vet_SNR = [SNR_dB_min:SNR_dB_max];
##A = 1; % nível de tensão da sinalização
##limiar = A/2;
##N = 5; % n. de amostras por duração do bit
##Rb = 1e6; % taxa de transmissão
##Tb = 1/Rb; % duração do bit
##fs = N*Rb; % frequência de amostragem
##Ts = 1/fs; % tempo de amostragem
##t=[0:Ts:1-Ts];
##filtro_RZ = ones(1,N); % filtro RZ
##filtro_RZ_casado = fliplr(filtro_RZ);
##info = randn(1,Rb)>0; % informação binária
##info_up = upsample(info,N); % informação super amostrada
##sinal_tx = filter(filtro_RZ, 1, info_up)*A; %código de linha/sinal de tensão transmitido
##
##for SNR_dB = SNR_dB_min : SNR_dB_max
##  z_t = awgn(sinal_tx, SNR_dB);
##  z_t = filter(filtro_RZ_casado,1,z_t)/N;
##  z_T = z_t(N/2:N:end);
##  z_T = z_t(N:N:end);
##  info_hat = z_T > limiar;
##  num_erro(SNR_dB+1) = sum(xor(info, info_hat));
##  taxa_erro(SNR_dB +1) = num_erro(SNR_dB+1)/length(info);
##end
##hold on
##semilogy(vet_SNR, taxa_erro,"-*;RZ (1V) - filtro casado;")
##xlim([SNR_dB_min SNR_dB_max])
##xlabel('SNR [dB]')
##ylabel('Pb - BER')
##hold off
