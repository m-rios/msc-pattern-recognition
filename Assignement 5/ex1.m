% For this script to work lvq1 and evaluate_color functions must be available
rng(6);
clear; close all; clc;
load('data_lvq_A.mat'), load('data_lvq_B.mat');
points = [matA;matB];
labels = [zeros(length(matA),1);ones(length(matB),1)];

%% Question 1
figure, hold on, grid on;
scatter(matA(:,1), matA(:,2), 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b', 'DisplayName', 'Class A');
scatter(matB(:,1), matB(:,2), 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r', 'DisplayName', 'Class B');
title('Scatter plot of the dataset');
% legend('show');

%% Question 4
mu = [mean(points(:,1)), mean(points(:,2))];
Sigma = [std(points(:,1)), std(points(:,2))];
randw = @() [randn * Sigma(1) + mu(1), randn * Sigma(2) + mu(2)];
w = [randw();randw();randw();randw()];
ws = [0;0;1;1];
[prot, err] = lvq1(points, labels, w, ws, 0.01);
%% Plot results
w_color = [0 0 1; 0 0 1; 1 0 0; 1 0 0];
scatter(w(:,1), w(:,2), 200, w_color);
legend('show');

figure, grid on, hold on;
plot([1:length(err)], err);

%% Question 5
[prot2, err2] = lvq1(points, labels, w(2:3,:), ws(2:3,:), 0.01);%1 1
[prot3, err3] = lvq1(points, labels, w(2:4,:), ws(2:4,:), 0.01);%1 2
[prot4, err4] = lvq1(points, labels, w(1:3,:), ws(1:3,:), 0.01);%2 1

ax = [1 max([length(err2) length(err3) length(err4) length(err)]) min([min(err) min(err2) min(err3)]) max([max(err) max(err2) max(err3)]) ];

figure, hold on;

subplot(2,2,1);
plot([1:length(err2)], err2);
axis(ax)
title('Training error for 1-1')
xlabel('epochs');
ylabel('error');

subplot(2,2,2);
plot([1:length(err3)], err3);
axis(ax)
xlabel('epochs');
ylabel('error');
title('Training error for 1-2')

subplot(2,2,3);
plot([1:length(err4)], err4);
axis(ax)
xlabel('epochs');
ylabel('error');
title('Training error for 2-1')

subplot(2,2,4);
plot([1:length(err)], err);
axis(ax)
xlabel('epochs');
ylabel('error');
title('Training error for 2-2')

%% Question 6

% Color the dataset

color1 = evaluate_color(points, w(2:3,:), ws(2:3,:));%1 1
color2 = evaluate_color(points, w(2:4,:), ws(2:4,:));%1 2
color3 = evaluate_color(points, w(1:3,:), ws(1:3,:));%2 1
color4 = evaluate_color(points, w, ws); % 2 2

%Plot
figure, hold on;

subplot(2,2,1);
hold on;
scatter(points(:,1), points(:,2), 40, color1);
title('Scatter plot for 1-1')

subplot(2,2,2);
hold on;
scatter(points(:,1), points(:,2), 40, color2);
title('Scatter plot for 1-2')

subplot(2,2,3);
hold on;
scatter(points(:,1), points(:,2), 40, color3);
title('Scatter plot for 2-1')

subplot(2,2,4);
hold on;
scatter(points(:,1), points(:,2), 40, color4, 'DisplayName', 'Class A');
title('Scatter plot for 2-2')