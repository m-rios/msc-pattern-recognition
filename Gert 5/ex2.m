%% Load data
load('data_lvq_A.mat');
load('data_lvq_B.mat');

k = 10; % for k-fold crossvalidation

%% Prepare data
X = [matA; matB];
y = [zeros(100,1); ones(100,1)];

%% Partition data
o = split_data(k, X, y);
ps = [0 0 1];
rng(4);

E = zeros(10,1);

for i = 1:k
    r = 1:k;
    
    train = o(r(r~=i), :, :);
    train = reshape(train, (k - 1) * size(train,2), 3);
    
    test = o(r(r==i), :, :);
    test = reshape(test, size(test,2), 3);
    
    X_ic = train(:, 1:2);
    y_ic = train(:, 3);
    
    [w, ~, ~] = lvq1(X_ic, y_ic, ps, 0.01);
    
    E(i) = 0;
    % determine classification error for this fold
    for j = 1:size(test, 1)
        ds = (w(:,1) - test(j,1)).^2 + (w(:,2) - test(j,2)).^2;
        [~, w_i] = min(ds);

        E(i) = E(i) + (ps(w_i) ~= test(j,3));
    end
end

E = E / length(X) * k;
%% Plotting
figure;
bar(E);
title('Classification error using 10-fold crossvalidation');
xlabel('Test set used');
ylabel('Classification error');
mean(E)