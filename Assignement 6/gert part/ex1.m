clear; clc; close all;
load('kmeans1.mat');

ks = [2 4 8];

rng(0);

%% Ex 1-3

for i = 1:3
    k = ks(i);
    
    cmap = gray(k + 1);
    cmap = cmap(1:end-1,:);
    
    [ps, X_cls, ps_hist] = kmeansb(kmeans1, k, false);
    
    % Cluster assignments
    figure(1);
    subplot(1,3,i);
    scatter(kmeans1(:,1), kmeans1(:,2), 5, X_cls, '.');
    hold on;
    scatter(ps(:,1), ps(:,2), 40, 's', 'filled');
    title(['kmeans for k=' num2str(k)]);
    colormap(cmap);
    
    % save axis limits to make sure other plots are on the same limits
    c_xlim = xlim(); c_ylim = ylim();
    
    % Prototype movement
    figure(2);
    subplot(1,3,i);
    title(['kmeans prototype movement for k=' num2str(k)]);
    hold on;
    prev_ps = ps_hist{1};
    clear h;
    h(1) = scatter(prev_ps(:,1), prev_ps(:,2), 20, 's', 'filled');
    xlim(c_xlim); ylim(c_ylim);
    
    for j = 2:length(ps_hist)
        cur_ps = ps_hist{j};
        
        for m = 1:length(cur_ps)
            line([prev_ps(m,1) cur_ps(m,1)], [prev_ps(m,2) cur_ps(m,2)], 'Color', 'k');
        end
        
        h(j) = scatter(cur_ps(:,1), cur_ps(:,2), 20, 's', 'filled');
        
        prev_ps = cur_ps;
    end
    
    legend(h); 
end

%% Ex 4 -- calculation
rng(0);
krange = 20;
J = zeros(krange,1);
R = zeros(krange,1);
D = zeros(krange,1);

n_runs = 5;     % amount of runs to average on

for k = 1:krange
    for i = 1:n_runs
        [ps, ~] = kmeansb(kmeans1, k, false);
        J(k) = J(k) + quant_error(kmeans1, ps);
    end
    
    J(k) = J(k) / n_runs;
    R(k) = J(1)*k^(-2/2);
    D(k) = R(k) / J(k);
end

%% Ex4 -- plotting
figure;
plot(1:krange, D);
hold on;
[max_d, k_opt] = max(D);
text(k_opt, max_d, ['\leftarrow k_{opt} = ' num2str(k_opt)]);
title('R(k) / J(k)');
xlabel('k'); ylabel('R(k) / J(k)');

%% Ex5
figure;
plot(1:krange, [J R]);
hold on;
line([k_opt k_opt], [0 max(J)], 'Color', 'r');
text(k_opt, max(J)*.9, '\leftarrow k_{opt}');
legend('J(k)', 'R(k)');
title('J(k) and R(K) together with k_{opt}');
xlabel('k');

%% Ex7 -- calculation

load('checkerboard.mat');

for j = 1:10
    for i = 1:20
        % Normal k-means
        ps = kmeansb(checkerboard, 100, false);
        err_norm(j,i) = quant_error(checkerboard, ps);

        % k-means++
        ps = kmeansb(checkerboard, 100, true);
        err_plus(j,i) = quant_error(checkerboard, ps);
    end
end
%% Ex7 -- answers
x_plus = min(err_plus, [], 2);
x_norm = min(err_norm, [], 2);

plus_m = mean(x_plus)
plus_std = std(x_plus)

norm_m = mean(x_norm)
norm_std = std(x_norm)

[~, p] = ttest2(x_plus, x_norm, 'Tail', 'left')