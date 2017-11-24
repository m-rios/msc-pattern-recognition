clc; clear; cla;
load('data/lab1_1.mat');

height = lab1_1(:,1);
age = lab1_1(:,2);
weight = lab1_1(:,3);
c = [];
for i = 1:3
    row = [];
    for j = 1:3
        row = [row, pairwise_correlation(lab1_1(:,i), lab1_1(:,j))]
    end
    c = [c;row];
end


hold on;
plot(height, weight, 'or');
title('Features with the highest correlation');
xlabel('Height in cm');
ylabel('Weight in Kg');


axis 'equal';
axis 'square';

figure;
plot(age, weight, 'or');
title('Features with the second highest correlation');
xlabel('Age in years');
ylabel('Weight in kg');

axis 'equal';
axis 'square';

figure;
plot(height, age, '+');

axis 'equal';
axis 'square';