function [ color ] = evaluate_color( x, w, ws )    
    color = zeros(length(x), 3);
    [~, cls] = min(pdist2(x, w)');    
    
    for i = 1:length(x)
        if ws(cls(i)) == 0
            color(i,:) = [0 0 1];
        else
            color(i,:) = [1 0 0];
        end
    end
end

