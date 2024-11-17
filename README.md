% Write MATLAB/Python function to compute modified Discrete Cosine Transform (MDCT).
function X = mdct(x, N)
    % Ensure the input is a row vector
    x = x(:)';  
    % Length of the input signal
    len = length(x);
    % Number of MDCT frames
    numFrames = floor(len / (2 * N));
    % Initialize output matrix
    X = zeros(numFrames, N);
    % Apply MDCT frame by frame
    for frame = 1:numFrames
        % Extract the current 2N segment
        startIdx = (frame - 1) * 2 * N + 1;
        segment = x(startIdx:startIdx + 2 * N - 1);
        % Compute the MDCT for this segment
        for k = 0:N-1
            sumVal = 0;
            for n = 0:2*N-1
                sumVal = sumVal + segment(n + 1) * ...
                         cos(pi / N * (n + 0.5 + N/2) * (k + 0.5));
            end
            X(frame, k + 1) = sumVal;
        end
    end
end
% Example usage
x = randn(1, 1024);  % Random signal with 1024 samples
N = 256;             % Block size
X = mdct(x, N);      % Compute MDCT
disp(X);             % Display the result







