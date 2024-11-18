% Write a MATLAB/Python function for the feature Extraction from Speech.

audioFile = 'sample.wav'; 
function extractSpeechFeatures(audioFile, frameSize, overlap)
   % Read audio file
   [signal, fs] = audioread(audioFile);
   % Normalize signal
   signal = signal / max(abs(signal));
   % Frame length and step
   frameStep = frameSize - overlap;
   % Total number of frames
   numFrames = floor((length(signal) - overlap) / frameStep);
   % Initialize features
   zcr = zeros(numFrames, 1);     % Zero-crossing rate
   ste = zeros(numFrames, 1);     % Short-time energy
   % Loop over frames
   for i = 1:numFrames
       % Define frame start and end points
       startIdx = (i-1)*frameStep + 1;
       endIdx = startIdx + frameSize - 1;
       % Extract current frame
       frame = signal(startIdx:min(endIdx, length(signal)));
       % Compute ZCR (zero-crossing rate)
       zcr(i) = sum(abs(diff(sign(frame)))) / (2 * length(frame));
       % Compute STE (short-time energy)
       ste(i) = sum(frame.^2) / length(frame);
   end
   features.ZCR = zcr;
   features.STE = ste;
   disp('Zero-Crossing Rate (ZCR):');
   disp(features.ZCR);             % Display ZCR feature as a vector
   disp('Short-Time Energy (STE):');
   disp(features.STE);             % Display STE feature as a vector
end
extractSpeechFeatures(audioFile, 1024, 128);
