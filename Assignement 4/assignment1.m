clear; clc; cla;

img = imread('Cameraman.tiff');
edges = edge(img,'Canny');
[H, T, R] = hough(edges); %HT in H, values of theta and rho in T & R respectively

%% Plot the accumulator (H)

imshow(imadjust(mat2gray(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit'); %Rescale to T, R and plot the image
xlabel('\theta');
ylabel('\rho');
title('Hough Transform')
axis on, axis normal, hold on;
colormap(gca, hot); %colormap to distinguish values in the accumulator


%% Threshold the accumulator
th = max(max(H))*0.999; %threshold bellow which each value should be 0
apply_th = @(x) (x >= th) * x; %filter x that are above th
th_H = arrayfun(apply_th, H); %apply filter to H

%% Find maxima
[maxima, ind]=max(th_H(:)); %highest value in the thresholded accumulator
[row, col]=ind2sub(size(th_H),ind); %index in th_H of the maxima
max_theta = T(col); %get the value of those indexes
max_rho = R(row);


%% Five highest maxima
P  = houghpeaks(H,5); %find coordinates of the 5 highest peaks
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho'), title('5 Highest Peaks in Hough Transform');
axis on, axis normal, hold on;
colormap(gca, hot); %colormap to distinguish values in the accumulator
plot(T(P(:,2)),R(P(:,1)),'s','color','white', 'MarkerSize', 10);


%% Question 10
myhoughline(img, R(P(1,1)), T(P(1,2)));
