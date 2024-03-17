clc
clear
%%
% Load the original image
f = imread("./peppers.bmp");
fs_input_points = load("./data-points/fs_input_points_8.mat");
fs_base_points = load("./data-points/fs_base_points_8.mat");
fsr_input_points = load("./data-points/fsr_input_points_8.mat");
fsr_base_points = load("./data-points/fsr_base_points_8.mat");
fss_input_points = load("./data-points/fss_input_points_8.mat");
fss_base_points = load("./data-points/fss_base_points_8.mat");

% Set transformation matrix 1
sx = 0.85;
sy = 1.15;
T1 = [sx, 0, 0;
      0, sy, 0;
      0, 0, 1];
t1 = affine2d(T1);
fs = imwarp(f, t1);

% Set transformation matrix 2
theta = pi/6;
T2 = [cos(theta), sin(theta), 0;
     -sin(theta), cos(theta), 0;
     0, 0, 1];
t2 = affine2d(T2);
fsr = imwarp(fs, t2);

% Set transformation matrix 3
alpha = 0.75;
T3 = [1, 0, 0;
      alpha, 1, 0;
      0, 0, 1];
t3 = affine2d(T3);
fss = imwarp(fs, t3);
%%

% Display the original and transformed images
subplot(2, 2, 1);
imshow(f);
title('Original Image');

subplot(2, 2, 2);
imshow(fs);
title('Transformed Image (fs)');

subplot(2, 2, 3);
imshow(fsr);
title('Transformed Image (fsr)');

subplot(2, 2, 4);
imshow(fss);
title('Transformed Image (fss)');
%%
% cpselect(fss, f)
% save('base_points.mat', 'base_points');
% save('input_points.mat', 'input_points');
%%
% Perform recover
tietform = fitgeotrans(fs_input_points.input_points, ...
    fs_base_points.base_points, "affine");
fs2 = imwarp(fs, tietform);
win_fs2 = centerCropWindow2d(size(fs2), [512 512]);
fs2 = imcrop(fs2, win_fs2);

tietform = fitgeotrans(fsr_input_points.fsr_input_points, ...
    fsr_base_points.fsr_base_points, "affine");
fsr2 = imwarp(fsr, tietform);
win_fsr2 = centerCropWindow2d(size(fsr2), [512 512]);
fsr2 = imcrop(fsr2, win_fsr2);

tietform = fitgeotrans(fss_input_points.fss_input_points, ...
    fss_base_points.fss_base_points, "affine");
fss2 = imwarp(fss, tietform);
win_fss2 = centerCropWindow2d(size(fss2), [512 512]);
fss2 = imcrop(fss2, win_fss2);

% Display recover image
figure

% Original Image
subplot(3,4,1)
imshow(f)
title('Original Image')

% fs
subplot(3,4,2)
imshow(fs)
title('fs')

% Transform back from fs
subplot(3,4,3)
imshow(fs2)
title('8 Transform back from fs')

% Difference Image for fs2
subplot(3,4,4)
imshow(fs2 - f)
title('Difference Image (fs2)')

% Original Image for fsr
subplot(3,4,5)
imshow(f)
title('Original Image')

% fsr
subplot(3,4,6)
imshow(fsr)
title('fsr')

% Transform back from fsr
subplot(3,4,7)
imshow(fsr2)
title('8 Transform back from fsr')

% Difference Image for fsr2
subplot(3,4,8)
imshow(fsr2 - f)
title('Difference Image (fsr2)')

% Original Image for fss
subplot(3,4,9)
imshow(f)
title('Original Image')

% fss
subplot(3,4,10)
imshow(fss)
title('fss')

% Transform back from fss
subplot(3,4,11)
imshow(fss2)
title('8 Transform back from fss')

% Difference Image for fss2
subplot(3,4,12)
imshow(fss2 - f)
title('Difference Image (fss2)')
