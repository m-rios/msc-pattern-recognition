%% Q1
clear;clc;cla;
img = imread('HeadTool0002.bmp');
%% Q2
prepro_img = adapthisteq(img);
%% Q3
[centers,radii] = imfindcircles(prepro_img,[20,40], 'Sensitivity', 0.9);

%% Q4
figure, imshow(prepro_img);
viscircles(centers,radii, 'Color', 'r');

%% Q6
figure, imshow(prepro_img);
viscircles(centers(1:2,:),radii(1:2), 'Color', 'r');