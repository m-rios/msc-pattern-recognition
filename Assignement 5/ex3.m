% For this script to work [] functions must be available
clear; close all; clc;
load('data_lvq_A.mat'), load('data_lvq_B.mat');
points = [matA;matB];
labels = [zeros(length(matA),1);ones(length(matB),1)];

%% Question 2
mu = [mean(points(:,1)), mean(points(:,2))];
Sigma = [std(points(:,1)), std(points(:,2))];
randw = @() [randn * Sigma(1) + mu(1), randn * Sigma(2) + mu(2)];
w = [randw();randw();randw()];
ws = [0;0;1];

[w error, lambdas] = rlvq(points, labels, w, ws, 0.01);
color = evaluate_color(points, w, ws);
w_colors = [0 0 1; 0 0 1; 1 0 0];
%% Plot for Q2
figure, hold on, grid on;

scatter(points(:,1), points(:,2), 40, color, 'DisplayName', 'Class A');
scatter(w(:,1), w(:,2),100, w_colors, 'MarkerFaceColor', 'auto');
title('RLVQ classification for \lambda = [0.5 0.5], 2 prototypes for A and 1 for B')

%% Q3 
figure;

subplot(1,2,1);
grid on;
plot([1:length(error)], error);
title('Training error')
xlabel('epochs');
ylabel('error');

subplot(1,2,2);
hold on, grid on;
plot([0:length(error)], lambdas(:,1));
plot([0:length(error)], lambdas(:,2));
title('Evolution of \lambda')
xlabel('epochs');
ylabel('\lambda');

%% Q4

[errors, error] = k_fold_cross_validation(points, labels, 10);

figure;
hold on, grid on;
bar(errors, 'DisplayName', 'Error per susbset');
hline = refline(0,error);hline.Color = 'r';hline.DisplayName = 'Avg error';
xlabel('Subset left out');
ylabel('Error');
legend('Show');
title('Error per test subset');
