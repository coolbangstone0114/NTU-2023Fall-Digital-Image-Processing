%Q3
lena = imread('lena.bmp');
lenafft = fft2(lena);
gaussianlp = fftshift(fspecial("gaussian", 512, 10));
lena_lp = lenafft .* gaussianlp;
figure('Name', 'Q3_1');
subplot(2, 2, 1), imshow(lena), title('(a)original');
subplot(2, 2, 2), imshow(log(abs(fftshift(lenafft)) + 1), []), title('(b)spectrum');
subplot(2, 2, 3), imshow(log(abs(fftshift(lena_lp)) + 1), []), title('(c)spectrum after lowpass filtering');
subplot(2, 2, 4), imshow(real(ifft2(lena_lp)),[]), title('(d)lowpass filtered image');
sgtitle('Gaussian Lowpass Filter with sigma = 10');

gaussianlp = fftshift(fspecial("gaussian", 512, 30));
lena_lp = lenafft .* gaussianlp;
figure('Name', 'Q3_2');
subplot(2, 2, 1), imshow(lena), title('(a)original');
subplot(2, 2, 2), imshow(log(abs(fftshift(lenafft)) + 1), []), title('(b)spectrum');
subplot(2, 2, 3), imshow(log(abs(fftshift(lena_lp)) + 1), []), title('(c)spectrum after lowpass filtering');
subplot(2, 2, 4), imshow(real(ifft2(lena_lp)),[]), title('(d)lowpass filtered image');
sgtitle('Gaussian Lowpass Filter with sigma = 30');

gaussianlp = fftshift(fspecial('gaussian', 512, 10));
gaussianlp = gaussianlp/max(gaussianlp(:));
gaussianhp = 1 - gaussianlp;
lena_hp = lenafft .* gaussianhp;
figure('Name', 'Q3_3');
subplot(2, 2, 1), imshow(lena), title('(a)original');
subplot(2, 2, 2), imshow(log(abs(fftshift(lenafft)) + 1), []), title('(b)spectrum');
subplot(2, 2, 3), imshow(log(abs(fftshift(lena_hp)) + 1), []), title('(c)spectrum after highpass filtering');
subplot(2, 2, 4), imshow(real(ifft2(lena_hp)), []), title('(d)highpass filtered image');
sgtitle('Gaussian Highpass Filter with sigma = 10');

gaussianlp = fftshift(fspecial('gaussian', 512, 30));
gaussianlp = gaussianlp / max(gaussianlp(:));
gaussianhp = 1 - gaussianlp;
lena_hp = lenafft .* gaussianhp;
figure('Name', 'Q3_4');
subplot(2, 2, 1), imshow(lena), title('(a)original');
subplot(2, 2, 2), imshow(log(abs(fftshift(lenafft)) + 1), []), title('(b)spectrum');
subplot(2, 2, 3), imshow(log(abs(fftshift(lena_hp)) + 1), []), title('(c)spectrum after highpass filtering');
subplot(2, 2, 4), imshow(real(ifft2(lena_hp)), []), title('(d)highpass filtered image');
sgtitle('Gaussian Highpass Filter with sigma = 30');