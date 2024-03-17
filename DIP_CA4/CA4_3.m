clc;clear;
img = imread('test_pattern.tif');

% (a) Compute the 4th order Symlets wavelet transform
[cm, sm] = wavefast(img, 1, 'sym4');
% Display the wavelet coefficients
wavedisplay(cm, sm, -6);
title('Wavelet Coefficients (Original)');

% (b) Zero coefficients using wavecut
[nc, ym] = wavecut('a', cm, sm);
wavedisplay(nc, sm, -6);
title('Zeroed Coefficients');

% (c) Compute inverse FWT and display the image
img_reconstructed = mat2gray(abs(waveback(nc, sm, 'sym4')));

figure;
subplot(1,2,1);
imshow(img);
title('Original Image');
subplot(1,2,2);
imshow(img_reconstructed);
title('Reconstructed Image');
% Adjust layout
sgtitle('Wavelet Transform and Reconstruction');
