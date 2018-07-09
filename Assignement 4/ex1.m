%% Q1
f = imread('Cameraman.tiff');
%% Q2
edges = edge(f,'Canny');
%% Q3
[H,T,R] = hough(edges);
%% Q4
imshow(H / 256,'XData',T,'YData',R,'InitialMagnification','fit');
title('Hough transform of Cameraman.tif');
xlabel('\theta'), ylabel('\rho');
colormap(gca,hot);
axis on, axis normal;
%% Q6
threshold = max(max(H)) * 0.999;
H(H < threshold) = 0;
%% Q7
[X,Y] = find(H == max(max(H)));
local_max = H(X,Y);
%% Q8
% recalculate hough, since thresholding only leaves one point
[H_r,~,~] = hough(edges);
[~, I_h] = sort(H_r(:), 'descend');

top5 = I_h(1:5);
[I,J] = ind2sub(size(H_r), top5);
hold on;
for i = 1:5
    plot(T(J(i)), R(I(i)), '+w', 'MarkerSize', 10);
end
%% Q10
[X,Y] = find(H == max(max(H)));
rho_m = R(X); theta_m = T(Y);
myhoughline(f, rho_m, theta_m);
