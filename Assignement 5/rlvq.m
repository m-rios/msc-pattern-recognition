function [ w, errors, lambdas ] = rlvq( xi, S, w, ws, eta )
    lambda = ones(1,size(xi,2))*0.5;
    dist = @(x, y) relevance_euclidean(x, y, lambda);
    class = @(k) ws(k);
    errors = [Inf 0];
    lambdas = [lambda];
    while abs(errors(end) - errors(end-1)) > 0.000001
        for t = 1:randperm(length(xi))
            [d, i] = min(pdist2(w, xi(t, :), dist));
            if ws(i) == S(t)
                w(i) = w(i) + eta * (xi(t) - w(i));
            else
                w(i) = w(i) - eta * (xi(t) - w(i));
            end
            %adjust lambda
            for j = 1:length(lambda)
                if ws(i) ~= S(t)
                    lambda(j) = lambda(j) - eta * abs(xi(t,j) - w(i,j));
                else
                    lambda(j) = lambda(j) + eta * abs(xi(t,j) - w(i,j));
                end
                lambda = max(lambda,0);
                lambda = lambda / sum(lambda);
            end
        end            
        [d, k] = min(pdist2(w, xi, dist));
        errors = [errors sum(arrayfun(class, k)' == S)/length(xi)];
        lambdas = [lambdas; lambda];
    end
    errors = errors(3:end);
end

