function [ k_class ] = KNN( p, K, data, class_labels )

N = length(data);   % number of data points
D = length(p);      % dimensionality of the problem
ds = zeros(N, 1);

for i = 1:D % distance for each dimension
    ds = ds + (p(i) - data(:,i)).^2;
end
% we could take the square root, but that is not needed since we just need
% the k nearest neighbours and are not interested in the specific distances

% sort the array to get k indices with smallest distance
[~, dsIdx] = sort(ds);

% get the labels associated with these k nearest neighbours
k_labels = zeros(K,1);
for i = 1:K
    k_labels(i) = class_labels(dsIdx(i));
end

% assign the most frequent label to p
k_class = mode(k_labels);

end