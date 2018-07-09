%% Q1
clear;clc;cla;
[x,fs] = audioread('corrupted_voice.wav');

% plot(t,x)
% xlabel('Time (seconds)')
% ylabel('Amplitude')
% xlim([0 t(end)])

y = fft(x);

T = 1/fs;             % Sampling period       
L = length(x);             % Length of signal
t = (0:L-1)*T;        % Time vector

P2 = abs(y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

%% Q2

[b, a] = butter(1,[80 120]/(fs/2), 'bandpass');
[b2, a2] = butter(1,[5950 6050]/(fs/2), 'bandpass');

f1 = filter (b, a, x);
f2 = filter (b2, a2, x);

sound(x-f1-f2, fs);

audiowrite('clean_voice.wav', x-f1-f2, fs);