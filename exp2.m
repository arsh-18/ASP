% Write a MATLAB / Python function for characterizing the Audio Signal: Transforming to Frequency Domain.

function plot_audio_spectrum(file_path)
   [audio_data, sample_rate] = audioread(file_path);
   % If stereo, take only one channel
   if size(audio_data, 2) > 1
       audio_data = audio_data(:, 1);
    end
   % Normalize audio data
   audio_data = audio_data / max(abs(audio_data));
   % Compute the FFT
   N = length(audio_data);
   fft_values = fft(audio_data);
   fft_values = fft_values(1:N/2); % Take the positive frequency part
   fft_values = abs(fft_values);   % Get the magnitude
   % Frequency axis
   freqs = (0:N/2-1)*(sample_rate/N);
   % Plot the frequency spectrum
   figure;
   plot(freqs, fft_values);
   title('Frequency Spectrum');
   xlabel('Frequency (Hz)');
   ylabel('Magnitude');
   grid on;
end
plot_audio_spectrum('sample.wav');