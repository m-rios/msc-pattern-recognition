function [ o ] = split_data(n, X, y)
% Assume that the data is separable into n partitions of equal size
cs = unique(y);
ps = cell(n, 1);

data = [X y];

% distribute points for each class
for i = 1:length(cs)
    cls_data = data(data(:,3) == cs(i), :);
    % create indices 1,2,..,10,1,2,..k to ensure that there is an equal
    % amount of points of class i in each partition
    idxs = mod(0:length(cls_data)-1, n) + 1;
    % shuffle these
    idxs = idxs(randperm(length(idxs)));
    
    for j = 1:length(idxs)
        ps{idxs(j)} = [ps{idxs(j)}; cls_data(j,:)];
    end
end

% cast the cell array back into an array
o = zeros(n, length(X) / n, 3);
for i = 1:n
    o(i,:,:) = ps{i};
end

end
