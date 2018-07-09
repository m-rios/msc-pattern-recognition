function [ errors, error ] = k_fold_cross_validation( points, labels, k )

    [data, labels] = k_fold_sepparation(points, labels, k);

    errors = zeros(k,1);
    for i = 1:k
        % sepparate train/test
        train_data = [];
        train_labels = [];
        for j = 1:k
            if i == j 
                continue 
            end;
            train_data = [train_data; [data{i}]];
            train_labels = [train_labels; [labels{i}]];
        end
        %train
        [w, ws] = initialise_w(train_data);
        w = lvq1(train_data, train_labels, w, ws, 0.01);
        %test
        test_data = data{i};
        for t = 1:length(test_data)
            [~,cls] = min(pdist2(w, test_data(i,:)));
            errors(i) = errors(i) + (ws(cls) == labels{i}(t));
        end
    end
    error = mean(errors);

end

