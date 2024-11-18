% Write MATLAB/Python program for Mel-frequency cepstral coefficients (MFCC).

audio='sample.wav';
[signal, fs] = audioread(audio);
if size(signal,2)>1
    signal= mean(signal,2);
end
pre_emphasis = [1, -0.97];
emphasized_signal = filter(pre_emphasis, 1, signal);
frame_size = 0.025;
frame_stride = 0.01;
frame_length = round(frame_size * fs);
frame_step = round(frame_stride * fs);
signal_length = length(emphasized_signal);
num_frames = floor((signal_length - frame_length) / frame_step) + 1;
pad_signal_length = num_frames * frame_step + frame_length;
z = zeros(pad_signal_length - signal_length, 1);
padded_signal = [emphasized_signal; z];
indices = repmat(1:frame_length, num_frames, 1) + repmat((0:(num_frames - 1))' * frame_step, 1, frame_length);
frames = padded_signal(indices);
hamming_window = hamming(frame_length);
frames = frames .* hamming_window';
NFFT = 512;
mag_frames = abs(fft(frames, NFFT));
pow_frames = ((1 / NFFT) * ((mag_frames) .^ 2));
nfilt = 40;
low_freq_mel = 0;
high_freq_mel = (2595 * log10(1 + (fs / 2) / 700));
mel_points = linspace(low_freq_mel, high_freq_mel, nfilt + 2);
hz_points = (700 * (10.^(mel_points / 2595) - 1));
bin = floor((NFFT + 1) * hz_points / fs);
bin(bin < 1) = 1;
bin(bin > floor(NFFT / 2 + 1)) = floor(NFFT / 2 + 1);
fbank = zeros(nfilt, floor(NFFT / 2 + 1));
for m = 2:nfilt + 1
    f_m_minus = bin(m - 1);
    f_m = bin(m);
    f_m_plus = bin(m + 1);
    for k = f_m_minus:f_m
        fbank(m - 1, k) = (k - bin(m - 1)) / (bin(m) - bin(m - 1));
    end
    for k = f_m:f_m_plus
        fbank(m - 1, k) = (bin(m + 1) - k) / (bin(m + 1) - bin(m));
    end
end
filter_banks = pow_frames(:, 1:floor(NFFT / 2 + 1)) * fbank';
filter_banks = log(filter_banks);
mfcc = dct(filter_banks, [], 2);
mfcc = mfcc(:, 2:13);
figure;
imagesc(mfcc');
title('MFCC of Speech Signal');
xlabel('Time (frames)');
ylabel('MFCC Coefficients');
colorbar;