clc;clear;
rng('default')
rng(1)
%% Part 1


S = [];

for i = 1:10000
    r = randi([1, 20]);
    load(strcat('data/person',sprintf('%02d',r),'.mat'));
    ind = randi([1,size(iriscode,1)], 1, 2);
    S = [S, pdist2(iriscode(ind(1),:), iriscode(ind(2),:),'hamming')];    
end

D = [];

for i = 1:10000
    r = randi([1,20],1,2);
    while r(1) == r(2)
        r = randi([1,20],1,2);
    end
    load(strcat('data/person',sprintf('%02d',r(1)),'.mat'));
    p1 = iriscode(randi([1,20]),:);
    load(strcat('data/person',sprintf('%02d',r(2)),'.mat'));
    p2 = iriscode(randi([1,20]),:);
    
    D = [D, pdist2(p1, p2, 'hamming')];
end

%% Plotting

figure

h1 = histogram(S, 6, 'FaceColor', 'green');
hold on;
h2 = histogram(D, 'BinWidth', h1.BinWidth,'FaceColor', 'red');
title('HD histograms for similar (green) and different (red) iris comparissons');
xlabel('Normalized HD');
legend('Similar','Different');

% xS = [min(S):(max(S)-min(S))/size(S,2):max(S)];
% xD = [min(D):(max(D)-min(D))/size(D,2):max(D)];
xS = [0:.0001:.7];
xD = xS;

Sdist = normpdf(xS, mean(S), sqrt(var(S)));
Ddist = normpdf(xD, mean(D), sqrt(var(D)));

plot(xS, Sdist*max(h1.BinCounts)/max(Sdist), 'b', 'LineWidth', 2);
plot(xD, Ddist*max(h2.BinCounts)/max(Ddist), 'b', 'LineWidth', 2);
line([0.4239 0.4239], [0 3000]); is the easy command;
% plot(x, Ddist);


%% Part 2

% question 11
p = norminv(0.0005, mean(D), sqrt(var(D)));
Z = (p - mean(S))/sqrt(var(S));

cp = normcdf([Z, inf]);
frj = cp(2) - cp(1);

%% Occlusion
clear;
load('data/testperson.mat');
testperson = iriscode;

% Array of distances between testperson and all the other individuals;
distances = [];

for i = 1:20
    load(strcat('data/person',sprintf('%02d',i),'.mat'));
    distanceDist = [];
    for j = 1:20
        distanceDist = [distanceDist, occludedHD(testperson, iriscode(j,:))];
    end
    distances = [distances, mean(distanceDist)]
end

load('data/person01.mat');
person = iriscode(3,:);

HD = occludedHD(testperson, person)

% I is the person number with the highest distance, and D is that
% distance.
[D, I] = min(distances);

%% Question 16

clear;
load('data/testperson.mat');
testperson = iriscode;

M = [];

for i = 1:20
    load(strcat('data/person',sprintf('%02d',i),'.mat'));
    for j = 1:size(iriscode, 1)
        M = [M, occludedHD(testperson, iriscode(j,:))];
    end
end

mu = mean(M);
std = sqrt(var(M));

% from Occlusion
HDmin = 0.0275;

Z = (HDmin - mu) / std;
cp = normcdf([-inf, Z]);
frj = cp(2) - cp(1);