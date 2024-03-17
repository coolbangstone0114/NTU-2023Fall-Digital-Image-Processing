clc;clear;
img = imread('hurricane-katrina.tif');
level = 4; wavelet_name = 'bior6.8';
% Perform the Cohen-Daubechies-Feauveau biorthogonal wavelet transform
[cm, sm] = wavefast(img, level, wavelet_name);

% (a) Smoothing process without noise
figure;
for i = 1:4
    subplot(2,2,i);
    [nc, g8] = wavezero(cm, sm, i, wavelet_name);
    imshow(g8);
    title(['Smoothed Image (Level ' num2str(i) ')']);
end
% (b) Display the difference image between img and g8 for different level values
figure;
for i = 1:4
    subplot(2, 2, i);
    [nc, g8] = wavezero(cm, sm, i, wavelet_name);
    difference_image = imabsdiff(img, g8);
    imshow(difference_image);
    title(['Difference Image (Level ' num2str(i) ')']);
end

%% Repeat the process with Gaussian noise
variance = 0.15;
noisy_img = imnoise(img, 'gaussian', 0, variance);
% Perform the wavelet transform on the noisy image
[cm_noisy, sm_noisy] = wavefast(noisy_img, level, wavelet_name);
% Find the best level with the highest PSNR
best_psnr = -Inf;
best_level = -Inf;
for i = 1:level
    [nc, g8] = wavezero(cm_noisy, sm_noisy, i, wavelet_name);
    denoised_img = g8;
    % Calculate PSNR
    psnr_value = psnr(denoised_img, img);
    % Update best level if PSNR is higher
    if psnr_value > best_psnr
        best_psnr = psnr_value;
        best_level = i;
    end
end

% Display the denoised image with the best level
[nc, g8] = wavezero(cm_noisy, sm_noisy, best_level, wavelet_name);
denoised_img_best = g8;
% Display results
figure;
subplot(1, 2, 1);
imshow(denoised_img_best);
title(['Denoised Image (Best Level ' num2str(best_level) ')']);
subplot(1, 2, 2);
imshow(noisy_img);
title('Gaussian Noise Image');
% Display PSNR
fprintf('Best Level: %d\n', best_level);
fprintf('PSNR: %.2f \n', best_psnr);
