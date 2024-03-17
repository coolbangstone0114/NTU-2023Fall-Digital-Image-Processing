clc
clear

x = imread("cameraman.tif");

% Display the original image
figure;
subplot(3, 3, 1);
imshow(x);
title('Original Image');

% Isolate the bit planes
xd = double(x);
c0 = mod(xd, 2);
c1 = mod(floor(xd/2), 2);
c2 = mod(floor(xd/4), 2);
c3 = mod(floor(xd/8), 2);
c4 = mod(floor(xd/16), 2);
c5 = mod(floor(xd/32), 2);
c6 = mod(floor(xd/64), 2);
c7 = mod(floor(xd/128), 2);

% Display the bit planes in subplots
subplot(3, 3, 2);
imshow(c0);
title('Bit Plane 0 (LSB)');

subplot(3, 3, 3);
imshow(c1);
title('Bit Plane 1');

subplot(3, 3, 4);
imshow(c2);
title('Bit Plane 2');

subplot(3, 3, 5);
imshow(c3);
title('Bit Plane 3');

subplot(3, 3, 6);
imshow(c4);
title('Bit Plane 4');

subplot(3, 3, 7);
imshow(c5);
title('Bit Plane 5');

subplot(3, 3, 8);
imshow(c6);
title('Bit Plane 6');

subplot(3, 3, 9);
imshow(c7);
title('Bit Plane 7 (MSB)');

% Check if c7 correct
ct = x > 127;
all(ct(:)==c7(:))

% Reconstruct the image
recon_c7 = uint8(c7 * 2^7);
recon_c6_and_c7 = uint8(c6 * 2^6 + c7 * 2^7);
recon_c4_to_c7 = uint8(c4 * 2^4 + c5 * 2^5 + c6 * 2^6 + c7 * 2^7);

% Display the three images
figure;
subplot(1,3,1);
imshow(recon_c7);
title('c7')

subplot(1,3,2);
imshow(recon_c6_and_c7);
title('c6 and c7');

subplot(1,3,3);
imshow(recon_c4_to_c7);
title('c4 to c7');