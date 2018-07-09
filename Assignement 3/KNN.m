function [ label ] = KNN( point, K, data, class_labels )

    %compute dataset distances
    distances = zeros(size(data, 1), 1);
    
    for i = 1:size(data,1)
        distances(i) = norm(point - data(i, :));
    end
    
    [dist_sorted, order] = sort(distances);
    neighbors = zeros(K, 1);
    
    for i=1:K
        neighbors(i) = class_labels(order(i));
    end
    
    label = mode(neighbors);
end

