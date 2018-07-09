clear; close all; clc;

load('checkerboard');
load('clusterCentroids');


%% Question 2
figure

subplot(2,2,1)
batchNG(checkerboard, 100, 20);
title('Batch Neural Gas, 20 epochs')

subplot(2,2,2)
batchNG(checkerboard, 100, 100);
title('Batch Neural Gas, 100 epochs')

subplot(2,2,3)
batchNG(checkerboard, 100, 200);
title('Batch Neural Gas, 200 epochs')

subplot(2,2,4)
batchNG(checkerboard, 100, 500);
title('Batch Neural Gas, 500 epochs')

%% Question 3
ps = kmeansb2(checkerboard,100);

figure, hold on;
scatter(checkerboard(:,1), checkerboard(:,2));
scatter(ps(:,1), ps(:,2), 'r', 'filled');
vor = voronoi(ps(:,1), ps(:,2), 'k', 10);
vor(2).LineWidth = 2
title('K-means with 100 clusters');