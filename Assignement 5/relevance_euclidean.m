function [ dist ] = relevance_euclidean( x, y, lambda )
    dist = 0;
    for j = length(x)
        dist = dist + lambda(j) * (x(j) - y(j))^2;
    end
    
end

