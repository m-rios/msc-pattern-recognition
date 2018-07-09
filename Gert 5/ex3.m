% RNG init seed
rngs = 4;

%% Load data
load('data_lvq_A.mat');
load('data_lvq_B.mat');

%% Prepare data for RLVQ1
X = [matA; matB];
y = [zeros(100,1); ones(100,1)];

%% Execute RLVQ1
% reset RNG for proper reproduction
rng(rngs);
[w, err, lambda] = rlvq1(X, y, [0 0 1], 0.01);
%% Plot the data and the prototypes
cmap = [1 0 0; 0 0 1];

figure; colormap(cmap);
scatter(X(:,1), X(:,2), 5, y, 'filled'); hold on;
scatter(w(:,1), w(:,2), 50, [0 0 1]');
title('Original data with prototypes computed using RLVQ');

%% Plot both the error and lambdas over time
figure;
subplot(1,2,1);
plot(1:length(err), err);
title('Error over number of epochs for RLVQ');
xlabel('Epoch'); ylabel('Classification error');
subplot(1,2,2);
plot(1:length(lambda), lambda);
title('Lambda over number of epochs for RLVQ');
xlabel('Epoch'); ylabel('\lambda');

%% Perform 10-fold crossvalidation
k = 10;

o = split_data(k, X, y);
ps = [0 0 1];
rng(rngs);

E = zeros(10,1);

for i = 1:k
    r = 1:k;
    
    train = o(r(r~=i), :, :);
    train = reshape(train, (k - 1) * size(train,2), 3);
    
    test = o(r(r==i), :, :);
    test = reshape(test, size(test,2), 3);
    
    X_ic = train(:, 1:2);
    y_ic = train(:, 3);
    
    [w, ~, lambda] = rlvq1(X_ic, y_ic, ps, 0.01);
    
    E(i) = 0;
    % determine classification error for this fold
    for j = 1:size(test, 1)
        ds = lambda(end,1)*(w(:,1) - test(j,1)).^2 + lambda(end,2)*(w(:,2) - test(j,2)).^2;
        [~, w_i] = min(ds);

        E(i) = E(i) + (ps(w_i) ~= test(j,3));
    end
end

E = E / length(X) * k;

%% Plot results of 10-fold crossvalidation

figure;
bar(E);
title('Classification error using 10-fold crossvalidation for RLVQ');
xlabel('Test set used');
ylabel('Classification error');
mean(E)