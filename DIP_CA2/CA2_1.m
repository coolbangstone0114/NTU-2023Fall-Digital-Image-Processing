clc
clear
% Create the first image with a single edge
img = [zeros(256, 128) ones(256, 128)];
% Move the origin to the center of the image
imgfft = fft2(img);
% Move the origin to the center of the image
imgfft = fftshift(imgfft);
% Compute the log of the absolute value of the Fourier transform
spectrum = log(1 + abs(imgfft));
% Display the original image
subplot(2, 2, 1);
imshow(img);
title('Original Image');
% Display the real part of the Fourier transform
subplot(2, 2, 2);
imshow(real(imgfft));
title('Real Part');
% Display the imaginary part of the Fourier transform
subplot(2, 2, 3);
imshow(imag(imgfft));
title('Imaginary Part');
% Display the spectrum of the image in the Fourier domain
subplot(2, 2, 4);
imshow(spectrum);
title('Spectrum');

% Repeat the process for a box
img = zeros(256, 256);
img(78:178, 78:178) = 1;
% Compute the Fourier transform of the box image using FFT
imgfft = fft2(img);
% Move the origin to the center of the image
imgfft = fftshift(imgfft);
% Compute the log of the absolute value of the Fourier transform
spectrum = log(1 + abs(imgfft));
% Display the box image
figure;
subplot(2, 2, 1);
imshow(img);
title('Box Image');
% Display the real part of the Fourier transform
subplot(2, 2, 2);
imshow(real(imgfft));
title('Real Part');
% Display the imaginary part of the Fourier transform
subplot(2, 2, 3);
imshow(imag(imgfft));
title('Imaginary Part');
% Display the spectrum of the image in the Fourier domain
subplot(2, 2, 4);
imshow(spectrum);
title('Spectrum');

% Repeat the process for a 45-degree rotated box
[x, y] = meshgrid(1:256, 1:256);
img = (x + y < 329) & (x + y > 182) & (x - y > -67) & (x - y < 73);
% Compute the Fourier transform of the rotated box image using FFT
imgfft = fft2(img);
% Move the origin to the center of the image
imgfft = fftshift(imgfft);
% Compute the log of the absolute value of the Fourier transform
spectrum = log(1 + abs(imgfft));
% Display the rotated box image
figure;
subplot(2, 2, 1);
imshow(img);
title('Rotated Box Image');
% Display the real part of the Fourier transform
subplot(2, 2, 2);
imshow(real(imgfft));
title('Real Part');
% Display the imaginary part of the Fourier transform
subplot(2, 2, 3);
imshow(imag(imgfft));
title('Imaginary Part');
% Display the spectrum of the image in the Fourier domain
subplot(2, 2, 4);
imshow(spectrum);
title('Spectrum');

% Repeat the process for a circle
[x, y] = meshgrid(-128:127, -128:127);
z = sqrt(x.^2 + y.^2);
img = (z < 20);
% Compute the Fourier transform of the circle image using FFT
imgfft = fft2(img);
% Move the origin to the center of the image
imgfft = fftshift(imgfft);
% Compute the log of the absolute value of the Fourier transform
spectrum = log(1 + abs(imgfft));
% Display the circle image
figure;
subplot(2, 2, 1);
imshow(img);
title('Circle Image');
% Display the real part of the Fourier transform
subplot(2, 2, 2);
imshow(real(imgfft));
title('Real Part');
% Display the imaginary part of the Fourier transform
subplot(2, 2, 3);
imshow(imag(imgfft));
title('Imaginary Part');
% Display the spectrum of the image in the Fourier domain
subplot(2, 2, 4);
imshow(spectrum, []);
title('Spectrum');

