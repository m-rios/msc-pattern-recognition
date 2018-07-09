%% Reading
[y,Fs] = audioread('corrupted_voice.wav');
L = length(y);
%% Fourier Transform
Y = fft(y);

%% Plotting
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1) ;
title('Single-Sided Amplitude Spectrum of X(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');

%% Fixing
filt1 = [96 104]/(Fs/2);
filt2 = [5900 6100]/(Fs/2);

[b,a] = butter(2, filt1, 'stop');
[b2,a2] = butter(2, filt2, 'stop');

filtered1 = filter(b,a,y);
filtered2 = filter(b2,a2,filtered1);
sound(filtered2, Fs);

%% Result of filtering
Y2 = fft(filtered2);

P2 = abs(Y2/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1) ;
title('Single-Sided Amplitude Spectrum of X(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');

audiowrite('corrupted_voice_fixed.wav', filtered2, Fs);
