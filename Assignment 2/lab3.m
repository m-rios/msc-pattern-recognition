%% Initialization and plotting
mu = [3 4];
sigma = [1 0; 0 2];

[X, Y] = meshgrid(-10:0.1:10, -10:0.1:10);
F = mvnpdf([X(:), Y(:)], mu, sigma);
F_res = reshape(F, length(Y), length(X));
mesh(X, Y, F_res)
xlabel('X');
ylabel('Y');
zlabel('Probability Density');

%% Mahalanobis distances

obs = [10 10; 0 0; 3 4; 6 8];

for i = 1:4
    sqrt((obs(i,:)-mu)*inv(sigma)*(obs(i,:)-mu)')
end