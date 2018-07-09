% seed for RNG
rngs = 4;

%% Load data
load('data_lvq_A.mat');
load('data_lvq_B.mat');

%% Plot
figure;
plot(matA(:,1), matA(:,2), '.');
hold on;
plot(matB(:,1), matB(:,2), '*');
title('Supplied dataset');
legend('Class A', 'Class B');

%% Prepare data for LVQ1
X = [matA; matB];
y = [zeros(100,1); ones(100,1)];

%% Execute LVQ1
% reset RNG for proper reproduction
rng(rngs);
[~, err, ~] = lvq1(X, y, [0 0 1], 0.01);
%% Plot the classification error over the epochs
figure;
plot(1:length(err), err);
title('Classification error over the epochs');
xlabel('Epoch');
ylabel('Classification error');

%% With different values
%  1-1, 1-2, 2-1, 2-2
rng(rngs);
[w_1, err1, y_1] = lvq1(X, y, [0 1], 0.01); rng(rngs);
[w_2, err2, y_2] = lvq1(X, y, [0 1 1], 0.01); rng(rngs);
[w_3, err3, y_3] = lvq1(X, y, [0 0 1], 0.01); rng(rngs);
[w_4, err4, y_4] = lvq1(X, y, [0 0 1 1], 0.01);
%% in one plot
figure;
plot(1:length(err1), err1);
hold on;
plot(1:length(err2), err2);
plot(1:length(err3), err3);
plot(1:length(err4), err4);
legend('1-1', '1-2', '2-1', '2-2');
title('Comparison of error over epochs for different prototypes');
xlabel('Epoch');
ylabel('Classification error');
%% classifications in different plots
cmap = [1 0 0; 0 0 1];

figure;
title('Comparison of classications made using different prototypes');
subplot(2,2,1); colormap(cmap);
scatter(X(:,1), X(:,2), 5, y_1); hold on;
scatter(w_1(:,1), w_1(:,2), 50, [0 1]');
title('1-1');

subplot(2,2,2); colormap(cmap);
scatter(X(:,1), X(:,2), 5, y_2); hold on;
scatter(w_2(:,1), w_2(:,2), 50, [0 1 1]');
title('1-2');

subplot(2,2,3); colormap(cmap);
scatter(X(:,1), X(:,2), 5, y_3); hold on;
scatter(w_3(:,1), w_3(:,2), 50, [0 0 1]');
title('2-1');

subplot(2,2,4); colormap(cmap);
scatter(X(:,1), X(:,2), 5, y_4); hold on;
scatter(w_4(:,1), w_4(:,2), 50, [0 0 1 1]');
title('2-2');
