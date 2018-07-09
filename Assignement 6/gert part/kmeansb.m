function [ ps, X_cls, ps_hist ] = kmeansb(X, k, use_plus)
P = length(X);

if use_plus
    ps(1,:) = X(randi(P),:);
    
    for i = 2:k
        dst = pdist2(X,ps);
        D = min(dst, [], 2);
        
        y = randsample(P, 1, true, D.^2);
        
        ps(i,:) = X(y,:);
    end
else
    ps_idx = randperm(P);   % create random indices without replacement
    ps = X(ps_idx(1:k), :); % init k prototypes using these indices
end

ps_hist(1) = {ps};

X_cls_prev = ones(P,1) + 1;
X_cls = ones(P, 1);

while any(X_cls ~= X_cls_prev)
    X_cls_prev = X_cls;
    
    dst = pdist2(X, ps);            % calculate distances to prototypes
    [~, X_cls] = min(dst, [], 2);   % assign class to closest prototype
    
    % Update prototypes
    for i = 1:k
        ps(i,:) = mean(X(X_cls == i,:));
    end
    
    ps_hist(end+1) = {ps};
end

end