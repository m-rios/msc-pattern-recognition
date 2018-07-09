clear; clc;

load lab3_3_cat1;
load lab3_3_cat2;
load lab3_3_cat3;

u = [0.5 1 0]';
v = [0.31 1.51 -0.5]';
w = [-1.7 -1.7 -1.7]';
h = 2;
%% 

parzen = @(x, k, h) exp(-((x(1)-k(1))^2+(x(2)-k(2))^2+(x(3)-k(3))^2)/2*h^2);

x = [u, v, w];
classes = x_w1;
classes(:,:,2) = x_w2;
classes(:,:,3) = x_w3;
density = zeros(3);
for k = 1:3
    for p = 1:3
        for j = 1:10
            density(k, p) = density(k, p) + parzen(x(:,p), classes(j,:,k)', h);
        end
    end
end

density = density/(h*sqrt(2*pi))^3/10;

%% Posterior
posterior = zeros(3);
for k = 1:3
    for p = 1:3
        posterior(k,p) = (density(k,p)*1/3)/(density(1,p)*1/3 + density(2,p)*1/3 + density(3,p)*1/3)
    end
end

[maxP, bestClass] = max(posterior)

%% KNN

data = [x_w1;x_w2;x_w3];
labels = floor((0:29)/10 + 1);

u1 = KNN(u, 1, data, labels)
v1 = KNN(v, 1, data, labels)
w1 = KNN(w, 1, data, labels)

u5 = KNN(u, 5, data, labels)
v5 = KNN(v, 5, data, labels)
w5 = KNN(w, 5, data, labels)
