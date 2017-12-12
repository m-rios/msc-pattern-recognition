mu_1 = 5;
mu_2 = 7;
sigma = sqrt(4);

x_prime = 10;

hit_rate = 1 - cdf('Normal', x_prime, mu_2, sigma)

fa_rate = 1 - cdf('Normal', x_prime, mu_1, sigma)
