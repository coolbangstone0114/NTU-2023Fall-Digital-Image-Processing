clc;clear;
figure; peppers = imread("peppers_gray.tif");
subplot(1,2,1); imshow(peppers);
% Create gaussian noise
g = imnoise(peppers, "gaussian");
subplot(1,2,2); imshow(g);

