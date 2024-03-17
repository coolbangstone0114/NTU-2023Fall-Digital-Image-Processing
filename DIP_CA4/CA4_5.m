clc;clear;
img = imread('barbara.tif');
level = 4;
wavelet_name = 'jpeg9.7';
% Perform the Antonini-Barlaud-Mathieu-Daubechies wavelet transform
[cm, sm] = wavefast(img, level, wavelet_name);
wavedisplay(cm, sm, 8);
title('Wavelet Coefficients');

reconstructed_images = cell(1, level + 1);
% Reconstruct images with different resolutions
figure;
for i = 1:(level + 1)
    % Copy coefficients for reconstruction
    yi = wavecopy('a', cm, sm);    
    % Display the reconstructed image
    subplot(2, 3, i);
    imshow(mat2gray(yi));
    title(['Resolution level' num2str(i)]);
    % Store the reconstructed image
    reconstructed_images{i} = yi;
    
    % If not the last level, perform one-scale inverse FWT for the next iteration
    if i < (level + 1)
        [cm, sm] = waveback(cm, sm, wavelet_name, 1);
    end
end

% Display the original image
subplot(2, 3, level + 2);
imshow(mat2gray(img));
title('Original Image');

% Calculate the difference image between the final reconstruction and the original image
difference_image = imabsdiff(img, uint8(reconstructed_images{end}));
% Display the difference image
figure;
imshow(mat2gray(difference_image));
title('Difference Image');
