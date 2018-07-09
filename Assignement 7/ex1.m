clear; clc; close all;
load('cluster_data.mat');

dst = pdist2(cluster_data, cluster_data);
% we only take the upper left corner as an optimization
% dst is symmetric, so to avoid double lines we only take half of the
% points
dst = dst + (triu(ones(length(cluster_data))) * 10);

ts = [0.1 0.2 0.05 0.25 0.15];

figure;

for i = 1:length(ts)
    t = ts(i);
    lixs = find(dst < t);
    [Ys, Xs] = ind2sub(size(dst), lixs);
    
    subplot(2,3,i);
    title(['t = ' num2str(t)]);
    hold on;
    for ix = 1:length(lixs)
        line([cluster_data(Ys(ix), 1) cluster_data(Xs(ix), 1)], [cluster_data(Ys(ix), 2) cluster_data(Xs(ix), 2)], 'Color', 'k');
    end
    scatter(cluster_data(:,1), cluster_data(:,2), 2, '.');
end

%% Clustering
figure;

t = 0.1;
lixs = find(dst < t);
[Ys, Xs] = ind2sub(size(dst), lixs);

title(['Clustering for t = ' num2str(t)]);
hold on;
for ix = 1:length(lixs)
    line([cluster_data(Ys(ix), 1) cluster_data(Xs(ix), 1)], [cluster_data(Ys(ix), 2) cluster_data(Xs(ix), 2)], 'Color', 'k');
end
scatter(cluster_data(:,1), cluster_data(:,2), 50, '.');