% For this script to work [k_fold_sepparation, initialise_w, lvq1] functions must be available
clear, close all, clc;
load('data_lvq_A.mat'), load('data_lvq_B.mat');
points = [matA;matB];
labels = [zeros(length(matA),1);ones(length(matB),1)];

[errors, error] = k_fold_cross_validation(points, labels, 10);

figure;
hold on, grid on;
bar(errors, 'DisplayName', 'Error per susbset');
hline = refline(0,error);hline.Color = 'r';hline.DisplayName = 'Avg error';
xlabel('Subset left out');
ylabel('Error');
legend('Show');
title('Error per test subset');