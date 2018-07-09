clear; cla; clc;
format long;
fs = [  4 6 8 7 4;
        5 3 7 4 6;
        6 9 3 8 5];
mu = [mean(fs(1,:)); mean(fs(2,:)); mean(fs(3,:))];
C = cov(fs',1)

% figure;
% hold on;
% fplot(@(n) 1/n)
% fplot(@(n) 1/(n-1))

m1 = mvnpdf([5; 5; 6;],mu,C)
m2 = mvnpdf([3; 5; 7],mu,C)
m3 = mvnpdf([4; 6.5; 1],mu,C)