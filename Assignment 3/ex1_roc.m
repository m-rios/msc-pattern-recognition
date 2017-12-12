mu_1 = 0;
mu_2 = 1;
sigma = 2.5;

cutoff = 0.5;

xs = -2:.1:200;
hit_rate = zeros(1, length(xs));
fa_rate = zeros(1, length(xs));

for i = 1:length(xs)
    hit_rate(i) = 1 - cdf('Normal', mu_2, sigma, xs(i));
    fa_rate(i) = cdf('Normal', mu_1, sigma, xs(i));
end

clf;
plot(0.1, 0.8, '.');
hold on;
plot(fa_rate, hit_rate);