clc
clear
img_pollen = imread("pollen.tif");

% Display the original image
figure;
subplot(2, 2, 1);
imshow(img_pollen);
title('Original Image');

% Apply histogram equalization
img_pollen_histeq = histeq(img_pollen);
subplot(2, 2, 2);
imshow(img_pollen_histeq);
title('Histogram Equalization');

% Display the histogram of the equalized image
subplot(2, 2, 3);
imhist(img_pollen);
title('Histogram of Original Image');
subplot(2, 2, 4);
imhist(img_pollen_histeq);
title('Histogram of Equalized Image');

% Perform histogram stretching using imadjust
% You need to manually select parameters for better visualization
low_in = 0.06;  % Adjust according to your preference
high_in = 0.3; % Adjust according to your preference
low_out = 0;
high_out = 1;
img_pollen_stretched = imadjust(img_pollen, [low_in, high_in], [low_out, high_out]);

% Display the stretched image
figure;
subplot(1, 2, 1);
imshow(img_pollen_stretched);
title('Histogram Stretched Image');
% Display the histogram of the stretched image
subplot(1, 2, 2);
imhist(img_pollen_stretched);
title('Histogram of Stretched Image');