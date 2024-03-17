clc
clear
x = imread("lena.bmp");
figure;
imshow(x);

% Do the resize here
resized_to_4x = imresize(imresize(x, 1/4), 4);
resized_to_8x = imresize(imresize(x, 1/8), 8);
resized_to_16x = imresize(imresize(x, 1/16), 16);
resized_to_32x = imresize(imresize(x, 1/32), 32);

% Display the resized images.
figure;
subplot(2,2,1);
imshow(resized_to_4x);
title('Resized to 1/4x then resized back');

subplot(2,2,2);
imshow(resized_to_8x);
title('Resized to 1/8x then resized back');

subplot(2,2,3);
imshow(resized_to_16x);
title('Resized to 1/16x then resized back');

subplot(2,2,4);
imshow(resized_to_32x);
title('Resized to 1/32x then resized back');

% Add a title to the figure.
sgtitle('Lena Image Resized to Different Sizes');

% Nearest, bilinear, and bicubic
resized_nearest = imresize(x, 1/8, "nearest");
resized_bilinear = imresize(x, 1/8, "bilinear");
resized_bicubic = imresize(x, 1/8, "bicubic");

% Display the three images
figure;
subplot(1,3,1);
imshow(resized_nearest);
title('nearest')

subplot(1,3,2);
imshow(resized_bilinear);
title('bilinear');

subplot(1,3,3);
imshow(resized_bicubic);
title('bicubic')