%% Normal distributions
mu_1 = [3 5];
mu_2 = [2 1];

sigma_1 = [1 0; 0 4];
sigma_2 = [2 0; 0 1];

p_1 = 0.3;
p_2 = 0.7;

%% Plotting

[X, Y] = meshgrid(-10:0.5:10, -10:0.5:10);
F_1 = mvnpdf([X(:), Y(:)], mu_1, sigma_1);
F_2 = mvnpdf([X(:), Y(:)], mu_2, sigma_2);

F = max(F_1, F_2);
F_res = reshape(F, length(Y), length(X));
g_f_res = reshape(dis, length(Y), length(X));
figure(1);
hold on;
mesh(X, Y, F_res);
xlabel('X');
ylabel('Y');
zlabel('Probability Density');