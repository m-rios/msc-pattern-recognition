function [ w, Es, lambda ] = rlvq1( X, y, ps, eta )
% init random prototypes.
w = zeros(length(ps), 2);

data = [X y];
for i = 1:length(ps)
    r_i = data(data(:,3) == ps(i),1:2);
    w(i,:) = r_i(randi(length(r_i)),:);
end

lambda = [0.5 0.5];
Es = [1];
j = 1;
c_counter = 0;

while true
    j = j+1;
    
    for i = randperm(length(X))
        ds = sqrt(lambda(j-1,1)*(w(:,1) - X(i,1)).^2 + lambda(j-1,2)*(w(:,2) - X(i,2)).^2);

        [~, w_i] = min(ds);

        if ps(w_i) == y(i) % prototype same class as point
            w(w_i,:) = w(w_i,:) + eta * (X(i,:) - w(w_i,:));
            lambda(j,:) = lambda(j - 1,:) - eta * abs(X(i,:) - w(w_i,:));
        else % prototype different class from point
            w(w_i,:) = w(w_i,:) - eta * (X(i,:) - w(w_i,:));
            lambda(j,:) = lambda(j - 1,:) + eta * abs(X(i,:) - w(w_i,:));
        end
        
        % normalise lambda
        lambda(j,:) = lambda(j,:) / sum(lambda(j,:));
    end

    Es(j) = 0;
    % determine classification error after epoch
    for i = 1:length(X)
        ds = lambda(j,1)*(w(:,1) - X(i,1)).^2 + lambda(j,2)*(w(:,2) - X(i,2)).^2;
        [~, w_i] = min(ds);

        Es(j) = Es(j) + (ps(w_i) ~= y(i));
    end
    Es(j) = Es(j) / length(X);
    
    if abs(Es(j) - Es(j-1)) < 0.0001 || (Es(j) - Es(j-1) > 0)
        c_counter = c_counter + 1;
        if c_counter == 4
            break;
        end
    else
        c_counter = 0;
    end
end

Es = Es(2:end);
lambda = lambda(2:end,:);

end
