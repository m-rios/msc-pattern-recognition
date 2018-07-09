clear; clc; cla;
img = imread('dogGrayRipples.png');

y = fft2(img);
f = fftshift(y);
imagesc(abs(fftshift(y)));

im = ifft2(f);

imshow(im);