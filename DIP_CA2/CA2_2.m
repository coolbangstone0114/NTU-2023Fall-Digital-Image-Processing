clc
clear
% Read the cameraman image
cameraman = imread('cameraman.tif');
% Take the Fourier transform of the image
cameraman_fft = fft2(cameraman);
% Move the origin to the center of the image
cameraman_fft = fftshift(cameraman_fft);
% Compute the spectrum of the original image
spectrum_original = log(1 + abs(cameraman_fft));
% Create a circle matrix for lowpass and highpass filtering
[x, y] = meshgrid(-128:127, -128:127);
z = sqrt(x.^2 + y.^2);
% Create lowpass and highpass filter masks
lowpass_filter_5 = (z < 5);
lowpass_filter_30 = (z < 30);
highpass_filter_5 = (z > 5);
highpass_filter_30 = (z > 30);
% Apply lowpass filtering with a cutoff frequency of 5
cameraman_lowpass_5 = ifft2(ifftshift(cameraman_fft .* lowpass_filter_5));
% Apply lowpass filtering with a cutoff frequency of 30
cameraman_lowpass_30 = ifft2(ifftshift(cameraman_fft .* lowpass_filter_30));
% Apply highpass filtering with a cutoff frequency of 5
cameraman_highpass_5 = (ifft2(ifftshift(cameraman_fft .* highpass_filter_5)));
% Apply highpass filtering with a cutoff frequency of 30
cameraman_highpass_30 = (ifft2(ifftshift(cameraman_fft .* highpass_filter_30)));
% Display the original image
subplot(2, 3, 1);
imshow(cameraman, []);
title('Original Image');
% Display the spectrum of the original image
subplot(2, 3, 2);
imshow(spectrum_original, []);
title('Spectrum (Original)');
% Display the spectrum after lowpass filtering with a cutoff of 5
spectrum_lowpass_5 = log(1 + abs(cameraman_fft .* lowpass_filter_5));
subplot(2, 3, 3);
imshow(spectrum_lowpass_5, []);
title('Spectrum (Lowpass, 5)');
% Display the lowpass filtered image with a cutoff of 5
subplot(2, 3, 4);
imshow(abs(cameraman_lowpass_5), []);
title('Lowpass Filtered (5)');
% Display the spectrum after lowpass filtering with a cutoff of 30
spectrum_lowpass_30 = log(1 + abs(cameraman_fft .* lowpass_filter_30));
subplot(2, 3, 5);
imshow(spectrum_lowpass_30, []);
title('Spectrum (Lowpass, 30)');
% Display the lowpass filtered image with a cutoff of 30
subplot(2, 3, 6);
imshow(abs(cameraman_lowpass_30), []);
title('Lowpass Filtered (30)');
% Comment on the results
disp('Lowpass filtering with cutoff of 5: Preserves low-frequency details.');
disp('Lowpass filtering with cutoff of 30: Preserves more details but smooths the image.');

% Display the original image
figure;
subplot(2, 3, 1);imshow(cameraman, []);title('Original Image');
% Display the spectrum of the original image
subplot(2, 3, 2);imshow(spectrum_original, []);title('Spectrum (Original)');
% Display the spectrum after highpass filtering with a cutoff of 5
spectrum_highpass_5 = log(1 + abs(cameraman_fft .* highpass_filter_5));
subplot(2, 3, 3);imshow(spectrum_highpass_5, []);title('Spectrum (Highpass, 5)');
% Display the highpass filtered image with a cutoff of 5
subplot(2, 3, 4);imshow(real(cameraman_highpass_5), []);title('Highpass Filtered (5)');
% Display the spectrum after highpass filtering with a cutoff of 30
spectrum_highpass_30 = log(1 + abs(cameraman_fft .* highpass_filter_30));
subplot(2, 3, 5);imshow(spectrum_highpass_30, []);title('Spectrum (Highpass, 30)');
% Display the highpass filtered image with a cutoff of 30
subplot(2, 3, 6);imshow(real(cameraman_highpass_30), []);title('Highpass Filtered (30)');
% Comment on the results
disp('Highpass filtering with cutoff of 5: Enhances high-frequency details.');
disp('Highpass filtering with cutoff of 30: Preserves more high-frequency details.');
