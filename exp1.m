% Write a MATLAB/Python function for visualizing Audio Signals - Reading from a File and Working on it.
function speechSignalProcessing(audioFile)
    % Read the audio file and convert to mono if it's stereo
    [audioSignal, fs] = audioread(audioFile);
    if size(audioSignal, 2) > 1
        audioSignal = mean(audioSignal, 2); % Convert stereo to mono
    end

    % Display the original speech signal
    figure(1);
    plot(audioSignal);
    title('Original Speech Signal');
    xlabel('Sample');
    ylabel('Amplitude');

    % Perform basic signal processing operations

    % 1. Fourier Transform
    fftSignal = fft(audioSignal);

    % 2. Power Spectrum
    powerSpectrum = abs(fftSignal).^2;

    % Display the processed speech signals
    figure(2);
    % Plot Fourier Transform
    freq = linspace(0, fs, length(fftSignal));
    plot(freq, powerSpectrum);
    title('Power Spectrum');
    xlabel('Frequency (Hz)');
    ylabel('Power');

    % 3. Spectrogram
    figure(3);
    spectrogram(audioSignal, 256, [], [], fs, 'yaxis');
    title('Spectrogram');

    % Save the spectrogram plot as an image
    saveas(gcf, 'Spectrogram.png');
end

% Example usage
audioFile = "sample.wav";
speechSignalProcessing(audioFile);
