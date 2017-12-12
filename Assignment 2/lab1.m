data = [4 5 6; 6 3 9; 8 7 3; 7 4 8; 4 6 5];

mu = mean(data, 1);
% use parameter w=1 to get the biased covariance matrix
cov_m = cov(data, 1);

p_1 = mvnpdf([5 5 6], mu, cov_m);
p_2 = mvnpdf([3 5 7], mu, cov_m);
p_3 = mvnpdf([4 6.5 1], mu, cov_m);