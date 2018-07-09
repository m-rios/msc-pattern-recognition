function [ w, errors ] = lvq1( xi, S, w, ws, eta )
    class = @(k) ws(k);
    errors = [Inf 0];
    while abs(errors(end) - errors(end-1)) > 0.0001
        for t = randperm(length(xi))
            [d, i] = min(pdist2(w, xi(t, :)));
            if ws(i) == S(t)
                w(i) = w(i) + eta * (xi(t) - w(i));
            else
                w(i) = w(i) - eta * (xi(t) - w(i));
            end
        end            
%         [d, k] = min(pdist2(w, xi));
%         errors = [errors sum(arrayfun(class, k)' == S)/length(xi)];
        
        % determine classification error after epoch
        error = 0;
        for i = 1:length(xi)
            ds = (w(:,1) - xi(i,1)).^2 + (w(:,2) - xi(i,2)).^2;
            [~, w_i] = min(ds);
            error = error + (ws(w_i) ~= S(i));            
        end
        error = error/length(xi);
        errors = [errors error];
        
    end
    errors = errors(3:end);
end

