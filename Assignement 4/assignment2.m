clear; clc; cla;

img = imread('cameraman.tif');
edges = edge(img,'Canny');
[H2, T2, R2] = hough(edges, 'RhoResolution',1,'ThetaResolution',1);
[H, T, R] = myhough(edges, 1); %HT in H, values of theta and rho in T & R respectively

%% Custom
% subplot(3,2,1);
subplot(1,2,1);
imshow(imadjust(mat2gray(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit'); %Rescale to T, R and plot the image
xlabel('\theta');
ylabel('\rho');
title('Custom Hough Transform')
axis on, axis normal, hold on;
colormap(gca, hot); %colormap to distinguish values in the accumulator

%% Default
% subplot(3,2,2);
subplot(1,2,2);
imshow(imadjust(mat2gray(H2)),'XData',T2,'YData',R2,...
      'InitialMagnification','fit'); %Rescale to T, R and plot the image
xlabel('\theta');
ylabel('\rho');
title('Default Hough Transform')
axis on, axis normal, hold on;
colormap(gca, hot); %colormap to distinguish values in the accumulator

%% Difference
H3 = abs(H-H2);
subplot(3,2,[3 4 5 6]);
imshow(imadjust(mat2gray(H3)),'XData',T2,'YData',R2,...
      'InitialMagnification','fit'); %Rescale to T, R and plot the image
xlabel('\theta');
ylabel('\rho');
title('Difference')
axis on, axis normal, hold on;
colormap(gca, hot); %colormap to distinguish values in the accumulator