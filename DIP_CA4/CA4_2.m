clc;clear;
import wavefast.m.*
img = imread('zoneplate.tif');
% Compute wavelet decomposition coefficients using Haar wavelets
[cm, sm] = wavefast(img, 2, 'haar');
% (a) Display with the default setting (without scale)
wavedisplay(cm, sm);
title('Default Display');
% (b) Magnify default by the scale factor, scale = 8
wavedisplay(cm, sm, 8);
title('Magnify by Scale Factor 8');
% (c) Magnify absolute values by abs(scale) with scale = -8
wavedisplay(cm, sm, -8);
title('Magnify Absolute Values by Scale Factor -8');
% (d) Display the original image for comparison
figure;
imshow(img);
title('Original Image');

