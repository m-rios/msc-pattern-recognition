clear; clc;

mu1 = 5;
mu2 = 7;
var = 4;
Sigma = sqrt(var);
x = 10;

false_alarm = 1 - normcdf(x, mu1, Sigma);
hit_rate = 1 - normcdf(x, mu2, Sigma);

% Z1 = (x - mu1)/Sigma;
% cp1 = normcdf([Z1, inf]);
% cp1_aux = 1- normcdf(x, mu1, Sigma);
% false_alarm = cp1(2) - cp1(1)
% 
% Z2 = (x - mu2)/Sigma;
% cp2 = normcdf([Z2, inf]);
% hit = cp2(2)
% 
% discr = abs(mu2 - mu1)/Sigma
% discr2 = abs(mu1 - 9)/Sigma
% 
% mu2_q5 = 3*Sigma+5




%%

load('lab3_1');

% count 11
hits = sum(outcomes(:,1) == 1 & outcomes(:,2) == 1);

false_negatives = sum(outcomes(:,1) == 1 & outcomes(:,2) == 0);

hit_rate = hits/(hits+false_negatives)


false_alarm = sum(outcomes(:,1) == 0 & outcomes(:,2) == 1);
true_negatives = sum(outcomes(:,1) == 0 & outcomes(:,2) == 0);

fa_rate = false_alarm/(false_alarm+true_negatives);

%% Plot ROC
roc_coords = [hit_rate, fa_rate];

roc = @(fa_rate, d) 1-normcdf(-norminv(fa_rate), d, 1);

x = linspace(0,1);

figure;

hold on;

plot(roc_coords(2), roc_coords(1), 'Marker', 'o', 'MarkerFace', 'r', 'MarkerSize', 7, 'MarkerEdgeColor', 'r');
plot(x, roc(x,0), 'DisplayName','d=0');
plot(x, roc(x,1), 'DisplayName','d=1');
plot(x, roc(x,2), 'DisplayName','d=2');
plot(x, roc(x,3), 'DisplayName','d=3');
legend('show');
axis square;

