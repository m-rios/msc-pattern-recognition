clear; clc; close all;
load('cluster_data.mat');

%% Single linkage
Z = linkage(cluster_data, 'single');
c = cluster(Z, 'maxclust', 4);

figure;
colors = [1 0 0; 0 1 0; 0 0 1; 0 1 1];
colormap(colors);
scatter(cluster_data(:,1), cluster_data(:,2), 3, c);
hold on;

for i = 1:4
    scatter(mean(cluster_data(c==i,1)), mean(cluster_data(c==i,2)), 50, 'ks', 'filled');
end

%% Complete linkage
Z = linkage(cluster_data, 'complete');
c = cluster(Z, 'maxclust', 4);

figure;
colors = [1 0 0; 0 1 0; 0 0 1; 0 1 1];
colormap(colors);
scatter(cluster_data(:,1), cluster_data(:,2), 3, c);
hold on;

for i = 1:4
    scatter(mean(cluster_data(c==i,1)), mean(cluster_data(c==i,2)), 50, 'ks', 'filled');
end

%% Dendrogram for average
Z = linkage(cluster_data, 'average');
dendrogram(Z);
title('Dendrogram for average linkage');