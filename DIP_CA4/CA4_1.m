clc;clear;
import wavefast.m.*
img = imread('hurricane-katrina.tif');
wname = 'db4';
% Initialize arrays to store results
ratios = zeros(1, 10);
max_abs_diff = zeros(1, 10);
% Loop through n from 1 to 10
for n = 1:10
    % Measure execution time for wavedec2
    w1 = @() wavedec2(img, n, wname);
    t1 = timeit(w1);
    % Measure execution time for wavefast
    w2 = @() wavefast(img, n, wname); % replace wavefast with the actual function name
    t2 = timeit(w2);
    % Calculate ratio of t2 to t1
    ratios(n) = t2 / t1;
    % Perform wavelet decomposition using both functions
    [c1, l1] = wavedec2(img, n, wname);
    [c2, l2] = wavefast(img, n, wname); % replace wavefast with the actual function name
    % Calculate maximum absolute difference between w1 and w2
    max_abs_diff(n) = max(abs(c1 - c2));
end

% Plot the ratios of t2/t1 
figure;
subplot(2, 1, 1);
plot(1:10, ratios, '-o');
title('Execution Time Ratios');
xlabel('n');
ylabel('t2 / t1');

% Plot the maximum absolute differences between w1 and w2 for n = 1 to 10
subplot(2, 1, 2);
plot(1:10, max_abs_diff, '-o');
title('Maximum Absolute Differences');
xlabel('n');
ylabel('Max Abs Diff');

% Adjust layout
sgtitle('Comparison of wavedec2 and wavefast');
