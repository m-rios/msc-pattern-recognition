function [ w, Es, X_cls ] = glvq1( X, y, ps, eta )
% init random prototypes.
w = zeros(length(ps), 2);

data = [X y];
for i = 1:length(ps)
    r_i = data(data(:,3) == ps(i),1:2);
    w(i,:) = r_i(randi(length(r_i)),:);
end

Es = [inf 1];
j = 2;

while abs(Es(j) - Es(j-1)) > 0.0001
    j = j+1;
    
    for i = randperm(length(X))
        ds = sqrt((w(:,1) - X(i,1)).^2 + (w(:,2) - X(i,2)).^2);

        [~, w_i] = min(ds);

        if ps(w_i) == y(i) % prototype same class as point
            w(w_i,:) = w(w_i,:) + eta * (X(i,:) - w(w_i,:));
        else % prototype different class from point
            w(w_i,:) = w(w_i,:) - eta * (X(i,:) - w(w_i,:));
        end
    end

    Es(j) = 0;
    % determine classification error after epoch
    for i = 1:length(X)
        ds = (w(:,1) - X(i,1)).^2 + (w(:,2) - X(i,2)).^2;
        [~, w_i] = min(ds);

        Es(j) = Es(j) + (ps(w_i) ~= y(i));
    end
    Es(j) = Es(j) / length(X);
end

Es = Es(3:end);

for i = 1:length(X)
    ds = (w(:,1) - X(i,1)).^2 + (w(:,2) - X(i,2)).^2;
    [~, w_i] = min(ds);

    X_cls(i) = ps(w_i);
end

end
