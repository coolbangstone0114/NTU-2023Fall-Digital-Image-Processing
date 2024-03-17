clc
clear
% Read the lena.bmp image
lena = imread('lena.bmp');
% Take the Fourier transform of the Lena image
lena_fft = fft2(lena);
% Move the origin to the center of the image
lena_fft = fftshift(lena_fft);
% Compute the spectrum of the original image
spectrum_original = log(1 + abs(lena_fft));
% Create lowpass filters with Gaussian windows
lowpass_filter_10 = fspecial('gaussian', 512, 10);
lowpass_filter_30 = fspecial('gaussian', 512, 30);
% Apply lowpass filtering with sigma 10
lena_lowpass_10 = ifft2(ifftshift(lena_fft .* lowpass_filter_10));
% Apply lowpass filtering with sigma 30
lena_lowpass_30 = ifft2(ifftshift(lena_fft .* lowpass_filter_30));
% Display the original image
subplot(3, 4, 1);
imshow(lena, []);
title('Original Image');
% Display the spectrum of the original image
subplot(3, 4, 2);
imshow(spectrum_original, []);
title('Spectrum (Original)');
% Display the spectrum after lowpass filtering with sigma 10
spectrum_lowpass_10 = log(1 + abs(lena_fft .* lowpass_filter_10));
subplot(3, 4, 3);
imshow(spectrum_lowpass_10, []);
title('Spectrum (Lowpass, \sigma=10)');
% Display the lowpass filtered image with sigma 10
subplot(3, 4, 4);
imshow(real(lena_lowpass_10), []);
title('Lowpass Filtered (\sigma=10)');
% Display the spectrum after lowpass filtering with sigma 30
spectrum_lowpass_30 = log(1 + abs(lena_fft .* lowpass_filter_30));
subplot(3, 4, 5);
imshow(spectrum_lowpass_30, []);
title('Spectrum (Lowpass, \sigma=30)');
% Display the lowpass filtered image with sigma 30
subplot(3, 4, 6);
imshow(real(lena_lowpass_30), []);
title('Lowpass Filtered (\sigma=30)');
% Comment on the lowpass filtering results
disp('Lowpass filtering with smaller sigma (10) preserves more high-frequency details.');
disp('Lowpass filtering with larger sigma (30) results in more blurring.');

% Create highpass filters with Gaussian windows
highpass_filter_10 = 1 - lowpass_filter_10/max(lowpass_filter_10(:));
highpass_filter_30 = 1 - lowpass_filter_30/max(lowpass_filter_30(:));
% Apply highpass filtering with sigma 10
lena_highpass_10 = ifft2(ifftshift(lena_fft .* highpass_filter_10));
% Apply highpass filtering with sigma 30
lena_highpass_30 = ifft2(ifftshift(lena_fft .* highpass_filter_30));
% Display the spectrum after highpass filtering with sigma 10
spectrum_highpass_10 = log(1 + abs(lena_fft .* highpass_filter_10));
subplot(3, 4, 7);
imshow(spectrum_highpass_10, []);
title('Spectrum (Highpass, \sigma=10)');
% Display the highpass filtered image with sigma 10
subplot(3, 4, 8);
imshow(real(lena_highpass_10), []);
title('Highpass Filtered (\sigma=10)');
% Display the spectrum after highpass filtering with sigma 30
spectrum_highpass_30 = log(1 + abs(lena_fft .* highpass_filter_30));
subplot(3, 4, 9);
imshow(spectrum_highpass_30, []);
title('Spectrum (Highpass, \sigma=30)');
% Display the highpass filtered image with sigma 30
subplot(3, 4, 10);
imshow(real(lena_highpass_30), []);
title('Highpass Filtered (\sigma=30)');
% Comment on the highpass filtering results
disp('Highpass filtering with smaller sigma (10) enhances high-frequency details.');
disp('Highpass filtering with larger sigma (30) results in more pronounced high-frequency enhancement.');
% Adjust figure size and display the results
set(gcf, 'Position', [100, 100, 1200, 600]);
