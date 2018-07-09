clear; clc; cla;
img = imread('chess.jpg');
bw = rgb2gray(img);
edges = edge(bw, 'Canny');
[H, T, R] = hough(edges);
P = houghpeaks(H,15);
highest_peak = P(1,:);
%% Show the f15 highest peaks
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho'), title('15 Highest Peaks in Hough Transform');
axis on, axis normal, hold on;
colormap(gca, hot); %colormap to distinguish values in the accumulator
plot(T(P(:,2)),R(P(:,1)),'s','color','white', 'MarkerSize', 10);

%% Plot 15 best lines
hold on;

figure, imshow(img);
hold on;
for l = 1:length(P)
    line = myhoughline2(img, R(P(l,1)), T(P(l,2))); %function very similar to myhoughline that returns the line to be plotted
    plot(line(1,:), line(2,:), 'LineWidth', 2, 'Color', 'g');
end
