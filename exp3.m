% Write a MATLAB/Python function for generating a Monotone Audio Signal.

% Parameters
fs = 44200;  % Sampling frequency (Hz)
duration = 1; % Duration of the tone (seconds)
frequency = 2000; % Frequency of the tone (Hz) - A4 note
amplitude = 1; % Amplitude of the signal (between 0 and 1)
% Time vector
t = 0:1/fs:duration;
% Generate the monotone signal
signal = amplitude * sin(2 * pi * frequency * t);
% Play the signal
sound(signal, fs);
audiowrite('testing.wav', signal,fs);